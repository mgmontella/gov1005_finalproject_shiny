#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(tidyverse)
library(stringr)
library(ggplot2)
library(janitor)
library(rsconnect)
library(shinythemes)
library(plotly)
library(scales)

data <- read_rds("services copy.rds")
  

# Define UI for application that draws a plot
ui <- fluidPage(
  
  # Application title
  titlePanel("US-China Exchange of Services"),
  
  # Sidebar with a slider input for  
  sidebarLayout(
    sidebarPanel(
      selectInput("X1_06", "Choose Type of Service:",
                  choices = c("All Services" = "Services",
                              "Intellectual Property" = "Charges for the use of intellectual property n.i.e.",
                              "Maintenance and Repair" = "Maintenance and repair services n.i.e.",
                              "Air Freight Transport" = "Freight (Air)",
                              "Financial Services" = "Financial services",
                              "Travel" = "Travel",
                              "Education-related" = "Education-related",
                              "Construction" = "Construction",
                              "Telecommunications" = "Telecommunications services",
                              "Computer Services" = "Computer services",
                              "Information Services" = "Information services",
                              "Research and Development" = "Research and development services",
                              "Professional and Management Consulting" = "Professional and management consulting services",
                              "Commercial" = "Commercial services",
                              "Other Commercial" = "Other commercial services",
                              "Other Services" = "Other services",
                              "Operating Leasing" = "Operating leasing services",
                              "Legal" = "Legal services",
                              "Goods-related" = "Goods-related services",
                              "Governement Goods & Services" = "Government goods and services n.i.e.",
                              "Total Transport" = "Transport",
                              "Sea Transport" = "Sea transport",
                              "Air Transport" = "Air transport",
                              "Passenger Transport" = "Passenger (Air)",
                              "Other Modes of Transport" = "Other modes of transport",
                              "Insurance & Pension" = "Insurance and pension services",
                              "Direct Insurance" = "Direct insurance",
                              "Reinsurance" = "Reinsurance",
                              "Licenses for Research & Development" = "Licences for the use of outcomes of research and development",
                              "Licenses for Computer Software" = "Licences to reproduce and/or distribute computer software",
                              "Licenses for Other Products" = "Licences to reproduce and/or distribute other products",
                              "Franchises and Trademarks Licensing" = "Franchises and trademarks licensing fees"),
                  selected = "All Services",
                  multiple = FALSE)),
# Show a plot of the generated distribution
  mainPanel(plotlyOutput("lineplot"))))

# Define server logic required to draw a histogram
server <- function(input, output) { 
  
  output$lineplot <- renderPlotly({
    
      lineplot <- data %>%
        filter(X1_06 == input$X1_06) %>%
        ggplot(aes(x = Year, y = X1_11, color = X1_08, group = X1_08)) + 
      geom_point() + 
      geom_line() + 
      labs(title = "US-China Trade in Services over Time") + 
      ylab("Millions of USD") + 
      xlab("Year") + 
      theme(text = element_text(family = "Times New Roman", size = 14), panel.background = element_blank()) + 
      theme(legend.title=element_blank())
      
      ggplotly(lineplot)
  })
}

#Run the application 
shinyApp(ui = ui, server = server)

