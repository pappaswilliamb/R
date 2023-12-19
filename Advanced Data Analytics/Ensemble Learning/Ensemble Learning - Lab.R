### Ensemble Learning in R

## Load Libraries

library(caret)
library(dplyr)
library(e1071)
library(rpart)
library(ipred)
library(fastAdaboost)
library(randomForest)


## Load Data

income = read.csv("income.csv", stringsAsFactors = TRUE)

train_rows = createDataPartition(y = income$wage,
                                 p = 0.70, list = FALSE)

income_train = income[train_rows, ]
income_test = income[-train_rows, ]


## Bagging

library(ipred)

bag_model = bagging(wage ~ ., data = income_train, nbagg = 50)

# Make Predictions and Evaluate Performance
pred = predict(bag_model, income_test)
confusionMatrix(pred, income_test$wage, mode = "prec_recall", positive = ">50K")


## Boosting

library(fastAdaboost)

adaboost_model = adaboost(wage ~ ., data = income_train, nIter = 100)

# Make Predictions and Evaluate Performance
pred = predict(adaboost_model, income_test)
confusionMatrix(pred$class, income_test$wage, mode = "prec_recall", positive = ">50K")


## Random Forest

library(randomForest)

rf_model = randomForest(wage ~ ., data = income_train, ntree = 100)

# Make Predictions and Evaluate Performance
pred = predict(rf_model, income_test)
confusionMatrix(pred, income_test$wage, mode = "prec_recall", positive = ">50K")


## Stacking

# Build a Stacking Model

train_rows = createDataPartition(y = income$wage,
                                 p = 0.50, list = FALSE)

income_train = income[train_rows, ]
income_test = income[-train_rows, ]


# Train Three Base Learners
tree_model = rpart(wage ~ ., data = income_train, method = "class",
                   parms = list(split = "information"))

nb_model = naiveBayes(wage ~ ., data = income_train)

svm_model = svm(wage ~ ., data = income_train, kernel = "radial")

# Make Predictions Using Base Learners
pred_tree = predict(tree_model, income_test, type = "class")

pred_nb = predict(nb_model, income_test)

pred_svm = predict(svm_model, income_test)

# Add Base Learners' Predictions to the income_test Data
income_test = income_test %>%
  mutate(pred_tree = pred_tree,
         pred_nb = pred_nb,
         pred_svm = pred_svm)

# Do the Second Split
train2_rows = createDataPartition(y = income_test$wage,
                                  p = 0.50, list = FALSE)

income_train2 = income_test[train2_rows, ]
income_test2 = income_test[-train2_rows, ]

# Build the Logistic Combiner
logit_model = glm(wage ~ ., data = income_train2,
                  family = binomial(link = "logit"))

# Evaluate the Logit Model
pred_logit = predict(logit_model, income_test2, type = "response")

pred_binary = ifelse(pred_logit > 0.5, ">50K", "<=50K")

confusionMatrix(factor(pred_binary), income_test2$wage,
                mode = "prec_recall", positive = ">50K")