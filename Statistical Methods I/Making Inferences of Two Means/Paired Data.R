gradrates <- read.csv("gradrates.csv", header = T)
head(gradrates)

names(gradrates) <- c("school", "gr1617", "gr1718")
gradrates

# Univariate Summaries
summary(gradrates$gr1617)
summary(gradrates$gr1718)

boxplot(gradrates$gr1617, gradrates$gr1718)

# Assess Association
plot(gradrates$gr1617, gradrates$gr1718)
cor(gradrates$gr1617, gradrates$gr1718)


# Summarize Differences
gradrates$gr1617 - gradrates$gr1718
gradrates$differences <- gradrates$gr1617 -gradrates$gr1718

gradrates

# Univariate Summaries of Differences
summary(gradrates$differences)
boxplot(gradrates$differences)


# ================================
# Inference on mu_d
# ================================

# CI for mu_d: Average Difference Between 2016-2017 Graduate Rates and 2017-2018 Graduate Rates

t.test(gradrates$differences, conf.level = 0.9)

qqnorm(gradrates$differences)
qqline(gradrates$differences, col = 'red')

diff_no_outlier <- gradrates$differences[-3]
t.test(diff_no_outlier, conf.level = 0.9)
qqnorm(diff_no_outlier)
qqline(diff_no_outlier)


# Hypothesis Test:
# Is There Evidence That Graduate Rates Increased?

# H_0: mu_d = 0
# H_A: mu_d < 0
# alpha = 0.01

t.test(diff_no_outlier, alternative = "less")
t.test(gradrates$differences, alternative = "less")