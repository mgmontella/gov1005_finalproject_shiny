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
  

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Upshot Data and Midterm Results"),
  
  # Sidebar with a slider input for  
  sidebarLayout(
    sidebarPanel(
      selectInput("X1_06", "Choose Type of Service:",
                  choices = c("Servies" = "Total Services",
                              "Charges for the use of intellectual property n.i.e." = "Intellectual Property",
                              "Maintenance and repair services n.i.e." = "Maintenance and Repair",
                              "Freight (Air)" = "Air Freight Transport",
                              "Financial services" = "Financial Services",
                              "Travel" = "Travel",
                              "Education-related" = "Education-related",
                              "Construction" = "Construction",
                              "Telecommunications services" = "Telecommunications",
                              "Computer services" = "Computer Services",
                              "Information services" = "Information Services",
                              "Research and development services" = "Research and Development",
                              "Professional and management consulting services" = "Professional and Management Consulting",
                              "Commercial services" = "Commercial",
                              "Other commercial services" = "Other Commercial",
                              "Other services" = "Other Services",
                              "Operating leasing services" = "Operating Leasing",
                              "Legal services" = "Legal",
                              "Goods-related services" = "Goods-related",
                              "Government goods and services n.i.e." = "Governement Goods & Services",
                              "Transport" = "Total Transport",
                              "Sea transport" = "Sea Transport",
                              "Air transport" = "Air Transport",
                              "Passenger (Air)" = "Passenger Transport",
                              "Other modes of transport" = "Other Modes of Transport",
                              "Insurance and pension services" = "Insurance & Pension",
                              "Direct insurance" = "Direct Insurance",
                              "Reinsurance" = "Reinsurance",
                              "Licences for the use of outcomes of research and development" = "Licenses for Research & Development",
                              "Licences to reproduce and/or distribute computer software" = "Licenses for Computer Software",
                              "Licences to reproduce and/or distribute other products" = "Licenses for Other Products",
                              "Franchises and trademarks licensing fees" = "Franchises and Trademarks Licensing"),
                  selected = "Total Services",
                  multiple = FALSE))
  ),
  
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("lineplot")
     
      
       ##tabsetPanel(type = "tabs",
                  #tabPanel("About this app", htmlOutput("about")),
                #3tabPanel("Total Polling Data", plotlyOutput("barPlot")),
                  #tabPanel("NJ-03 Demographics", plotOutput("piechart")))
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) { 
  
  output$lineplot <- renderPlotly({
    
      lineplot <- ggplot(data, aes(x = Year, y = X1_11, color = X1_08, group = X1_08)) + 
      geom_point() + 
      geom_line() + 
      labs(title = "US-China Trade in Services over Time") + 
      ylab("Millions of USD") + 
      xlab("Year") + 
      theme(text = element_text(family = "Times New Roman", size = 14), panel.background = element_blank()) + 
      theme(legend.title=element_blank())
      
      ggplotly(lineplot)
  })
  
  #output$piechart <- renderPlot({
    #specific %>% 
      #ggplot(aes_string(x = input$characteristic, color = input$characteristic)) + geom_bar() + 
      #coord_polar("y", start=0) + ggtitle("New Jersey District 3, by characteristic")})
  
  #output$about <- renderUI({
    
    # Provide users with a summary of the application and instructions
    # Provide users with information on the data source
    
    #str1 <- paste("Summary")
    #str2 <- paste("This app shows the interviewees that Upshot used in their poll.")
    #str3 <- paste("Instructions") 
    #str4 <- paste("Click through the tabs to see the data in different ways and use the drop-down menu to go between different characteristics.")
    
}

#Run the application 
shinyApp(ui = ui, server = server)

