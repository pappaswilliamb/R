### Logistic Regression and Feature Selection in R

## Load Libraries

library(caret)
library(dplyr)
library(imbalance)
library(ROSE)
library(pROC)
library(FSelectorRcpp)


## Load Data

# Bank Data: Outcome of "y" = Whether a Customer Made a Deposit as a Result of the Bank's Marketing Activities

bank = read.csv("bank.csv", sep = ";")

train_rows = createDataPartition(y = bank$y,
                                 p = 0.80, list = FALSE)

bank_train = bank[train_rows, ]
bank_test = bank[-train_rows, ]


## Construct Balanced Data

# Need to specify the "N", "p", and "method" parameters
# N = the desired sample size of the resulting data set
# p = portion of the rare class
# method = "both" means combination of oversampling the minority class and undersampling the majority class

# Check Imbalance Ratios in Data
imbalanceRatio(bank_train, classAttr = "y")
summary(factor(bank_train$y))

# Creation of Balanced Data
bank_train = ovun.sample(y ~ ., data = bank_train,
                         N = nrow(bank_train), p = 0.5,
                         method = "both")$data

imbalanceRatio(bank_train, classAttr = "y")
summary(factor(bank_train$y))


## Train a Logistic Regression Model

# Need to specify the "family" parameter
# family = binomial means this is binary classification
# link = "logit" means we are using logit regression
bank_train$y = ifelse(bank_train$y == "yes", 1, 0)
logit_model = glm(y ~ ., data = bank_train,
                  family = binomial(link = "logit"))


## Examine the Model

# Use summary() to print all coefficients
summary(logit_model)


## Make Predictions

# By default, predict() gives you the log odds
pred = predict(logit_model, bank_test)

# To get predicted probability:
pred_prob = predict(logit_model, bank_test,
                    type = "response")

# To convert to binary predictions
pred_binary = ifelse(pred_prob > 0.5, "yes", "no")


## Performance Evaluation

# Confusion Matrix
confusionMatrix(factor(pred_binary), factor(bank_test$y),
                mode = "prec_recall", positive = "yes")

# AUC for class "yes"
library(pROC)
roc_logit = roc(response = ifelse(bank_test$y == "yes", 1, 0),
                predictor = pred_prob)
plot(roc_logit)
auc(roc_logit)


## Feature Selection: Filter Approach

library(FSelectorRcpp)

IG = information_gain(y ~ ., data = bank_train)

# Select Top 10 Attributes
topK = cut_attrs(IG, k = 10)

bank_topK_train = bank_train %>% select(topK, y)
bank_topK_test = bank_test %>% select(topK, y)

# Build Logistic Regression Model

library(pROC)

logit_model2 = glm(y ~ ., data = bank_topK_train,
                   family = binomial(link = "logit"))

pred_prob = predict(logit_model2, bank_topK_test,
                    type = "response")

auc(ifelse(bank_topK_test$y == "yes", 1, 0), pred_prob)


## Feature Selection: Wrapper Approach - Forward Selection

best_auc = 0
selected_features = c()
while (TRUE) {
  feature_to_add = -1
  # The elements of setdiff(x, y) are those elements in x, but not in y
  for (i in setdiff(1:16, selected_features)) {
    train = bank_train %>% select(selected_features, i, y)
    test = bank_test %>% select(selected_features, i, y)
    
    logit_model = glm(y ~ ., data = train,
                      family = binomial(link = "logit"))
    
    pred_prob = predict(logit_model, test,
                        type = "response")
    
    auc = auc(ifelse(test$y == "yes", 1, 0), pred_prob)
    
    if (auc > best_auc) {
      best_auc = auc
      feature_to_add = i
    }
  }
  
  if (feature_to_add != -1) {
    selected_features = c(selected_features, feature_to_add)
    print(selected_features)
    print(best_auc)
  }
  else break
}

print(selected_features)
print(best_auc)

## Feature Selection: Wrapper Approach - Backward Elimination

model_all = glm(y ~ ., data = bank_train,
                family = binomial(link = "logit"))

pred_prob = predict(model_all, bank_test,
                    type = "response")

best_auc = auc(ifelse(bank_test$y == "yes", 1, 0), pred_prob)

print(best_auc)

selected_features = 1:16
while (TRUE) {
  feature_to_drop = -1
  for (i in selected_features) {
    train = bank_train %>% select(setdiff(selected_features, i), y)
    test = bank_test %>% select(setdiff(selected_features, i), y)
    
    logit_model = glm(y ~ ., data = train,
                      family = binomial(link = "logit"))
    
    pred_prob = predict(logit_model, test,
                        type = "response")
    
    auc = auc(ifelse(test$y == "yes", 1, 0), pred_prob)
    
    if (auc > best_auc) {
      best_auc = auc
      feature_to_drop = i
    }
  }
  
  if (feature_to_drop != -1) {
    selected_features = setdiff(selected_features, feature_to_drop)
    print(selected_features)
    print(best_auc)
  }
  else break
}

print(selected_features)
print(best_auc)