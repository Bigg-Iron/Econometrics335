# List of packages you want to install -- separated with a comma and surrounded in "quotes" 
packages <- c("tidyverse", "dplyr", "moments", "lmtest","AER", "sandwich", "stringr", "readr", "here", "ggplot2", "modelr", "MASS", "knitr", "formatR", "here")

# Installs packages
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}

# Loads packages
invisible(lapply(packages, library, character.only = TRUE))

data(CASchools)

str(CASchools)

# define variables
CASchools$STR <- CASchools$students/CASchools$teachers       

CASchools$score <- (CASchools$read + CASchools$math)/2

# compute correlations
cor(CASchools$STR, CASchools$score)

cor(CASchools$STR, CASchools$english)

# estimate both regression models
mod <- lm(score ~ STR, data = CASchools) 

summary(mod)

mult.mod <- lm(score ~ STR + english, data = CASchools)

summary(mult.mod)


