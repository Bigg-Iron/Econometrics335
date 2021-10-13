# List of packages you want to install -- separated with a comma and surrounded in "quotes" 
packages <- c("tidyverse", "dplyr", "moments", "lmtest", "sandwich", "stringr")

# Installs packages
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}

# Loads packages
invisible(lapply(packages, library, character.only = TRUE))


# Your code should go here ▼

