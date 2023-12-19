### Class Probability Prediction in R

## Load Libraries

library(dplyr)
library(caret)
library(e1071)
library(pROC)
library(rpart)


## Load Data

library(caret)

car = read.csv("car.csv")


## Create Training and Testing Datasets

train_rows = createDataPartition(y = car$evaluation,
                                 p = 0.70, list = FALSE)

car_train = car[train_rows, ]

car_test = car[-train_rows, ]


## Train a Naive Bayes Model

library(e1071)

NB_model = naiveBayes(evaluation ~ ., data = car_train)


## Make Predictions

# Make Categorical Predictions
pred_nb = predict(NB_model, car_test, type = "class")

# Make Class Probability Predictions
prob_pred_nb = predict(NB_model, car_test, type = "raw")


## Evaluate Model Performance

confusionMatrix(pred_nb, as.factor(car_test$evaluation),
                mode = "prec_recall", positive = "vgood")

# Sensitivity Is the Same as Recall
# Positive Predicted Value ("Pos Pred Value") Is Precision