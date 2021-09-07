# Load packages
library(tidyverse)

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
df1 <- drop_na(df)
summary(df1)

# Compute mean for PerCapitaInc
mean_per_capita_inc <- summarize(df1, mean(PerCapitaInc))
print(mean_per_capita_inc)

# 4.
#   a)
#     i) Sample mean
#     ii) Sample Standard Deviation
#     iii) Sample skewness
#     iv) Sample kurtosis and (v)
#     v) Sample size for per capita income (variable name is "PerCapitaInc")
