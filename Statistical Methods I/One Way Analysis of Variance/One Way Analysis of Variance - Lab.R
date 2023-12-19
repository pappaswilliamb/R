# ===========================================
# Typing Data - ANOVA the Ordinary Way
# ===========================================

# Read Data In
typing <- read.csv('typing.csv')
head(typing)

# Find Mean and Standard Deviation by Group
# Approach 1: Using Subsets

mean(subset(typing, brand == "REGAL")$speed)
sd(subset(typing, brand == "REGAL")$speed)

mean(subset(typing, brand == "SPEEDYTYPE")$speed)
sd(subset(typing, brand == "SPEEDYTYPE")$speed)

mean(subset(typing, brand == "WORD-O-MATIC")$speed)
sd(subset(typing, brand == "WORD-O-MATIC")$speed)

# Approach 2: The tapply Function
group_means <- tapply(typing$speed, typing$brand, mean)
group_sds <- tapply(typing$speed, typing$brand, sd)



# ===========================================
# Fit the One-Way ANOVA Model
# ===========================================

lm_typing <- lm(speed ~ brand, data = typing)
anova(lm_typing)

anova_typing <- anova(lm_typing)
names(anova_typing)

# Use the $ to Extract Specific Numbers
anova_typing$`Pr(>F)`
anova_typing$`Sum Sq`


# ==============================================
# Mosquito Data - ANOVA the Long Way
# ==============================================
mosquito <- read.csv("mosquito.csv")

boxplot(mosquito$Mosquito.bite.rate ~ mosquito$Treatment.group)

t <- length(unique(mosquito$Treatment.group)) 
nT <- nrow(mosquito)

# Calculate the Means Within Each Treatment
ybar_treatment <- tapply(mosquito$Mosquito.bite.rate, mosquito$Treatment.group, mean)
ybar_treatment

# Calculate Sample Size Within Each Group
n_treatment <- tapply(mosquito$Mosquito.bite.rate, mosquito$Treatment.group, length)
n_treatment

# ================================
# Finding SSW
# ================================

# First Let's Focus on Group 1 to Get Some Intuition
response_group1 <- mosquito$Mosquito.bite.rate[mosquito$Treatment.group == 1]
response_group1

# Sum of Squares Within Group 1
sum((response_group1 - ybar_treatment[1])^2)

# The SSW is Within the Group Sum of Squares Added Up for All Groups 
# You Can Find This Many Ways. Here is a Way Using a For Loop:

ssw <- 0
for(j in 1:t)
{
  response_groupj <- mosquito$Mosquito.bite.rate[mosquito$Treatment.group == j]
  
  # Add the Group j SS to the Total SSW
  ssw <- ssw + sum((response_groupj - ybar_treatment[j])^2)
}

ssw

# ==================================
# SSB
# ==================================
overall_mean <- mean(mosquito$Mosquito.bite.rate)

(ybar_treatment - overall_mean)^2
ssb <- sum(n_treatment * ((ybar_treatment - overall_mean)^2))
ssb

# ========================================
# Calculate the Missing ANOVA Table Values
# ========================================

# Total Sum of Squares
ssb + ssw

# Mean Squares
s.squared.b <- ssb / (t - 1)
s.squared.w <- ssw / (nT - t)

# f0 Test Statistic
f0 <- s.squared.b / s.squared.w
f0

# p-Value
pf(f0, df1 = t - 1, df2 = nT - t, lower.tail = FALSE)

# Compare These to the Automatic ANOVA

# Cautionary Tale: Something is Wrong Here
# Notice df for Treatment is 1, While It Should Be 4

lm_mosquito <- lm(Mosquito.bite.rate ~ Treatment.group, data = mosquito)
anova(lm_mosquito)

# Convert the Group Indicator to Be a Factor
mosquito$Treatment.group <- as.factor(mosquito$Treatment.group)

lm_mosquito2 <- lm(Mosquito.bite.rate ~ Treatment.group, data = mosquito)
anova(lm_mosquito2)



# =========================================
# Residual Analysis
# =========================================

# Typing Data (Make Sure to Run the lm() First to Create lm_typing)
typing_residuals <- residuals(lm_typing)

stripchart(typing_residuals ~ typing$brand, vertical = TRUE,
           main = 'Residuals by Group: Typing Data',
           ylab = 'Residuals')

qqnorm(typing_residuals)
qqline(typing_residuals, col = 'darkgreen')

# FYI: You Can Use Stripchart to Visualize the Data by Group, Too
stripchart(typing$speed ~ typing$brand, vertical = TRUE)



# Mosquito Data
mosquito_residuals <- residuals(lm_mosquito2)

stripchart(mosquito_residuals ~ mosquito$Treatment.group, vertical = TRUE,
           main = 'Residuals by Group: Mosquito Data',
           ylab = 'Residuals')

qqnorm(mosquito_residuals)
qqline(mosquito_residuals, col = 'darkgreen')