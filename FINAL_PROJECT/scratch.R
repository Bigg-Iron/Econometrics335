# Code


# Mortality Rate Model Specifications:
Mortality.model.1 <- lm(data_table_16$mortrate ~ data_table_16$indv_inc)
summary(Mortality.model.1)
coeftest(Mortality.model.1, vcov. = vcovHC, type = "HC1")


Mortality.model.2 <- lm(data_table_16$mortrate ~ data_table_16$indv_inc + data_table_16$indv_pctile)
summary(Mortality.model.2)
coeftest(Mortality.model.2, vcov. = vcovHC, type = "HC1")


Mortality.model.3 <- lm(data_table_16$mortrate ~ data_table_16$indv_inc + data_table_16$indv_pctile + data_table_16$age_at_d)
summary(Mortality.model.3)
coeftest(Mortality.model.3, vcov. = vcovHC, type = "HC1")




# Life Expectancy (Age at Death) Model Specifications:
Life.Expect.model.1 <- lm(data_table_16$age_at_d ~ data_table_16$indv_inc)
summary(Life.Expect.model.1)
coeftest(Mortality.model.1, vcov. = vcovHC, type = "HC1")


Life.Expect.model.2 <- lm(data_table_16$age_at_d ~ data_table_16$indv_inc + data_table_16$indv_pctile)
summary(Life.Expect.model.2)
coeftest(Mortality.model.2, vcov. = vcovHC, type = "HC1")


Life.Expect.model.3 <- lm(data_table_16$age_at_d ~ data_table_16$indv_inc + data_table_16$indv_pctile + data_table_16$mortrate)
summary(Life.Expect.model.3)
coeftest(Mortality.model.3, vcov. = vcovHC, type = "HC1")




# Mortality Models standard errors in a list
mortality_standard_errors <- list(sqrt(diag(vcovHC(Mortality.model.1, type = "HC1"))),
               sqrt(diag(vcovHC(Mortality.model.2, type = "HC1"))),
               sqrt(diag(vcovHC(Mortality.model.3, type = "HC1"))))
               

# Life Expectancy Models standard errors in a list
Life_Expect_standard_errors <- list(sqrt(diag(vcovHC(Life.Expect.model.1, type = "HC1"))),
               sqrt(diag(vcovHC(Life.Expect.model.2, type = "HC1"))),
               sqrt(diag(vcovHC(Life.Expect.model.3, type = "HC1"))))



# Mortality Models STARGAZER TABLE
stargazer(Mortality.model.1, Mortality.model.2, Mortality.model.3,
          digits = 3,
          header = FALSE,
          type = "latex", 
          title = "Mortality Models",
          model.numbers = TRUE,
          out="mortality_table.txt")

# Life Expectancy Models STARGAZER TABLE
stargazer(Life.Expect.model.1, Life.Expect.model.2, Life.Expect.model.3,
          digits = 3,
          header = FALSE,
          type = "latex", 
          title = "Life Expectancy Models",
          model.numbers = TRUE,
          summary = TRUE,
          t.auto = TRUE,
          out="life_expect_table.txt")




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


df16 <- read_csv(here("./Data/health_ineq_online_table_16.csv"))
is.data.frame(df16)

panel_model <- plm(df16$age_at_d ~ df16$indv_inc, data = df16, index = "yod", model = "within")
summary(panel_model)

stargazer(panel_model,
          header = FALSE,
          type = "latex", 
          title = "panel model",
          model.numbers = TRUE,
          out="panelModel.txt")




df16 <- dummy_cols(df16, select_columns = 'gnd')

dummy.model <- lm(df16$age_at_d ~ df16$indv_inc + df16$gnd_M + df16$gnd_F)
summary(dummy.model)
