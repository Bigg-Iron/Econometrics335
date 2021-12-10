summary(data_table_16)


# subset the data (remove income values less than $1)
adjusted_income <- subset(data_table_16, indv_inc > 1)



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

