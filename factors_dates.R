################################## FACTORS ####################################

library(tidyverse)

# factors are also known as categorical variables, with no inherent numeric values

sex = sample (1:2, 20, T)
sex_factor = factor(sex, levels = c(1,2), labels = c('male', 'female'))

# creating a factor from a string variable using base R
# creating a string from a factor variable will always have the #s be 1, 2, 3, 4

sex = sample(c('male', 'female'), 20, T)
sex_factor = factor(sex, levels = c('male', 'female'))
as.integer(sex_factor)

# we can also use the 'readr' package to create factors, which is nice because
# it lets us known if there are alements in the vector we didn't specify in the levels

sex = sample(c('male', 'female', 'other'), 20, T)
sex_factor = factor(sex, levels = c('male', 'female')) # no warnings


sex_factor = parse_factor(sex, levels = c('male', 'female')) # warnings!


# you can also use as.factor() to convert a string to a factor without
# specifying levels

# when we have a factor inside a tibble, it will let us know with <fct>
tibble(x = sex_factor)


############################### forcats package ################################

# every function starts with fct_, and starts with the data you want to manipulate

# get number of people in each level of a factor variable
fct_count(gss_cat$partyid)

# sort from highest to least
fct_count(gss_cat$partyid, sort = T)

# collapse a factor into manually defined groups
partyid_collapsed = fct_collapse(
  gss_cat$partyid,
  missing = c('No answer', "Don't know"),
  other = "Other party",
  rep = c('Not str republican', 'Strong republican'),
  ind = c('Ind,near rep', 'Ind,near dem', 'Independent'),
  dem = c('Not str democrat', 'Strong democrat')
)

fct_count(partyid_collapsed, sort = T)


# drop unused levels
sex_factor = factor(c('male', 'female'), levels = c('male', 'female', "other"))
fct_drop(sex_factor)
fct_drop(sex_factor, only = 'other')

# add additional levels to a factor
sex_factor = factor(c('male', 'female'), levels = c('male', 'female'))
fct_expand(sex_factor, 'other')

# give NA values an explicit factor level
fct_explicit_na()

# reorder factor levels by first appearance or frequency

fct_inorder()
fct_infreq()

# lump together least/most common factor levels into "other"
fct_lump()

# can recode factor levels manually

fct_recode()

# relevel factors manually
fct_relevel()

# change the position/reorder
fct_reorder()

# reverse the order of factors
fct_rev()




################################## Dates in R ##################################

library(lubridate)


as_date(0)
as_date(1)
as_date(-1)

standard_date = '2019-04-06'  # this is the ideal date format
as_date(standard_date)
as_date(standard_date) %>% class()

as_date('2019-4-6')
as_date('19-4-6')

todays_date = 20190406
as_date(todays_date)
todays_date %>% as.character(.) %>% as_date(.)

non_standard_date = '04/06/2019'
as_date(non_standard_date)
as_date(non_standard_date, tz = "US/Eastern", format = '%m/%d/%Y')

OlsonNames() # for finding the timezone. you don't need to specific a timezone though


# you can also use as.Date() in base R to do the above
as.Date(non_standard_date, format = '%m/%d/%Y')


########################### lubridate functions #################################

# get todays date
now()
now() %>% as_date(.)
today_date = today()
today_date

# extract the day
day(today_date)

# day of the week
wday(today_date)
wday(today_date, label = T, abbr = F)

days_in_month(today_date)

leap_year(today_date)

month()

week()

year()

# can do nummeric computations on dates as a class

today_date + years(1)
today_date + days(1)
today_date + months(1)

# etc...











