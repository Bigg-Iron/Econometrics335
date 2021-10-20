# List of packages you want to install -- separated with a comma and surrounded in "quotes" 
packages <- c("tidyverse", "dplyr", "moments", "lmtest", "sandwich", "stringr", "readr", "here", "ggplot2", "modelr", "MASS", "knitr", "formatR", "car", "ggvis", "class", "gmodels", "caret")

# Installs packages
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}

# Loads packages
invisible(lapply(packages, library, character.only = TRUE))


head(iris)
#   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
# 1          5.1         3.5          1.4         0.2  setosa
# 2          4.9         3.0          1.4         0.2  setosa
# 3          4.7         3.2          1.3         0.2  setosa
# 4          4.6         3.1          1.5         0.2  setosa
# 5          5.0         3.6          1.4         0.2  setosa
# 6          5.4         3.9          1.7         0.4  setosa

str(iris)
# 'data.frame':	150 obs. of  5 variables:
#  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
#  $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
#  $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
#  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
#  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
# NULL

summary(iris)
#   Sepal.Length    Sepal.Width     Petal.Length    Petal.Width          Species  
#  Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100   setosa    :50  
#  1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300   versicolor:50  
#  Median :5.800   Median :3.000   Median :4.350   Median :1.300   virginica :50  
#  Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199                  
#  3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800                  
#  Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500                  

names(iris)
# [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species"     

# Iris scatter plot
iris %>% ggvis(~Sepal.Length, ~Sepal.Width, fill = ~Species) %>% layer_points()

# Overall correlation `Petal.Length` and `Petal.Width`
cor(iris$Petal.Length, iris$Petal.Width)
# [1] 0.9628654

# Return values of `iris` levels 
x=levels(iris$Species)
# [1] "setosa"     "versicolor" "virginica" 

# Print Setosa correlation matrix
print(x[1])
cor(iris[iris$Species==x[1],1:4])
#              Sepal.Length Sepal.Width Petal.Length Petal.Width
# Sepal.Length    1.0000000   0.7425467    0.2671758   0.2780984
# Sepal.Width     0.7425467   1.0000000    0.1777000   0.2327520
# Petal.Length    0.2671758   0.1777000    1.0000000   0.3316300
# Petal.Width     0.2780984   0.2327520    0.3316300   1.0000000

# Print Versicolor correlation matrix
print(x[2])
cor(iris[iris$Species==x[2],1:4])
#              Sepal.Length Sepal.Width Petal.Length Petal.Width
# Sepal.Length    1.0000000   0.5259107    0.7540490   0.5464611
# Sepal.Width     0.5259107   1.0000000    0.5605221   0.6639987
# Petal.Length    0.7540490   0.5605221    1.0000000   0.7866681
# Petal.Width     0.5464611   0.6639987    0.7866681   1.0000000

# Print Virginica correlation matrix
print(x[3])
cor(iris[iris$Species==x[3],1:4])
#              Sepal.Length Sepal.Width Petal.Length Petal.Width
# Sepal.Length    1.0000000   0.4572278    0.8642247   0.2811077
# Sepal.Width     0.4572278   1.0000000    0.4010446   0.5377280
# Petal.Length    0.8642247   0.4010446    1.0000000   0.3221082
# Petal.Width     0.2811077   0.5377280    0.3221082   1.0000000


set.seed(1234)

ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.67, 0.33))

# Compose training set
iris.training <- iris[ind==1, 1:4]

# Inspect training set
head(iris.training)

# Compose test set
iris.test <- iris[ind==2, 1:4]

# Inspect test set
head(iris.test)
#    Sepal.Length Sepal.Width Petal.Length Petal.Width
# 4           4.6         3.1          1.5         0.2
# 6           5.4         3.9          1.7         0.4
# 8           5.0         3.4          1.5         0.2
# 19          5.7         3.8          1.7         0.3
# 21          5.4         3.4          1.7         0.2
# 23          4.6         3.6          1.0         0.2

# Compose `iris` training labels
iris.trainLabels <- iris[ind==1,5]

# Inspect result
print(iris.trainLabels)

# Compose `iris` test labels
iris.testLabels <- iris[ind==2, 5]

# Inspect result
print(iris.testLabels)

# Build the model
iris_pred <- knn(train = iris.training, test = iris.test, cl = iris.trainLabels, k=3)

# Inspect `iris_pred`
iris_pred

# Put `iris.testLabels` in a data frame
irisTestLabels <- data.frame(iris.testLabels)

# Merge `iris_pred` and `iris.testLabels` 
merge <- data.frame(iris_pred, iris.testLabels)

# Specify column names for `merge`
names(merge) <- c("Predicted Species", "Observed Species")

# Inspect `merge` 
merge

