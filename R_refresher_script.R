# Introduction to R BIOL4062/5062 - (ana.eguiguren@dal.ca) --------------
# Summary:
# 1. First movements - Setting up your work
# 2. Types of data and Data structures
# 3. Importing data 
# 4. Accessing bits of data: indexing
# 5. Packages and functions
# 6. Visualizing data
# 7. Making your own functions
# 8. Basics of linear models

#####################################################################################
##### Credits: Original - Mauricio Cantor
##### Modifications - Laura J. Feyrer, Ana Eguiguren)
####################################################################################


# 1. First movements - Setting up your workspace -------------------------------------------

# First of all, let's check our working directory 
# (where we get files from and save our work in)
getwd()

# you can change it using the function 'setwd()' and 
# pasting the directory path in quotes inside the parentheses
# note that in R we always use "/" instead of "\" on mswindows systems

setwd("C:/Users/firas/OneDrive/Desktop/BIOL4062/Refresher")

# You can also set up your working directory in Rstudio 
#by clicking in Session>Set Working Directory>Choose Directory; 
#or in R by clicking in File>Change Directory

# Let's take a look in what we have in our working directory
dir()

# If you are already sick of R, you can quit by typing:
#q()

# You can save your work before you go (useful sometimes)
save.image()#but remember to give it a useful name

##### ex, sept11_2023---- 

# Let's take a look in our workspace
ls()

# It's empty: no objects.Sure? what about x?
x
# See, there's no such object. Let's create one called x
x <- 2
# '<-' assigns values to objects, works the same as '='
# here is our object x

x


# Let's take another look in our workspace. See all you objects there?
ls()



# 2. Types of Data and Data Structures-----------------------------------------------------

# There are many types of data structures in R: vectors, matrices, 
#dataframes, arrays, lists, functions etc.
#that contain different types of data

# 2.a) Types of Data -----
# ~~~ NUMERIC 
a <- c(2,4,7,8)

a# prints the object
summary(a) #summarizes data

# mathematical operations can be done:
mean(a)# get the average

# ~~~ CHARACTER  
b <- c("hello", "goodbye", "goodbye")
b
summary(b)

# doesn't allow for mathematical operations
mean(b)# get the average

# ~~~ FACTORS
# factors act as categorical varaibles
c <- as.factor(b)
c
mean(c)
summary(c)
# Factors have categorical meaning, but when making a summary, R can understand each factor as a character

# ~~~ LOGICAL
# Any data that's true or false variables
d <- a == b
d
summary(d)
mean(d)# logical operation converts F = 0, T = 1


# 2.b) Types of objects -------

# different data types can be stored in different objects
# ~~~ VECTOR: one-dimensional sequence of values

# it can have numbers, characters, etc
num_vector <- c(3,6,9,12, 15)
num_vector
#R combines one number/character after another

char_vector <- c("Data", "analysis", "fun")
char_vector

char_vector2 <- c("Data", "analysis", 1)
# when we mix character with numbers, everything becomes character
char_vector2

#check data class stored within a vector:
data.class(char_vector2)
data.class(num_vector)

# ~~~ MATRIX AND DATA FRAMEs: 2 dimensions
# matrices are usually numerical

#calls for data, n rows, n cols
my_matrix1 <-  matrix(1:6, 2, 3, byrow = T)# data, rows, columns
#data is normally organized by columns, but in this case we specify that we want data to be organized by rows
#can organize vectors by columns or by rows (rbind = rows; cbind = columns) 
my_matrix2 <-  rbind(num_vector, num_vector) # or 'rbind()', 'cbind()' and others


# ~~~ DATA.FRAMES (regular tables) can contain numbers, characters or both
my_df <- data.frame(char_vector, char_vector2)
names(my_df) <- c("name", "order") #adding the names adds titles to the columns


# ~~~ LISTs are multidimensional objects of anything (shelf where each shelf holds different things)
# with any dimension (can have anything! even a model)
my_list <- list(x, num_vector, char_vector, my_df)
my_list

#lists hold each of the elements in a "slot" ->square brackets


