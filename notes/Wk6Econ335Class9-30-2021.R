#Set your working directory.
#Of course this path depends on your location on your machine.
getwd()
setwd('C:/Users/lacks/OneDrive - Colostate/Colorado SU/PhD/6. Teaching Materials/Introduction to Econometrics/Fall 2021/R/ClassPractice/ECON335') 

#Call the different packages you may need especially "lmtest" and "sandwhich" 
#which are for the regression and R-SE packages respectively.
library("tidyverse")
library("dplyr")
library("moments")
library("lmtest")
library("sandwich")


#Now load California school district example from Stock & Watson
caschool1 <- read.csv('data/caschool.csv') #this may be different depending on the defined paths.

#Inspect the data
head(caschool1) #look at first 6 rows (all columns)
str(caschool1) #structure # rows, cols, data types
nrow(caschool1) #number of rows
ncol(caschool1) #number of columns
names(caschool1) #column names

#summary stats for each column. 
summary(caschool1) 

#Do a regression. To understand how linear modeling happens type '?lm' in the console window
model1<-lm(formula = testscr~str, caschool1)
summary(model1)

#In R the function coeftest from the lmtest package can be used in combination with the
#function vcovHC from the sandwich package to obtain heteroskedastic standard errors.
#Make sure required libraries are loaded

# Robust t test
coeftest(model1, vcov = vcovHC(model1, type = "HC0"))

#Compare coefficients
#Compare SE 

names(caschool1)
#Adding more regressors to your regression
Regression2<-lm(formula = testscr~str+el_pct, caschool1)
summary(Regression2)
#Robust Standard errors
coeftest(Regression2, vcov = vcovHC(Regression2, type = "HC0"))
#econometric intuition for different coefficients.

#Constrcut 90% confidence interval
#lower limiit of the CI
686.0322 - 1.64* 8.6969

#Upper limiit of the CI
686.0322 + 1.64* 8.6969

#(671.7693, 700.2951)

#Recall: We restricting the sample PS1.
small_class<-subset(caschool1, str<20)

large_class<-subset(caschool1, str>=20)

#Create a class size variable
#Hint: You don't have to do this for your PS2 Metro2013 variable because its already 
#a dummy variable.
caschool1$classsize<-ifelse(caschool1$str<20, 1, 0)
summary(caschool1)

Reg3<-lm(formula = testscr~classsize, caschool1)
summary(Reg3)
#Robust Standard errors
coeftest(Reg3, vcov = vcovHC(Reg3, type = "HC0"))

#Regression using only small classes:
Reg4<-lm(formula = testscr~str, small_class)
summary(Reg4)
coeftest(Reg4, vcov = vcovHC(Reg4, type = "HC0"))

#Regression using only small classes:
Reg5<-lm(formula = testscr~str, large_class)
summary(Reg5)
coeftest(Reg4, vcov = vcovHC(Reg5, type = "HC0"))
#Check significance
#Intuition

#Back to the full dataset
Reg6<-lm(formula = testscr~classsize+el_pct+meal_pct, caschool1)
summary(Reg6)
coeftest(Reg6, vcov = vcovHC(Reg6, type = "HC0"))

#Take Note!!!!
#Presentation Matters
#
#Typed word but convert to PDF before submitting.
#Timing of submission

#Here is some more coding to help you learn how to graph different plots such as Bar charts
#Piechart, Histogram, density plot, Linechart,Boxplot, Heat map, Wordcloud etc
#supposed you use inbuilt data set in R called mtcars...note you can view all in built data in R
#using the command "data()". Try it and you will see all the inbuilt data you can play with.

#So lets load mtcars data
mtcars

#1. Bar charts
counts<-table(mtcars$gear)
barplot(counts)

#2. horizontal bar chart
barplot(counts,horiz=TRUE)

#3. Pie Charts
#Piechart Syntax is: pie(attributes) i.e.,
#Consider a pie chart that contains values 10, 12, 4, 16, 8 as slices and US, UK, Au stralia, 
#Germany, and France as labels. Use pie(x,labels=) function to create the pie chart:
slices <-c(10, 12,4, 16,8) 
lbls <-c("US","UK", "Australia", "Germany", "France") 
pie( slices, labels = lbls, main="Simple PieChart")


#A 3-dim ensional pie chart
install.packages("plotrix")
library("plotrix")
slices <-c(10, 12,4, 16, 8) 
lbls <-paste(c("US", "UK", "Australia", "Germany","France"),"",pct,"%", sep="") 
pie3D(slices, labels=lbls,explode=0.0, main="3D PieChart")


#4. Histogram
mtcars$mpg #miles per gallon data 
hist(mtcars$mpg)



