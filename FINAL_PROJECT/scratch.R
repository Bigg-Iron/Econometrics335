summary(data_table_16)


model_1 <- lm(data_table_16$age_at_d ~ data_table_16$indv_inc)
summary(model_1)

plot(x = data_table_16$indv_inc, 
     y = data_table_16$age_at_d, 
     xlab = "Individual Income",
     ylab = "Age at Death",
     main = "Income and Life Expectancy",
     col = "steelblue",
abline(model_1))
