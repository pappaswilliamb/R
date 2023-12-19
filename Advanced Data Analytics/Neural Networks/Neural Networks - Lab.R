### Neural Networks in R

## Load Libraries

library(caret)
library(dplyr)
library(neuralnet)


## Load Data

iris = read.csv("iris.csv")

train_rows = createDataPartition(y = iris$class,
                                 p = 0.80, list = FALSE)


## Data Pre-Processing

normalize = function(x) {
  return((x - min(x)) / (max(x) - min(x)))
  }

iris = iris %>%
  mutate(setosa = ifelse(class == "Iris-setosa", 1, 0),
         versicolor = ifelse(class == "Iris-versicolor", 1, 0),
         virginica = ifelse(class == "Iris-virginica", 1, 0)) %>%
  mutate_at(1:4, normalize)

iris_train = iris[train_rows, ]
iris_test = iris[-train_rows, ]


## Train a Neural Network Classifier

library(neuralnet)

nn_model = neuralnet(setosa + versicolor + virginica ~ sepal_length + sepal_width + petal_length + petal_width,
                     data = iris_train,
                     act.fct = "logistic",
                     linear.output = FALSE,
                     hidden = 2,
                     # 1 hidden layer, 2 nodes in the layer
                     algorithm = "backprop",
                     learningrate = 0.1,
                     rep = 1)


## Visualize the Neural Network

plot(nn_model)


## Make Predictions and Evaluate Performance

# Need neuralnet::compute because of function name conflict
pred = neuralnet::compute(nn_model, iris_test[, 1:4])$net.result

# Convert to class labels
outcomes = c("Iris-setosa", "Iris-versicolor", "Iris-virginica")
pred_label = outcomes[max.col(pred)]
confusionMatrix(factor(pred_label), factor(iris_test$class))


## Other Parameters of a Neural Network Model

# Add More Hidden Layers
NN_model = neuralnet(setosa + versicolor + virginica ~ sepal_length + sepal_width + petal_length + petal_width,
                     data = iris_train,
                     act.fct = "logistic",
                     linear.output = FALSE,
                     hidden = c(2, 3, 2),
                     # 2 nodes in the first layer, 3 nodes in the second layer
                     algorithm = "backprop",
                     learningrate = 0.1,
                     rep = 1)
plot(NN_model)

# Modify Learning Rate
hidden_layer = rep(2, 3)
NN_model = neuralnet(setosa + versicolor + virginica ~ sepal_length + sepal_width + petal_length + petal_width,
                     data = iris_train,
                     act.fct = "logistic",
                     linear.output = FALSE,
                     hidden = hidden_layer,
                     # 3 hidden layers each with 2 nodes
                     algorithm = "backprop",
                     learningrate = 0.01,
                     rep = 1)
plot(NN_model)

# Modify Number of Training Epochs
NN_model = neuralnet(setosa + versicolor + virginica ~ sepal_length + sepal_width + petal_length + petal_width,
                     data = iris_train,
                     act.fct = "logistic",
                     linear.output = FALSE,
                     hidden = 2,
                     algorithm = "backprop",
                     learningrate = 0.001,
                     rep = 5)

if(!is.null(NN_model$net.result)) {
  plot(NN_model)
} else {
  print("The model is not estimated, please try different parameters")
}

NN_model = neuralnet(setosa + versicolor + virginica ~ sepal_length + sepal_width + petal_length + petal_width,
                     data = iris_train,
                     act.fct = "logistic",
                     linear.output = FALSE,
                     hidden = 2,
                     algorithm = "backprop",
                     learningrate = 0.01,
                     rep = 5)

if(!is.null(NN_model$net.result)) {
  plot(NN_model)
} else {
  print("The model is not estimated, please try different parameters")
}