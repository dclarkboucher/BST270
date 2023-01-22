library(data.table)
library(dtplyr)
library(tidyverse)

#Function to retrieve population data from the US Census Bureau. 
#Outputs a data frame with the variables region (i.e., state), 
#subregion, and population

get_county_pop_data <- function(){
  
  # Read data and enable data.table backend
  county_pop <- 
    fread("https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/totals/co-est2019-alldata.csv") |> 
    lazy_dt()
  
  # Clean county population data to get population estimates
  county_pop |> 
    mutate(
      STNAME = str_to_lower(STNAME),
      CTYNAME = str_replace(CTYNAME, "\\sCounty|\\sParish", ""),
      CTYNAME = str_replace(CTYNAME, "\\.", ""),
      CTYNAME = str_to_lower(CTYNAME)
    ) |> 
    transmute(region = STNAME, subregion = CTYNAME, population = POPESTIMATE2019) |> 
    as_tibble()
  

}





