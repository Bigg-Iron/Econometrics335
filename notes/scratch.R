packages <- c("dataRetrieval", "ggplot2", "tidyverse", "sandwich", "moments", "dplyr", "tidyr", "lmtest")

# Loads packages
lapply(packages, library, character.only = TRUE)



# Retrieve flow data for Poudre River
poudre <- readNWISdv(siteNumbers = '06752260',
                     parameterCd = c('00060'),
                     startDate = '2010-10-01',
                     endDate = Sys.Date())

head(poudre)

#Remove the first two columns
pq <- poudre[,-c(1,2,5)]

#Rename the remaining columns
names(pq) <- c('Date','q_cfs')

summary(pq)

# Plot the data
plot(pq$q_cfs ~ pq$Date, type = 'l', ylab = 'River Flow (cfs)', 
     xlab = 'Date',col = 'blue3')

as_tibble(rural_atlas_merged)
