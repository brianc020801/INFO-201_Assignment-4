library(shiny)
library(dplyr)
library(shinyWidgets)
library(plotly)
source("app_ui.R")
source("app_server.R")

# Define UI for application that draws a histogram

ui <- ui

# Define server logic required to draw a histogram
server <- server

# Run the application 
shinyApp(ui = ui, server = server)
