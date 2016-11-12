##############################################################################
## Worksheet 5: K-means and k-NN
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

library(kknn) # for k-nn
library(stats) # for k-means

## load data 
data(Salaries)
Salaries <- data.table(Salaries)

## --------------------
## 1. K-means 
## --------------------

## We want to run K-means on yrs.since.phd and salary, to see if we can find clusters
## corresponding to different ranks. Start by plotting those two variables, by rank,
## to see the "true" values:
ggplot(Salaries, aes(x=yrs.since.phd, y=salary, color=rank)) + 
  geom_point() +
  labs(title="Rank, by Years since Ph.D and Salary")

## Now, to set up for K-means: we only want the algorithm to look at years since phd and salary, so we 
## subset the dataset:
for_kmeans <- Salaries[, list(yrs.since.phd, salary)]

## Since we expect to see 3 different ranks, run k-means with k=3
## (the "centers" argument takes the number of clusters, run ?kmeans to see the full documentation)
output <- kmeans(for_kmeans, centers=3)

## "output" is an object of class "kmeans". One of the attributes of this object, "cluster",
## is a vector of all the different cluster assignments for the dataset. Let's add these predictions 
## to our original "Salaries" dataset.
Salaries[, kmean_rank:=output$cluster]

## What do the results look like? Close to the true "rank" distinctions?
ggplot(Salaries, aes(x=yrs.since.phd, y=salary, color=factor(kmean_rank))) +
  geom_point() +
  labs(title="Predicted Clusters, K=3")

## Hmm, it sort of just makes some horizontal bands across the surface. What if we did the same 
## thing, with k=5? This is no longer trying to compare the clustering algorithm to the "rank"
## variable, it's just playing around.
output_k5 <- kmeans(for_kmeans, centers=5)
Salaries[, kmean5_rank:= output_k5$cluster]
ggplot(Salaries, aes(x=yrs.since.phd, y=salary, color=factor(kmean5_rank))) +
  geom_point() +
  labs(title="Predicted Clusters, K=5")

## Nope, more bands!

## Test k-NN 
## lazy algorithm: ONLY tests the points you put in
## for any given test point, finds the k closest train points and assigns class to the most common among those k

train <- Salaries[1:350, list(yrs.since.phd, salary, rank)]
test <- Salaries[351:397, list(yrs.since.phd, salary, rank)]
knn_output <- kknn(rank~., train, test, k=100)
test[, predicted:=knn_output$fitted.values]

ggplot(test, aes(x=yrs.since.phd, y=salary)) +
geom_point(aes(color=rank), size=5, alpha=0.3) +
geom_point(aes(color=predicted))

  
  