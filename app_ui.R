emissionData <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
ui <- shinyUI(
  navbarPage("CO2 Emissions", 
             setBackgroundImage(src = "https://geographical.co.uk/media/k2/items/cache/8d4037d29c87f8fc3ae6bd767796d3bf_XL.jpg"), 
             tabPanel("Introduction", 
                      h1("Introduction", align = "center"), 
                      p("This projects explores the CO2 Emissions for countries around the world. 
                        For this project I found the country that has the highest average CO2 emissions per capita per year, which is Qatar 
                        with 45.66678 tonnes per person. I also found the year when each country has its highest CO2 emission and there were 17 countries 
                        with the highest CO2 emission in 2020. Next I also found the country that has the least percentage of CO2 emission share 
                        (not cumulative) in 2020, and there was 61 countries with close to 0.0% in 2020 so their data showed 0.0%. I also found the year
                        when the world had the least CO2 emission that year, which was 2019. Finally I found the country that has the highest percentage of 
                        oil CO2 emission to CO2 emission (both cumulative), and there was 40 countries with that has 100% of oil CO2 to total CO2 emission.")),
             tabPanel("Chart",
                      sidebarLayout(
                        sidebarPanel(
                          setSliderColor("red", 1), 
                          sliderInput(
                            "year",
                            label = h3("Years"),
                            min = 1970,
                            max = 2020,
                            value = c(1970, 2020), 
                            sep = ""
                          ),
                          selectInput(
                            "country", 
                            label = h3("Select country"), 
                            choices = emissionData$country
                          )
                        ),
                        mainPanel(
                          plotlyOutput("yearCO2Plot"), 
                          p("This chart was added so that we could explore the CO2 emissions each year for different countries."), 
                          br(), 
                          p("I found that like expected the smaller countries have less CO2 production each year, 
                            and the industrial countries have higher CO2 production each year. Also progressive countries 
                            like the U.S. are steadily dropping their CO2 emissions yearly.")
                        )
                      )
             ), 
             tags$style(
               "p {color: #FFFFFF !important;
          font-family: Rockwell !important;
          font-size: 20px !important;}", 
               "h1 {color: #FFFFFF !important;
          font-family: Rockwell}"
             )
  )
)