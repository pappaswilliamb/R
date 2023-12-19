# R Functions

# Packages needed ---------------------------------------------------------

library(tidyverse)


# Function Key Steps -----------------------------------------------------

# Name the Function
# List the Input Arguments - Like function(a, b, c)
# Place Code in the Body of Function Inside {} Block

# Check Your Function with Different Inputs
# Modify Function to Produce Errors When Input Arguments Are Not Valid
# Comment Your Code so That You (and Others) Know What It Does When You Come Back to It Later
# Use Ctrl/Cmd + Shift + R to Create Comment Headers

df <- tibble::tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

df$a <- (df$a - min(df$a, na.rm = TRUE)) / 
  (max(df$a, na.rm = TRUE) - min(df$a, na.rm = TRUE))
df$b <- (df$b - min(df$b, na.rm = TRUE)) / 
  (max(df$b, na.rm = TRUE) - min(df$a, na.rm = TRUE))
df$c <- (df$c - min(df$c, na.rm = TRUE)) / 
  (max(df$c, na.rm = TRUE) - min(df$c, na.rm = TRUE))
df$d <- (df$d - min(df$d, na.rm = TRUE)) / 
  (max(df$d, na.rm = TRUE) - min(df$d, na.rm = TRUE))

rescale01 <- function(x) {
  rng <- range(x, na.rm = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}

rescale01(c(0, 5, 10))



# Conditional Execution ---------------------------------------------------

# Example
has_name <- function(x) {
  nms <- names(x)
  if (is.null(nms)) {
    rep(FALSE, length(x))
  } else {
    !is.na(nms) & nms != ""
  }
}

y <- c(1, 2, 3, 4)

has_name(mtcars)
has_name(y)

# Conditions Must Be for a Single TRUE or FALSE  
# It Is Possible to Use || (or) and && (and) to Combine Multiple Logical Expressions

# To Chain Multiple If Statements Together, Use if/else if/else or the switch() Function

# Example: if/else if/else
a <- 3
mynumber <- 4
if(a <= mynumber && mynumber > 3) {
  cat("Same as 'first condition TRUE and second TRUE")
  a <- a^2
  b <- seq(1, a, length = mynumber)
  } else if (a <= mynumber && mynumber <= 3) {
    cat("Same as 'first condition TRUE and second FALSE'")
    a <- a^2
    b <- a * mynumber
    } else if (mynumber >= 4) {
      cat("Same as 'first condition FALSE and second TRUE'")
      a <- a - 3.5
      b <- a^(3 - mynumber)
      } else {
        cat("Same as 'first condition FALSE and second FALSE'")
        a <- a - 3.5
        b <- rep(a + mynumber, times = 3)
        }


# Example: Switch Statement
mystring <- "Lisa"
if(mystring == "Homer") {
  foo <- 12
  } else if (mystring == "Marge") {
    foo <- 34
  } else if(mystring == "Bart") {
    foo <- 56
  } else if(mystring == "Lisa") {
    foo <- 78
  } else if(mystring == "Maggie") {
    foo <- 90
  } else {
    foo <-NA
  }
  
foo
  
# Using Switch
foo <- switch(EXPR = mystring,
              Homer = 12, 
              Marge = 34, 
              Bart = 56, 
              Lisa = 78, 
              Maggie = 90, 
              NA)
foo
  

# Function Arguments ------------------------------------------------------

# In General: Data Arguments Come First Detail Arguments Come Second
# Typically the Most Common Value Is the Default Value

# Typical Argument Names:
# x, y, z: Vectors
# w: A Vector of Weights
# df: A Data Frame
# i, j: Numeric Indices (Typically Rows and Columns)
# n: Length, or Number of Rows
# p: Number of Columns
  

# Using dot-dot-dot(...)

# For Example
?c
  

# Explicit Return Statements
  
# For Example
fahrenheit_to_kelvin <- function(temp_F) {
  temp_K <- ((temp_F - 32) * (5 / 9)) + 273.15
  return(temp_K)
  }
  
fahrenheit_to_kelvin(97)
  
# Without Return Statement
fahrenheit_to_kelvin <- function(temp_F) {
  temp_K <- ((temp_F - 32) * (5 / 9)) + 273.15
  }
  
x <- fahrenheit_to_kelvin(97)
x

  
# Writing Pipable Functions
# Two Basic Types

# Transformations - An Object Is Passed to the Function's First Argument and a Modified Object Is Returned

# Side-Effects - The Passed Object Is Not Transformed
# Side-Effects Functions Should Invisibly Return the First Argument
  
show_missings <- function(df) {
  n <- sum(is.na(df))
  cat("Missing values: ", n, "\n", sep = "")
  
  invisible(df)
  }
  
show_missings(mtcars)
  
x <- show_missings(mtcars) 
class(x)
dim(x)
  
mtcars %>%
  show_missings() %>%
  mutate(mpg = ifelse(mpg < 20, NA, mpg)) %>%
  show_missings() 