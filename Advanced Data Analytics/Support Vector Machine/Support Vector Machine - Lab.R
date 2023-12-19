### Support Vector Machine in R

## Load Libraries

library(caret)
library(dplyr)
library(e1071)


## Load Data

bank = read.csv("bank.csv", sep = ";", stringsAsFactors = TRUE)

train_rows = createDataPartition(y = bank$y,
                                 p = 0.80, list = FALSE)

bank_train = bank[train_rows, ]
bank_test = bank[-train_rows, ]


## Train a Linear SVM Model

library(e1071)

# Need to Specify Kernel Type
svm_model = svm(y ~ ., data = bank_train,
                kernel = "linear")


## Make Predictions

# Use predict() to get predictions
pred = predict(svm_model, bank_test)


## Performance Evaluation

# Confusion Matrix
confusionMatrix(pred, bank_test$y, mode = "prec_recall", positive = "yes")


## Try a 2-Degree Polynomial Kernel

svm_model = svm(y ~ ., data = bank_train,
                kernel = "polynomial", degree = 2)

pred = predict(svm_model, bank_test)

confusionMatrix(pred, bank_test$y, mode = "prec_recall", positive = "yes")


## Try a Gaussian Kernel

svm_model = svm(y ~ ., data = bank_train,
                kernel = "radial")

pred = predict(svm_model, bank_test)

confusionMatrix(pred, bank_test$y, mode = "prec_recall", positive = "yes")


## Visual Example of SVM

# Make an Artificial Dataset
x1 = runif(n = 500, min = -0.3, max = 0.8)
x2 = runif(n = 500, min = -0.3, max = 0.8)

data = data.frame(x1, x2) %>% filter(x1 + x2 > 0.7 | x1 + x2 < 0.3) %>%
  mutate(y = ifelse(x1 + x2 > 0.7, 1, -1))

plot(data$x1, data$x2, col = ifelse(data$y == 1, "red", "blue"))


# Visualize the Support Vectors
data$y = factor(data$y)

svm_model = svm(y ~ ., data = data, kernel = "linear")

sv = data[svm_model$index, ]

plot(data$x1, data$x2, col = ifelse(data$y == 1, "red", "blue"))

points(x = sv$x1, y = sv$x2, pch = 19)