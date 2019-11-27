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

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    p <- ggplot(data)
    
    if (input$xvar == "GDP") {
      p <- p + geom_point(aes(x=GDP, y=WAPs)) 
    } else if (input$xvar == "population") {
      p <- p + geom_point(aes(x=population, y=WAPs))
    } else {
      p <- p + geom_point(aes(x=size, y=WAPs))
    }
    
    if (input$xlog) { p <- p + scale_x_continuous(trans="log10")}
    if (input$ylog) { p <- p + scale_y_continuous(trans="log10")}
    
    p
    
    # generate bins based on input$bins from ui.R
    #x    <- faithful[, 2] 
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    #hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
})
