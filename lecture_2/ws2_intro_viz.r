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
##  2. Basic plotting in ggplot
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
data_frame[1:5,] # QUIZ: Why is it important to include the comma?

## To isolate rows based on the value of one of the columns (say, we only want to see the rows about the Beatles), 
## Use the following syntax:
data_frame[data_frame$affiliation=="Beatle",]

## Get an overview of the entire data.frame using summary():
summary(data_frame)

## NOTE: you can next commands within each other. So, if you wanted to summarize just 
## the data about Beatles, you could call:
summary(data_frame[data_frame$affiliation=="Beatle",])

## We'll go into a LOT more detail about data.frames and how to manipulate them next lecture,
## but for now this is all the information we need. 

## Interlude: Loading libraries ---------------------------------------------------------

## The standard version of R that you've recently downloaded is great, but it only includes so much stuff. 
## Over the years, researchers have found themselves thinking "man, I wish the plotting tools were better in R",
## or "man, I wish there were a bunch of useful datasets that I could easily load into R as examples", or 
## "man, I wish I could run a nonlinear hierarchical regression with this new optimization algorithm I just 
## heard about".

## The amazing thing about open-source languages like R is that, when users of the program have feelings like this,
## They can just write R code that does exactly what they want, and, if they think it will be useful to others, 
## they can make those tools publicly available. If the folks who maintain R collectively decide that this new
## *package* (aka *library*) is useful, they'll put it in a shared database so users can install it right from the R console.

## To use a library in R, there are two steps: First, you have to *install* it on your computer. You only have to do this 
## once. Let's say, for example, that we want to install the library "car", which contains some nice example datasets.
## The first step would be:
install.packages("car")

## Ok, now {car} is installed on our computer, but to save memory R doesn't automatically load that functionality into
## the active environment. In order to make all the functionality of your new library available to you, you need to 
## explictly ask for it using the library() function. So, to actually be able to use the elements of {car}, you would say:
library(car)

## and now you're ready to go! Usually, coders put all the librarys they need for a script at the very top of the script,
## so they're easier to keep track of. 

## We'll use the {car} library in the next section. Now it's your turn: can you install and load the package 
## {ggplot2} into this environment?

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

#########################
## II. Plotting in R  
########################

## 1. Plotting in {base} ---------------------------------------------------------

## The standard R that exists before you load in any libraries (which we denote by {base})
## has plotting functionality. Let's see what happens if we just throw our Salaries dataset
## at it.
plot(Salaries)

## Whoa! That did... something. What did that do?

## What if we only select two columns?
plot(Salaries[c("rank", "sex")])
plot(Salaries[c("sex", "yrs.since.phd")])
plot(Salaries[c("yrs.since.phd", "salary")])

## Ok, that's fine, it has some decent default functionality. But frankly it's ugly, it's unweildy,
## and we will never speak of it again. We'll move on to bigger and better things in the form of....

##     **
##    ****
##   ******
##  ********
## **********

## **ggplot2**

## **********
##  ********
##   ******
##    ****
##     **

## 2. Plotting in ggplot ---------------------------------------------------------

## ggplot (or, more specifically, its updated version ggplot2) is an extremely popular plotting library 
## for R. It's more involved than the simple plot() function we demo'd above, but it's also much more 
## versatile. We're just going to cover the basics now, but its power will become clear to you shortly. 

## If you didn't already load ggplot2 into your R environment, let's do that now.
library(ggplot2)

## Let's start by just looking at the most basic function in ggplot: ggplot() 
bare <- ggplot(Salaries)

## That did... nothing? 
## Not quite: it created an object called "bare" that, when you call it, gives us a blank grey slate.
## If you look at the *attributes* of this object, you'll see that it is indeed a lot of blank spaces
## waiting to be filled.
bare$layers
bare$theme
bare$mapping

## Next step: what are plot aesthetics?
aesthetic <- ggplot(Salaries, aes(x=yrs.since.phd, y=salary))

## Ok, adding "aes" (the plot *aesthetics*) is still mostly blank but gives us a little more information:
## it's populated an x and y axis onto the plot. 
## Broadly, an *aesthetic* is anything that maps data in the dataset onto some element of the plot (x axis location,
## y axis location, color, grouping, etc.) We'll get more into this later. Look at the "mapping" attribute 
## to see what the aesthetics have done. 
aesthetic$mapping

## Next: how do you put actual stuff on the plot?
## You have to add another function on to the end, saying what type of plot you want to make. 
## geom_point(), for example, will yield a scatterplot:
scatter <- ggplot(Salaries, aes(x=yrs.since.phd, y=salary)) +
  geom_point()

## Success! We have ourselves our first actual plot. To understand what geom_point() did, 
## let's take a look at the "layers" attribute of our three ggplot objects "bare", "aesthetic", and "scatter":
bare$layers
aesthetic$layers
scatter$layers

## QUIZ: what did geom_point() do?

## Ok, this scatter plot has been great fun, but can we make different types of plot? 

## LINE PLOT: geom_line:
line <- ggplot(Salaries, aes(x=yrs.since.phd, y=salary)) +
        geom_line()

## that looks weird! Which should make you think: what is the appropriate plot type to use here?

## BAR PLOT: geom_bar() (NOTE: can't have a y-value aesthetic for this one)
bar <- ggplot(Salaries, aes(x=yrs.since.phd)) +
          geom_bar()

## That's it for our intro plotting lesson. I know it was boring and not very colorful, so to prove to you 
## how cool ggplot is let me leave you with this, which you can create in six lines of code:

fancy <- ggplot(Salaries, aes(x=yrs.since.phd, y=salary)) +
              geom_point(aes(color=rank), alpha=0.6) +
              facet_grid(sex~discipline) +
              labs(title="Salary by Rank, Discipline, and Sex in an American University",
                   x="Years Since Ph.D",
                   y="Salary (USD)")

## See you next time!

