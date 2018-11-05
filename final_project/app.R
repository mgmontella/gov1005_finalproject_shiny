#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#library(readxl)
#library(tidyverse)
#library(janitor)
library(readr)
#library(stringr)
#library(fs)
#library(splitstackshape)
library(shiny)

data <- read_rds("intelexports.rds")

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("US revenue from charges for the use of intellectual property by China"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      ggplot(data, aes(x = Year, y = USD)) + geom_point()
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

