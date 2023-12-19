### Fuji Apples

apples <- read.csv("fuji_apples.csv")

## Descriptive Summary

overlapped_arm <- subset(apples, apples$treatment == "overlapped_arm")
tipped_arm <- subset(apples, apples$treatment == "tipped_arm")
tall_spindle <- subset(apples, apples$treatment == "tall_spindle")

summary(overlapped_arm$weight.per.fruit)
summary(tipped_arm$weight.per.fruit)
summary(tall_spindle$weight.per.fruit)

apples_means <- tapply(apples$weight.per.fruit, apples$treatment, mean)
apples_means
apples_sds <- tapply(apples$weight.per.fruit, apples$treatment, sd)
apples_sds

boxplot(apples$weight.per.fruit ~ apples$treatment, main = "Fuji Apple Weights", ylab = "Weight (lbs)", xlab = "Treatment")


options(scipen = 10000)
par(mfrow = c(4, 3))
hist(overlapped_arm$weight.per.fruit, main = "overlapped_arm", xlab = "Weight (lbs)")
hist(tipped_arm$weight.per.fruit, main = "tipped_arm", xlab = "Weight (lbs)")
hist(tall_spindle$weight.per.fruit, main = "tall_spindle", xlab = "Weight (lbs)")

## Inferential Models - ANOVA

lm_apples <- lm(weight.per.fruit ~ treatment, data = apples)
anova_apples <- anova(lm_apples, conf.level = 0.95)
anova_apples

anova_apples$`Pr(>F)`
anova_apples$`Sum Sq`

# Tukey's HSD

apples_pairwise_comparisons <- TukeyHSD(aov(lm_apples), conf.level = 0.95)
apples_pairwise_comparisons

## Assumptions
# Residual Analysis and Normality

apples_residuals <- residuals(lm_apples)

stripchart(apples_residuals ~ apples$treatment, vertical = TRUE,
           main = 'Residuals by Group: Treatment Data',
           ylab = 'Residuals')
qqnorm(apples_residuals)
qqline(apples_residuals, col = 'darkgreen')

# Equal Variances

stripchart(apples$weight.per.fruit ~ apples$treatment, vertical = TRUE, main = "Apple Variances by Treatment Group", xlab = "Treatment", ylab = "Weight (lbs)")


### Evaluations

evals <- read.csv("evals.csv")

## Descriptive Summary

# Summary Statistics
summary(evals$cls_did_eval)
summary(evals$age)

ethnicity_table <- as.table(rbind(c(64, 399)))
rownames(ethnicity_table) <- c("Instructor Ethnicity")
colnames(ethnicity_table) <- c("Minority", "Not Minority")
ethnicity_table

prop.table(ethnicity_table, margin = 1)

barplot(ethnicity_table)
barplot(ethnicity_table, beside = TRUE)

level_table <- as.table(rbind(c(157, 306)))
rownames(level_table) <- c("Class Level")
colnames(level_table) <- c("Lower", "Upper")
level_table

prop.table(level_table, margin = 1)

barplot(level_table)
barplot(level_table, beside = TRUE)

# Boxplots
par(mfrow = c(1, 4))
boxplot(evals$cls_did_eval, main = 'Number of Student Evaluations', ylab = '# Evaluations')
boxplot(evals$age, main = 'Instructor Age', ylab = 'Age')


# Correlations
cor(evals$score,evals$cls_did_eval, method = 'spearman')
cor(evals$score,evals$age, method = 'spearman')

# Scatterplots
plot(evals$score,evals$cls_did_eval, main = 'Scores vs. Number of Student Evaluations', 
     xlab = 'Score', ylab = '# Student Evaluations')

plot(evals$score,evals$age, main = 'Scores vs. Instructor Age', 
     xlab = 'Score', ylab = 'Instructor Age')

## Inferential Models - SLR

# cls_did_eval
lm_evals <- lm(score ~ cls_did_eval, data = evals)
summary(lm_evals)

n <- nrow(evals)
tstar <- qt(0.995, df = n - 2)
tstar
evals_coefficients <- summary(lm_evals)$coefficients
evals_coefficients

pt(tstar, df = n - 2, lower.tail = FALSE)

# Age
lm_age <- lm(score ~ age, data = evals)
summary(lm_age)

n <- nrow(evals)
tstar <- qt(0.995, df = n - 2)
tstar
age_coefficients <- summary(lm_age)$coefficients

pt(tstar, df = n - 2, lower.tail = TRUE)

## Assumptions

# Residual Analysis

# cls_did_eval
evals_resid <- residuals(lm_evals)
evals_fitted <- fitted(lm_evals)

plot(evals_fitted, evals_resid , main = 'cls_did_eval: Fitted vs. Residuals',
     xlab = 'Fitted Values', ylab = 'Residuals')

abline(h = 0)

# Age
age_resid <- residuals(lm_age)
age_fitted <- fitted(lm_age)

plot(age_fitted, age_resid , main = 'age: Fitted vs. Residuals',
     xlab = 'Fitted Values', ylab = 'Residuals')

abline(h = 0)


# Normality

# cls_did_eval
qqnorm(evals_resid)
qqline(evals_resid, col = 'red')

# Age
qqnorm(age_resid)
qqline(age_resid, col = 'red')