# 2.c) useful f unctions for object types----
#2 ~~~ figuring data types and structure
class(my_df) 
data.class(my_df) #synonyms to classify data type or object type
class(x)

str(my_df) # see components of an object (what object made of)
summary(my_df) # summarize each of the components of an object (each column in a data frame)

str(my_list)
summary(my_list)

object <- c(1:10)
length(object) # number of elements or components
c(object,object) # combine objects into a vector
cbind(object, object) # combine objects as columns
rbind(object, object) # combine objects as rows 
object     # prints the object
rm(object) #removes object from environment
object


# 3. Importing data in R ------------------------------------

# 3.1 Let's import an external data file "Schoenemann".
# First, make sure the files are placed in your directory folder 
# directory

getwd()
dir()


# From a Comma Delimited Text File (.csv)
# first row contains variable names, comma is separator 
scho <- read.csv("Data/Schoenemann.csv", header=T, sep=",")
head(scho) #shows first few rows of a data frame
scho

# From a Tab delimited text file (.txt)
scho_txt <- read.table("Data/Schoenemann.txt", header=TRUE)
scho_txt



# 3.2 Make sure your data is correct
# Some functions that help us to check if the data was 
# input correctly: str(); dim(); head(); tail()

str(scho) # internal structure of the data
dim(scho) # dimensions (numbers of row and column)
head(scho) # column names and first rows (are the column names correct?)
tail(scho) # last rows
summary(scho)

# ~~~ saving data
write.csv(scho, "Data/Schoenemann_edited.csv")


# 4. Accessing bits of data: indexing ------------------------------------------

# Ok, now you have your objects, your own data in R.
# How do you access them?
# First thing: make sure they exist...
num_vector
my_matrix1
my_list
scho

# Each type of object has a specific way to manipulating 
# its values.
# Let's start with VECTORS: square brackets []
num_vector
num_vector[1] # the first element
num_vector[5] # the 5th element
num_vector[8] # there's only five, right?

# you can change specific entries of your vector:
num_vector[1] <- 6

num_vector[2] <- NA 

num_vector

# MATRICIEs: square brackets and commas [,] i.e. [row, column]
my_matrix1
my_matrix1[1,1] # first cell, row 1, column 1
my_matrix1[1,] # first row
my_matrix1[,1] # first column
my_matrix1[5,5] # out of bounds!


# LISTs: double square brackets [[]]
my_list
my_list[[1]] # that's our x
my_list[[2]] # that's our num_vector
my_list[[3]] # that's our matrix1
my_list[[2]][2] # that's the second element of the vector
my_list[[4]][,2] # that's the third column of the dataframe ...


# DATA FRAME: dollar sign $ to access the columns, typing the column names
scho$Mass

# or...you can use the functions 'attach()' and 'detach()':
attach(scho) # scho was copied to the workspace; the column names became objects and we can simply access them by typing their names
Mass

# but remember to 'detach' your dataframe when your done:
detach(scho)
Mass # see? an error, R doesn't recognize it anymore

# you can also call single datapoints of a dataframe:
scho$Mass[5] # gives you the 5th mass entry
scho$Mass[5] <- NA # assign a new value to that entry


scho[5,] #gives you the 5th row

scho[,5] #gives you the 5th column



# conditional indexing
# sometimes you want to extract the datapoints that meet certain
# conditions 

scho$Mass[which(scho$Mass < 100)]# get the values that meet a condition
which(scho$Mass < 100)# get the index of rows that meet a condition (which rows have values <100)

which(is.na(scho$Mass)) #find which values in a Mass column are not a number

# you can create a new dataframe that includes only rows that
# meet a certain condition:

scho_big <- scho[-which(scho$Mass<100),]
#"-" means you want to exclude some data
#this means that scho_big will include all the rows of scho
# Except those whose weight is less than 100. 
# the "-" sign excludes rows

scho_clean <- scho[-which(is.na(scho$Mass)),]
# here you are removing all rows that have NA'values


# you can also do a dataframe that only includes those instances:

