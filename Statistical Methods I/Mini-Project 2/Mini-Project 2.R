### Groceries - **Paired Data**
grocery <- read.csv("grocery_prices2.csv")

## Descriptive Summary

# Univariate Summaries
summary(grocery$Item, na.rm = T)
summary(grocery$WinCo, na.rm = T)
summary(grocery$Wal.Mart, na.rm = T)

# Correlation
cor(grocery$WinCo, grocery$Wal.Mart)

# Scatterplot
plot(grocery$WinCo, grocery$Wal.Mart, main = 'WinCo Prices vs. Walmart Prices', 
     xlab = 'WinCo Price ($)', ylab = 'Walmart Price ($)')

boxplot(grocery$WinCo, grocery$Wal.Mart, main = "Price of Groceries", ylab = "Price ($)", xlab = "Grocery Store")


# Summarize Differences
grocery$differences <- grocery$WinCo - grocery$Wal.Mart

# Univariate Summary of the Differences
summary(grocery$differences)
boxplot(grocery$differences, main = "Differences in Prices of Groceries", ylab = "Price ($)")


## Inferential Analysis

# Confidence Interval and Hypothesis Test
t.test(grocery$differences, conf.level = 0.95)

# Normality of the Data
qqnorm(grocery$differences)
qqline(grocery$differences, col = 'red')




### Dating
survey <- read.csv("dating_survey.csv")

## Descriptive Summary

survey_table <- as.table(rbind(c(48, 238), c(39, 190)))
rownames(survey_table) <- c("Black", "White")
colnames(survey_table) <- c("Lost to Follow-Up", "Follow-Up")
survey_table

prop.table(survey_table, margin = 1)

## Inferential Analysis

survey_test <- prop.test(survey_table, conf.level = 0.95)
survey_test

abs.z0 <- sqrt(survey_test$statistic)
abs.z0

p.value <- survey_test$p.value
p.value