CrossTable(x = iris.testLabels, y = iris_pred, prop.chisq=FALSE)
# 
#  
#    Cell Contents
# |-------------------------|
# |                       N |
# |           N / Row Total |
# |           N / Col Total |
# |         N / Table Total |
# |-------------------------|
# 
#  
# Total Observations in Table:  48 
# 
#  
#                 | iris_pred 
# iris.testLabels |     setosa | versicolor |  virginica |  Row Total | 
# ----------------|------------|------------|------------|------------|
#          setosa |         17 |          0 |          0 |         17 | 
#                 |      1.000 |      0.000 |      0.000 |      0.354 | 
#                 |      1.000 |      0.000 |      0.000 |            | 
#                 |      0.354 |      0.000 |      0.000 |            | 
# ----------------|------------|------------|------------|------------|
#      versicolor |          0 |         16 |          1 |         17 | 
#                 |      0.000 |      0.941 |      0.059 |      0.354 | 
#                 |      0.000 |      0.941 |      0.071 |            | 
#                 |      0.000 |      0.333 |      0.021 |            | 
# ----------------|------------|------------|------------|------------|
#       virginica |          0 |          1 |         13 |         14 | 
#                 |      0.000 |      0.071 |      0.929 |      0.292 | 
#                 |      0.000 |      0.059 |      0.929 |            | 
#                 |      0.000 |      0.021 |      0.271 |            | 
# ----------------|------------|------------|------------|------------|
#    Column Total |         17 |         17 |         14 |         48 | 
#                 |      0.354 |      0.354 |      0.292 |            | 
# ----------------|------------|------------|------------|------------|
# 
#  
# $t
#             y
# x            setosa versicolor virginica
#   setosa         17          0         0
#   versicolor      0         16         1
#   virginica       0          1        13
# 
# $prop.row
#             y
# x                setosa versicolor  virginica
#   setosa     1.00000000 0.00000000 0.00000000
#   versicolor 0.00000000 0.94117647 0.05882353
#   virginica  0.00000000 0.07142857 0.92857143
# 
# $prop.col
#             y
# x                setosa versicolor  virginica
#   setosa     1.00000000 0.00000000 0.00000000
#   versicolor 0.00000000 0.94117647 0.07142857
#   virginica  0.00000000 0.05882353 0.92857143
# 
# $prop.tbl
#             y
# x                setosa versicolor  virginica
#   setosa     0.35416667 0.00000000 0.00000000
#   versicolor 0.00000000 0.33333333 0.02083333
#   virginica  0.00000000 0.02083333 0.27083333
# 


# Create index to split based on labels  
index <- createDataPartition(iris$Species, p=0.75, list=FALSE)

# Subset training set with index
iris.training <- iris[index,]

# Subset test set with index
iris.test <- iris[-index,]


# Overview of algos supported by caret
names(getModelInfo())

# Train a model
model_knn <- train(iris.training[, 1:4], iris.training[, 5], method='knn')
# k-Nearest Neighbors 
# 
# 114 samples
#   4 predictor
#   3 classes: 'setosa', 'versicolor', 'virginica' 
# 
# No pre-processing
# Resampling: Bootstrapped (25 reps) 
# Summary of sample sizes: 114, 114, 114, 114, 114, 114, ... 
# Resampling results across tuning parameters:
# 
#   k  Accuracy   Kappa    
#   5  0.9454210  0.9166847
#   7  0.9464521  0.9183958
#   9  0.9424626  0.9121628
# 
# Accuracy was used to select the optimal model using the largest value.
# The final value used for the model was k = 7.


model_cart <- train(iris.training[, 1:4], iris.training[, 5], method='rpart2')


# Predict the labels of the test set
predictions<-predict.train(object=model_knn,iris.test[,1:4], type="raw")

# Evaluate the predictions
table(predictions)
# predictions
#     setosa versicolor  virginica 
#         12         13         11 

# Confusion matrix 
confusionMatrix(predictions,iris.test[,5])
# Confusion Matrix and Statistics
# 
#             Reference
# Prediction   setosa versicolor virginica
#   setosa         12          0         0
#   versicolor      0         12         1
#   virginica       0          0        11
# 
# Overall Statistics
#                                           
#                Accuracy : 0.9722          
#                  95% CI : (0.8547, 0.9993)
#     No Information Rate : 0.3333          
#     P-Value [Acc > NIR] : 4.864e-16       
#                                           
#                   Kappa : 0.9583          
#                                           
#  Mcnemar's Test P-Value : NA              
# 
# Statistics by Class:
# 
#                      Class: setosa Class: versicolor Class: virginica
# Sensitivity                 1.0000            1.0000           0.9167
# Specificity                 1.0000            0.9583           1.0000
# Pos Pred Value              1.0000            0.9231           1.0000
# Neg Pred Value              1.0000            1.0000           0.9600
# Prevalence                  0.3333            0.3333           0.3333
# Detection Rate              0.3333            0.3333           0.3056
# Detection Prevalence        0.3333            0.3611           0.3056
# Balanced Accuracy           1.0000            0.9792           0.9583


# Train the model with preprocessing
model_knn <- train(iris.training[, 1:4], iris.training[, 5], method='knn', preProcess=c("center", "scale"))

# Predict values
predictions<-predict.train(object=model_knn,iris.test[,1:4], type="raw")

# Confusion matrix
confusionMatrix(predictions,iris.test[,5])

