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

# Summarize PerCapitaInc for sample statistics
summarize(df, mean=mean(PerCapitaInc), sd=sd(PerCapitaInc), skewness=skewness(PerCapitaInc), kurtosis=kurtosis(PerCapitaInc), n())


# 4.
#   a)
#     i) Sample mean PerCapitaInc
mean(df$PerCapitaInc, na.rm=TRUE)

#     ii) Sample Standard Deviation PerCapitaInc
sd(df$PerCapitaInc, na.rm=TRUE)

#     iii) Sample skewness PerCapitaInc (package: moments)
skewness(df$PerCapitaInc, na.rm=TRUE)

#     iv) Sample kurtosis and (v) PerCapitaInc (package: moments)
kurtosis(df$PerCapitaInc, na.rm=TRUE)

#     v) Sample size for per capita income (variable name is "PerCapitaInc")
sample_size <- summarize(df, n())
sample_size

# Min
min(df$PerCapitaInc, na.rm=TRUE)
# Max
max(df$PerCapitaInc, na.rm=TRUE)

# Indicate in your answer whether the per capita income distribution has a longer right tail or a longer left tail (and how you know). Also indicate whether the tails of the distribution would be considered statistically “heavy” or not (and how you know).
