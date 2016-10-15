##############################################################################
## Problem Set 2: Intro Stats & Linear Regression
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

## Go to https://vincentarelbundock.github.io/Rdatasets/datasets.html
## This is an excellent catalog of datasets that come built-in with R 
## libraries. Notice that it lists on the leftmost column which library
## the dataset belongs to. 

## Load and examine some of these datasets until you find one that you are interested in. The 
## dataset you choose must have at least four columns and at least twenty rows, though I would
## prefer a larger dataset if you can find one.

## Remember, to load a dataset into R you first need to install and load the relevant library.
## So for example if you wanted to look at the very first dataset (AirPassengers), which is 
## in the 'datasets' library, you would need to do the following:

## 1. If you've never used the 'datasets' library before, run 'install.packages("datasets")'
## 2. Load the library into your R workspace with 'library(datasets)'
## 3. Load the AirPassengers dataset with 'data(AirPassengers)'

## WRITE CODE HERE: Load the library your dataset is in, as well as data.table and ggplot.
## Load the dataset, and convert it to a data.table

## 2. Exploring your dataset -------------------------

## To see the documentation for your dataset, either type ?{datasetname} into the console, or 
## click the "DOC" link in the catalog above. This should show you what each column name means 
## and where the dataset came from.

## QUESTION 1: In one or two sentences, describe your dataset. Where is it from? What features
## does it contain? Why is it interesting?

## WRITE CODE HERE: Look at the 'summary' of your dataset. Make 2-3 exploratory plots that might help
## you understand what interesting relationships there are to explore in your data. 

## QUESTION 2: Have you found any interesting trends in your data? What are they (qualitatively)? Be brief.

#########################################
## II. Doing statistics to your dataset
#########################################

## 1. Sampling -------------------------------

## QUESTION 3: What is the population that your dataset was sampled from? Based on what 
## you can infer about how the data was collected, do you think it's an unbiased sample?

## 2. Bivariate linear regression -------------------------------

## WRITE CODE HERE: Run a simple bivariate regression on two columns of your dataset. What is the 
## value of your coefficient? What is your uncertainty? 

## QUESTION 4: What is your p-value from this regression? What does that p-value mean? Is it high or low?
## Why is it high or low (think of sample size, effect size, etc)?


## 3. Confounding & Multivariate regression  -------------------------------

## QUESTION 5: What are two possible confounders to the relationship you analyzed with that bivariate
## regression? How do you hypothesize they may have biased your results?

## WRITE CODE HERE: If your dataset includes columns for one or both of the confounders you discussed above,
## run a new regression including those confounders. If it doesn't include those specific confounders, either:
## 1. Run a regression including one or two other columns in your dataset, whether or not you think they're 
##    actually confounders (just to get practice running a multivariate regression).
## 2. Make up some fake data for one or both of the confounders you discussed above, add a column in the 
##    dataset with that fake data, and then run a multivariate regression including those confounders.

## QUESTION 6: How does the inclusion of new variables change the value of the coefficient (and uncertainty,
## and p-value) you got in your bivariate regression? What coefficient values did you get for your confounders?
## Are all of these relationships in the direction you expected?


## QUESTION 7: Are there other possible sources of bias in your data? (autocorrelation, heteroscedasticity,
## nonlinearity, problems with the data itself, etc)? If so, what are they? 