scho_small <- scho[which(scho$Mass<100),]

#only the lightest individuals weighing less than a 100


# 5. Functions and packages ----------------------------------

# Functions are objects too. The basic structure of a function is:
# function(argument1 = value, argument = value, ...)
# everytime you have an object with followed by parentheses,
# there is a function
# Inside the parentheses you can place the function arguments

# If you type the function's name with no parentheses 
# you will get the code for the function:

data.frame


# Example: the function 'mean()' returs the mean value of a object
mean(num_vector, na.rm =T)
# type the function with nothing inside the parentheses 
#and get a error!
mean()

# 3.1 There are SO MANY functions in R. How do we figure out 
#how they work? 
#HELP!
help(mean)
?mean

# this will lead you to the help page with 
#the description of the function, how you use it, 
#what arguments it has, retuned values, references, 
#examples...everything you need to know how any function works



# 4.2 Where are the functions?
# R has several base functions and many, 
# many others created by users around the world.
# Formally they are organized into modules, called packages. 
# They come in a standardized way, with the help files, 
# to help users understandand how to use them. 
# We have access to virtually any kind of function in the CRAN 
# repository.
# A repository is a "place" where a lot of packages are stored
# and from which they can be accessed
# Examples inlcude CRAN and GitHub
# First, let's see the packages you already have installed:
installed.packages()

# Let's install the package "vegan" that contains many useful ecological tools. We can do it by typing:
install.packages("vegan")

# or going in Tools>Install packages> 
# Select a CRAN> select the package you want. 
# Google is good to figure out which package has the function you want
# Now, and everytime you start a new R session, you have to 
# load the packages you will use. Go ahead and type

library(vegan)
help(package="vegan") # take a look in the package documentation

citation("vegan")

# install Packages from GitHub
library(devtools)
devtools::install_github("hadley/babynames", force = TRUE)
library(babynames)




# 6. Summarizing and visualizing data -------------------------------------------------------

# Basic functions for summarizing your data
# This are the basic functions to explore your data. Their names are pretty self-explanatory: 
# mean(), var(), sd(), min(), max(), range(), sum(). 
# They operate in the entire object

num_vector <- rnorm(50, mean = 20, sd = 10)
num_vector
summary(num_vector) # the basics all together
mean(num_vector)
median(num_vector)
var(num_vector)
sd(num_vector)
min(num_vector)
max(num_vector)
range(num_vector)
quantile(num_vector)
IQR(num_vector) # inter quarter range
sum(num_vector)
cumsum(num_vector) # cumulative sum


# Hint: the function 'apply()' is a nice way to 
#apply any kind of function to parts of you data frame, 
#matrix, array. It basically work like this:
# apply(X, MARGIN, FUN), where X is the object; 
#MARGIN is 1(row) or 2(column); and FUN is the function 
?apply # to explore examples 
my_matrix1

apply(my_matrix1, MARGIN=1, FUN=mean) # mean values for each row
apply(my_matrix1, MARGIN=2, FUN=mean) # mean values for each column



# Exploring factor data with tapply
scho # this is the csv data we imported from the Schoenemann dataset
# available in the course excel files
# the function 'tapply()' is the right tool for the job:
# tapply(X, INDEX, FUN); same as before, but now INDEX 
# is the factor

#first, transform into factors
#we want location to be as a factor
scho$Location_f <- factor(scho$Location.)
scho$Order_f <- factor(scho$Order.)



tapply(scho$Fat, INDEX = scho$Location_f, FUN=mean)

# or the standard deviation of Fat..
tapply(scho$Fat, INDEX = scho$Location_f, FUN=sd)
# and so on
#INDEX means summarize by..

# Hint: Contingency tables - the 'table()' function
# also indicates how many samples/category

table(scho$Location_f) #This is particularly useful for plotting (see below)
table(scho$Location_f, scho$Order_f)
# this is even more useful when we have MORE than one category!!



# 6b. Basic plotting  ------------------

