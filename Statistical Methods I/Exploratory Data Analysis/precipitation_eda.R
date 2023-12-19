# ===========================================================
# Example: Precipitation
# ===========================================================
precip <- read.csv('chicago_precip.csv')
names(precip)
head(precip)

# Find Mean Precipitation by Year at Station 304
tapply(precip$station304, precip$year, mean)

# How Many Missing Values Are There?
precip$station304 == -99.9
sum(precip$station304 == -99.9)
sum(precip$station314 == -99.9)

# Another Approach: Read in Data Again but Use NA for Missing Values
precip2 <- read.csv('chicago_precip.csv', na.strings = -99.9)
head(precip2)

# How Many Missing Values in Stations 304 and 314?
sum(is.na(precip2$station314))
sum(is.na(precip2$station304))

tapply(precip2$station314, precip2$year, mean, na.rm = T)

# Look Into Where Missing Values Occcur
precip.t1 <- table(precip2$weekday, is.na(precip2$station304))
precip.t1

barplot(precip.t1[, 2])

table(precip2$month, is.na(precip2$station304))

# Two Barplots of Month by Missings
barplot(table(precip2$month, is.na(precip2$station304))[, 2])
barplot(table(is.na(precip2$station304), precip2$month))

# Missings for Station 314
barplot(table(is.na(precip2$station314),precip2$month))
barplot(table(is.na(precip2$station314),precip2$weekday))

# Are Some Days Rainier Than Others?
boxplot(precip2$station314 ~ precip2$weekday)
hist(precip2$station314)
sum(precip2$station314 == 0, na.rm = T)
hist(log(precip2$station314 + 1))
boxplot(log(precip2$station314 + 1) ~ precip2$weekday)

boxplot(log(precip2$station314 + 1) ~ precip2$month)
zero.table <- table(precip2$station314 == 0, precip2$month)
prop.table(zero.table, 2) # Makes a proportion table

# Are Some Months Rainier Than Others?
tapply(precip2$station314, precip2$month, mean, na.rm = T)
tapply(precip2$station304, precip2$month, mean, na.rm = T)

# What About Annual Averages?
tapply(precip2$station304, precip2$year, mean, na.rm = T)

table(precip2$month, is.na(precip2$station304))