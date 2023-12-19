library(fortunes)

help(package = "fortunes")

ls("package:fortunes")

fortune()

fortune("Ripley")

fortune(17)

library(cowsay)

help(package = "cowsay")

ls("package:cowsay")

animals

names(animals)

say(by = "cow")

say("GO TIGERS!", by = "chicken")

say(paste(fortune(), collapse = "\n"), by = "monkey")

data()

?mtcars

head(mtcars, 8)

dplyr::glimpse(mtcars)

nrow(mtcars)
ncol(mtcars)
dim(mtcars)

?tidyr::billboard