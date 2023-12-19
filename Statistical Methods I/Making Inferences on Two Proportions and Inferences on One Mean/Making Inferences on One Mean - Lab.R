# =================================
# One Sample t-Test
# =================================

# White Croaker
n <- 15
tstar <- qt(0.995, df = n - 1)
ybar <- 0.287
s <- 0.069

ybar + tstar*s / sqrt(n)
ybar - tstar*s / sqrt(n)


# Cherry Blossom
ybar <- 97.32
mu0 <- 93.29
s <- 16.98
n <- 100

# Test Statistic
t0 <- (ybar - mu0) / (s / sqrt(n))
t0

# p-Value
pt(t0, df = n - 1, lower.tail = FALSE)

# CI for mu
ybar <- 97.32
s <- 16.98
n <- 100
alpha <- 0.05
tstar <- qt(1 - alpha / 2, df = n - 1)

ybar - tstar * s / sqrt(n)
ybar + tstar * s / sqrt(n)