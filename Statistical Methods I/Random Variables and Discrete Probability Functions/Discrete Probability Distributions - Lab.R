# ==================================
# Example: Customer Counts
# ==================================

# Probability of 5 Customers
# Using R as a Calculator
(3.75)^5 * exp(-3.75) / factorial(5)

# Using Built-In Function
dpois(5, lambda = 3.75)

# Probability of > 1 Customers
ppois(1, lambda = 3.75, lower.tail = FALSE)

# ==================================
# Example: Mendel's Peas
# ==================================
# Probability of At Least 8 Yellow

# Using R as a Calculator
choose(10, 8) * (0.75)^8 * (1 - 0.75)^2 + choose(10, 9) * (0.75)^9 * (1 - 0.75)^1 +
  choose(10, 10) * (0.75)^10 * (1 - 0.75)^0

# Using dbinom
dbinom(8, size = 10, prob = 0.75) + dbinom(9, size = 10, prob = 0.75) + dbinom(10, size = 10, prob = 0.75)

# Using pbinom
pbinom(7, size = 10, prob = 0.75, lower.tail = FALSE)

# ======================================
# Example: Binomial
# ======================================

# P(17 < Y <= 20)
# Using dbinom
dbinom(18, size = 21, prob = 0.65) + dbinom(19, size = 21, prob = 0.65) + dbinom(20, size = 21, prob = 0.65)

# Using pbinom
pbinom(20, size = 21, prob = 0.65) - pbinom(17, size = 21, prob = 0.65)


# P(17 <= Y < 20)
# Using dbinom
dbinom(17, size = 21, prob = 0.65) + dbinom(18, size = 21, prob = 0.65) + dbinom(19, size = 21, prob = 0.65)

# Using pbinom
pbinom(19, size = 21, prob = 0.65, lower.tail = TRUE) - pbinom(16, size = 21, prob = 0.65, lower.tail = TRUE)