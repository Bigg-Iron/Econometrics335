# Read in CA School data as CSV
surveys <- read.csv('data/caSchool.csv')

# Library help stats
library(help = 'stats')

sample(1:6, 3, replace = FALSE, prob = NULL)

# Generate the vector of probabilities
probability <- rep(1/6, 6)

# Plot the probabilities
plot(probability,
     xlab = "outcomes",
     main = "Probability Distribution") 

# generate the vector of cumulative probabilities 
cum_probability <- cumsum(probability) 

# plot the probabilities 
plot(cum_probability, 
     xlab = "outcomes", 
     main = "Cumulative Probability Distribution") 

# Vectors
y <- c(1,2,3,4,5)

# Functions:
# generate the vector `z`
z <- seq(from = 1, to = 5, by = 1)

# compute the mean of the entries in `z`
mean(z)

# Bernoulli Trials
# The set of elements from which sample() draws outcomes does not have to consist of numbers only. We might as well simulate coin tossing with outcomes  
# H (heads) and T (tails)
coin_toss <- sample(c("H", "T"), 1) 
