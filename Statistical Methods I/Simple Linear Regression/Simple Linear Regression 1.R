# =====================================
# Simple Linear Regression
# Part 1
# =====================================

starbucks <- read.csv("starbucks.csv")
head(starbucks)

# ================================
# Descriptive Analysis
# ================================

# Create a Scatterplot
plot(starbucks$calories, starbucks$carb, xlab = 'Calories', ylab = 'Carbohyrdates (Grams)')

# Calculate Pearson's Correlation
cor(starbucks$calories, starbucks$carb)


# Fit a Linear Regression Model
lm_starbucks<- lm(carb ~ calories, data = starbucks)

# View Coefficients, Standard Errors, p-Values
summary(lm_starbucks)
summary(lm_starbucks)$coefficients
summary(lm_starbucks)$coefficients[2, 2]

# You Can Also View Just the Coefficients
lm_starbucks$coefficients

# Make a Scatterplot with the Regression Line Overlaid
plot(starbucks$calories, starbucks$carb, xlab = 'Calories', ylab = 'Carbohydrates (Grams)')
abline(a = lm_starbucks$coefficients[1], b = lm_starbucks$coefficients[2], col = 'darkgreen')

# Predict Y at a New X Value
newX <- 150  # Number of calories

beta0_hat <- as.numeric(lm_starbucks$coefficients[1])
beta1_hat <- as.numeric(lm_starbucks$coefficients[2])
predictedY <- beta0_hat + beta1_hat * newX
predictedY


# ======================================================
# Inference on Regression Parameters
# Make Confidence Intervals for the Intercept and Slope
# ======================================================

# This Code Retrieves the Estimates and Standard Errors
# lm_starbucks$coefficients Just Gives the Estimates
starbucks_coefficients <- summary(lm_starbucks)$coefficients
starbucks_coefficients

# 99% CI for the Intercept
n <- nrow(starbucks)
tstar <- qt(0.995, df = n - 2)

beta0_hat <- starbucks_coefficients[1, 1]
se_beta0_hat <- starbucks_coefficients[1, 2]

lower <- beta0_hat - tstar * se_beta0_hat
upper <- beta0_hat + tstar * se_beta0_hat

# Print the Confidence Interval
c(lower, upper)


# 95% CI for the Slope
n <- nrow(starbucks)
tstar <- qt(0.975, df = n - 2)

# Get Estimate and Standard Error from Row 2 of the Coefficients Matrix
beta1_hat <- starbucks_coefficients[2, 1]
se_beta1_hat <- starbucks_coefficients[2, 2]

lower_slope <- beta1_hat - tstar * se_beta1_hat
upper_slope <- beta1_hat + tstar * se_beta1_hat

# Print the Confidence Interval
c(lower_slope, upper_slope)

# Here is One More Way to Find the Same Thing
# 99% Confidence Intervals for Both Coefficients
confint(lm_starbucks, level = 0.99)
confint(lm_starbucks, level = 0.95)

# ============================================
# Hypothesis Tests for Coefficients
# ============================================


# H0: beta1 = 0; HA: beta1 =/= 0
# Using alpha = 0.05

# This is the p-Value for the Test
starbucks_coefficients[2, 4]
starbucks_coefficients[2, 3]

# Reject H0


# H0: beta0 = 6; HA: beta0 =/= 6
# Using alpha = 0.05

t0 <- (beta0_hat - 6) / se_beta0_hat
t0

# Find Two-Sided p-Value from t0
2 * pt(t0, df = n - 2, lower.tail = FALSE)