# Let's cover the very basics of plotting in R: again, 
# we create objects, use functions and voilá!
# We will not cover formatting details. 
# It's a bit of work to get a nice plot in R (by nice plot I mean one ready for publication). Again, it's worthy anyway, because we get a script to generate the figure as many times you wish later. And you can share the code (or reuse it later)

# Histograms and barplots: frequency
hist(scho$Fat)
hist(scho$Fat, breaks=20) # a little more detail
hist(scho$Mass, breaks=20) # a little more detail

# Barplots for number of cases
#table function is useful here
barplot(table(scho$Location_f))

# Scatterplots (x vs y)
plot(scho$Fat, scho$Mass) # plot where x = Fat, y = Mass
plot(scho$Mass ~ scho$Fat) # plot where x = Fat, y = Mass too
scatter.smooth(scho$Mass ~ scho$Fat) # add a trend line

# Basic formatting
plot(scho$Fat, scho$Mass, col = "blue", cex = 1, pch = 19)
# col = color (numbers or names, google options)
# cex = relative size
# pch = type of point - PLAY withe the options

levels(scho$Order_f)

# add only carnivores to see if there's a pattern
plot(scho$Fat[which(scho$Order_f == "Carnivora")], 
     scho$Mass[which(scho$Order_f == "Carnivora")], 
     col = 'blue', cex = 1, pch = 19)

# if I want this to go over my previous graph, 
# I can add points
plot(scho$Fat, scho$Mass, col = 1, cex = 1, pch = 19)
points(scho$Fat[which(scho$Order_f == "Carnivora")], 
     scho$Mass[which(scho$Order_f == "Carnivora")], 
     col = 2, cex = 1, pch = 19)


# Color points by category
plot(scho$Fat, 
     scho$Mass, col = scho$Order_f, cex = 1, pch = 19)
#turns each factor level into a number that corresponds to a color

# Box plot
boxplot(scho$Mass)#one variable (numerical)
boxplot(scho$Mass ~ scho$Location_f)# One numerical variable as a function of a categorical variable
?boxplot

# Density plots
plot(density(scho$Fat))

# 6 BONUS ~~~ Brief intro to ggplot----
# taken and modified from Rebecca Barter:
# URL: http://www.rebeccabarter.com/blog/2017-11-17-ggplot2_tutorial/

# 1. install & upload package
# installl.packages("ggplot2")
library(ggplot2)#first install this package

# 2. BONUS! you can upload data directly
gapminder <- read.csv("https://raw.githubusercontent.com/zief0002/miniature-garbanzo/main/data/gapminder.csv")
# this will fail if you are not connected to internet though

# 3. see what is in there
head(gapminder)
str(gapminder)



# 4. Start plot:
# ggplots are built in layers, to which you add elements
# the first bit is a "canvas" that holds the x and y axis

ggplot(gapminder, aes(x = income, y = life_exp))
# we are telling the function to use the "gapminder dataset"
# and to draw the x axis based on gdp/capita and y axis as life expectancy
# but this is still a blank canvas

# 5. Populate plot 
# start adding things by following your "canvas function" by a
# + sign:
p<- ggplot(gapminder, aes(x = income, y = life_exp)) +
  geom_point() # add a points layer on top


# 6. Make things easier to see

# you can modify the format of your points by adding 
# specifications within  gemo_point() 
# alpha = transparency (0 - 1)
# col = color (explore RColor Palettes for options)
# size = point size

p +
  geom_point(alpha = 0.5, col = "cornflowerblue", size = 0.5)

# you can also color each point by a category:
# here, because we are plotting color based on a variabe, we
# add it to the aes() input
# so that now points are colored by continent

ggplot(gapminder, aes(x = income, y = life_exp, color = region)) +
  geom_point(alpha = 0.9, size = 2)


# you can also modify the size of points based on a variable
# so that bigger points show larger populations

ggplot(gapminder, aes(x = income, y = life_exp, color = region, 
                      size = population)) +
  geom_point(alpha = 0.5)


# To make things easier to see, we will look at
# only one year at a time

