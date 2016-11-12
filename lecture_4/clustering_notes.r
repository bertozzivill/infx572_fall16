library(stats)
library(car)
library(data.table)
library(ggplot2)
## Tests for clustering

data(Salaries)
Salaries <- data.table(Salaries)

## K-means
## 1. start at K random centers
## 2. split the data points into K groups based on how close they are to the centers
## 3. Reassign centers to centroids of each group
## 4. Repeat until convergence
ggplot(Salaries, aes(x=yrs.since.phd, y=salary, color=rank)) + geom_point()

for_kmeans <- Salaries[, list(yrs.since.phd, salary)]
output <- kmeans(for_kmeans, 3)
Salaries[, kmean_rank:=output$cluster]

ggplot(Salaries, aes(x=yrs.since.phd, y=salary, color=factor(kmean_rank))) + geom_point()


## Test k-NN 
## lazy algorithm: ONLY tests the points you put in
## for any given test point, finds the k closest train points and assigns class to the most common among those k
library(kknn)
train <- Salaries[1:350, list(yrs.since.phd, salary, rank)]
test <- Salaries[351:397, list(yrs.since.phd, salary, rank)]
knn_output <- kknn(rank~., train, test, k=100)
test[, predicted:=knn_output$fitted.values]

example_point <- data.table(yrs.since.phd=16, salary=100000)

closest <- rbind(train[yrs.since.phd<19 & yrs.since.phd>13 & rank=="AssocProf" & salary>90000 & salary<109000],
                 train[rank=="Prof" & yrs.since.phd==16 & salary>100000 & salary<107000])


ggplot(train, aes(x=yrs.since.phd, y=salary)) +
  geom_point(aes(color=rank)) +
  geom_point(data=example_point, size=3, color="green3") +
  geom_point(data=closest, size=3, alpha=0.3, color="red") +
  labs(title="Since 3 of the 4 points are AssocProf, new rank is AssocProf")



ggplot(test, aes(x=yrs.since.phd, y=salary)) +
geom_point(aes(color=rank), size=5, alpha=0.3) +
geom_point(aes(color=predicted))

  
  