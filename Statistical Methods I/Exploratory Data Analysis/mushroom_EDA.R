# ===========================================================
# Example: Mushrooms
# ===========================================================

# Link to documentation: https://archive.ics.uci.edu/ml/datasets/mushroom
# This data set is a random sample of the full data
mushroom <- read.csv("mushrooms.csv")
dim(mushroom)
names(mushroom)

# Univariate Summaries
class(mushroom$cap.color)
mushroom$cap.color <- as.factor(mushroom$cap.color)
table(mushroom$cap.color)
cap.color.t <- table(mushroom$cap.color)
barplot(cap.color.t)

edible.t <- table(mushroom$edible)
edible.t
barplot(edible.t)
prop.table(edible.t) # Converts to a proportion table

# Association Between Cap Color and Edible
edible.capcolor.t <- table(mushroom$cap.color, mushroom$edible)
edible.capcolor.t

# Give the Table More Informative Names
dimnames(edible.capcolor.t)
dimnames(edible.capcolor.t) <- list(capcolor = c("buff", "cinnamon", "red", "gray",
                                               "brown", "pink", "purple", "white", "yellow"),
                                    ed = c("edible", "poisonous"))
edible.capcolor.t

mosaicplot(edible.capcolor.t, color = TRUE)


edible.capcolor.t2 <- table(mushroom$edible, mushroom$cap.color)
dimnames(edible.capcolor.t2) <- list(ed = c("edible", "poisonous"), capcolor = c("buff", "cinnamon" ,"red", "gray",
                                                                           "brown", "pink", "purple", "white", "yellow"))
mosaicplot(edible.capcolor.t2, color = TRUE)
barplot(edible.capcolor.t)
barplot(edible.capcolor.t2)


# Proportion Tables
# Compare Interpretation of Row Proportions vs. Column Proportions
prop.table(edible.capcolor.t, margin = 1) # Row proportions

prop.table(edible.capcolor.t, margin = 2)

# What is a List?
empty.list <- list() # Creates an empty list
empty.list[[1]] <- c(2, 5, 1, 9) # Adds vector to empty list
empty.list
empty.list[[2]] <- mushroom # Adds "mushroom" data frame to list

# Use a For Loop to Make a List of Tables
n.variables <- ncol(mushroom)
names(mushroom)
list.of.tables <- list()

for(j in 2:n.variables)
{
  list.of.tables[[j]] <- table(mushroom$edible, mushroom[, j])
}

names(mushroom)[12]
list.of.tables[[12]]