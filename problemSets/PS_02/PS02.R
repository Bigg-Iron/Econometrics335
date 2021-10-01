# List of packages you want to install -- separated with a comma and surrounded in "quotes" 
packages <- c("tidyverse", "dplyr", "moments", "lmtest", "sandwich", "stringr", "readr", "here", "ggplot2")

# Installs packages
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}

# Loads packages
invisible(lapply(packages, library, character.only = TRUE))


df <- read.csv(here("Data/rural_atlas_merged.csv"))


save(rural_atlas, file = "rural_atlas.Rdata")
load(file = "rural_atlas.Rdata")

head(df)
summary(df)
str(df)
nrow(df)
ncol(df)

# Subset the df -- Metro 2013
metro2013 <- subset(df, Metro2013 == 1)


# 4. 
# a) Run a regression to determine the impact of the 2013 unemployment rate (UnempRate2013) on the per capita income (PerCapitaInc) in a county. What is the estimated slope? Explain what this number means in words in terms of the unemployment rate and in terms of per capita income. Also indicate if the relationship is statistically significant at the 10%, 5%, and 1% levels. For this first pass, use homoskedastic standard errors.

# (use lm to fit linear models) ex. lm(formula = testscr~str, caschool1)
model <- lm(formula = testscr~df, df)
summary(model)

# Robust t test
coeftest(model)

# 