#if not yet done, install tidyverse package using install.packages("tidyverse")
#Note: This package has many useful features which we will be using throughout the course. 

#call the package using:
library("tidyverse")

#call the dplyr package which uses a “grammar of data manipulation” which basically means that there’s a set of functions with logical verb names for what you want to do.
library("dplyr")

# Required for skewness()and kurtosis() functions
#install.packages("moments")
library(moments)

# The best is to read about these packages so you learn in detail the power of these packages and what you can do with them.Just google. Resources are plenty! 

#Now set your working directory and use the getwd command to see that the it is nicely set.
setwd('C:/Users/lackson/desktop/ECON335') #Of course this path depends on your location on your machine.
getwd()

#Now lets load our California school district example from Stock & Watson
caschool1 <- read.csv('data/caschool.csv') #this may be different depending on the defined paths.

#Inspect the data
head(caschool1) #look at first 6 rows (all columns)
str(caschool1) #structure # rows, cols, data types
nrow(caschool1) #number of rows
ncol(caschool1) #number of columns
names(caschool1) #column names
glimpse(caschool1)#to look at the variable names and types using one code.

#Statistics if we did not have missing values. Missing values in data are Coded by "NA" in R
summary(caschool1) #does summary stats for each column. From this you can get the sample size. 
mean_tscore<-summarize(caschool1, mean(testscr))

#Or to get all the stats of interest you can do it in once code.
summarize(caschool1, mean_tscore=mean(testscr), sd_tscore=sd(testscr), sk_tscore=skewness(testscr), k_tscore=kurtosis(testscr), n())

#HERE IS A NOTE FOR PS1: if we have missing values as in PS1 we get the Statistics like this. Just change the name of the file and the variable to the variable of interest
# looking at Per capita income to check for missing values. Read about R handles missing values in the analysis.

#Statistics
mean(caschool1$testscr, na.rm=TRUE)
sd(caschool1$testscr, na.rm=TRUE)
skewness(caschool1$testscr, na.rm=TRUE)
kurtosis(caschool1$testscr, na.rm=TRUE)
min(caschool1$testscr, na.rm=TRUE)
max(caschool1$testscr, na.rm=TRUE)

#So your PS code will look like. The last part na.rm=TRUE tells R that there are missing values and so should be taken into account when computing statistics
#mean(rural_atlas_merged$PerCapitaInc, na.rm=TRUE)
#sd(rural_atlas_merged$PerCapitaInc, na.rm=TRUE)
#skewness(rural_atlas_merged$PerCapitaInc, na.rm=TRUE)
#kurtosis(rural_atlas_merged$PerCapitaInc, na.rm=TRUE)
#min(rural_atlas_merged$PerCapitaInc, na.rm=TRUE)
#max(rural_atlas_merged$PerCapitaInc, na.rm=TRUE)

#Confidence intervals. Check the formula for the standard error.
#90% CI for Miu(y)={ybar+/-1.64SE(ybar)}
#95% CI for Miu(y)={ybar+/-1.96SE(ybar)}
#99% CI for Miu(y)={ybar+/-2.58SE(ybar)}

#654.1565+/-1.96(19.05335/sqrt(420))==>95%CI is (652.33,655.98)

#ggplot2 is a data visualization package of R that provides a general scheme for data visualization.
ggplot(data = caschool1) +  
  geom_point(mapping = aes(x = str, y = testscr), color="black")
  
#Restricting the sample...Subsetting is a very important component of data management and there are several ways that one can subset data in R.
small_class<-subset(caschool1, str<20)
summarize(small_class, mean_tscore=mean(testscr), sd_tscore=sd(testscr), sk_tscore=skewness(testscr), k_tscore=kurtosis(testscr), n())

large_class<-subset(caschool1, str>=20)
summarize(large_class, mean_tscore=mean(testscr), sd_tscore=sd(testscr), sk_tscore=skewness(testscr), k_tscore=kurtosis(testscr), n())

#Hint: Subseting for metro and non metro in PS1 use something like(note, it depends on how you name the data): metro <- rural_atlas_merged[rural_atlas_merged$metro13 == 1, ]
  