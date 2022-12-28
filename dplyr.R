#################################### dplyr #####################################
library(tidyverse)
library(lubridate)
library(nycflights13)

##################### using the select() function from dplyr ###################

# load in the nyc flights data
nycflights13::flights

df = nycflights13::flights %>%
  slice(1:1000)

df = nycflights13::flights %>%
  sample_n(1000)

glimpse(df) # peek at the data

# use select() to only keep certain variables
select(df, origin, dep_delay, arr_delay)
# or
df %>% select(origin, dep_delay, arr_delay)

# use select and the - to keep everything except certain variables
df %>% select(-origin)

# we can use select to reorder the variables
df %>% select(hour, minute) #but this will drop all other variables
df %>% select(hour, minute, everything()) #this will include everything and change the order

# we can select a range of variables
df %>% select(year:day) #by name
df %>% select(1:3) #by position

# we can rename variables while we select them
df %>% select(flight_year = year, flight_day = day, origin)

# helper functions
df %>% select(starts_with('arr_'))
df %>% select(ends_with('time'))
df %>% select(contains('_'))

df %>% select(-contains('_'))

################## using filter(), arrange(), and mutate() #####################

# filter allows us to use a conditional to only return certain rows
# a conditional must evaluate to a TRUE/FALSE logical vector

# filter data so that we only have cases (rows) of flights before Sept
df %>% dplyr::filter(month < 9)

# arrange sorts the data by a variable
df %>% select(time_hour, everything()) %>%
  arrange(time_hour)

# arrange in descending order
df %>% select(time_hour, everything()) %>%
  arrange(desc(time_hour))

# arrange by multiple columns
df %>% arrange(year, desc(month), day)

# rename variables using the rename command
df %>% select(flight_day = day, everything())
df %>% rename(flight_day = day) #this is the easier way to do the above

# mutate (transform) variables to add a new variable/field
df %>% mutate(date = as_date(time_hour)) %>%
  select(date, everything())

df %>% mutate(log_distance = log(distance)) %>%
  select(log_distance, everything())

####################### more advanced dplyr functions ##########################

# do something to all of the variables
df %>% select(distance, arr_time, dep_time) %>%
  mutate_all(log)

# this works for other functions too, like rename, using regex
rename_function = function(x) paste0(x, "_123")
df %>% rename_all(rename_function) %>%
  glimpse() # this is inefficient

df %>% rename_all(function(x) paste0(x, "_123")) %>%
  glimpse # this does the same as above, but more efficient

df %>% rename_all(~ paste0(., '_123')) # this does the same as above, but EVEN more efficient

# we can only choose what variables to work on with the _if selector
df %>% select_if(is.numeric)
df %>% mutate_if(is.numeric, function(x) log(abs(x)))
df %>% mutate_if(is.numeric, ~ log(abs(.)))

# _at allows us to only specific certain variables
df %>% rename_at(
  vars(contains('time')),
  function(x) paste0(x, "__123")
) %>% glimpse()

df %>% mutate_at(
  vars(month, day, dep_time),
  function(x) x^2
)

# be aware that you can use pipes inside of dplyr functions too
df %>% mutate_if(
  is.character,
  ~ str_to_lower(.) %>% str_c("CONCAT")
) %>% glimpse()
