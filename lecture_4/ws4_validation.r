
## load libraries
library(data.table)
library(ggplot2)
library(car)

## load data 
data(Salaries)
Salaries <- data.table(Salaries)

## Run regressions
bivariate_regression <- lm(salary ~ yrs.since.phd, data=Salaries)
multivariate_regression <- lm(salary ~ yrs.since.phd + sex + sex*yrs.since.phd, data=Salaries)

## Predict regression outputs 
Salaries[, predict_bi:= predict(bivariate_regression)]
Salaries[, predict_multi:= predict(multivariate_regression)]

## Plot outputs
ggplot(Salaries, aes(x=yrs.since.phd)) +
  geom_point(aes(y=salary, color=sex), alpha=0.5) + 
  geom_line(aes(y=predict_bi), size=2) + 
  geom_line(aes(y=predict_multi, color=sex), size=2, alpha=0.75)
  

## Cross-validation: 
Salaries[, c("predict_bi", "predict_multi"):=NULL]

rmse_bi_list <- NULL
rmse_multi_list <- NULL

## Do this ten times:

for (idx in 1:10){
  ## Hold out a random 10% of the data
  random_order <- sample(nrow(Salaries))
  Salaries <- Salaries[random_order] #randomly reorder data
  testing_set <- Salaries[1:40]
  training_set <- Salaries[41:nrow(Salaries)]
  
  ## Run regressions on training set:
  bivariate_regression <- lm(salary ~ yrs.since.phd, data=training_set)
  multivariate_regression <- lm(salary ~ yrs.since.phd + sex + sex*yrs.since.phd, data=training_set)
  
  ## Predict new values for TESTING set
  testing_set[, predict_bi:= predict(bivariate_regression, newdata = testing_set)]
  testing_set[, predict_multi:= predict(multivariate_regression, newdata = testing_set)]
  
  ## Calculate error statistic
  testing_set[, squared_error_bi:=(predict_bi - salary)^2]
  testing_set[, squared_error_multi:=(predict_multi - salary)^2]
  
  rmse_bi <- sqrt(sum(testing_set$squared_error_bi)/nrow(testing_set))
  rmse_multi <- sqrt(sum(testing_set$squared_error_multi)/nrow(testing_set))
  
  rmse_bi_list[[idx]] <- rmse_bi
  rmse_multi_list[[idx]] <- rmse_multi
  
}

##Plot
ggplot(testing_set, aes(x=yrs.since.phd)) +
  geom_point(aes(y=salary, color=sex), alpha=0.5) + 
  geom_line(aes(y=predict_bi), size=2) + 
  geom_line(aes(y=predict_multi, color=sex), size=2, alpha=0.75)

library(stats)
## Tests for clustering
ggplot(Salaries, aes(x=yrs.since.phd, y=salary, color=rank)) + geom_point()

for_kmeans <- Salaries[, list(yrs.since.phd, salary)]
output <- kmeans(for_kmeans, 3)
Salaries[, kmean_rank:=output$cluster]

ggplot(Salaries, aes(x=yrs.since.phd, y=salary, color=factor(kmean_rank))) + geom_point()

