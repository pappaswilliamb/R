### Numeric Prediction in R

## Load Libraries

library(dplyr)
library(caret)
library(rpart)
library(rpart.plot)


## Load Data

library(caret)

wine = read.csv("winequality.csv", sep = ";")

# createDataPartition preserves distribution of the target variable in train/test partitions
train_rows = createDataPartition(y = wine$quality,
                                 p = 0.70, list = FALSE)
wine_train = wine[train_rows, ]
wine_test = wine[-train_rows, ]


## Train a Regression Tree Model

library(rpart)
library(rpart.plot)

tree = rpart(quality ~ ., data = wine_train)
prp(tree, varlen = 0)


## Make Predictions and Obtain Prediction Error

# Make Prediction
pred_tree = predict(tree, wine_test)

# Evaluation
actual = wine_test$quality
error = pred_tree - actual


## Calculate Performance Metrics

# Average Error
AE = mean(error)

# Mean Absolute Error
MAE = mean(abs(error))

# Mean Absolute Percentage Error
MAPE = mean(abs(error / actual))

# Root Mean Squared Error
RMSE = sqrt(mean(error^2))

# Total Sum of Squared Error
SSE = sum(error^2)


## Train a K-NN Model and Evaluate its Performance

library(dplyr)

# Don't forget to normalize the data
normalize = function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
  }

wine_normalized = wine %>% mutate_at(1:11, normalize)
wine_normalized_train = wine_normalized[train_rows, ]
wine_normalized_test = wine_normalized[-train_rows, ]

# Build K-NN model
pred_knn = knnregTrain(train = wine_normalized_train[, 1:11],
                       test = wine_normalized_test[, 1:11],
                       y = wine_normalized_train[, 12],
                       k = 3)

# Performance Evaluation
actual = wine_normalized_test$quality
error = pred_knn - actual

KNN_AE = mean(error)
KNN_MAE = mean(abs(error))
KNN_MAPE = mean(abs(error / actual))
KNN_RMSE = sqrt(mean(error^2))
KNN_SSE = sum(error^2)


## Build Linear Regression Model

lm_model = lm(quality ~ ., data = wine_train)


## Examine the Regression Model

summary(lm_model)


## Make Predictions and Evaluate Performance

# Make Prediction
pred_lm = predict(lm_model, wine_test)

# Performance Evaluation
actual = wine_test$quality
error = pred_lm - actual

lm_AE = mean(error)
lm_MAE = mean(abs(error))
lm_MAPE = mean(abs(error / actual))
lm_RMSE = sqrt(mean(error^2))
lm_SSE = sum(error^2)


## How to Do Cross-Validation

cv = createFolds(y = wine$quality, k = 5)

rmse_cv = c()

for (test_row in cv) {
  
  wine_train = wine[-test_row, ]
  wine_test = wine[test_row, ]
  
  lm_model = lm(quality ~ ., data = wine_train)
  
  pred_lm = predict(lm_model, wine_test)
  
  rmse = sqrt(mean((pred_lm - wine_test[, 12])^2))
  
  rmse_cv = c(rmse_cv, rmse)
}

print(mean(rmse_cv))