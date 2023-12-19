# Vectors in R

# Packages Needed ---------------------------------------------------------

library(tidyverse)


# Vector Basics -----------------------------------------------------------

# Atomic Vectors
# Logical
1:10 %% 3 == 0
c(TRUE, TRUE, FALSE, NA)
  
# Numeric
typeof(1)
typeof(1L)
  
# Difference In Double and Integers:
# Doubles Are Approximations
# Integers Have One Special Value NA, While Doubles Have Four: NA, NaN, Inf, and -Inf

# Character
x <- "This is a reasonably long string."
typeof(x)
pryr::object_size(x)
  
y <- rep(x, 1000)
typeof(y)
pryr::object_size(y)


# Using Atomic Vectors ----------------------------------------------------

# Explicit Coercion
# as.logical(), as.integer(), as.double(), as.character()
  
# Implicit Coercion
x <- sample(20, 100, replace = TRUE)
y <- x > 10
typeof(y)
sum(y)  # How many are greater than 10?
mean(y) # What proportion are greater than 10?

# When You Try to Create a Vector of Multiple Types with c(), the Most Complex Type Always Wins
  
# Recycling tools:
# A Single Number is a Vector of Size 1
# R Will Implicitly Coerce the Length of Vectors
  
sample(10) + 100
# sample() Function Takes a Random Sample of 10 Numbers from 1 to 10

runif(10) > 0.5
#runif(10) Generates 10 Uniform Random Numbers
  
1:10 + 1:2
1:10 + 1:3
  
# In tidyverse, Functions Will Throw an Error When You Recycle Anything Other Than a "scalar"
tibble(x = 1:4, y = 1:2)
tibble(x = 1:4, y = rep(1:2, 2))
tibble(x = 1:4, y = rep(1:2, each = 2))
  
  
# Naming
  
# Name During Creation
c(x = 1, y = 2, z = 4)
  
# Names After the Fact
purrr::set_names(1:3, c("a", "b", "c"))

  
# Subsetting Vectors
  
# Numeric Vector Containing Only Integers
x <- c("one", "two", "three", "four", "five")
x[c(3, 2, 5)]
x[c(1, 1, 5, 5, 5, 2)]
x[c(-1, -3, -5)]
x[c(1, -1)]
x[0]
  
# With a Logical Vector
x <- c(10, 3, NA, 5, 8, 1, NA)
x[!is.na(x)]
x[x %% 2 == 0]
  
x <- c(abc = 1, def = 2, xyz = 5)
x[c("xyz", "def")]
  

# Lists -------------------------------------------------------------------

x <- list(1, 2, 3)
x
  
# str() Focuses on Structure, Not Content
str(x)
x_named <- list(a = 1, b = 2, c = 3)
str(x_named)
  
# Can Contain a Mix of Objects
y <- list("a", 1L, 1.5, TRUE)
str(y)
  
z <- list(list(1, 2), list(3, 4))
str(z)
  
# Subsetting
a <- list(a = 1:3, b = "a string", c = pi, d = list(-1, -5))
str(a[1:2])
a[1:2]
  
str(a[[1]])
a[[1]]
str(a[[4]])
a[[4]]
  

# Augmented Vectors -------------------------------------------------------

# Factors
x <- factor(c("ab", "cd", "ab"), levels = c("ab", "cd", "ef"))
typeof(x)
attributes(x)
  
# Dates and Datetimes
# Dates Are Actually Vectors Representing the Number of Days Since January 1, 1970
x <- as.Date("1971-01-01")
unclass(x)
typeof(x)
attributes(x)  
  
# Tibbles
tb <- tibble::tibble(x = 1:5, y = 5:1)
typeof(tb)
attributes(tb)