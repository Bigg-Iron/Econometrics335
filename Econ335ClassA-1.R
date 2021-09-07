
# Basics
1 + 1

# create a variable that is equal to 5:
x <- 5

y <- 10

# Variables are assigned using “<-”, although “=” also works.

x + y

z <- x + y

print(z)

# Note that you can use other operations as well such as addition, subtraction, multiplication, division, etc
# Note: Variables in R are defined as vectors. So far x, y, and z are all vectors of 1.

w <- c(1, 2, 3, 4, 5, 6, 7, 8, 9) # vector

mean(w)
mean(1:9) # compute mean of natural numbers from 1 to 9
median(w)
sum(w)

# Some Visualizations
# Recall Chapter2 Roll a dice
rolldie <- sample(1:6, 1)

# generate the vector of probabilities
probability <- rep(1 / 6, 6)
# plot the probabilities
plot(probability,
     xlab = "outcomes",
     main = "Probability Distribution"
)

# generate the vector of cumulative probabilities
cum_probability <- cumsum(probability)
# plot the probabilities
plot(cum_probability,
     xlab = "outcomes",
     main = "Cumulative Probability Distribution"
)

# we can conveniently obtain densities of normal distributions using the function dnorm(). i.e., draw a plot of the N(0,1)
curve(dnorm(x),
     xlim = c(-2.5, 2.5),
     ylab = "Density",
     main = "Standard Normal Density Function"
)

# So far we're in Base R. Since changing the language is complicated, most innovation is done through PACKAGES. # nolint
# install.packages("tidyverse")
# Note: This package has many useful features which we will be using throughout the course.

# call the package using:
library("tidyverse")

# Required for skewness()and kurtosis() functions
install.packages("moments")
library(moments)

# Now lets load our California school district example from Stock & Watson
caschool1 <- read.csv("data/caschool.csv")

# Inspect the data
head(caschool1) # look at first 6 rows (all columns)
str(caschool1) # structure # rows, cols, data types
nrow(caschool1) # number of rows
ncol(caschool1) # number of columns
names(caschool1) # column names

# Statistics
summary(caschool1) # does summary stats for each column
mean_tscore <- summarize(caschool1, mean(testscr))

# Or
summarize(caschool1, mean_tscore = mean(testscr), sd_tscore = sd(testscr), sk_tscore = skewness(testscr), k_tscore = kurtosis(testscr), n())

# ggplot2 is a data visualization package of R that provides a general scheme for data visualization.
ggplot(data = caschool1) +
     geom_point(mapping = aes(x = str, y = testscr), color = "black")

# Restricting the sample...
small_class <- subset(caschool1, str < 20)