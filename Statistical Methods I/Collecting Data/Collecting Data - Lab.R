highschools <- read.csv("Chicago_HS.csv", header = TRUE)

# View First 5 Rows
head(highschools)
# View Variable Names
names(highschools)
# Look at One Variable
highschools$Student_Count_Total
dim(highschools)

# Investigate Object Classes
class(highschools)
class(highschools$Student_Count_Total)
class(highschools$Graduation_Rate_School)
class(highschools$Dress_Code)



# Convert Dress Code into a Factor (Categorical Variables)
highschools$Dress_Code <- as.factor(highschools$Dress_Code)

class(highschools$Dress_Code)

# Make Some Exploratory Plots
hist(highschools$Student_Count_Total)
hist(highschools$Student_Count_Total, main = "Histogram of Student Count",
     xlab = 'count', breaks = 15)


# Make a Boxplot of "Student_Count_Low_Income"
boxplot(highschools$Student_Count_Low_Income,
        main = 'Low Income Students',
        ylab = 'Counts')

# Change Title, Axis Labels, and Orientation
boxplot(highschools$Student_Count_Low_Income,
        main = 'Low Income Students', horizontal = TRUE,
        xlab = 'Counts')

# ?boxplot --> Provides Info on Boxplot Function

# Save Boxplot as an Object
student_lowincome_boxplot <- boxplot(highschools$Student_Count_Low_Income,
        main = 'Low Income Students', horizontal = TRUE,
        xlab = 'Counts')
class(student_lowincome_boxplot)
student_lowincome_boxplot

# Scatter Plot of "Average_ACT_School" vs. "College_Enrollment_Rate_School"
plot(highschools$Average_ACT_School, 
     highschools$College_Enrollment_Rate_School,
     xlab = 'Average ACT', ylab = 'College Enrollment')

# Frequency Table of "Dress_Code"
table(highschools$Dress_Code)

# Summary Statistics
mean(highschools$Student_Count_Total)
median(highschools$Student_Count_Total)
sd(highschools$Student_Count_Total)
var(highschools$Student_Count_Total)
summary(highschools$Student_Count_Total)
cor(highschools$Student_Count_Total, highschools$Graduation_Rate_School)

# ====================================
# Subsetting with R
# ====================================

# Extract Rows 1-19 of the Data Frame
highschools[1:19, ]

# Extract Row 24 of the Data Frame
highschools[24, ]

# Extract Rows 3 and 12
highschools[c(3, 12), ]

# Extract Rows for All Schools with Greater Than 1500 Students
big.schools <- subset(highschools, highschools$Student_Count_Total > 1500)
highschools$Student_Count_Total > 1500
dim(big.schools)

# Look for Schools with Dress Code
highschools$Dress_Code == 'N'
no.dress.code <- subset(highschools, highschools$Dress_Code == 'N')
dim(no.dress.code)

# Extract Just Column 4
highschools[, 4]
highschools$Student_Count_Special_Ed

# Extract Columns 4, 6, 9, and 10
highschool.small <- highschools[, c(4, 6, 9, 10)]
dim(highschool.small)
head(highschool.small)