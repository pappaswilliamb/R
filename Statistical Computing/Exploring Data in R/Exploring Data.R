# Exploring Data

# Load Appropriate Packages
library(tidyverse) # Loads the tidyverse package
library(ggplot2) # Loads the ggplot2 package

data() # Explore datasets innate to console
?starwars # Info on this dataset

view(starwars) # View starwars dataset as a data frame

# Creates a Sub-Dataset That Filters for All Male Humans in the starwars Dataset
(star_wars_human_males <- filter(starwars, species == "Human" & gender == "masculine")) # Uses logical operator ("==") and conditional operator ("&")

# Mean, Standard Deviation, Median, and IQR of Height Variable in Sub-Dataset
(star_wars_subset_summary <- summarize(star_wars_human_males, Mean_Height = mean(height, na.rm = TRUE), 
          Height_SD = sd(height, na.rm = TRUE), 
          Median_Height = median(height, na.rm = TRUE), 
          Height_IQR = IQR(height, na.rm = TRUE)))

# How is the Distribution of Male Human Height in the Star Wars Universe? 
# Is it Positively-Skewed, Negatively-Skewed, or Approximately Normally Distributed?
ggplot(star_wars_human_males, aes(y = height)) + 
  geom_boxplot(fill = "green") + 
  labs(title = "Star Wars", subtitle = "Distribution of Human Male Character Height", caption = "The following boxplot shows the height distribution of human males in the Star Wars universe.") + 
  ylab("Height (cm)")
ggsave("star_wars_human_male_heights.pdf")

# How Does the Distribution of Feminine Height Compare to the Distribution of Masculine Height in the Star Wars Universe? 
star_wars <- filter(starwars, gender %in% c("masculine", "feminine")) # Filters out NAs from gender field
ggplot(star_wars, aes(y = height)) + 
  geom_boxplot(fill = c("red", "blue")) + 
  labs(title = "Star Wars", subtitle = "Feminine versus Masculine Height Distributions", caption = "The following boxplot compares the height distribution of feminine and masculine characters in the Star Wars universe.") + 
  ylab("Height (cm)") +
  facet_wrap(~ gender)
ggsave("star_wars_feminine_vs_masculine_height.pdf")