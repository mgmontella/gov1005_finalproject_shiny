#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(tidyverse)
library(scales)
library(plotly)

data <- read_rds("services.rds")
select_goods <- read_rds("goods.rds")

# Define UI for application 
ui <- navbarPage(
  title = "US-China Trade",
  theme = shinytheme("sandstone"),
# beginning of tabs atop page (first tab to provide context)
  tabPanel(
    title = "Why US-China Trade",
    mainPanel(
      textOutput("text")
    )
  ),
# second tab atop page (services exchange)
  tabPanel(
    title = "US-China Services Exchange",
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
                    multiple = FALSE),
        h6("Source: World Trade Organization")),
      mainPanel(
        tabsetPanel(
          tabPanel(
            title = "Export-Import Comparison",
            plotlyOutput("lineplot"))
        )
      )
    )
  ),
# third tab panel (goods exports to China)
  tabPanel(
    title = "US Goods Exports",
    sidebarLayout(
      sidebarPanel(
        selectInput("Sector", "Choose sector of goods:",
                    choices = c("Total Merchandise" = "Total Merchandise",
                                "Agricultural Products" = "Argicultural Products",
                                "Food" = "Food",
                                "Fish" = "Fish",
                                "Other Food" = "Other Food",
                                "Raw Materials" = "Raw Materials",
                                "Fuels and Mining" = "Fuels and Mining",
                                "Ores and Other Minerals" = "Ores and Other Minerals",
                                "Fuels" = "Fuels",
                                "Non-ferrous Metals" = "Non-ferrous Metals",
                                "Manufactures" = "Manufactures",
                                "Iron and Steel" = "Iron and Steel",
                                "Chemicals" = "Chemicals",
                                "Pharmaceuticals" = "Pharmaceuticals",
                                "Other Chemicals" = "Other Chemicals",
                                "Other Semi-manufactures" = "Other Semi-manufactures",
                                "Machinery and Transport Equipment" = "Machinery and Transport Equipment",
                                "Office and Telecom Equipment" = "Office and Telecom Equipment",
                                "Electronic data processing and office equipment" = "Electronic data processing and office equipment",
                                "Telecommunications Equipment" = "Telecommunications Equipment",
                                "Integrated circuits and electronic components" = "Integrated circuits and electronic components",
                                "Transport equipment" = "Transport equipment",
                                "Automotive products" = "Automotive products",
                                "Other transport equipment" = "Other transport equipment",
                                "Other machinery" = "Other machinery",
                                "Textiles" = "Textiles",
                                "Clothing" = "Clothing",
                                "Other manufactures" = "Other manufactures",
                                "Personal and household goods" = "Personal and household goods",
                                "Scientific and controlling instruments" = "Scientific and controlling instruments",
                                "Miscellaneous manufactures" = "Miscellaneous manufactures"),
                    selected = "Total Merchandise",
                    multiple = FALSE),
        h6("Source: World Trade Organization")),
      mainPanel(
        tabsetPanel(
          tabPanel(
            title = "US Goods Exports to China",
            plotlyOutput("lineplot_b")
          )
        )
      )
    )
  ),
# fourth tab panel with take-aways
  tabPanel(
    title = "Takeaways",
    mainPanel(
      textOutput("text")
    )
  )
)

###########################
##Define the server logic##
###########################

server <- function(input, output) { 
  
  output$text <- renderText({
    "This data is collected from the World Trade Organization and observes trends in the exchange of services between the United States and China since 2005."
  })
  
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
  
  output$lineplot_b <- renderPlotly({
    
    lineplot_b <- select_goods %>%
      ggplot(aes(x = Year, y = Value, color = Sector, group = Sector)) + 
      geom_point() + 
      geom_line() + 
      labs(title = "US Goods Export to China") + 
      ylab("Millions of USD") + 
      xlab("Year") + 
      theme(text = element_text(family = "Times New Roman", size = 14), panel.background = element_blank()) + 
      theme(legend.title=element_blank())
    
    ggplotly(lineplot_b)
  })
}

###########################
## Run the application ##
###########################

shinyApp(ui = ui, server = server)

