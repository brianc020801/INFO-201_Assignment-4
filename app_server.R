emissionData <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
server <- function(input, output) {
  data <- reactive({
    emission <- emissionData %>% 
      filter(
        year >= input$year[1],
        year <= input$year[2], 
        country == input$country)
  })
  
  output$yearCO2Plot <- renderPlotly({
    e <- data()
    plot <- plot_ly(data = e, x = ~year, y = ~co2, type = 'scatter', mode = 'lines', 
                    hovertemplate = paste("Year: %{x:.0f}<br>", "CO2 Emission: %{y:.0f}<br>" ), color = 'red') %>% 
      layout(title = 'CO2 Emissions Each Year', plot_bgcolor = "#e5ecf6", xaxis = list(title = 'Year'), 
             yaxis = list(title = 'CO2 Emissions (tonnes)'))
  })
  
  #Which country has the highest average co2 per capita over the years.
  highestAverageCO2Capita <- emissionData %>% 
    group_by(country) %>% 
    summarise(.groups = "drop", averageCO2Capita = mean(co2_per_capita)) %>% 
    filter(averageCO2Capita == max(na.omit(averageCO2Capita))) %>% 
    select(country, averageCO2Capita)
  #Qatar with 45.66678 tonnes per person
  
  #Which is each country's year with the highest co2 emission
  yearEachCountryHighestEmission <- emissionData %>% 
    group_by(country) %>% 
    slice_max(n = 1, na.omit(co2)) %>% 
    select(country, year)
  #17 countries have the highest co2 emission in 2020
  
  #Which country has the least percentage of CO2 emission (not cumalative) in 2020
  countryLowestShare2020 <- emissionData %>% 
    filter(country != 'World', country != 'Asia', country != 'Europe', country != 'Africa', country != 'South America', year == 2020, 
           share_global_co2 == min(na.omit(share_global_co2))) %>% 
    select(country)
  #61 countries have 0.0 percent share of global CO2 emission in 2020
  
  #What year did the world have the most CO2 emission
  yearMostCO2Emission <- emissionData %>% 
    filter(country == 'World', co2 == max(na.omit(co2))) %>% 
    select(year, co2)
  #2019 with 36702.5 tonnes
  
  #Which country has the most share of oil co2 to its total co2 (cumulative)
  countryMostShareOil <- emissionData %>% 
    filter(year == 2020) %>% 
    summarise(country = country, shareOil = cumulative_oil_co2/cumulative_co2) %>% 
    filter(shareOil == max(na.omit(shareOil))) %>% 
    select(country, shareOil)
  #There are 50 countries that has 100% of its CO2 emission from oil
  
}

