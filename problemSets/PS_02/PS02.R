# Install packages
install.packages("tidyverse")
install.packages("dplyr")
install.packages("moments")

# Load packages
library(tidyverse)
library(dplyr)
library(moments)

# Load in data
df <- read_csv("Data/rural_atlas_merged.csv")
head(df)
summary(df)

# Subset the df -- Metro 2013
metro2013 <- subset(df, Metro2013 == 1)


# 4. 
# a) Run a regression to determine the impact of the 2013 unemployment rate (UnempRate2013) on the per capita income (PerCapitaInc) in a county. What is the estimated slope? Explain what this number means in words in terms of the unemployment rate and in terms of per capita income. Also indicate if the relationship is statistically significant at the 10%, 5%, and 1% levels. For this first pass, use homoskedastic standard errors.

# (use lm to fit linear models)
