# Tidying Data in R

library(tidyverse)

table1
table2
table3
table4a
table4b


# Looking at table1
table1

# Looking at table2
table2 %>% 
pivot_wider(names_from = type, values_from = count)

# Looking at table3
table3 %>%
  separate(rate, into = c("cases", "population"), 
           sep = "/", convert = TRUE)

# Looking at table4a
t1 <- table4a %>% 
  pivot_longer(c(`1999`, `2000`), 
               names_to = "year", 
               values_to = "cases")

t2 <- table4b %>% 
  pivot_longer(c(`1999`, `2000`), 
               names_to = "year", 
               values_to = "population")

test <- right_join(t1, t2)
test

# Looking at the Unite Function
table5 %>% unite(new, century, year, sep = "") %>% 
  rename (new = "year")