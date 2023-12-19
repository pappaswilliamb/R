# Data Importation in R

library(tidyverse)

tomato <- read_csv("TomatoFirst.csv")
tomato


beer <- read_csv("beers.txt", skip = 14)

varNames <- scan("beers.txt", 
                 skip = 5, 
                 nlines = 1, 
                 what = "")
varNames

beer <- read_csv("beers.txt", skip = 14, 
                 col_names = varNames, 
                 na = "#")
beer
tail(beer)



# Read in birthdate Data

bd <- read_csv("class_birthdate.csv")
bd

# Fix birthdate Variable

bd <- read_csv("class_birthdate.csv", 
               col_types = cols(
                 Name = col_character(),
                 Sex = col_character(),
                 Age = col_double(),
                 Height = col_double(),
                 Weight = col_double(),
                 Birthdate = col_date("%m/%d/%Y")
               ))
bd