library(dplyr)
# the dplyr package allows another way to access
# bits of your data
# this can be read as:
# First, take "gapminder" data and THEN
# filter out data for the americas
gapminder_Am <- gapminder %>% filter(region == "Americas")
summary(gapminder_Am)

#NOTE: %>% means "then"
# first we replicate our previous plot
# it is now a bit easier to see patterns

ggplot(gapminder_Am, aes(x = income, y = life_exp, color = co2_change , size = population)) +
  geom_point(alpha = 0.5)


# because there is so much variation in income, it 
# may be easier to see it in a logarithmic scale

ggplot(gapminder_Am, aes(x = income, y = life_exp, color = co2_change , size = population)) +
  geom_point(alpha = 0.5) +
  scale_x_log10()# this prints the x axis in a log10

# you can now add more informative titles using the
# + labs() element

ggplot(gapminder_Am, aes(x = income, y = life_exp, color = co2_change , size = population)) +
  # add scatter points
  geom_point(alpha = 0.5) +
  # log-scale the x-axis
  scale_x_log10() +
  # change labels
  labs(title = "Income versus life expectancy in the Americas",
       x = "Income per capita (log scale)",
       y = "Life expectancy",
       size = "Popoulation",
       color = "CO2 chage")


# and make things prettier by adding the
# + themes() options
ggplot(gapminder_Am, aes(x = income, y = life_exp, color = co2_change , size = population)) +
  # add scatter points
  geom_point(alpha = 0.5) +
  # log-scale the x-axis
  scale_x_log10() +
  # change labels
  labs(title = "Income versus life expectancy in the Americas",
       x = "Income per capita (log scale)",
       y = "Life expectancy",
       size = "Popoulation",
       color = "CO2 chage")+
       theme_classic()

# add labels!
# I want to know where Ecuador fits here
ggplot(gapminder_Am, aes(x = income, y = life_exp, color = co2_change , size = population)) +
  # add scatter points
  geom_point(alpha = 0.5) +
  # log-scale the x-axis
  scale_x_log10() +
  # change labels
  labs(title = "Income versus life expectancy in the Americas",
       x = "GDP per capita (log scale)",
       y = "Life expectancy",
       size = "Popoulation",
       color = "Continent")+
       theme_classic() +
    geom_text( 
    data=gapminder_Am %>% filter(country == "Ecuador"), 
    # Filter data first
    aes(label=country))
  
# save your plot 
# first put it in an object:
p <- ggplot(gapminder_Am, aes(x = income, y = life_exp, color = co2_change , size = population)) +
  # add scatter points
  geom_point(alpha = 0.5) +
  # log-scale the x-axis
  scale_x_log10() +
  # change labels
  labs(title = "Income versus life expectancy in 2007",
       x = "Income per capita (log scale)",
       y = "Life expectancy",
       size = "Popoulation",
       color = "Continent")+
       theme_classic() +
    geom_text( 
    data=gapminder_Am %>% filter(country == "Ecuador"), 
    # Filter data first
    aes(label=country))
  


plot(p)



ggsave("Outputs/beautiful_plot.png", p, 
       dpi = 500, width = 10, height = 10)
#dpi = resolution



# you can also overlap things:
# here, we have the initial point graph + a smoother line
ggplot(gapminder_Am, aes(x = income, y = life_exp, color = co2_change , size = population)) +
  geom_point(alpha = 0.5) +
  geom_smooth(se = FALSE, method = "loess", color = "grey30")

# 7.b Different types of plots
# instead of points, you can create a line plot
# (note how contents in the aes() change)
ggplot(gapminder, aes(x = income, y = life_exp,
                      color = region)) +
  geom_line(alpha = 0.5)



# a boxplot
# (try replacing "fill" by "col")
ggplot(gapminder, aes(x = region, y = co2, 
                      fill = region)) +
  geom_boxplot()
# a histogram
# explore modifying the bindwidth

ggplot(gapminder, aes(x = co2)) + 
  geom_histogram(binwidth = 5)




# 7. Linear models in R (the basics) --------------------------------------


