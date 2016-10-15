##############################################################################
## data.table exercise
## Author: Amelia Bertozzi-Villa
##############################################################################

library(data.table)

## Creating a data.table --------------------------------------------------------------
library(data.table)
## Create a data.table named DT that is ten elements long, with the following columns:
## V1: the integers 1-10 
## V2: the letters A and B, repeating
## V3: the integers 1-5, repeating
## V4: the following vector: c(4.55, 2.6, 90.9, 21.2, 4.81, 77.1, 4.4, 8.43, 5.09, 2.33)
custom_vector <- c(4.55, 2.6, 90.9, 21.2, 4.81, 77.1, 4.4, 8.43, 5.09, 2.33)

DT <- data.table(V1=1:10,
                 V2=c("A", "B"), # rep(c("A", "B"), 5)
                 V3=1:5,
                 V4=custom_vector)

## Subsetting on rows (i) --------------------------------------------------------------

## Select all rows in which V3 is equal to 4
DT[V3==4]
DT[V3 %in% 4]

## Select all rows in which V3 is equal to 3 or 4
DT[V3 %in% c(3,4)]
DT[V3==3 | V3==4]

## Select all rows in which V2 is equal to A
DT[V2=="A"]

## Subsetting on columns (j) --------------------------------------------------------------

## Select column V1
DT[, V1]

## Select columns V1 and V4
DT[, list(V1, V4)]

## Take the sum of column V4
DT[, sum(V4)]


## Return the sum of column V4 (named 'sum') and the maximum value of column V1 (named 'max')
DT[, list(sum=sum(V4), max=max(V1))]


## Doing (j) *by* group --------------------------------------------------------------

## Take the sum of column V4, by column V2
DT[, sum(V4), by=V2]

## Do the same as above, but name the summed column "sum_V4"
DT[, list(sum_V4=sum(V4)), by=V2]

## Do the same as above, but take the sum by column V2 and V3


## Adding/Updating columns --------------------------------------------------------------

## Create a new column, V5, equal to the minimum value of V4.


## Do the same thing, but grouping by column V2. 


## Delete column V5. 


## Create a new column, V6, equal to the standard deviation of V4, 
## AND a new column, V7, equal to the sum of V3, grouped by V2. 
## Note: do this in a single command.


## or : 


## Delete column V6 and V7. 




