library(tidyverse)
library(lubridate)
library(nycflights13)

############################### group_by basics ################################
# subset the data to look only at LGA and JFK

lga = flights %>%
  mutate(date = paste0(year, '-', month, '-', day) %>% as_date()) %>%
  dplyr::filter(origin == "LGA") %>%
  sample_n(5) %>%
  select(date, origin, dep_delay) %>%
  mutate(was_delayed = as.numeric(dep_delay > 0))

jfk = flights %>%
  mutate(date = paste0(year, '-', month, '-', day) %>% as_date()) %>%
  dplyr::filter(origin == "JFK") %>%
  sample_n(5) %>%
  select(date, origin, dep_delay) %>%
  mutate(was_delayed = as.numeric(dep_delay > 0))

# now we can run statistics on these airports separately
table(lga$was_delayed)
table(jfk$was_delayed)
mean(lga$dep_delay)
mean(jfk$dep_delay)

# there is a better way with group_by

df = flights %>%
  mutate(
    origin = parse_factor(flights$origin, levels = c('JFK', 'LGA', 'EWR')),
    date = paste0(year, '-', month, '-', day) %>% as_date()
  ) %>%
  select(date, origin, dep_delay) %>%
  sample_n(900)
table(df$origin)

df = flights %>%
  mutate(
    origin = parse_factor(flights$origin, levels = c('JFK', 'LGA', 'EWR')),
    date = paste0(year, '-', month, '-', day) %>% as_date()
  ) %>%
  select(date, origin, dep_delay) %>%
  group_by(origin)%>%
  sample_n(300) %>%
  ungroup()
table(df$origin)

# now we can perform operations by group
df %>%
  group_by(origin) %>%
  tally()

# an even simpler way
df %>%
  count(origin)

# add the sort option
flights %>% count(origin, sort = T)

# we can group multiple variables
df %>%
  group_by(origin, date) %>%
  tally() # %>% ungroup() # can use ungroup to change it back to a normal tibble

# similarly
df %>% count(origin, date)

# we can add unique identifiers to our groups
df = df %>% group_by(origin) %>% sample_n(5) %>% ungroup()

df %>% group_by(origin) %>% mutate(group_index = 1:n()) #n() returns the number 
# of rows inside of a tidyverse function

df %>% mutate(group_ids = group_indices(df, origin)) %>%
  group_by(origin) %>% mutate(group_index = 1:n())

################################## summarize ###################################

df = flights %>% select(origin, dep_delay, arr_delay, distance, tailnum) %>%
  mutate (origin = factor(origin))

# calculate summary statistics by group
df %>%
  group_by(origin) %>%
  summarise(mean_distance = mean(distance, na.rm = T))

df %>% 
  group_by(origin) %>% 
  summarise(
    mean_distance = mean(distance, na.rm = T),
    total_arr_delay = sum(arr_delay, na.rm = T))

# we can also use the _all, _if, and _at additions like with other dplyr
# functions with summarize
df %>% select(-tailnum) %>% 
  group_by(origin) %>% 
  summarize_all(mean, na.rm = T) %>%
  rename_at(vars(dep_delay, arr_delay, distance), ~ paste0(., '_mean'))

# instead of using select to get rid of the character variable tailnum, we can 
# use summarize_if

df %>%
  group_by(origin) %>% 
  summarize_if(is.numeric, ~ mean(., na.rm = T))

# only specify certain variables

df %>%
  group_by(origin) %>% 
  summarize_at(
    vars(dep_delay, arr_delay),
    funs(mean(., na.rm = T), var(., na.rm = T))
  )

############################ joining data with dplyr ###########################

# set up 2 tibbles
tibble_1 = tibble(
  age = c(10, 20, 30),
  gender = factor(c('M', 'M', 'F'), levels = c('F', 'M')),
  weight = c(200, 185, 125)
)

tibble_2 = tibble(
  age = c(11, 22, 33),
  income = c(10, 20, 30),
  gender = factor(c('M', 'M', 'F'), levels = c('F', 'M')),
  weight = c(200, 185, 125)
)

# we can stack these on top of one another, notice that the variables do not
# have to be in the same order or have the same exact variables, bind_rows()
# will fine in NA values in this case
bind_rows(tibble_1, tibble_2)

# we can also pass a single list filled with tibbles/data frames and bind_rows
# will stack every tibble in the list

tibble_list = list(tibble_1, tibble_2)
bind_rows(tibble_list)


# instead of stacking data frames on top of one another, we can also stack them
# next to each other with bind_cols()
bind_cols(tibble_1, tibble_2)

bind_cols(tibble_list)

# the data sets much have the same length or you will get an error
jobs = tibble(job = c('accountant', 'doctor', 'teacher', 'dentist'))

bind_cols(tibble_1, jobs)

################################# joins #######################################

# left join with dplyr = returns all rows from the left dataset and all 
# column from both data sets. The columns will be matched by a common variable
states = tibble(state_name = state.name, state_abb = state.abb)

df = tibble(
  state_name = sample(state.name, 100, replace = T),
  zip_code = sample(10000:99999, 100, replace = T)
)
df

unique(df$state_name)

left_join(df, states)
left_join(df, states, by = 'state_name')

states <- states %>% rename(name_of_state = state_name)
left_join(df, states, by = c('state_name' = 'name_of_states'))

# right join works the same way but keeps all rows from the dataset on the right

# inner_join keeps all the data that exists in both dataframes
band_members
band_instruments
inner_join(band_members, band_instruments, by = 'name')

# mick exists in band_members but not in instruments
# keith exists in band instruments but not in members
# so, these are excluded

# full_join() basically keeps everything, with missing data as NA
band_members %>% full_join(band_instruments)
