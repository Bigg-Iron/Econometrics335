
#Call the different packages you may need  
library("tidyverse")
library("dplyr")
library("moments")
library("lmtest")
library("sandwich")
library("car") #This is the package that allows you to obtain Robus F-Statistics

#Now load California school district example from Stock & Watson
caschool1 <- read.csv('Data/caschool.csv') #this may be different depending on the defined paths.

#Inspect the data
head(caschool1) #look at first 6 rows (all columns)

#To generate a new variable that is a log of one of the variables let's say the 
#logarithm of testscore, use the assignment operator <- to create new variables. 
#this is what we do:
#name_of_data_u_r_working_with$newvariablename<- read.csv('your_data_here.csv') for example
caschool1$logTestscore <- log(caschool1$testscr)

#use the "head()" function to see that your variable was created
head(caschool1) #You can see that the variabe is duly created at the end of all the variables.

#summary stats just for this newly created variable. 
summary(caschool1$logTestscore) 
sd(caschool1$logTestscore, na.rm = TRUE) #To get standard Deviation
length(caschool1$logTestscore) # To see the sample Size
skewness(caschool1$logTestscore, na.rm = TRUE) #To get skewness
kurtosis(caschool1$logTestscore, na.rm = TRUE) #To get kurtosis

#Do a regression including the newly created variable is very simple i.e., 
#use the new dependent variable i.e., logTestscore instead of TestScore. 
caschool_model1 <- lm(formula = logTestscore ~ str + el_pct + expn_stu, caschool1)
summary(caschool_model1)

# Of course don't forget to get robust S.Es using the Robust t test
coeftest(caschool_model1, vcov = vcovHC(model1, type = "HC0"))

  #To get robust F-statistics
  linearHypothesis(caschool_model1, c("str=0", "expn_stu=0"))




