# Code
sink(file = "data_structure_summary.txt")

cat("Summary statistics for table 16")
cat("\n-------------------------------------------------\n")

str(data_table_16)
cat("\n")
summary(data_table_16)


sink()



## Graphs and Figures
# Plot Income and Mortality 
plot(x = data_table_16$indv_inc, 
     y = data_table_16$mortrate, 
     xlab = "Income",
     ylab = "Mortality Rate",
     main = "Mortality Rates and Income",
     col = "steelblue")
abline(mortality_model, col = "red")


# estimate simple regression models
adjusted_income_model <- lm(age_at_d ~ indv_inc, data = adjusted_income)
summary(adjusted_income_model)
coeftest(adjusted_income_model, vcov. = vcovHC, type = "HC1")



# plot the observations and add the estimated regression line
# Adjusted income model (Income above $1)
plot(x = adjusted_income$indv_inc, 
     y = adjusted_income$age_at_d, 
     xlab = "Income",
     ylab = "Age",
     main = "Income and Life Expectancy",
     col = "steelblue")
abline(adjusted_income_model, col = "red")


# Individual Income and Mortality Rate model
mortality_model <- lm(mortrate ~ indv_inc, data = data_table_16)
summary(mortality_model)

# Plot Income and Mortality 
plot(x = data_table_16$indv_inc, 
     y = data_table_16$mortrate, 
     xlab = "Income",
     ylab = "Mortality Rate",
     main = "Mortality Rates and Income",
     col = "steelblue")
abline(mortality_model, col = "red")

# Income Percentile and Mortality Rate Model

# Individual Income and Age at Death Model


# Age and Mortality Rate model
age_mortality_model <- lm(mortrate ~ age_at_d, data = data_table_16)
summary(age_mortality_model)

coeftest(age_mortality_model, vcov. = vcovHC, type = "HC1")


# Plot Age and Mortality Rate
plot(x = data_table_16$age_at_d, 
     y = data_table_16$mortrate, 
     xlab = "Age",
     ylab = "Mortality Rate",
     main = "Mortality Rates and Age",
     col = "steelblue")
abline(age_mortality_model, col = "red")





# generate the table
stargazer(fatalities_mod1, fatalities_mod2, fatalities_mod3, 
          fatalities_mod4, fatalities_mod5, fatalities_mod6, fatalities_mod7, 
          digits = 3,
          header = FALSE,
          type = "latex", 
          se = rob_se,
          title = "Linear Panel Regression Models of Traffic Fatalities due to Drunk Driving",
          model.numbers = FALSE,
          column.labels = c("(1)", "(2)", "(3)", "(4)", "(5)", "(6)", "(7)"),
          out="table10.txt")

