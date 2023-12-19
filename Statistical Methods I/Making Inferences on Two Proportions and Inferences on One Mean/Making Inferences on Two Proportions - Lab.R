# ===================================
# Example: Texting and Speeding
# ===================================

# Large Sample CI
pihat1 <- 25 / 305
pihat2 <- 45 / 450

# Lower and Upper Endpoints
pihat1 - pihat2 + qnorm(0.95) * sqrt(pihat1 * (1 - pihat1) / 305 +
                                    pihat2 * (1 - pihat2) / 450)

pihat1 - pihat2 - qnorm(0.95) * sqrt(pihat1 * (1 - pihat1) / 305 +
                                    pihat2 * (1 - pihat2) / 450)

# Use prop.test
prop.test(x = c(25, 45), n = c(305, 450), conf.level = 0.9, correct = FALSE)
prop.test(x = c(25, 45), n = c(305, 450), conf.level = 0.9, correct = TRUE)

# ===================================
# Example: Blood Thinners
# ===================================

# Blood thinners Using Formula
# Sample Sizes in Control and Treatment Groups
n1 <- 50
n2 <- 40

# Number of Successes in Control and Treatment Groups
x1 <- 11
x2 <- 14

pihat1 <- x1 / n1
pihat2 <- x2 / n2
pihat.pool <- (x1 + x2) / (n1 + n2)

# Test Statistic
z0 <- (pihat1 - pihat2) / sqrt(pihat.pool * (1 - pihat.pool) / n1 +
                               pihat.pool * (1 - pihat.pool) / n2)

# p-Value
2 * pnorm(abs(z0), lower.tail = FALSE)

# Blood Thinners Using prop.test
# Sample Sizes in Control and Treatment Groups
n1 <- 50
n2 <- 40
x1 <- 11
x2 <- 14
prop.test(x = c(x1, x2), n = c(n1, n2), alternative = 'two.sided',
          correct = TRUE)