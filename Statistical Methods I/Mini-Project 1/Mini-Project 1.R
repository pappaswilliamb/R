loans <- read.csv("LCloans2_Q1_2018.csv")

# Summary Statistics of Variables
par(mfrow = c(5, 1))
summary(loans$annual_inc, na.rm = T)
summary(loans$dti, na.rm = T)
summary(loans$funded_amnt, na.rm = T)
summary(loans$tot_hi_cred_lim, na.rm = T)
table(loans$application_type)

# Histograms
options(scipen = 10000)
par(mfrow = c(4, 2.5))
hist(loans$annual_inc, main = "Annual Income", xlab = "Applicant Income ($)")
hist(loans$dti, main = "Debt-to-Income", xlab = "DTI")
hist(loans$funded_amnt, main = "Funded Loan Amounts", xlab = "Dollars ($)")
hist(loans$tot_hi_cred_lim, main = "Credit Limits", xlab = "Dollars ($)")

# Boxplots
par(mfrow = c(1, 4))
boxplot(loans$annual_inc, main = 'Annual Income of Applicants', ylab = 'Income ($)')
boxplot(loans$dti, main = 'Debt-to-Income of Applicants', ylab = 'Debt-to-Income')
boxplot(loans$funded_amnt, main = 'Applicant Loan Amounts', ylab = 'Loan Amount ($)')
boxplot(loans$tot_hi_cred_lim, main = 'Applicant Credit Limits', ylab = 'Credit Limit ($)')

# Boxplot for Variables by Application Type
par(mfrow = c(1, 4))
boxplot(loans$annual_inc ~ loans$application_type, 
        main = 'Annual Income of Applicants', xlab = "Application Type", ylab = 'Income ($)')
boxplot(loans$dti ~ loans$application_type, 
        main = 'Debt-to-Income of Applicants', xlab = "Application Type", ylab = 'Debt-to-Income')
boxplot(loans$funded_amnt ~ loans$application_type, 
        main = 'Applicant Loan Amounts', xlab = "Application Type", ylab = 'Loan Amount ($)')
boxplot(loans$tot_hi_cred_lim ~ loans$application_type, 
        main = 'Applicant Credit Limits', xlab = "Application Type", ylab = 'Credit Limit ($)')

# Scatterplot
loans$application_type <- as.factor(loans$application_type)
color.names <- c("red", "green")
plot(loans$annual_inc, loans$tot_hi_cred_lim, main = 'Applicant Income vs. Credit Limit', 
     xlab = 'Income ($)', ylab = 'Credit Limit', col = color.names[loans$application_type])
legend('topright', legend = c("Individual",
                           "Joint App"),
       col = c("red", "green"),
       pch = 1, cex = 0.6)

# Overall Spearman Correlation
cor(loans$annual_inc, loans$tot_hi_cred_lim, method = 'spearman')

# Overall Pearson Correlation
cor(loans$annual_inc, loans$tot_hi_cred_lim)

# Pearson Correlation of Individual Subset
indv_comp <- subset(loans, loans$application_type == "Individual")
cor(indv_comp$annual_inc, indv_comp$tot_hi_cred_lim)

# Pearson Correlation of Joint Subset
joint_comp <- subset(loans, loans$application_type == "Joint App")
cor(joint_comp$annual_inc, joint_comp$tot_hi_cred_lim)