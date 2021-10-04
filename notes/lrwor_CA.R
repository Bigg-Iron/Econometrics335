## # install the AER package (once)
install.packages("AER")
## 
## # load the AER package
library(AER)

# load the the data set in the workspace
data(CASchools)

class(CASchools)
head(CASchools)

# compute STR and append it to CASchools
CASchools$STR <- CASchools$students/CASchools$teachers 

# compute TestScore and append it to CASchools
CASchools$score <- (CASchools$read + CASchools$math)/2


# compute sample averages of STR and score
avg_STR <- mean(CASchools$STR) 
avg_score <- mean(CASchools$score)

# compute sample standard deviations of STR and score
sd_STR <- sd(CASchools$STR) 
sd_score <- sd(CASchools$score)

# set up a vector of percentiles and compute the quantiles 
quantiles <- c(0.10, 0.25, 0.4, 0.5, 0.6, 0.75, 0.9)
quant_STR <- quantile(CASchools$STR, quantiles)
quant_score <- quantile(CASchools$score, quantiles)

# gather everything in a data.frame 
DistributionSummary <- data.frame(Average = c(avg_STR, avg_score), 
                                  StandardDeviation = c(sd_STR, sd_score), 
                                  quantile = rbind(quant_STR, quant_score))

# print the summary to the console
DistributionSummary

plot(score ~ STR, 
     data = CASchools,
     main = "Scatterplot of TestScore and STR", 
     xlab = "STR (X)",
     ylab = "Test Score (Y)")

cor(CASchools$STR, CASchools$score)

attach(CASchools) # allows to use the variables contained in CASchools directly

# compute beta_1_hat
beta_1 <- sum((STR - mean(STR)) * (score - mean(score))) / sum((STR - mean(STR))^2)

# compute beta_0_hat
beta_0 <- mean(score) - beta_1 * mean(STR)

# print the results to the console
beta_1
beta_0

# estimate the model and assign the result to linear_model
# linear_model <- lm(formula = dependent_variable ~ independent_variable, data = DATA)
linear_model <- lm(score ~ STR, data = CASchools)

# print the standard output of the estimated lm object to the console 
linear_model


# plot the data
plot(score ~ STR, 
     data = CASchools,
     main = "Scatterplot of TestScore and STR", 
     xlab = "STR (X)",
     ylab = "Test Score (Y)",
     xlim = c(10, 30),
     ylim = c(600, 720))

# add the regression line
abline(linear_model) 

mod_summary <- summary(linear_model)
mod_summary
  
# The $R^2$ in the output is called *Multiple R-squared* and has a value of $0.051$. Hence, $5.1 \%$ of the variance of the dependent variable $score$ is explained by the explanatory variable $STR$. That is, the regression explains little of the variance in $score$, and much of the variation in test scores remains unexplained (cf. Figure 4.3 of the book).   

# The $SER$ is called *Residual standard error* and equals $18.58$. The unit of the $SER$ is the same as the unit of the dependent variable. That is, on average the deviation of the actual achieved test score and the regression line is $18.58$ points. 
 
