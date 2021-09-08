# Load packages
library(tidyverse)
library(dplyr)

# Load in data
df <- read_csv("Data/rural_atlas_merged.csv")

# Inspect data
print(spec(df))
View(df)
head(df)
str(df)
nrow(df)
ncol(df)
names(df)

# Summary
summary(df)

# Drop N/A values to compute statistics
df <- drop_na(df)
summary(df)

my_data <- as_tibble(df)

per_capita_income <- summarise(my_data, avg = mean(PerCapitaInc))

sample_stats <- summarise(my_data, across(everything(), list(mean)))

# 4.
#   a)
#     i) Sample mean
#     ii) Sample Standard Deviation
#     iii) Sample skewness
#     iv) Sample kurtosis and (v)
#     v) Sample size for per capita income (variable name is "PerCapitaInc")
