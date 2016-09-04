##############################################################################
## Coding Worksheet 1: What is Programming?
## Author: Amelia Bertozzi-Villa
## Description: Describes basic concepts of the R programming language in 
##              general and the RStudio user interface in particular. 
##              

## Sections:
## 1. Basic data types
## 2. Variables
## 3. 1-Dimensional Arrays
## 4. Logic and Loops
## 5. Functions
##############################################################################

## Hello new R user! Welcome to your first RStudio interaction. This stuff that you're reading up 
## here is all part of a *script* that I've written. A script is a set of programming commands 
## that you write down so you can run through them in whole or in part later. 

## Below the "script" section of Rstudio is the *console* section, which lets you submit R commands
## and see their output in real time. The console is also where you'll see any output from scripts you run.

## All of this text that's preceded by a "#" is a *comment*. Comments are ignored by R when you run a script,
## and are designed to aid human readers of scripts. You should always comment your code to help explain what 
## you're doing. 

## NOTE: To execute code in RStudio, hit Ctrl-Enter (or Command-Enter, for Mac users). This will execute whatever
##      line of code your cursor is on, or, if you select multiple lines, will run just those lines. Ctrl-Alt-B
##      will run the entire script up to the line your cursor is on.

## 1. Basic data types ---------------------------------------------------------
## Ok, let's see what this thing can do. Let's say you just want to do some math. Try typing the following into the console:
2+3
19-17
5*7
9/36
2^4

## What if you want the computer to display text to the screen? The command for that is called print(). Try, for example:
print("Hello, world!")

## What if you want to know whether something (say, an equation) is correct? The test for equality is denoted by "==":
2+2==4
5*11==20

## You can also ask if something is INcorrect, using "!=":
2+2!=4
5*11!=20

## The above examples give you a taste of the three fundamental data types of most programming languages: 
## 1. *numeric* values
## 2. *characters*, or *strings* (anything text based, within quotes)
## 3. true/false statements, often called *booleans*
## Almost everything you do in any programming language will simply be manipulating some of these three data types in intricate ways.

## 2.Variables  ---------------------------------------------------------

## What use is all of this information? What makes R different from just some fancy calculator or word processor?

## The utility of programming languages like R come from the fact that you can *store* values that you create in one step (say, adding two numbers)
## and use those saved values later in a different operation. These stored values are referred to by whatever name you give them. These stored values
## are known as *variables*. 

## Variables are assigned using the symbol *<-* in R. So, in our above example when we added 2+3, we could instead say:
a <- 2+3 

## Notice that no output is printed to the console when you run this command. But then, if you type in just the name of the variable,
## it will print out the value of that variable:
a

## And then you can manipulate this variable exactly the same way that you manipulated the original values:
5*a
a+3
a^4

## You can even use variables when creating new variables:
b <- a/3
b

## Variables can be assigned to any of our three basic data types:
# numeric
a <- 2+3

# character
text <- "Hello, World!"
print(text)
paste(text, "Nice to meet you") # the "paste" command concatenates strings

# logical
bool <- 2==4
bool

## Note 1: You can name variables whatever you want, the names I've chosen aren't special in any way. 
##        For example, this works just as well as what I've typed above:
goose <- "Hello, World"
print(goose)

## With great power comes great responsibility-- choose your variable names wisely. Ideally they should be relevant, descriptive, and fairly short.

## Note 2: In the top right of RStudio, in your "Environment" tab, it shows you all the variables currently loaded into RStudio. 
## You can find the same information by typing ls() into the console.

## 3. 1-Dimensional Arrays  ---------------------------------------------------------

## Often, we'll want to examine or manipulate multiple things (numbers, strings, what have you) in a group, either all at once or in sequence. 
## You'll want to make what in English we would call a list. The word *list* has a very specific meaning in most programming languages, so the more general
## term for this sort of structure is an *array*, specifically a *1-dimensional array*. An *array* is any collection of values that are all stored as a single object.
## In R the most common type of 1D array is called a *vector*. You create vectors with the command c():
numeric_vector <- c(1, 5, 8)
string_vector <- c("Hello", "World")
boolean_vector <- c(T,T,T,F)

## Notice that I assigned these three vectors to variable names, so they're stored in the environment. How would you check what each of these vectors looks like?

## QUESTION 1: Notice that all the elements of each vector are of the same type. What happens if you try to create a vector with mixed types? Experiment.