# This is a VERY BASIC introduction to models in R. The idea here is just to illustrate how we create models, explore and plot them. We will cover statistical and biological details in the next classes and tutorials.
# Basically, here we will repeat the same steps of our recipe: create an object, explore it with indexing tools, apply few functions.

# we already have our data to work with.
# Let's take a look in the function 'lm()' for linear models
help(lm)


# Basically we need a formula and data. 
# Here's another way of getting data that is associated

# with a package:
install.packages("agridat")

# if slow connection try running : options(timeout = 400)

library(agridat)#this package has many datasets from agriculture
library(devtools)

devtools::install_github("kwstat/agridat")
?agridat #shows all different datasets
?lord.rice.uniformity # gives details for this dataset



head(lord.rice.uniformity)
data("lord.rice.uniformity")

#lets give it a shorter name to make our life easier
rice <- lord.rice.uniformity

#Let's pretend we are interested in the linear 
#relationship between straw weight and grain weight

lm(grain ~ straw, rice)
# What do we have? The estimates for the linear function 
# parameters (intercept and slope)
# if we save this model as an object:
rice_mod <- lm(rice$grain ~ rice$straw)

# now we can take a look in other details:
summary(rice_mod)
anova(rice_mod)
# Good! We got the same estimates but with t-tests, 
# R^2, Residual standard error, F-test and more..
# you can also explore these by calling them directly:
rice_mod$coefficients
rice_mod$residuals


# Let's see this things in a plot:
plot(rice$grain ~ rice$straw, pch = 19, cex = 0.2)
# Ok, we can do it a bit better:
plot(rice$grain ~ rice$straw,pch = 19,  cex = 0.2,
     ylab="grain weight (g)", 
     xlab="straw weight (g)",
     main="linear model")

# adding the model
abline(rice_mod, col = 2)# adds the linear function from the model
# adding the equation


#first "write it" (paste joins bits of characters)
# y = mx + b
eqn <-paste("y=", round(rice_mod$coefficients[2], 2),
            "x + ", round(rice_mod$coefficients[1], 2) )
text(3.9,9, eqn, cex = 0.6)# this adds text to the graph

# We can also take a look in the model premisses
plot(rice_mod)# here you have to hit enter for new graphs to 
#show up

par(mfrow=c(2,2))
plot(rice_mod)# here all graphs are plotted together


# We can use other kinds of models 
#(e.g. General Linear models, Additive linear models etc). 
# they all mostly have similar formats to the basic lm()



# 8. I. Programming fundamentals - Functions -----------------------------------


# User-defined functions: function(){}
# To create your own function, again, the recipe is the same: 
# create another object using pre-defined functions. What?
# We will use a function called "function()" (boring, I know, but effective!).
# For example, a very simple, but limited, function could be the one that sums 5 input values:
# We will call it 'sum_5_numbers'



sum_5_numbers <- function(value1, value2, value3, value4, value5){
  object <- value1 + value2 + value3 + value4 + value5
  return(object)
}

# What happened? R saved our function in the workspace
# Note the structure: we give it a name, arguments (value1 to 5). It has internal objects (object) and it returns the sum of all arguments. Let's see if it works:

sum_5_numbers(value1=10, value2=20, value3=30, value4=40, value5=50)
sum_5_numbers(3,6,90,1,2)

# Sweet! It did his job: summed 10+20+30+40+50.


# use this for any formula that you apply frequently
# ex: the vertical distance travelled by a free falling 
# object after x seconds
d <- 1/2 *9.8 * 5^2
d

d2 <- 1/2 *9.8 * 2^2

dist_fall <- function(time_sec){
  d <- 1/2 *9.8 * time_sec^2
  return(d)
}

dist_fall(20)

#~~~~ A bit more complex functions----
# It is good to have a workflow:
# 1. design the steps of your process
# 2. identify the inputs of your function
# 3. change specific inputs to generic names
# 4. add process into the body of your function




# I want to simulate rolling a 6-faced dice once:
dice <- seq(1:6)
sample(dice, 1)


# What about twice?
sample(dice, 2, replace = T)

