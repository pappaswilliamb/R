### KNN and Decision Trees in R

## Load Libraries

library(class)
library(rpart)
library(rpart.plot)
library(caret)
library(dplyr)


## Load Data

Iris = read.csv("iris.csv")


## Training and Validation Split: Method 1

# First, Randomly Permutate Rows of the Entire Dataset
IrisData_rand = Iris[sample(nrow(Iris)), ]

# Second, Split by Row Indexes
# Here, We're Using 70% Training and 30% Testing
IrisData_train = IrisData_rand[1:105, ]
IrisData_test = IrisData_rand[106:150, ]


## Training and Validation Split: Method 2

library(caret)

# Randomly Pick the Rows for Training Partition
train_rows = createDataPartition(y = Iris$class,
                                 p = 0.70, list = FALSE)
IrisData_train = Iris[train_rows, ]
IrisData_test = Iris[-train_rows, ]
# "-" Means Selecting Rows *Not* Included In train_rows


## Train a K-NN Model

library(dplyr)

normalize = function(x) {
  return ((x - min(x))/(max(x) - min(x)))
  }

# Normalize
Iris_normalized = Iris %>% mutate_at(1:4, normalize)

# Reconstruct Training and Testing Data
Iris_normalized_train = Iris_normalized[train_rows, ]
Iris_normalized_test = Iris_normalized[-train_rows, ]

pred_knn = knn(train = Iris_normalized_train[, 1:4],
               test = Iris_normalized_test[, 1:4],
               cl = Iris_normalized_train[, 5], k = 3)


## Evaluate K-NN Performance

confusionMatrix(pred_knn, as.factor(Iris_normalized_test[, 5]))

cm = confusionMatrix(pred_knn, as.factor(Iris_normalized_test[, 5]))
# cm$overall


## Train a Decision Tree Model

library(rpart)

tree = rpart(class ~ ., data = IrisData_train,
             method = "class",
             parms = list(split = "information"))


## Evaluate Decision Tree Performance

pred_tree = predict(tree, IrisData_test, type = "class")

confusionMatrix(pred_tree, as.factor(IrisData_test[, 5]), mode = "prec_recall")


## Visualize Decision Tree

library(rpart.plot)

prp(tree, varlen = 0)


## Store Model for Future Use

save(tree, file = "my_tree.rda")

load("my_tree.rda")


## Cross-Validation

cv = createFolds(y = Iris$class, k = 5)

# Make a Vector to Store Accuracy from Each Fold
accuracy = c()

# Loop Through Each Fold
for (test_rows in cv) {
  IrisData_train = Iris[-test_rows, ]
  IrisData_test = Iris[test_rows, ]
  # Then, Train Your Model and Evaluate Its Performance
  tree = rpart(class ~ ., data = IrisData_train,
               method = "class", parms = list(split = "information"))
  pred_tree = predict(tree, IrisData_test, type = "class")
  cm = confusionMatrix(pred_tree, as.factor(IrisData_test[, 5]))
  # Add the Accuracy of Current Fold
  accuracy = c(accuracy, cm$overall[1])
}
# Average Accuracy Across Folds
print(mean(accuracy))