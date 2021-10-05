# List of packages you want to install -- separated with a comma and surrounded in "quotes" 
packages <- c("tidyverse", "dplyr", "moments", "lmtest", "sandwich", "stringr", "readr", "here", "ggplot2", "modelr", "MASS", "knitr", "formatR")

# Installs packages
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}

# Loads packages
invisible(lapply(packages, library, character.only = TRUE))

# Chapter 6
# estimate both regression models
mod <- lm(rural_atlas_merged$PerCapitaInc ~ rural_atlas_merged$UnempRate2013, data = rural_atlas_merged) 
mult.mod <- lm(rural_atlas_merged$PerCapitaInc ~ rural_atlas_merged$UnempRate2013 + rural_atlas_merged$Ed5CollegePlusPct + rural_atlas_merged$BlackNonHispanicPct2010 + rural_atlas_merged$HispanicPct2010, data = rural_atlas_merged)

# print the results to the console
mod
mult.mod
summary(mult.mod)
