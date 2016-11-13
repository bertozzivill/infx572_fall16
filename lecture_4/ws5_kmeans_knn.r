##############################################################################
## Worksheet 5: K-means and k-NN
## Author: Amelia Bertozzi-Villa
## Description: Give an example of K-means and k-NN clustering methods, 
##              discussing some interpretations of each.
##############################################################################

## load libraries 
library(data.table)
library(ggplot2)
library(car)

library(kknn) # for k-NN
library(stats) # for K-means

## load data 
data(Salaries)
Salaries <- data.table(Salaries)

## Set a random seed 
set.seed(572)

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

## Since we expect to see 3 different ranks, run K-means with K=3
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
## thing, with K=5? (This is no longer trying to compare the clustering algorithm to the "rank"
## variable, it's just playing around.)
output_k5 <- kmeans(for_kmeans, centers=5)
Salaries[, kmean5_rank:= output_k5$cluster]
ggplot(Salaries, aes(x=yrs.since.phd, y=salary, color=factor(kmean5_rank))) +
  geom_point() +
  labs(title="Predicted Clusters, K=5")

## Nope, more bands!

## --------------------
## 2. k-NN 
## --------------------

## Ok, now let's run k-NN on those same variables: salary and years since Ph.D as predictors, rank as the outcome.

## remember, for k-NN we HAVE to split up our dataset into test and train sets, because there's nothing to predict if you don't. 

## randomly shuffle "Salaries"
new_order <- sample(nrow(Salaries))
Salaries <- Salaries[new_order]

## split this shuffled dataset in two: a training set with about 75% of the data, 
## and a test set with about 25%
train <- Salaries[1:350, list(yrs.since.phd, salary, rank)]
test <- Salaries[351:397, list(yrs.since.phd, salary, rank)]

## Run the k-NN algorithm, with k=10 to start (QUIZ: what does the "k" denote here? what did it denote in K-means?)
knn_output <- kknn(rank~., train, test, k=10)

## knn_output is an object of class "kknn", which has an attribute called "fitted.values" giving the algorithms prediction
## for each element of our training set. Notice that, because k-NN is a supervised learning method, these predictions are 
## of the same format (factor variable with values "AsstProf", "AssocProf", and "Prof") as our original rank variable, whereas
## K-means just gives you a cluster number because it doesn't know anything about the "rank" variable. 
test[, predicted_rank:=knn_output$fitted.values]

## Let's take a look at the results: plot the *predicted* outputs as dark circles, with a transparent circle around each one
## showing the true value for that point. The triangles show the *training* data
## used to make the predictions:

ggplot(test, aes(x=yrs.since.phd, y=salary)) +
  geom_point(aes(color=rank), size=5, alpha=0.3) +
  geom_point(aes(color=predicted_rank)) +
  geom_point(data=train, aes(color=rank), alpha=0.4, shape=2) +
  labs(title="Predicted (dark) vs Real (opaque) Ranks, k=10")

## In general, this did pretty well, but there are a few cases in which it mispredicted:
test[rank!=predicted_rank]

## Let's test a few other values of k, practicing our for loops:

k_values <- c(5, 10, 25, 50, 100)

for (this_k in k_values){
  
  ## run k-nn
  knn_output <- kknn(rank~., train, test, k=this_k)
  
  ## predict a new rank 
  test[, predicted_rank:=knn_output$fitted.values]
  
  ## predict results
  plot <- ggplot(test, aes(x=yrs.since.phd, y=salary)) +
            geom_point(aes(color=rank), size=5, alpha=0.3) +
            geom_point(aes(color=predicted_rank)) +
            geom_point(data=train, aes(color=rank), alpha=0.4, shape=2) +
            labs(title=paste0("Predicted (dark) vs Real (opaque) Ranks, k=", this_k))
  
  print(plot)
  
  ## Print out how many times it mispredicts
  number_wrong = nrow(test[rank!=predicted_rank])
  pct_wrong = number_wrong/nrow(test)
  print(paste0("With k=", this_k, " k-NN makes ", number_wrong, " incorrect predictions, ", pct_wrong, " percent."))
  
}

## Which value of k predicts best for this test/train set split? What could you do to ensure that this 
## result isn't just a result of the specific test/train split you used? 
  
  