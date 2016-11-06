##############################################################################
## Problem Set 3: Machine Learning
## Author: Amelia Bertozzi-Villa
## Directions: Much of this script is a step-by-step guide for exploring new
##             datasets. There are also places where I'd like you to either 
##              write code (indicated by a "WRITE CODE HERE") label, or answer
##             a question in a comment (indicated by a "QUESTION") label. 

##             Your responses to questions should be in complete sentences, never
##             longer than a paragraph.
##############################################################################

######################################
## I. Finding and exploring a dataset 
######################################

## 1. Finding a dataset -------------------------

## Follow the instructions in problem set 2 to find a dataset you're interesting in exploring. This may be the same dataset
## you used last time, but you must make sure that it is appropriate to use for both *k-NN* and *K-means* analysis. 

## WRITE CODE HERE: Load the library your dataset is in, as well as data.table and ggplot.
## Load the dataset, and convert it to a data.table

## WRITE CODE HERE: Make at least 3 exploratory plots of your data. Because of the methods we're using right now, these should all 
## be scatter plots. At least one should be colored based on some factor variable in your dataset (e.g. a scatter plot of yrs.service vs salary,
## colored by rank in the "Salaries" dataset). 

## QUESTION 1: VERY BRIEFLY (~1 sentence) describe your dataset and what type of information it contains. Then, describe:
##            --What relationship you want to explore with k-NN, and why the dataset might be well-suited for such an analysis
##            --What relationship you want to explore with K-means, and why the dataset might be well-suited for such an analysis
## For both k-NN and K-means, refer to a specific exploratory plot that shows why the relationship you chose might be interesting/suitable for analysis.
## NOTE: for ease of visualization, please pick a three-variable relationship for k-NN (two continuous variables + a categorical class value to predict),
##       and a two-variable relationship for K-means (two continuous variables)


#########################################
## II. k-NN
#########################################
## WRITE CODE HERE:
## Run k-NN on the relationship you described in question 1. Use a test set 10-25% the size of your training set, and remember 
## to make it random! Test three different values of k, and make a plot showing predicted vs. actual class for each of them.

## QUESTION 2: For each value of k, what percentage of classes did k-NN accurately predict? Which value of k was most accurate? Why do you think 
## that is? 


#########################################
## III. K-means
#########################################

## WRITE CODE HERE: Pick a K, and run K-means on the relationship you described in question 1. Plot your variables, colored
## by their cluster. 

## QUESTION 3: Why did you pick the K you did? Do you think the algorithm found actual distinct elements of the dataset? If so, what do you think 
## differentiates the clusters? If not, why do you think the algorithm failed? 

#########################################
## IV. Review
#########################################

## QUESTION 4: What is the difference between supervised and unsupervised learning? Of the two algorithms we ran above, which is supervised and
## which is unsupervised? Why? 

## QUESTION 5: Based on your experience with supervised and unsupervised learning in this problem set, which type of machine learning do you think
## is most useful? Why? 

