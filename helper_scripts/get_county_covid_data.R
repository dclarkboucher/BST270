library(tidyverse)
library(data.table)
library(dtplyr)

#Function to retrieve county-level COVID data from the New York Times.
#Outputs a data frame with date, geoid, region, subregion, cases, and deaths

get_county_covid_data <- function(){
  
  # Read data and enable data.table backend
  covid <- 
    fread("https://raw.githubusercontent.com/nytimes/covid-19-data/master/rolling-averages/us-counties-2022.csv") |> 
    lazy_dt()

  covid |> 
    rename(region = state, subregion = county) |> 
    mutate(
      region = str_to_lower(region),
      subregion = str_to_lower(subregion),
      subregion = str_replace(subregion, "\\.", "")
    )  |> 
    select(date, geoid, region, subregion, cases, deaths) |> 
    as_tibble()
  
}