# How can I generalize this?
n_rolls <- 7
sample(dice, n_rolls, replace = T)

# Put it in a function
dice_rolling <- function(n_rolls){
  results<-sample(dice, n_rolls, replace = T)
  return(results)
}

dice_rolling(100)


# A function for a rolling dice in a game
# in which you get 10 dollars each time you roll a six
n_rolls <- 8
win_numb <- 6
price <- 0.10

dice_rolling_money <- function(n_rolls, win_numb, price){
  results <-sample(dice, n_rolls, replace = T)
  money <- sum(results == win_numb)*price
  return(list(results,money))
}


dice_rolling_money(5, 3, 50)


# 8. II. Programming fundamentals - For Loops -----------------------------------
# used to repeat an action for i number of times
# imagine I want to write sentence: today is (weekday)
# for each of the week.
# Initially you could try:


# first making a vector that contains all weekdays

weekday <- c("Monday", "Tuesday", "Wednesday", "Thursday", 
             "Friday", "Saturday", "Sunday")

# then pasting it to "today is" for each one:
paste("Today is", weekday[1])

# and I'd have to copy and paste this for each day of the week:
paste("Today is", weekday[2])
paste("Today is", weekday[3])
paste("Today is", weekday[4])
# etc...

# When coding, we try to avoid copying and pasting things
# more than twice because there is usually a more efficient
# way of doing this. 
# One option is to use a for loop:

for(i in seq(1:7)){
    print(paste("Today is", weekday[i]))
}
  


# you can also save each of your results in a vector
weekd_sent <- vector(length = 7)

for(i in seq(1:7)){
  weekd_sent[i] <- (paste("Today is", weekday[i]))
}

weekd_sent

# if you don't know the sequence lenth you can use the argument
# seq_along()
day_sentence <- vector(length = length(weekday)) # create an empty vector

for(i in seq_along(day_sentence)){
  day_sentence[i]<- paste("Today is", weekday[i])#carries operation for ith day
}

day_sentence


# This is very useful for processing files and making plots:
# create an empty list to save each plot in a slot
library(dplyr) # package for filtering data
library(ggplot2) #package for plotting

data(iris) # load iris dataset that comes in base R
head(iris) # see what is in there

# I want to make one graph for each species:

levels(iris$Species) # how many species are there?

# create list with slot for each plot = species
p <- vector("list", length = length(levels(iris$Species)))


for(i in seq(1:3)){
  
  subset_species <- iris %>% filter(Species == levels(iris$Species)[i])
  p[[i]]<- ggplot(subset_species,
         aes(x = Sepal.Length, y = Sepal.Width))+
        geom_point()
  
}


plot(p[[3]])

plot(p)


# 8. III. Programming fundamentals - If Else  -----------------------------------
# Perhaps you want parts of you code to run only when 
# satisfying some conditions. We then use a logical test.
# if(): if(condition=true) do_command

if(1 == 0) print("what?")
if(1 != 0) print("OK!")

# ifelse(): if(condition=true, do_command1, do_command2_instead)
ifelse(1 == 0, print("no way!"), print("OK!"))
ifelse(1 != 0, print("all right!"), print("what?!"))

# if{}else{}: if(condition=true) {do_command1} else{do_command2_instead}
# this is useful for long conditions or commands
if (1 == 0 ){
  print("are you crazy?")
} else {
  print("OK!")
}


# within a function:
# Going back to the dice game, we can create similar game
# in which you win if you roll the same number
# two consecutive times
# to keep it simple, we will only do this for 2 rolls

#first I'll make 
n_rolls <- 2

dice_rolling_pair <- function(n_rolls){
  dice <- seq(1:6)
  results <-sample(dice, n_rolls, replace = T)
  if(results[1]==results[2]){print("win")}else{
    print("loose")
  }
}

dice_rolling_pair(2)




#####################################################################################
##### I hope you have enjoyed this tutorial on the basics of R.
##### I also hope that you take the journey to learn R, or other programming language.
##### Let me know if I can help out.
####################################################################################