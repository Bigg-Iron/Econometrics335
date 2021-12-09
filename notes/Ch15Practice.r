library(AER)
library(tidyverse)
library(readxl)
#install.packages("quantmod") # Remember, only do this once, hecne commented out with # to avoid running again. 
library(quantmod)
library(stargazer)
library(urca)
library(dynlm)

#Example 1
data(CASchools)   
CASchools$STR <- CASchools$students/CASchools$teachers       
CASchools$score <- (CASchools$read + CASchools$math)/2

model1 <- lm(score ~ STR, data = CASchools)
model1
summary(model1)

predict(model1, newdata = data.frame("STR" = 25))

#Example 2 using quarterly Macro Data
usmacro<-read.csv('us_macro_quarterly.csv')
names(usmacro) # see how varaibles names are in the csv file.

usmacro2 <- read_xlsx("us_macro_quarterly.xlsx",
                      sheet = 1,
                      col_types = c("text", rep("numeric", 9)))

names(usmacro2) # see how varaibles names are in the excel file.

# format date column
usmacro2$Date <- as.yearqtr(usmacro2$...1, format = "%Y:0%q")

# GDP series as xts object
GDP <- xts(usmacro2$GDPC96, usmacro2$Date)["1960::2013"]

plot(log(as.zoo(GDP)),
     col = "steelblue",
     lwd = 2,
     ylab = "Logarithm",
     xlab = "Date",
     main = "U.S. Quarterly Real GDP")

#Example 3 using annual macro data
#define series as xts objects
USUnemp <- xts(usmacro2$UNRATE, usmacro2$Date)["1960::2013"]

DollarPoundFX <- xts(usmacro2$EXUSUK, usmacro2$Date)["1960::2013"]

JPIndProd <- xts(log(usmacro2$JAPAN_IP), usmacro2$Date)["1960::2013"]

#Attach NYSESW data
data("NYSESW")  
NYSESW <- xts(Delt(NYSESW))

# divide plotting area into 2x2 matrix
par(mfrow = c(2, 2))

# plot the series
plot(as.zoo(USUnemp),
     col = "steelblue",
     lwd = 2,
     ylab = "Percent",
     xlab = "Date",
     main = "US Unemployment Rate",
     cex.main = 1)

plot(as.zoo(DollarPoundFX),
     col = "steelblue",
     lwd = 2,
     ylab = "Dollar per pound",
     xlab = "Date",
     main = "U.S. Dollar / B. Pound Exchange Rate",
     cex.main = 1)

plot(as.zoo(JPIndProd),
     col = "steelblue",
     lwd = 2,
     ylab = "Logarithm",
     xlab = "Date",
     main = "Japanese Industrial Production",
     cex.main = 1)

plot(as.zoo(NYSESW),
     col = "steelblue",
     lwd = 2,
     ylab = "Percent per Day",
     xlab = "Date",
     main = "New York Stock Exchange Composite Index",
     cex.main = 1)

# Can You Beat the Market?
# read in data on stock returns monthly data from 
#1931:1 to 2002:12 on excess returns of a broad-based 
#index of stock prices, the CRSP value-weighted index. 
SR <- read_xlsx("Stock_Returns_1931_2002.xlsx",
                      sheet = 1,
                      col_types = "numeric")

names(SR)

# convert to ts object
StockReturns <- ts(SR[, 3:4], 
                   start = c(1931, 1), 
                   end = c(2002, 12), 
                   frequency = 12)

# estimate AR models i.e., AR(1), AR(2) and AR(3) models of 
#excess returns for the time period 1960:1 to 2002:12.

# AR(1)
SR_AR1 <- dynlm(ExReturn ~ L(ExReturn),data = StockReturns, start = c(1960, 1), end = c(2002, 12))

# AR(2)
SR_AR2 <- dynlm(ExReturn ~ L(ExReturn) + L(ExReturn, 2), 
                data = StockReturns, start = c(1960, 1), end = c(2002, 12))

# AR(4)
SR_AR4 <- dynlm(ExReturn ~ L(ExReturn) + L(ExReturn, 1:4), 
                data = StockReturns, start = c(1960, 1), end = c(2002, 12))

# compute robust standard errors
rob_se <- list(sqrt(diag(sandwich(SR_AR1))),
               sqrt(diag(sandwich(SR_AR2))),
               sqrt(diag(sandwich(SR_AR4))))

# generate table using 'stargazer()'
stargazer(SR_AR1, SR_AR2, SR_AR4,
          title = "Autoregressive Models of Monthly Excess Stock Returns",
          header = FALSE, 
          model.numbers = F,
          omit.table.layout = "n",
          digits = 3, 
          column.labels = c("AR(1)", "AR(2)", "AR(4)"),
          dep.var.caption  = "Dependent Variable: Excess Returns on the CSRP Value-Weighted Index",
          dep.var.labels.include = FALSE,
          covariate.labels = c("$excess return_{t-1}$", "$excess return_{t-2}$", 
                               "$excess return_{t-3}$", "$excess return_{t-4}$", 
                               "Intercept"),
          se = rob_se,
          omit.stat = "rsq",
          out="table1.txt") 

#The results are consistent with the hypothesis of efficient financial 
#markets: there are no statistically significant coefficients in any of 
#the estimated models and the hypotheses that all coefficients are zero 
#cannot be rejected.

# plot logarithm of dividend yield series
# plot logarithm of dividend yield series
plot(StockReturns[, 2], 
     col = "steelblue", 
     lwd = 2, 
     ylab = "Logarithm", 
     main = "Dividend Yield for CRSP Index")

# test for unit root in GDP using 'ur.df()' from the package 'urca'
summary(ur.df(window(StockReturns[, 2], 
                     c(1960,1), 
                     c(2002, 12)), 
              type = "drift", 
              lags = 0))

#The Dickey-Fuller test statistic for an autoregressive unit 
#root in an AR(1) model with drift provides further evidence 
#that the series might be nonstationary.