# ======================================
# Chi-Square Test in R
# ======================================


# iPod Example
# Input Data as a Table
ipod <- as.table(rbind(c(2, 23, 36), c(71, 50, 37)))
rownames(ipod) <- c("disclose", "hide")
colnames(ipod) <- c("general", "positive", "negative")

# Tables of Row Proportions and Column Proportions
prop.table(ipod, margin = 1)
prop.table(ipod, margin = 2)

# Barplots: Stacked and Grouped
barplot(ipod)
barplot(ipod, beside = TRUE)

# Chi-Square Test
chisq.test(ipod)

ipod_results <- chisq.test(ipod)
names(ipod_results)

# Show Expected Counts
ipod_results$expected
ipod_results$observed

# Print Test Statistic
ipod_results$statistic

# Contributions to the Test Statistic
# Both Lines of Code Find the Same Thing
(ipod_results$observed - ipod_results$expected)^2 / ipod_results$expected
(ipod_results$residuals)^2



# Data in Spreadsheet Format: Just Make a Table First
# simulated Example:

# Simulate Data Similar to the ipod Example
n <- 340
disclose_sim <- c("disclose", "hide")[sample(1:2, n, replace = TRUE)]
assumptions_sim <- c("general", "positive", "negative")[sample(1:3, n, replace = TRUE)]

# Use the Table Function and Save It
table(disclose_sim, assumptions_sim)
ipod_sim_table <- table(disclose_sim, assumptions_sim)

# Perform the Test
chisq.test(ipod_sim_table)