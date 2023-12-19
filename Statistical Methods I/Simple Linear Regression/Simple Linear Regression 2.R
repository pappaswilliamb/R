# =====================================
# Simple Linear Regression
# Part 2
# =====================================

starbucks <- read.csv("starbucks.csv")
head(starbucks)

# ================================
# Residual Analysis
# ================================

# Fit a Linear Regression Model
lm_starbucks<- lm(carb ~ calories, data = starbucks)

# View Coefficients, Standard Errors, and p-Values
summary(lm_starbucks)
class(lm_starbucks)

# Default Plots from R
plot(lm_starbucks)

# Calculate Residuals
starbucks_resid <- residuals(lm_starbucks)
starbucks_fitted <- fitted(lm_starbucks)

plot(starbucks$calories, starbucks_resid, main = 'Calories vs. Residuals',
     xlab = 'Calories', ylab = 'Residuals')
# Add Horizontal Line at 0 
abline(h = 0)

# Fitted vs. Residuals
# Has the Exact Same Pattern, but This is Not the Case with Multiple Linear Regression
plot(starbucks_fitted, starbucks_resid, main = 'Fitted vs. Residuals',
     xlab = 'Calories', ylab = 'Residuals')
# Add Horizontal Line at 0 
abline(h = 0)

# Normal Quantile Plot
qqnorm(starbucks_resid)


# ===============================================
# R-Squared
# ===============================================
summary(lm_starbucks)

# Save the R-Squared as an Object
starbucks_rsq <- summary(lm_starbucks)$r.squared
starbucks_rsq