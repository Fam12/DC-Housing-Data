#Cleaning data 
library(tidyverse)

#Read in Data and View 
housing <- read.csv("dc_final.csv")
#view(housing)
dim(housing)
str(housing)

#Drop Columns that we don't need 
housing_clean <- housing %>%
  select(-c("X","SSL", "SALEDATE","BLDG_NUM", "GIS_LAST_MOD_DTTM",
           "OBJECTID", "FULLADDRESS", "CITY", "STATE", "NATIONALGRID",
           "ASSESSMENT_NBHD", "ASSESSMENT_SUBNBHD", "CENSUS_BLOCK", "EYB"))
dim(housing_clean)
head(housing_clean)
view(housing_clean)

#Change certain values to factors 
cols <- c("AC","QUALIFIED", "HEAT", "STYLE_D", "STRUCT_D", "GRADE", "CNDTN", 
          "EXTWALL", "ROOF", "INTWALL", "ZIPCODE", "CENSUS_TRACT", "WARD")
housing_clean[cols] <- lapply(housing_clean[cols], factor)
sapply(housing_clean, class)
#Omit rows that have nan 
housing_clean <- na.omit(housing_clean)
#Add index column 
housing_clean <- tibble::rowid_to_column(housing_clean, "index")
view(housing_clean)
#Save csv 
write_csv(housing_clean, file = "housing_clean.csv")

