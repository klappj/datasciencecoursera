#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(jsonlite)
library(scales)

# load and clean data
wiggle <- as.data.frame(fromJSON("wiggleData.json"))
colnames(wiggle) <- c("success","two","WAPs")
wiggle$two[wiggle$two=="XK"] <- "KV" # Fix Kosovo
countrySize <- read.csv("IDBextCTYS.txt",sep = "|", stringsAsFactors = FALSE)
colnames(countrySize) <- c("two","Name","size")
countryPop <- read.csv("IDBext001.txt",sep = "|", stringsAsFactors = FALSE)
colnames(countryPop) <- c("two","year","population")
countryPop <- countryPop[countryPop$year==2019,] #just 2019 data
countryGDP <- read.csv("GDP.csv", stringsAsFactors = FALSE)
colnames(countryGDP) <- c("three","Ranking","name","GDP")
countryCodes <- read.csv("CountryCodes.csv", stringsAsFactors = FALSE)

#merge the data into a dataframe named data
data <- merge(wiggle, countryCodes) # get 3 digit codes, drop NA and blank
data <- merge(data, countrySize, by="two", all.x = TRUE) # add landmass
data <- merge(data, countryPop, by="two", all.x = TRUE) # add population
data <- merge(data, countryGDP, by="three", all.x = TRUE) # add GDP

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    p <- ggplot(data) + ylab("Number of WiFi Networks")
    
    if (input$xvar == "GDP") {
      p <- p + geom_point(aes(x=GDP, y=WAPs)) 
      p <- p + xlab("Gross Domestic Product, $USD")
    } else if (input$xvar == "Population") {
      p <- p + geom_point(aes(x=population, y=WAPs))
      p <- P + xlab("Population")
    } else {
      p <- p + geom_point(aes(x=size, y=WAPs))
      p <- p + xlab("Country Size, square miles")
    }
    
    if (input$xlog) { p <- p + scale_x_continuous(trans="log10",
                                                  labels=comma)}
    if (input$ylog) { p <- p + scale_y_continuous(trans="log10",
                                                  labels=comma)}
    
    p
    
    # generate bins based on input$bins from ui.R
    #x    <- faithful[, 2] 
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    #hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
})
