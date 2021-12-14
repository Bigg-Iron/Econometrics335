# Code


# Model Specifications:

# sink(file = "model_summaries.txt")

# Individual Income and mortality rate
indiv_Income_Mortality_Model <- lm(data_table_16$mortrate ~ data_table_16$indv_inc + data_table_16$gnd)
cat("Individual Income and Mortality Rate Model:")
cat("\n ---------------------------------------------------------------")
summary(indiv_Income_Mortality_Model)
coeftest(indiv_Income_Mortality_Model, vcov. = vcovHC, type = "HC1")


# Individual Income and Age at Death
indiv_Income_Age_at_Death_Model <- lm(data_table_16$age_at_d ~ data_table_16$indv_inc)
cat("Individual Income and Age at Death Model:")
cat("\n ---------------------------------------------------------------")
summary(indiv_Income_Age_at_Death_Model)
coeftest(indiv_Income_Age_at_Death_Model, vcov. = vcovHC, type = "HC1")


# Individual Income Percentile and Mortality Rate Model
indiv_Income_pctile_Mortality_Model <- lm(data_table_16$mortrate ~ data_table_16$indv_pctile)
cat("Individual Income Percentile and Mortality Rate Model: \n ")
summary(indiv_Income_pctile_Mortality_Model)
coeftest(indiv_Income_pctile_Mortality_Model, vcov. = vcovHC, type = "HC1")


# Income Percentile and Age at Death
indiv_IncomePercentile_Age_at_Death_Model <- lm(data_table_16$age_at_d ~ data_table_16$indv_pctile)
cat("Individual Income Percentile and Age at Death Model:")
cat("\n ---------------------------------------------------------------")
summary(indiv_IncomePercentile_Age_at_Death_Model)
coeftest(indiv_IncomePercentile_Age_at_Death_Model, vcov. = vcovHC, type = "HC1")

# sink()



# Plot Income and Mortality 
plot(x = data_table_16$indv_inc, 
     y = data_table_16$mortrate, 
     xlab = "Income",
     ylab = "Mortality Rate",
     main = "Mortality Rates and Income",
     col = "steelblue")
abline(indiv_Income_Mortality_Model, col = "red")



# gather clustered standard errors in a list
clustered_standard_errors <- list(sqrt(diag(vcovHC(indiv_Income_Mortality_Model, type = "HC1"))),
               sqrt(diag(vcovHC(indiv_Income_Age_at_Death_Model, type = "HC1"))),
               sqrt(diag(vcovHC(indiv_Income_pctile_Mortality_Model, type = "HC1"))),
               sqrt(diag(vcovHC(indiv_IncomePercentile_LifeExpectancy_Model, type = "HC1"))))


# STARGAZER TABLES
stargazer(indiv_Income_Mortality_Model, indiv_Income_Age_at_Death_Model, indiv_Income_pctile_Mortality_Model, indiv_IncomePercentile_LifeExpectancy_Model, 
          digits = 3,
          header = FALSE,
          se = clustered_standard_errors,
          type = "latex", 
          title = "Linear Panel Regression Models of Income and Life Expectancy",
          model.numbers = FALSE,
          out="stargazer_table.txt")

