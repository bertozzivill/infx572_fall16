##############################################################################
## Worksheet 4: Out of sample validation
## Author: Amelia Bertozzi-Villa
## Description: Give an example of out-of-sample validation, using the 
##              Salaries dataset. The question: which regression is better at
##              predicting salary, a bivariate regression on yrs.since.phd
##              or a multivariate regression including sex?
##############################################################################

## load libraries
library(data.table)
library(ggplot2)
library(car)

## set a random seed: this ensures that even randomly shuffling the dataset is replicable
set.seed(572)

## load data 
data(Salaries)
Salaries <- data.table(Salaries)

## Hold out a random 10% of the data
random_order <- sample(nrow(Salaries)) # the "sample" function randomly shuffles vectors
Salaries <- Salaries[random_order] # reorder the data according to the random_order vector
testing_set <- Salaries[1:40]
training_set <- Salaries[41:nrow(Salaries)]

## Run regressions on training set:
bivariate_regression <- lm(salary ~ yrs.since.phd, data=training_set)
multivariate_regression <- lm(salary ~ yrs.since.phd + sex, data=training_set)

## Predict new values for TESTING set, using the "newdata" argument
testing_set[, predict_bi:= predict(bivariate_regression, newdata = testing_set)]
testing_set[, predict_multi:= predict(multivariate_regression, newdata = testing_set)]

## Plot the predicted and actual values: bivariate results in blue, multivariate in red
ggplot(testing_set, aes(x=yrs.since.phd)) +
  geom_point(aes(y=salary)) +
  geom_point(aes(y=predict_bi), color="blue") +
  geom_point(aes(y=predict_multi), color="red") +
  labs(title="Out of sample validation results for two regression types",
       x="Years Since Ph.D",
       y="Salary")

## Calculate error statistic
## RMSE, or root-mean squared error, is calculated by:
## 1. Calculating how far off each prediction is from the actual value (the "error")
## 2. Squaring that value (the "squared error")
## 3. Taking the mean of all squared errors in the testing set (the "mean squared error")
## 4. Taking the square root of the mean squared error (the "root mean squared error"):

testing_set[, squared_error_bi:=(predict_bi - salary)^2]
testing_set[, squared_error_multi:=(predict_multi - salary)^2]

rmse_bi <- sqrt(sum(testing_set$squared_error_bi)/nrow(testing_set))
rmse_multi <- sqrt(sum(testing_set$squared_error_multi)/nrow(testing_set))

## We get a slightly lower RMSE value for the bivariate than the multivariate regression, which suggests that the bivariate regression 
## is more predictive (we want a LOW root-mean squared error). However, we've just looked at one random 10% holdout of the data. To be more thorough,
## we should see what happens when we hold out a different random 10% of the data, and then a different one, and then a different one... Usually, 
## out-of-sample validation like this is repeated many times, and the model with the lowest RMSE on average is considered the best one. 

## Test yourself: can you use a "for" loop to repeat the code above 10 times, and find the *average* RMSE for the bivariate and multivariate regressions?






