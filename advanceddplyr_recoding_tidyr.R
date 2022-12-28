library(tidyverse)
library(lubridate)
library(nycflights13)

###################### some other dplyr functions ##############################

# dplyr sample functions
flight_data = flights %>% sample_n(100000)
flights
flight_data

flight_data %>% sample_frac(.10)

# get the top ten most delayed departure flights
flights %>%
  top_n(10, dep_delay) %>% arrange(desc(dep_delay))

# works especially nice with group_by
flights %>% 
  select(origin, dep_delay) %>% 
  group_by(origin) %>% 
  top_n(10, dep_delay) %>% 
  ungroup() %>% 
  arrange(origin, desc(dep_delay)) %>% 
  print(n = 30)

# find values between two values - between(),
10 < 20 & 10 > 5
dplyr::between(10, 5, 20) # this asks is 10 between 5 and 20

# distinct() will only return unique rows of  a tibble/data frame
new_tibble = tibble(
  x = c(1,1,2,2),
  y = c(1,1,3,4)
)
new_tibble
new_tibble %>% distinct()

new_tibble %>% distinct(x) # unique values only within the x value
new_tibble %>% distinct(x, .keep_all = T) # keep all columns in the tibble

# pull a single variable out of a tibble
new_tibble %>% pull(x)

####################### recoding data using if_else ############################

# recode data using if_else
# say we want to recode the dep_delay variable or create a new variable based
# on a recode of the dep_delay variable such that if dep_delay is < 0 then 'early'
# if greater than 0 = late and NA otherwise

flights_recoded = flights %>% mutate(
  delay_status = if_else(dep_delay > 0, 'late', 'early')
) %>% select(dep_delay, delay_status, everything())
flights_recoded

unique(flights_recoded$delay_status)

sum(is.na(flights_recoded)) #NAs are preserved


# using if_Else with multiple statements. Notice above that we have a problem,
# if the dep_delay is exactly 0, then it will be put with the early group which
# is not really true, so let's rewrite

flights_recoded = flights %>% mutate(
  delay_status = if_else(
    dep_delay > 0, 'late', 
    if_else(dep_delay < 0, 'early', 'on_time')
  )
) 

unique(flights_recoded$delay_status)

# recode data using case_when. As a general rule, use if_else for simple 
# variable recodes with 2 conditions like the first example. Anything other
# than that and things get annoying so use case_when instead which is much
# cleaner

flights %>% 
  mutate(
    delay_status = case_when(
      dep_delay > 0 ~ 'late', # outputs must all be of the same type
      dep_delay < 0 ~ 'early',
      dep_delay == 0 ~ 'on time',
      T ~ NA_character_ # if any other condition is true, make it NA
    )
  ) %>% pull(delay_states) %>% unique()


###################################### tidyr ##################################

stocks = tibble(
  time = as.Date('2009-01-01') + 0:9,
  AAPL = rnorm(10, 0, 1),
  GOOGL = rnorm(10, 0, 2),
  MSFT = rnorm(10, 0, 4)
)

# gather collects variables into a single variable
stocks %>% gather(key = 'stock', value = 'price', AAPL, GOOGL, MSFT) %>% 
  print(n = 30)

long_data = stocks %>% gather('stock', 'price', -time)
print(long_data, n = 30)

# spread is the opposite, it spreads data out into wide format
long_data %>% spread(key = 'stock', value = 'price')


# be aware that with spread the data much have a unique identifier to know
# how to spread the data

# separate and unite
data = tibble(
  name = c('Robert Bird', 'Jennifer Jones', 'Pete Smith'),
  student_id = c(
    'robert35848393bird', 'jennifer239479234jones', 'pete2340803999smith'
  )
)

# separate the name into two columns, first and last names
data %>% separate(col = 'name', into = c('first name', 'last name'))

# we can specify the separator explicitly
data %>% separate(col = 'name', into = c('first name', 'last name'), sep = ' ')

# we can also use a regex
data %>% 
  separate(col = 'student_id', into = c('first name', 'last name'), sep = '\\d+')

# unite is the opposite
separated_data = data %>% 
  separate(col = 'name', into = c('first_name', 'last_name'), sep = ' ')

separated_data %>% unite(col = 'full_name', first_name, last_name, sep = ' ')
