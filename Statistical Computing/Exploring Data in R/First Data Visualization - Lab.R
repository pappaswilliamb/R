# 1
mtcars

# 2
mtcars$wt
mtcars$mpg

# 3
plot(x = mtcars$wt, y = mtcars$mpg)

# 4 - Practice Exporting Your Graph as a pdf Document

# 5
plot(mtcars$wt, mtcars$mpg, xlab = "Weight", ylab = "Miles per Gallon", main = "Scatterplot of Weight versus Miles per Gallon for mtcars", pch = 0)

# 6
plot(mtcars$wt, mtcars$mpg, xlab = "Weight", ylab = "Miles per Gallon", main = "Scatterplot of Weight versus Miles per Gallon for mtcars", pch = 19, col = "red")

# 7
library(tidyverse)
ggplot(data = mtcars) +
  geom_point(mapping = aes(x = wt, y = mpg), color = "red", shape = 16)

# Weight versus Miles per Gallon by Number of Cylinders
ggplot(data = mtcars) +
  geom_point(aes(x = wt, y = mpg, col = factor(cyl)))

ggplot(data = mtcars) +
  geom_text(aes(x = wt, y = mpg, label = cyl, col = factor(cyl)))