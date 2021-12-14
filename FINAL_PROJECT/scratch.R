# Code


# Mortality Rate Model Specifications:
Mortality.model.1 <- lm(data_table_16$mortrate ~ data_table_16$indv_inc)

Mortality.model.2 <- lm(data_table_16$mortrate ~ data_table_16$indv_inc + data_table_16$gnd)

Mortality.model.3 <- lm(data_table_16$mortrate ~ data_table_16$indv_inc + data_table_16$gnd + data_table_16$indv_pctile)

Mortality.model.4 <- lm(data_table_16$mortrate ~ data_table_16$indv_inc + data_table_16$gnd + data_table_16$indv_pctile + data_table_16$age_at_d)


# Life Expectancy (Age at Death) Model Specifications:
Life.Expect.model.1 <- lm(data_table_16$age_at_d ~ data_table_16$indv_inc)

Life.Expect.model.2 <- lm(data_table_16$age_at_d ~ data_table_16$indv_inc + data_table_16$gnd)

Life.Expect.model.3 <- lm(data_table_16$age_at_d ~ data_table_16$indv_inc + data_table_16$gnd + data_table_16$indv_pctile)

Life.Expect.model.4 <- lm(data_table_16$age_at_d ~ data_table_16$indv_inc + data_table_16$gnd + data_table_16$indv_pctile + data_table_16$mortrate)



combined_life_expect <- lm(data = data_table_16, data_table_16$age_at_d ~ data_table_16$indv_pctile + data_table_16$indv_inc + data_table_16$gnd)
summary(combined_life_expect)
coeftest(combined_life_expect, vcov. = vcovHC, type = "HC1")

combined_mortality <- lm(data = data_table_16, data_table_16$mortrate ~ data_table_16$indv_pctile + data_table_16$indv_inc + data_table_16$gnd)
summary(combined_mortality)
coeftest(combined_mortality, vcov. = vcovHC, type = "HC1")



# gather clustered standard errors in a list
standard_errors <- list(sqrt(diag(vcovHC(Mortality.model.1, type = "HC1"))),
               sqrt(diag(vcovHC(Mortality.model.2, type = "HC1"))),
               sqrt(diag(vcovHC(Mortality.model.3, type = "HC1"))),
               sqrt(diag(vcovHC(Mortality.model.4, type = "HC1"))),
               
               sqrt(diag(vcovHC(Life.Expect.model.1, type = "HC1"))),
               sqrt(diag(vcovHC(Life.Expect.model.2, type = "HC1"))),
               sqrt(diag(vcovHC(Life.Expect.model.3, type = "HC1"))),
               sqrt(diag(vcovHC(Life.Expect.model.4, type = "HC1"))))


# STARGAZER TABLES
stargazer(Mortality.model.1, Mortality.model.2, Mortality.model.3, Mortality.model.4, Life.Expect.model.1, Life.Expect.model.2, Life.Expect.model.3, Life.Expect.model.4,
          digits = 3,
          header = FALSE,
          se = standard_err,
          type = "latex", 
          title = "combined life expectancy model",
          model.numbers = FALSE,
          out="new_models.txt")





# Plots and Graphs

# Plot Income and Mortality 
plot(x = data_table_16$indv_inc, 
     y = data_table_16$mortrate, 
     xlab = "Income",
     ylab = "Mortality Rate",
     main = "Mortality Rates and Income",
     col = "steelblue")
# Add trend line
abline(indiv_Income_Mortality_Model, col = "red")



# Plot Income and Life Expectancy
plot(x = data_table_16$indv_inc, 
     y = data_table_16$mortrate, 
     xlab = "Income",
     ylab = "Mortality Rate",
     main = "Mortality Rates and Income",
     col = "steelblue")
# Add trend line
abline(indiv_Income_Mortality_Model, col = "red")



# Plot Income Percentile and Mortality 
plot(x = data_table_16$indv_inc, 
     y = data_table_16$mortrate, 
     xlab = "Income",
     ylab = "Mortality Rate",
     main = "Mortality Rates and Income",
     col = "steelblue")
# Add trend line
abline(indiv_Income_Mortality_Model, col = "red")



# Plot Income Percentile and Life Expectancy 
plot(x = data_table_16$indv_inc, 
     y = data_table_16$mortrate, 
     xlab = "Income",
     ylab = "Mortality Rate",
     main = "Mortality Rates and Income",
     col = "steelblue")
# Add trend line
abline(indiv_Income_Mortality_Model, col = "red")


