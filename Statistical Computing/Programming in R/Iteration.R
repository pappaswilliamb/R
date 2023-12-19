# Iteration in R

# For Loop Basic Structure ------------------------------------------------


# Example 1
for(myitem in 5:7) {
  cat("--BRACED AREA BEGINS--\n")
  cat("the current item is", myitem,"\n")
  cat("--BRACED AREA ENDS--\n\n")
  }
  
# Example 2: Create Data Frame Tibble
df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
  )
  
output <- vector("double", ncol(df))  # 1. output
output
df
for (i in seq_along(df)) {            # 2. sequence
  output[[i]] <- median(df[[i]])      # 3. body
  }
output
  
  
# Loop Variation - While  -------------------------------------------------

# Basic Structure
for (i in seq_along(x)) {
  # body
  }
  
# Equivalent to
i <- 1
while (i <= length(x)) {
  # body
  i <- i + 1 
  }
  
# Example 1
myval <- 5
while(myval < 10) {
  myval <- myval + 1
  cat("\n'myval' is now", myval, "\n")
  cat("'mycondition' is now", myval < 10, "\n")
  }

  
# Functional -------------------------------------------------------------

# The goal of using purrr functions instead of for loops is to allow you to break common list manipulation  challenges into independent pieces:
    
#1. How can you solve the problem for a single element of the list?
# Once you've solved that problem, purrr takes care of generalizing your solution to every element in the list.
  
#2. If you're solving a complex problem, how can you break it down into bite-sized pieces that allow you to advance one small step towards a solution?
# With purrr, you get lots of small pieces that you can compose together with the pipe.
  

# Map functions (in purrr package)
  
# map() Makes a List
# map_lgl() Makes a Logical Vector
# map_int() Makes an Integer Vector
# map_dbl() Makes a Double Vector
# map_chr() Makes a Character Vector
  
# Input Vector and Return Vector
df
map_dbl(df, mean)
map_dbl(df, median)
map_dbl(df, sd)
  
# Using Pipe
df %>% map_dbl(mean)
df %>% map_dbl(median)
df %>% map_dbl(sd)
  
# Shortcuts
models <- mtcars %>%
  split(.$cyl) %>%
  map(function(df) lm(mpg ~ wt, data = df))

models
  
models <- mtcars %>%
  split(.$cyl) %>%
  map(~lm(mpg ~ wt, data = .))

models  

# Mapping Over Multiple Arguments
# Using map()
mu <- list(5, 10, -3)
mu %>%
  map(rnorm, n = 5) %>%
  str()
  
# Using map2()
sigma <- list(1, 5, 10)
map2(mu, sigma, rnorm, n = 5) %>%
  str()
  
# Using pmap
n <- list(1, 3, 5)
args1 <- list(n, mu, sigma)
args1 %>%
  pmap(rnorm) %>%
  str()
  
# Better with Names Rather Than Positional Mapping
args2 <- list(mean = mu, sd = sigma, n = n)
args2 %>%
  pmap(rnorm) %>%
  str()
  
# Store in df
params <- tribble(
    ~mean, ~sd, ~n,
    5,     1,  1,
    10,     5,  3,
    -3,    10,  5
  )

params %>%
  pmap(rnorm)
  
  
# Invoking Different Functions
# Use invoke_map
f <- c("runif", "rnorm", "rpois")
param <- list(
  list(min = -1, max = 1),
  list(sd = 5),
  list(lambda = 10)
  )
  
invoke_map(f, param, n = 5) %>% str()
  
sim <- tribble(
  ~f,      ~params,
  "runif", list(min = -1, max = 1),
  "rnorm", list(sd = 5),
  "rpois", list(lambda = 10)
  )

T <- sim %>%
  mutate(sim = invoke_map(f, params, n = 10))
T[[3]]

# Using pwalk
library(ggplot2)
plots <- mtcars %>%
  split(.$cyl) %>%
  map(~ggplot(., aes(mpg, wt)) + geom_point())
plots
paths <- stringr::str_c(names(plots), ".pdf")
paths
pwalk(list(paths, plots), ggsave)