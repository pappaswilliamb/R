### Association Rules in R

## Convert Categorical and Numeric Variables to Binary

library(dplyr)

data_convert = read.csv("conversion.csv") %>%
  mutate(MedalG = ifelse(Medal == "Gold", 1, 0),
         MedalS = ifelse(Medal == "Silver", 1, 0),
         MedalB = ifelse(Medal == "Bronze", 1, 0)) %>%
  mutate(IncomeH = ifelse(Income > 100000, 1, 0),
         IncomeM = ifelse(Income <= 100000 & Income > 60000,
                          1, 0),
         IncomeL = ifelse(Income <= 60000, 1, 0))


## Read Transaction Data into R

# install.packages("arules")
library(arules)

coffee = read.transactions("coffeeshop.csv",
                           format = "basket",
                           sep = ",",
                           rm.duplicates = TRUE)


## Inspect and Visualize Transaction Data

itemInfo(coffee)

# By Default, It Tells You the Support Percentage of Each Item
itemFrequency(coffee)

# You Can Also Ask for the Absolute Frequency Count
itemFrequency(coffee, type = "absolute")

itemFrequencyPlot(coffee)

image(coffee)


## Find Association Rules from Data

rules = apriori(coffee,
                parameter = list(supp = 0.5, conf = 0.8))

inspect(rules)

# e.g., Sort Rules by Support
inspect(sort(rules, by = "support"))

inspect(sort(rules, decreasing = FALSE, by = "support"))

# e.g., Find Rules Whose lhs Has "chocolate"
# The Operator %pin% Means "contains"
inspect(subset(rules, lhs %pin% "chocolate"))


## Deal with Binary Matrix Format

coffee_data_frame = read.csv("coffeeshop_binary.csv")
coffee_matrix = as.matrix(coffee_data_frame)
coffee = as(coffee_matrix, "transactions")

rules = apriori(coffee,
                parameter = list(support = 0.5,
                                 confidence = 0.8))