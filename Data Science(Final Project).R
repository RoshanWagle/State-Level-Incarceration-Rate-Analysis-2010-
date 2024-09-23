#Loading both tidyverse library and haven library#
library(tidyverse)
library(dplyr)
library(haven)
library(readxl)

ncrp_3years_year_end = read_sav("C:/Users/rosha/Downloads/ncrp_3years_year_end.sav")

#Creating dataframe named "prison_counts"#
prison_counts <- ncrp_3years_year_end %>% 

#Filtering the unwanted years and listing only 2010 #   
filter(RPTYEAR == 2010) %>% 
  
#Converting all variable names to lower case #  
rename_all(tolower) 

#Creating a variable called "year" by assigning it the value of the rptyear variable #
prison_counts$year <- as.integer(prison_counts$rptyear)

#Creating ate a dummy variable (inmate_dummy) that is equal to “1” on each row #
prison_counts <- prison_counts %>% 
mutate(inmate_dummy = 1) %>% 
select(year, inmate_dummy, state)

#Aggregating all needed variables to the state-level using Dplyr group_by and the summarize function #
agg_prison_counts <- prison_counts %>% 
group_by(state, year) %>% 
summarize(inmate_dummy = sum(inmate_dummy)) %>% 

#Renaming the “inmate_dummy" to "inmate_count"#
rename(inmate_count = inmate_dummy)

#Importing the file name census_panel.csv and creating variable called year from existing variable called waves#
census_panel = read.csv("C:/Users/rosha/Downloads/census_panel.csv")
census_panel <- census_panel %>% 
mutate(year = as.integer(wave)) %>% 
rename(state = "STATE")

#Merging the 2010 state-level inmate count data with census population data and verifying the correct year which has been merged #
merged_data <- inner_join(agg_prison_counts, census_panel, by = c("state", "year"))
unique(merged_data$year)

#Creating incarceration rate for each states #
merged_data <- merged_data %>% 
relocate(NAME, .before = year) %>% 
relocate(inmate_count, .after = Pop) %>% 
mutate(incarceration_rate = (inmate_count / Pop) * 100000) %>% 
rename_all(toupper)

merged_data <- merged_data %>% 
select(-WAVE, -ROW)

#Sorting the dataframe and printing the incarceration rate#
merged_data_sorted <- merged_data %>% 
  arrange(desc(INCARCERATION_RATE))

print(merged_data_sorted[, c("NAME", "YEAR", "INCARCERATION_RATE")])

#######################  #####   ##################
  NAME                   YEAR    INCARCERATION_RATE
  <chr>                  <int>            <dbl>
1 District of Columbia   2010               986.
2 Louisiana              2010               877.
3 Mississippi            2010               720.
4 Oklahoma               2010               680.
5 Texas                  2010               633.
6 Arizona                2010               625.
7 Arkansas               2010               601.
8 Alabama                2010               589.
9 Delaware               2010               575.
10 Georgia               2010               556.
######################  #####   #################/