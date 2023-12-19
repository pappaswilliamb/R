# Factors in R

# Packages Needed

library(tidyverse)

###################################################
# Creating Factors
###################################################

x1 <- c("Dec", "Apr", "Jan", "Mar")
x1


# Nothing Saving You from Typos
x2 <- c("Dec", "Apr", "Jam", "Mar")
x2

# Does Not Sort Properly
sort(x1)

# Fixed with Levels

month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)

# Create Factor
y1 <- factor(x1, levels = month_levels)
y1
sort(y1)

# Any Values Not Set In Levels Will Convert to NA
y2 <- factor(x2, levels = month_levels)
y2

# If You Prefer a Warning, Use parse_factor from readr
y2 <- parse_factor(x2, levels = month_levels)
y2

# If You Omit Levels, They Will Be Taken from Data In Alphbetical order
factor(x1)

# If You Prefer the Levels Match the Order of the First Appearance in the Data, There Are Two Different Methods:
f1 <- factor(x1, levels = unique(x1))
f1

f2 <- x1 %>% factor() %>% fct_inorder()
f2

# To Access the Set of Levels 
levels(f2)


###################################################
# General Social Survey
###################################################

# Data from the General Social Survey. The gss_cat Data is Provided by the forcats Pacakge

# For Additional Information About the Dataset 
?gss_cat
gss_cat

# One Way to See Levels of Factor Is to Use count()
gss_cat %>%
  count(race)

# or a Bar Chart
ggplot(gss_cat, aes(race)) +
  geom_bar()

# By Default ggplot Will Drop Levels That Don't Have Any Values but You Can Force Them To Appear 

ggplot(gss_cat, aes(race)) +
  geom_bar() +
  scale_x_discrete(drop = FALSE)


###################################################
# Modifying Factor Order
###################################################

# Explore Average Number of Hours Spent Watching TV per Day Across Religions

relig_summary <- gss_cat %>%
  group_by(relig) %>%
  summarise(
    age = mean(age, na.rm = TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )

ggplot(relig_summary, aes(tvhours, relig)) + 
  geom_point()


# Reorder the Levels Using fct_reorder()
ggplot(relig_summary, aes(tvhours, fct_reorder(relig, tvhours))) +
  geom_point()

# If aes Becomes Too Complicated, It Is Sometimes Recommended to Move the Transformations to a Mutate Step

relig_summary %>%
  mutate(relig = fct_reorder(relig, tvhours)) %>%
  ggplot(aes(tvhours, relig)) +
  geom_point()

# Explore Average Age Varies Across Reported Income Level
rincome_summary <- gss_cat %>%
  group_by(rincome) %>%
  summarise(
    age = mean(age, na.rm = TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )

ggplot(rincome_summary, aes(age, rincome)) + 
  geom_point()


# Don't Want to Change Order of Levels Because There Is Natural Order 
# However, Want to Move NA Up Front Using fct_relevel()

ggplot(rincome_summary, aes(age, fct_relevel(rincome, "Not applicable"))) +
  geom_point()


# Reordering a Factor by y Associated With the Largest x
# This Makes Lines Line Up With Legend

by_age <- gss_cat %>%
  filter(!is.na(age)) %>%
  count(age, marital) %>%
  group_by(age) %>%
  mutate(prop = n / sum(n))

ggplot(by_age, aes(age, prop, color = marital)) +
  geom_line(na.rm = TRUE)

ggplot(by_age, aes(age, prop, color = fct_reorder2(marital, age, prop))) +
  geom_line() +
  labs(color = "marital")


# To Order Levels in Increasing Frequency for Bar Plot, Use fct_infre

gss_cat %>%
  mutate(marital = marital %>% fct_infreq()) %>%
  ggplot(aes(marital)) +
  geom_bar()

###################################################
# Modifying Factor Levels
###################################################

# Allows You to Clarify Labels - Use fct_recode()

gss_cat %>% count(partyid)
levels(gss_cat$partyid)


gss_cat %>%
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong"    = "Strong republican",
                              "Republican, weak"      = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak"        = "Not str democrat",
                              "Democrat, strong"      = "Strong democrat"
  )) %>%
  count(partyid)


# To Combine Labels, Combine Multiple Old Labels to One New Label

gss_cat %>%
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong"    = "Strong republican",
                              "Republican, weak"      = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak"        = "Not str democrat",
                              "Democrat, strong"      = "Strong democrat",
                              "Other"                 = "No answer",
                              "Other"                 = "Don't know",
                              "Other"                 = "Other party"
  )) %>%
  count(partyid)


# or to Collapse a Lot of Levels, Use fct_collapse

gss_cat %>%
  mutate(partyid = fct_collapse(partyid,
                                other = c("No answer", "Don't know", "Other party"),
                                rep = c("Strong republican", "Not str republican"),
                                ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                                dem = c("Not str democrat", "Strong democrat")
  )) %>%
  count(partyid)


# To Lump All Small Groups, Use fct_lump

gss_cat %>%
  mutate(relig = fct_lump(relig)) %>%
  count(relig)

# To Specify How Many Groups Within fct_lump 
gss_cat %>%
  mutate(relig = fct_lump(relig, n = 10)) %>%
  count(relig, sort = TRUE) 