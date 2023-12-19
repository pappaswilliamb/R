# Strings in R

library(tidyverse)

# Creating Strings
string1 <- "This is a string"
string1

# Include a Quote
string2 <- 'If I want to include a "quote" inside a string, I use single quotes.'
string2
writeLines(string2)

string3 <- "If I want to include a \"quote\" inside a string, I can use a backslash."
string3
writeLines(string3)

# Complete List of Special Characters
?'"'

# Storing Multiple Strings
c("one", "two", "three")

# String Length
x <- c("a", "R for data science", NA)
x
str_length(x)

# Combine Strings
str_c("x", "y")
str_c("x", "y", "z")
str_c("x", "y", sep=", ")

x <- c("abc", NA) 
x
str_c("|-", x, "-|")
str_c("|-", str_replace_na(x), "-|")

# Vectorized and Auto Recycles Shorter Vectors
str_c("prefix-", c("a", "b", "c"), "-suffix")

# Objects of Length 0 Are Silently Dropped
name <- "Hadley"
time_of_day <- "morning"
birthday <- TRUE
  
str_c(
  "Good ", time_of_day, " ", name,
  if (birthday) " and HAPPY BIRTHDAY",
  "."
  )

# Collapse a Vector Into a Single String
str_c(c("x", "y", "z"), collapse = ", ")

# Subsetting Strings
x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)
str_sub(x, -3, -1)
str_sub("a", 1, 5)

x
str_sub(x, 1, 1) <- str_to_lower(str_sub(x, 1, 1))
x


# Locales  
# Paying Attention to Locale
# For Example, Turkish Has Two i's: With and Without a Dot, and It Has a Different Rule for Capitalizing Them:
str_to_upper(c("i"))
str_to_upper(c("i"), locale = "tr")

# Additional Examples
dog <- "The quick brown dog."
str_to_upper(dog)
str_to_lower(dog)
str_to_title(dog)
str_to_sentence(dog)
  
letters
str_order(letters)
str_sort(letters)
str_sort(letters, locale="haw")

# Matching Patterns With Regular Expressions
x <- c("apple", "banana", "pear")
x
str_view(x, "an")

str_view(x, ".a.")

# Special Character Designations
str_view(c("abc", "a.c", "bef"), "a\\.c")

x <- "a\\b"
writeLines(x)
str_view(x, "\\\\")
  
# Anchors
x <- c("apple", "banana", "pear")

# ^ to Match the Start of a String
str_view(x, "^a")

# $ to Match the End of a String
str_view(x, "a$")
  
x <- c("apple pie", "apple", "apple cake")
str_view(x, "apple")

# To Force Regular Expression to Only Match Complete String
str_view(x, "^apple$")
  
# Character Classes and Alternatives

#\d matches any digit
#\s matches any whitespace
#[abc] matches a, b, or c. 
#[^abc] matches anything except a, b, or c.
  
ch = c('Nancy Smith',
       'is there any solution?',
       ".[{(^$|?*+",
       "coreyms.com", 
       "321-555-4321", 
       "123.555.1234",
       "123*555*1234"
  )
  
ch
ch %>% str_view("\\d")
str_view(ch, "\\s")
ch %>% str_view("[-]")  
str_view(ch, "[^-]")
  
ch %>% str_view("\\d\\d\\d-\\d\\d\\d-\\d\\d\\d\\d")

# Can Use Alternation to Pick Between One or More Alternative Patterns
cl <- c("grey", "gray")
str_view(cl, "gre|ay")
str_view(cl, "gr(e|a)y")

# Repetition
x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"

str_view(x, "CC?")

str_view(x, "CC+")

str_view(x, "C[LX]+")

str_view(x, "C+[LX]+")

# Can Also Specify Number of Matches Precisely
str_view(x, "C{2}")
str_view(x, "C{2,}")
str_view(x, "C{2,3}")
str_view(x, 'C{2,3}?')
str_view(x, 'C[LX]+?')


# Grouping and Back References
fruit
str_view(fruit, "(..)\\1", match=TRUE)

str_view(fruit, "(.)(.)\\2\\1", match = TRUE)


# Tools
x <- c("apple", "banana", "pear")
str_detect(x, "e")

