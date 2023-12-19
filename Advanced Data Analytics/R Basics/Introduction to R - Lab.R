### Introduction to R

## Syntax Constructs

# In its simplest form, R can be used as a calculator

2 + (3 * 4) / 2 - 5

exp(1)

sqrt(2)

pi


# Variables in R are like placeholders. They contain values we are working with.

x = 3
x

y = 2 + (3 * 4) / 2 - 5
y


# Create a Vector

v = c(1, 2, 3, 4)
v
v[1]


# Create a Matrix

m = matrix(1:6, nrow = 2, ncol = 3)
m
m[1][1]
m[, 1] # Pulls all values in the first column
m[1,] # Pulls all values in the first row
m[1, 1:3]


# Create a Data Frame

ID = c(1, 2, 3)
Gender = c("F", "F", "M")
i = data.frame(ID, Gender)

is.data.frame(i)

i[2, 2]

i[, 2]

i$Gender


# Functions

v = c(1, 2, 3, 4)
sum(v)

sort(v, decreasing = F)

sort(v, decreasing = T)


# Import Data

data = read.csv("toy data frame.csv", sep = ",")

View(data)

is.data.frame(data)

data[, 2]

data[3, ]

summary(data$Age)


# Install and Use R Packages

# install.packages("dplyr")

library(dplyr)


## Data Cleaning

data = read.csv("data manipulation.csv")

View(data)


# Arrange Data

data_sort = data %>% arrange(Age)

data_sort2 = data %>% arrange(desc(Age))


# Subset or Filter Data

data_female = data %>% filter(Gender == "F")

data_male20 = data %>% filter(Gender == "M" & Age > 20)


# Select Variables

data_GA = data %>% select(Gender, Age)

data_noID = data %>% select(-ID)


# Create New Variables

data_BMI = data %>% mutate(BMI = Weight / (Height / 100)^2)


# Joining Tables

data2 = read.csv("data manipulation2.csv")
data_join = left_join(data, data2, by = "ID")


# Group Data and Summarize

data_group = data %>% group_by(Gender) %>%
  summarise(ave_age = mean(Age),
            ave_height = mean(Height),
            ave_weight = mean(Weight))


## Visualization

iris = read.csv("iris.csv")


# Histogram

hist(iris$sepal_width)


# Boxplot

boxplot(iris$sepal_length)

boxplot(sepal_length ~ class, data = iris)


# Scatterplot

plot(iris$sepal_length, iris$sepal_width)


# Scatterplot Matrix

pairs(iris[, 1:4])