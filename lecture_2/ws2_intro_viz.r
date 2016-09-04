##############################################################################
## Coding Worksheet 2: 2D Arrays and Visualizations 101
## Author: Amelia Bertozzi-Villa
## Description: Introduces 2-D arrays, loading data, installing libraries.
##              Runs through basic visualization using ggplot.
## Sections:
## I. 2D Arrays
##  1. Matrices
##  2. data.frames
## Interlude: Loading libraries
##  3. Loading data

## II. Visualizations
##  1. Plotting in {base}
##  2. What is ggplot?
##  3. Basic plotting in ggplot
##############################################################################

#####################
## I. 2D Arrays  
#####################

## Hello again! Remember last time when we defined an *array* as a collection of values that are all stored as a single object?
## at that point we were focusing manly on *1-dimensional arrays*, which are like a list (or, in the object type we used, a *vector*).
## But that's not the way we're used to viewing data. We're used to viewing things in a spreadsheet, like in Excel. R supports this 
## type of data format too, in a family of objects called *2-dimensional arrays*. 


## 1. Matrices ---------------------------------------------------------

## The simplest type of 2D array is called a *matrix*. It's just a 1D array like a vector organized into a set of columns and rows that you define.
## For example, you can take a vector of length 12:

oneD_array <- c(1,2,3,4,5,6,7,8,9,10,11,12)  # QUIZ: What's a more efficient way of generating this vector?

## And make it into a matrix like so:
twoD_matrix <- matrix(oneD_array, nrow=3, ncol=4)

## You can find the index of a matrix the same way you indexed a vector, only this time you need to include two index 
## values, one for each dimension (by convention, *row* comes before *column*)
twoD_matrix[1,2]
twoD_matrix[1,] # returns the entire first row
twoD_matrix[,1] # returns the entire first column

## 2. data.frames ---------------------------------------------------------

## Matrices are fine so far as 2D arrays go, but they have limited functionality for data manipulation (for example, all elements
## in a matrix must have the same type). In data science, we almost exclusively use an object type called a *data.frame* 
## Data.frames have named columns, can incorporate multiple data types, are easy to manipulate, and have all 
## the nice properties you've come to expect from, say, an Excel spreadsheet, along with many more. At their core, though, data.frames
## are 2D arrays just like matrices. 

## Let's make a sample data.frame:
data_frame <- data.frame(id_number=1:10,
                         name=c("John", "Paul", "Ringo", "George", "Harry", "Hermione", "Ron", "Rosalind", "Marie", "Ada"),
                         affiliation=c(rep("Beatle", 4), rep("Harry Potter", 3), rep("Science", 3)),
                         is_real=c(rep(T, 4), rep(F, 3), rep(T, 3)))

## You can isolate just a column using the $ symbol, or double brackets [[]]:
data_frame$name
data_frame[["name"]]

## Isolate certain rows using the index syntax you learned for matrices:
data_frame[5,]
data_frame[1:5,] # QUIZ: why is it important to include the comma?

## Get an overview of the entire data.frame using summary():
summary(data_frame)

## We'll go into a LOT more detail about data.frames and how to manipulate them next lecture,
## but for now this is all the information we need. 

## Interlude: Loading libraries ---------------------------------------------------------


## 3. Loading data ---------------------------------------------------------

## Thrilling as it is to enter all the values of a dataset manually, we don't want to spend our lives doing that.
## This is why we keep our data in things like spreadsheets or automatically generated formats. You *can* load data
## from a relative of an excel spreadsheet called a CSV (comma separated values file), and from a variety of other
## data formats, but R also comes with some pre-packaged datasets that you can load and look at using the data() function.

## These datasets mostly live in other libraries, though. Some good ones live in the {car} library we installed and loaded
## just a minute ago. Let's look at a dataset of professor salaries called "Salaries". Because we've already loaded the 
## {car} library, we just need to call data() on this dataset name to load the dataset.
data(Salaries)

## What does this look like?
Salaries

## Whoa, that's a lot of information! Let's use head() to just see the first few lines of the dataset
head(Salaries)

## That's better. It looks like our dataset has six columns, with pretty self-explanatory names:
##        rank: AssocProf, AsstProf, or Prof
##        discipline: A or B
##        yrs.since.phd: ranges from 1-56
##        yrs.service: ranges from 0-60
##        sex: Male or Female
##        salary: in USD, ranges from 57,800-231,545

## Let's use this dataset to practice some simple plots.



###---- below is the code from my guest lecture of Mike's class, to be poached as needed for this lecture
library(ggplot2)
library(data.table)
library(reshape2)
library(dplyr)

load("suicides.rdata")
all_suicides <- copy(suicides)
suicides <- suicides %>% 
  group_by(year, state, means) %>% 
  mutate(deaths = sum(deaths))

# start from the very basics: what is ggplot, alone?
bare <- ggplot(suicides)

# what are plot aesthetics?
aesthetic <- ggplot(suicides, aes(x=year, y=deaths))

# how do you put actual stuff on the plot?
scatter <- ggplot(suicides, aes(x=year, y=deaths)) +
  geom_point()

# split "means" out by color
color_by_means <- ggplot(suicides, aes(x=year, y=deaths, color=means)) +
  geom_point(size=3)

# facet out by state, toggle scales on and off
scatter_by_state <- ggplot(suicides, aes(x=year, y=deaths, color=means)) +
  geom_point(size=3) +
  facet_wrap(~state, scales="free")

# experiment with a different type of plot
line_by_state <- ggplot(suicides, aes(x=year, y=deaths, color=means)) +
  geom_line(size=3) +
  facet_wrap(~state, scales="free")

# experiment with a third type of plot. Also: plotting functions have aesthetics too!
bar_by_state <- ggplot(suicides, aes(x=year, y=deaths, color=means)) +
  geom_bar(aes(fill=means), stat="identity") +
  facet_wrap(~state, scales="free")

##------------------------------------------------------------------
## look at a one state example to explor other dimensions/plot formats
##------------------------------------------------------------------
one_state <- all_suicides[all_suicides$state=="Haryana"] %>% 
  group_by(year, state, sex, age, means) %>% 
  mutate(deaths = sum(deaths))


#multiple aes values per plotting function, facet_grid, labels
density_plots <- ggplot(one_state, aes(x=deaths)) +
  geom_density(aes(color=means, fill=means), size=1, alpha=0.5) +
  facet_grid(age~sex, scales="free") +
  labs(title="Distribution of Suicides by Age, Sex, and Means, 2001-2010",
       x="Deaths",
       y="Density")

one_state <- all_suicides[all_suicides$state=="Haryana"] %>% 
  group_by(year, state, means) %>% 
  mutate(deaths = sum(deaths))

#multiple plotting functions per plot (toggle color aes in geom_point)
point_line <- ggplot(one_state, aes(x=year, y=deaths)) +
  geom_line(aes(color=means), size=2) +
  geom_point(aes(shape=means, color=means),  size=3)