# How Many Common Words Start with t?
sum(str_detect(words, "^t"))

# What Proportion of Common Words End with a Vowel?
mean(str_detect(words, "[aeiou]$"))

# Find All Words Containing at Least One Vowel, and Negate
no_vowels_1 <- !str_detect(words, "[aeiou]")

# Find All Words Consisting Only of Consonants (Non-Vowels)
no_vowels_2 <- str_detect(words, "^[^aeiou]+$")
identical(no_vowels_1, no_vowels_2)

# Select the Elements That Match a Pattern
words[str_detect(words, "x$")]

str_subset(words, "x$")

# Selecting Elements from a Column in a Data Frame
df <- tibble(
  word = words, 
  i = seq_along(word)
)

df
df %>% 
  filter(str_detect(word, "x$"))

# Looking at str_count()
x <- c("apple", "banana", "pear")
str_count(x, "a")

# On Average, How Many Vowels per Word?
mean(str_count(words, "[aeiou]"))


df %>% 
  mutate(
    vowels = str_count(word, "[aeiou]"),
    consonants = str_count(word, "[^aeiou]")
  )


# Extract Matches

# Using Sentences from stringr Package
length(sentences)
head(sentences)

# Finding All Sentences That Contain a Color
colors <- c("red", "orange", "yellow", "green", "blue", "purple")
color_match <- str_c(colors, collapse = "|")
color_match
  
# Select Sentences That Contain a Color
has_color <- str_subset(sentences, color_match)

# Extract Which Color Is Used
matches <- str_extract(has_color, color_match)
head(matches)
  
# str_extract Only Extracts First Match
more <- sentences[str_count(sentences, color_match) > 1]
str_view_all(more, color_match)
str_extract(more, color_match)
  
# str_exatract_all Extracts All Matches
str_extract_all(more, color_match)
  
# simplify = TRUE Will Return Matrix 
str_extract_all(more, color_match, simplify = TRUE)
  
# Grouped Matches
noun <- "(a|the) ([^ ]+)"
  
has_noun <- sentences %>%
  str_subset(noun) %>%
  head(10)
  
has_noun %>%
  str_extract(noun)
  
# str_match Gives Each Individual Component
has_noun %>%
  str_match(noun)
  
# Using extrac from tidyr Rather Than str_match
tibble(sentence = sentences) %>%
  tidyr::extract(
      sentence, c("article", "noun"), "(a|the) ([^ ]+)", 
      remove = FALSE
    )
  
# Replacing Matches
x <- c("apple", "pear", "banana")
str_replace(x, "[aeiou]", "-")
str_replace_all(x, "[aeiou]", "-")
  
x <- c("1 house", "2 cars", "3 people")
str_replace_all(x, c("1" = "one", "2" = "two", "3" = "three"))
  
# Using backreferences - Flip Second and Third Words
sentences %>%
  str_replace("([^ ]+) ([^ ]+) ([^ ]+)", "\\1 \\3 \\2") %>% 
  head(5)
  
# Splitting
sentences %>%
  head(5) %>%
  str_split(" ") # Can add simplify=TRUE
  
# Can Request a Max Number of Pieces
fields <- c("Name: Hadley", "Country: NZ", "Age: 35")
fields %>% str_split(": ", n = 2, simplify = TRUE)
  

# Other Types of Patterns

# The Regular Call:
str_view(fruit, "nana")

# Is Shorthand for
str_view(fruit, regex("nana"))
  
# ignore_case
bananas <- c("banana", "Banana", "BANANA")
str_view(bananas, "banana")
  
str_view(bananas, regex("banana", ignore_case = TRUE))
  
# Match the Start and End of Each Line 
x <- "Line 1\nLine 2\nLine 3"
x
writeLines(x)
str_extract_all(x, "^Line")[[1]]
str_extract_all(x, regex("^Line", multiline = TRUE))[[1]]
  
# Embed Comments
phone <- regex("
\\(?     # optional opening parens
(\\d{3}) # area code
[ )-]?   # optional closing parens, space, or dash
(\\d{3}) # another three numbers
[ -]?    # optional space or dash
(\\d{4}) # three more numbers
", comments = TRUE)
  
str_match("514-791-8141", phone)