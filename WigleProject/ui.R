#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Number of WiFi Networks"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       tags$div("This app gives you a visualization of wifi networks by country. The options below allow you to change the scale and axis."),
       #sliderInput("bins",
       #            "Number of bins:",
       #            min = 1,
       #            max = 50,
       #            value = 30),
       selectInput("xvar",
                    "Select variable for x axis",
                    choices = c("GDP","Population","Area")),
       checkboxInput("xlog",
                     "Scale x-axis logarithmically",
                     value = TRUE),
       checkboxInput("ylog",
                     "Scale y-axis logarithmically",
                     value = TRUE)
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot")
    )
  )
))
