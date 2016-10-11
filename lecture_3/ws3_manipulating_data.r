##############################################################################
## Coding Worksheet 3: Manipulating Datasets & Fancy Visualizations
## Author: Amelia Bertozzi-Villa
## Description: Introduces 2-D arrays, loading data, installing libraries.
##              Runs through basic visualization using ggplot.
## Sections:
## I. Manipulating Datasets
##  1. data.table and Logical subsetting
##  2. Adding/removing/renaming columns
##  3. Merging
##  4. Reshaping

## II. Advanced Visualizations
##  1. Using color
##  2. Faceting
##  3. Multiple types of plot on one graph

## III. Time permitting: seeking help online
##############################################################################

library(data.table)
library(car)
library(ggplot2)

#########################
## I. Manipulating Data  
########################

## Good evening! Last week we learned a few dataset manipulation tricks using just the {base} package in R.
## Today we're going to get more in-depth, using one of my personal favorite R packages, data.table.

## 1. data.table and Logical Subsetting ---------------------------------------------------------

## Let's start by loading our salary data from last week.
data(Salaries)

## we can find out what *class* of object this is by typing:
class(Salaries)

## data.frame, as we'd expect from last class. Now, let's convert that dataset to a data.table:
Salaries <- data.table(Salaries)

## Now, query the class of 'Salaries' again. What do you see?

## The {data.table} library doesn't remove any functionality from data.frame objects, it just adds a lot of additional
## speed and ease of use. For example, remember that last lecture we learned that if we wanted to subset the dataset down
## to only, say, assistant professors, we'd have to type this
## subset <- Salaries[Salaries$rank=="AsstProf",]
## Which is repetitive and annoying. The data.table sytax is:
subset <- Salaries[rank=="AsstProf"]

## So much better! data.table also makes a lot of dataset operations run much more quickly. Most data manipulation we do in this
## class will involve data.table syntax. 

## By the way, this type of subsetting that we've been doing of the dataset, where we create a *logical statement* (e.g. 'rank=="AsstProf"')
## and select based on that statement, is known as *logical subsetting*. You use it a lot.

## 2. Adding, Removing, and Renaming Columns ---------------------------------------------------------

## Let's say we want to add a 'country of origin' column to our dataset, even though all the professors are American. 
## We would type:
Salaries[, country:= "USA"]

## Note both the starting comma AND the ':=' syntax for column assignment here. in data.table the first argument will always refer to 
## the rows, and the second argument to the columns, so if you're performing an operation on columns only you need to leave an empty
## argument for rows.

## Ok, say we decide that column is silly and we want to remove it. We simply set it to NULL:
Salaries[, country:=NULL]

## What if we don't like the convention of using periods in column names and want to change to underscores? We could say:
setnames(Salaries, "yrs.since.phd", "yrs_since_phd")

## You can use "setnames" to change as many column names as you like:
setnames(Salaries, c("yrs.service", "discipline"), c("yrs_service", "department"))

## 3. Merging and Conditional Column Construction ---------------------------------------------------------

## Let's say we learned from external sources that nationwide, the mean salary for male professors
## is $100,000 and for female professors is $90,000 [I just made these up]. We could add a new column
## reflecting this information using the ifelse() function:
Salaries[, nat_salary:= ifelse(sex=="Male", 100000, 90000)]

## Or, if you prefer, by sequentially subsetting the data:
Salaries[, nat_salary:= NULL] #delete our previous work
Salaries[sex=="Male", nat_salary:= 100000] # QUIZ: what does the 'nat_salary' column look like now?
Salaries[sex=="Female", nat_salary:=90000]

## This method of making a new column is called *conditional construction*.
Salaries[, nat_salary:=NULL] # Delete to prep for next example

## Now, what if we had nationwide salary data for males and females, by department? E.g a dataset like this:
nat_salaries <- data.table(department=c("A","A","B","B"),
                           sex=c("Male", "Female", "Male", "Female"),
                           nat_salary=c(70000, 65000, 130000, 115000))

## We could use a lot of conditional constructions/ifelse() commands to make a new column out of these, but it's much 
## easier to *merge* the two datasets based on their common columns. This would look something like:
Salaries <- merge(Salaries, nat_salaries, by=c("department", "sex"), all=T)

## Dataset merges are incredibly common, get used to them!

## 4. Reshaping ---------------------------------------------------------

## Let's create a dataset containing the mean salaries for each department-sex-rank
mean_salaries <- unique(Salaries[, list(mean_salary=mean(salary)), by=c("sex", "rank", "department")])

## What if we wanted to transform this dataset so that, for example, there were a separate column for each
## department, with the value being the mean salary in that department?
## This type of operation, of splitting columns up or mooshing them together, is known as a *reshape*.

## In R, splitting columns up is called *casting*.
cast_df <- dcast(mean_salaries, sex + rank ~ department, value.var="mean_salary")

## And mooshing the columns back together is called a *melt*:
melt_df <- melt(cast_df, id.vars = c("sex", "rank"), measure.vars = c("A", "B"), variable.name = "department", value.name = "salary")

## notice that 'melt_df' is identical to 'mean_salaries'.


###############################
## II. Advanced Visualizations  
###############################

## 1. Add color ---------------------------------------------------------

scatter_color <- ggplot(Salaries, aes(x=yrs_since_phd, y=salary, color=sex)) +
            geom_point() +
            labs(title="Salary by Years Since Ph.D and Sex",
                 x="Years Since Ph.D",
                 y="Salary (USD)")

## HERE: Also talk about size, opacity, deepen idea of aes vs not.


## 2. Add faceting ---------------------------------------------------------
scatter_facets <- ggplot(Salaries, aes(x=yrs_since_phd, y=salary, color=sex)) +
                  geom_point() +
                  facet_grid(~department) +
                  labs(title="Salary by Years Since Ph.D, Department, and Sex",
                       x="Years Since Ph.D",
                       y="Salary (USD)")

scatter_facet_twoway <- ggplot(Salaries, aes(x=yrs_since_phd, y=salary, color=rank)) +
                        geom_point() +
                        facet_grid(sex~department) +
                        labs(title="Salary by Years Since Ph.D, Department, Rank, and Sex",
                             x="Years Since Ph.D",
                             y="Salary (USD)")


## 3. Add line plots ---------------------------------------------------------
scatter_line <- ggplot(Salaries, aes(x=yrs_since_phd, color=sex, fill=sex)) +
                geom_bar() +
                geom_freqpoly() +
                facet_grid(~department) +
                labs(title="Salary by Years Since Ph.D, Department, and Sex",
                     x="Years Since Ph.D",
                     y="Salary (USD)")


## Exercise: make three plots. Each has to include at least one of these components: colors, faceting, plot overlays.
## Each of them must be labeled. Each must include both aes and non-aes components.
