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

# plot the probabilites 
plot(cum_probability, 
     xlab = "outcomes", 
     main = "Cumulative Probability Distribution") 


