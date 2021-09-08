# Load packages
library(tidyverse)
library(dplyr)
library(moments)

# Load in data
df <- read_csv("Data/rural_atlas_merged.csv")

# Inspect data
View(df)
head(df)
str(df)
nrow(df)
ncol(df)
names(df)

# Summary
summary(df)

# Drop N/A values to compute statistics
my_data <- drop_na(df)
summary(my_data)

my_data <- as_tibble(df)

# Summarize data
sample_stats <- summarise(my_data, across(everything(), list(mean)))


# 4.
#   a)
#     i) Sample mean PerCapitaInc
sample_mean_PerCapitaInc <- summarise(my_data, mean = mean(PerCapitaInc))

#     ii) Sample Standard Deviation PerCapitaInc
sample_standard_deviation <- summarise(my_data, s = mean(PerCapitaInc))

#     iii) Sample skewness PerCapitaInc (package: moments)


#     iv) Sample kurtosis and (v) PerCapitaInc (package: moments)


#     v) Sample size for per capita income (variable name is "PerCapitaInc")