## To look at just one vector element at a time, select that element by its *index* (place in line). 
## So in our numeric_vector above, the number 1 has index 1, the number 5 has index 2, and the number 8 has index 3:
numeric_vector[1]
numeric_vector[2]
numeric_vector[3]

## To add elements to a vector, simply create a new vector that contains the old one:
numeric_vector <- c(numeric_vector, 5)

## To remove elements from a vector, use the following syntax:
numeric_vector <- numeric_vector[-4]

## QUESTION 2: what is the difference between the two snippets of code below?

## Snippet 1
this_vector <- c("duck", "goose", "swan")
this_vector[-3]

## Snippet 2
this_vector <- c("duck", "goose", "swan")
this_vector <- this_vector[-3]

## 4. Logic and Loops  ---------------------------------------------------------

## Familiarity with arrays gets us to the point where we can finally start talking about some of the most 
## powerful tools of programming: *logic*, which uses the commands *if*,  *else*, and *else if* to dictate how code gets 
## executed, and *loops*, which allow you to repeat a process many times using *for* and *while*

## Let's start by looking at a fairly involved loop, and break it down piece by piece The following code loops
## through the numbers 1:10, and prints "EVEN" if the number is even and "ODD" if it's odd.

sequence <- seq(1:10) # generates a vector of values from 1:10; equivalent of typing c(1,2,3,4,5,6,7,8,9,10)

for (element in sequence){ # loop through each item in the vector 'sequence', creating a variable called 'element' that contains that item
  print(paste("assessing evenness for element", element)) 
  
  if (element%%2==0){ # determine if the statement in parentheses is true or false, run the statement in brackets if true. NOTE:  %% is the function for finding the remainder
    print("EVEN")
  }else{  # if the statement in parentheses above is false, instead come to this section and run the statement in these brackets
    print("ODD")
  }
}

## As an example of how to use "else if", let's say we want to print something different at the letter 5:

sequence <- 1:10 # generates a vector of values from 1 to 10; equivalent of typing c(1,2,3,4,5,6,7,8,9,10)

for (element in sequence){
  print(paste("assessing evenness for element", element))
  
  if (element%%2==0){ # evaluate truth of statement in parentheses
    print("EVEN")
  }else if (element==5){ # if the statement above was false, come down here and evaluate *this* statement in parentheses
    print("FIVE")
  }else{  # if *both* the statements above were false, come down here and run the code in brackets
    print("ODD") 
  }
}

## *while* loops are much less common than *for* loops, but you might see them on occasion. Let's say you just want to print the word "Goose" ten times.
## Here's one way to do it:

idx <- 1
while (idx<11){
  print("Goose")
  idx <- idx+1  #iterate idx by one
}

## 5. Functions  ---------------------------------------------------------

## I want to leave you with a basic understanding of functions. A *function* is a piece of code that takes in *arguments* 
## and spits out *outputs* in a well-defined way. You've been using functions this entire time without even realizing it. 
## the print() command, for example, which outputs words to the console, is a function that takes as an input whatever 
## string you put within parentheses, and as its output prints that string to the console. Another example of functions we've seen
## so far is paste(), which has as its inputs multiple strings and outputs a single concatenated string. Just about every action you perform 
## on an object in R is done via functions.

## R has an incredible number of functions built in, and you can download many more by importing *libraries* of functions that others have made
## (see next worksheet). However, you can also make custom functions to make it easier to understand/run scripts.

## Let's say, for example, that determining whether a number is odd or even is something you'll have to do a lot. You could write the following function:

even_or_odd <- function(element){ ## the content here is the same as it was in your for loop
  if (element%%2==0){ 
    print("EVEN")
  }else{  
    print("ODD")
  }
}

## Then, you can *call* the function on a certain number with the syntax:
even_or_odd(4)

## One last thing: If you want to save the outputs of a function, you need to have the function *return* a value instead of just printing it. 
## For example:

even_or_odd <- function(element){ ## the content here is the same as it was in your for loop
  if (element%%2==0){ 
    return("EVEN") 
  }else{  
    return("ODD")
  }
}

what_is_4 <- even_or_odd(4)

## And now you have a variable called "what_is_4" with the value "EVEN".

## Whew, that was a lot of information! Go take a break, come back in a few for basic visualization.

