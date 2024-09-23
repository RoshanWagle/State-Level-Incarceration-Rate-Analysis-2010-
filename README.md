State-Level Incarceration Rate Analysis (2010)

Overview:
This project performs a detailed analysis of state-level incarceration rates for 2010, combining data from the National Corrections Reporting Program (NCRP) and U.S. Census data. The goal is to determine the incarceration rate (per 100,000 people) for each U.S. state.

Steps Involved:

  1.Data Loading: NCRP data was loaded from an SPSS file (.sav), while census data was loaded from a CSV file.
  2.Data Cleaning:
  3.Filtered data to focus on the year 2010.
  4.Standardized variable names and created additional variables.
  5.Data Aggregation: Inmate counts were aggregated at the state level.
  6.Data Merging: The NCRP inmate count data was merged with U.S. Census population data using the inner_join function.
  7.Calculation of Incarceration Rate: The incarceration rate was calculated as (inmate_count / population) * 100,000.
  8.Sorting and Analysis: The results were sorted to identify the top states with the highest incarceration rates in 2010.

Programming Language: R
Libraries: tidyverse, dplyr, haven, readxl
Data Sources: National Corrections Reporting Program (NCRP), U.S. Census

NOTE : The files that is used here will be uploaded in the same tab.
