# ===========================================================
# Example: Test Scores
# ===========================================================

scores <- read.csv("test_scores.csv", header = T)
head(scores)
names(scores)

scores$grade <- as.factor(scores$grade)

# Look at Univariate Distributions
table(scores$grade)
hist(scores$math)
hist(scores$reading)

hist(scores$poverty)
hist(scores$minority)

mean(scores$math, na.rm = TRUE)
mean(scores$reading, na.rm = TRUE)

median(scores$math, na.rm = TRUE)
median(scores$reading, na.rm = TRUE)

table(scores$school)

# Anything Missing?
sum(is.na(scores$math))
sum(is.na(scores$reading))
sum(is.na(scores$poverty))
sum(is.na(scores$minority))
subset(scores, is.na(scores$math))
subset(scores, school == 19)

# Explore Associations
plot(scores$school, scores$math)
plot(scores$reading, scores$math)
cor(scores$reading, scores$math, use = "complete.obs")

plot(scores$poverty, scores$math)
plot(scores$poverty, scores$reading)
cor(scores$poverty, scores$math, use = 'complete.obs')
cor(scores$poverty, scores$reading, use = 'complete.obs')

plot(scores$poverty, scores$minority)
cor(scores$poverty, scores$minority, use = 'complete.obs') # Pearson's coefficient
cor(scores$poverty, scores$minority, method = 'spearman',
    use = 'complete.obs') #Spearman's coefficient

boxplot(scores$reading~scores$grade) # Boxplots of reading scores grouped by grade
boxplot(scores$poverty~scores$grade) # Students in poverty across grade

# Use tapply to Find Summary Statistics by Group
tapply(scores$reading, scores$grade, mean)
tapply(scores$reading, scores$grade, mean, na.rm = T)

tapply(scores$reading, scores$grade, sd, na.rm = T)
tapply(scores$reading, scores$grade, quantile, 0.40, na.rm = T) # Finds the 40th percentile of reading scores by grade


# Add a 3rd Variable - Use Color in a Lazy Way
plot(scores$poverty, scores$math,
     col = scores$grade)

# Add a 3rd Variable - Choose Colors
color.names <- c("red", "darkgreen", "navy")
plot(scores$poverty, scores$math,
     col = color.names[scores$grade])

# Find Sample Correlation by Grade
scores_grade3 <- subset(scores, grade == 3)
dim(scores_grade3)
cor(scores_grade3$poverty, scores_grade3$math, use = 'complete.obs')

scores_grade4 <- subset(scores, grade == 4)
dim(scores_grade4)
cor(scores_grade4$poverty, scores_grade4$math, use = 'complete.obs')

scores_grade5 <- subset(scores, grade == 5)
dim(scores_grade5)
cor(scores_grade5$poverty, scores_grade5$math, use = 'complete.obs')


# clean Up Plot and Save It
plot(scores$poverty, scores$math,
     col = color.names[scores$grade],
     ylab = 'Math Score', xlab = 'Poverty (%)',
     main = 'Test Scores and Poverty Rate')
legend('topright', legend = c("Grade 3",
                           "Grade 4",
                           "Grade 5"),
       col = c("red", "darkgreen", "navy"),
       pch = 1, cex = 0.6)

# Optional: Save Plot Using Code
# Uncomment the Lines Starting with "png" and "dev.off()"
# png(filename="scores_scatterplot.png", width = 500, height = 400)
plot(scores$poverty, scores$math,
     col = color.names[scores$grade],
     ylab = 'Math Score', xlab = 'Poverty (%)',
     main = 'Test Scores and Poverty Rate')
legend('topright', legend = c("Grade 3",
                           "Grade 4",
                           "Grade 5"),
       col = c("red", "darkgreen", "navy"),
       pch = 1, cex = 0.6)

# dev.off()