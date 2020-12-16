library(haven)
library(tidyverse)
# Read in the raw data.
setwd("E:/Assignments/STA304/Sta304-Final Project")
raw_census_data <- read_dta("usa_00011.dta.gz")


# Add the labels
raw_census_data <- labelled::to_factor(raw_census_data)
head(raw_census_data)

reduced_census_data <- 
  raw_census_data %>% 
  select(age,
         sex,
         race,
         educd,
         stateicp,
         classwkrd,
         wkswork1,
         inctot)

reduced_census_data<-
  reduced_census_data %>%
  mutate(treatment = ifelse(sex=="female", 1, 0))

reduced_census_data <- 
  reduced_census_data %>%
  filter(age != "less than 1 year old") %>%
  filter(age != "90 (90+ in 1980 and 1990)")


reduced_census_data <-
  reduced_census_data %>%
  filter(inctot != 9999999)%>%
  filter(inctot != 0)

reduced_census_data <-
  reduced_census_data %>%
  filter(classwkrd != "n/a")

reduced_census_data <-
  reduced_census_data %>%
  filter(wkswork1 != 0)

# Saving the census data as a csv file in my working directory
write_csv(reduced_census_data, "E:/Assignments/STA304/Sta304-Final Project/Final_project_cleaned_data.csv")
