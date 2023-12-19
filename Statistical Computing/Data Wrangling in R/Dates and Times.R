# Dates and Times in R

# Packages Needed
library(tidyverse)
library(lubridate) # Not part of the tidyverse package
library(nycflights13)

######################################################
# Creating Dates and Times
######################################################

today()
now()

# Create Dates from Strings

ymd("2021-09-09")
mdy("May 25, 1946")
dmy("31Jan2017")
ymd(20210701)

# Create DATE-TIME from Strings

ymd_hms("2017-01-31 20:11:59")
mdy_hm("01/31/2017 08:01")

# You Can Also Supply a Timezone
mdy(04152020, tz="EST")

# Create from Individual Components
flights %>% 
  select(year, month, day, hour, minute)

flights %>% 
  select(year, month, day, hour, minute) %>% 
  mutate(departure = make_datetime(year, month, day, hour, minute))


# From Other Types

# To Switch Between Datetime and Date
# Use as_datetime() and as_date()

as_datetime(today())
as_date(now())