library(tidyverse)
library(lubridate)
library(nycflights13)
library(estimatr)


############################# Question 1 (20 Points)  ##########################
create_dummies <- function(df, a_factor, .keep = T) {
  
  # if the df is not a data.frame or tibble, then throw an error
  if (!is.data.frame(df) && !is.tibble(df)) {
    stop("'df' must be a data.frame or tibble.")
  }
  
  # make a copy of the data call it 'new_df'
  new_df <- df[a_factor]
  
  # select out only the factor variable we want to make dummies for
  my_factor <- as.factor(new_df[[a_factor]])

  # if a_factor is not a factor then throw an error
  if (!is.factor(my_factor)) {
    stop("'a_factor' must be a factor variable.")
  }

  # grab the levels of the 'my_factor' variable and store them in a variable
  factor_levels <- levels(my_factor)
  
  # for each level of 'factor_levels', test if that level is equal to
  # each element in 'my_factor'
  for (i in 1:length(factor_levels)) {
    # for each level of 'factor_levels', test if that level is equal to
    # each element in 'my_factor'
    level_dummy <- my_factor == factor_levels[i]

    # convert the level name to a valid R variable name
    level_name <- make.names(factor_levels[i])

    # convert that logical vector to an integer and append it to the 'new_df'
    new_df[[paste0(level_name, "_dummy")]] <- as.numeric(level_dummy)

  }
    # if .keep = TRUE, return the df as is
    if (.keep == TRUE) {
      return(new_df)
  }

# if .keep is not true then we only have to return the dummies
  new_df <- new_df %>% select(-a_factor)
  new_df
 }


# test the code with the below
set.seed(1234)
test <- tibble(
  sex = sample(c('Male', 'Female', NA), 20, T),
  voted = sample(c('Yes', 'No', NA), 20, T)
)
test <- test %>% mutate(
  sex = parse_factor(
    sex, levels = c('Male', 'Female'), include_na = F
  ),
  voted = parse_factor(voted, levels = c('Yes', 'No'), include_na = F)
)
create_dummies(test, 'sex', T)
create_dummies(test, 'sex', F)
create_dummies(test, 'voted', T)
create_dummies(test, 'voted', F)
  

############################# Question 2 (10 Points)  ##########################
create_multiple_dummies <- function(df, a_vector, .keep = T) {
  # if the df is not a data.frame or tibble, then throw an error
  if (!is.data.frame(df) && !is.tibble(df)) {
    stop("'df' must be a data.frame or tibble.")
  }
  
  # if a_vector is not a vector, then throw an error
  if (!is.vector(a_vector)) {
    stop("'a_vector' must be a vector of variable names.")
  }
  
  # create a list where each element is a dummy variable data frame for each 
  # variable in "a_vector"
  dummies_list <- map(a_vector, create_dummies, df = df, .keep = .keep)
  
  # bind the dummy variable data frames together and return the result
  bind_cols(dummies_list)
}

# test the code with the below
set.seed(1234)
test2 <- tibble(
  sex = parse_factor(
    sample(c('Male', 'Female'), 15, T), levels = c('Male', 'Female')
  ),
  age = parse_factor(
    sample(c('18-30', '30-50', '50+'), 15, T), 
    levels = c('18-30', '30-50', '50+')
  ),
  income = parse_factor(
    sample(c('< 25K', '25K < 50K', '50K < 100K', '100K+'), 15, T),
    levels = c('< 25K', '25K < 50K', '50K < 100K', '100K+')
  )
)

create_multiple_dummies(test2, c('sex', 'age', 'income'), .keep = T)
create_multiple_dummies(test2, c('sex', 'age', 'income'), .keep = F)


############################# Question 3 (15 Points)  ##########################
create_multiple_dummies2 <- function(df, a_vector, .keep = T, .keeps = NULL) {
  
  # if the df is not a data.frame or tibble, then throw an error
  if (!is.data.frame(df) && !is.tibble(df)) {
    stop("'df' must be a data.frame or tibble.")
  }
  
  # if a_vector is not a vector, then throw an error
  if (!is.vector(a_vector)) {
    stop("'a_vector' must be a vector of variable names.")
  }
  
  # create a list where each element is a dummy variable data frame for each 
  # variable in "a_vector"
  dummies_list <- map(a_vector, create_dummies, df = df, .keep = .keep)
  
  # bind the dummy variables data frames together and return the result
  result <- bind_cols(dummies_list)

  # if .keeps has supplied a vector, use it to determine which original
  # variables to keep in the resulting data frame
  if (!is.null(.keeps)) {
    for (i in 1:length(.keeps)) {
      if (.keeps[i] == F) {
        result <- result %>% select(-a_vector[i])
      }
    }
  }

  return(result)
}


create_multiple_dummies2(
  test2, c('sex', 'age', 'income'), .keep = T, .keeps = NULL
)
create_multiple_dummies2(
  test2, c('sex', 'age', 'income'), .keep = F, .keeps = NULL
)
create_multiple_dummies2(
  test2, c('sex', 'age', 'income'), .keeps = c(T, T, F)
)

############################# Question 4 (55 Points)  ##########################
df <- flights
glimpse(df)

# PART A 
df %>% dplyr::filter(month == 3)

# PART B 
df %>% 
  dplyr::filter(origin %in% c('JFK','LGA'), month %in% c(1, 2, 11, 12))

# PART C
df %>% select(-year)

# PART D
df %>% select(contains('_'), everything())

# PART E
df %>% select(dep_delay:tailnum)

# PART F
df %>% select_if(is.integer)

# PART G
df %>% select(starts_with('arr'), starts_with('dep'))

# PART H
df %>%
  mutate(total_delay = arr_delay + dep_delay) %>%
  select(dep_delay, arr_delay, total_delay, everything())

# PART I
df %>%
  select(where(is.character)) %>%
  mutate_all(as.factor)

# PART J 
df %>%
  mutate(
    distance_bins = if_else(
      distance < 1000, 'short',
      if_else(distance > 2000, 'long', 'medium')
    )
  ) %>% mutate(distance_bins = 
                 factor(distance_bins, 
                        levels = c('short', 'medium', 'long'))) %>% 
  select(distance, distance_bins, everything())

# PART K
df %>%
  mutate(date = as_date(time_hour)) %>%
  group_by(date) %>%
  summarise(daily_flights = n())

# PART L
df %>%
  group_by(month, origin) %>%
  summarise(avg_dep_delay = mean(dep_delay, na.rm = T))

# PART M
df %>% 
  mutate(
    season = case_when(
      month %in% c(12, 1, 2) ~ 'winter', 
      month %in% c(3, 4, 5) ~ 'spring',
      month %in% c(6, 7, 8) ~ 'summer',
      month %in% c(9, 10, 11) ~ 'fall',
      T ~ NA_character_ 
    )
  ) %>% 
  group_by(origin, season) %>% 
  summarize(
    avg_dep_delay = mean(dep_delay, na.rm = T), 
    med_dep_delay = median(dep_delay, na.rm = T))

# PART N
lpm_data = df %>% 
  mutate( 
    was_delayed = case_when(
      dep_delay > 0 & arr_delay > 0 ~ 1,
      is.na(arr_delay) & is.na(dep_delay) ~ NA_real_,
      T ~ 0
    ), 
    season = as.factor(
      case_when(
        month %in% c(12, 1, 2) ~ 'winter', 
        month %in% c(3, 4, 5) ~ 'spring',
        month %in% c(6, 7, 8) ~ 'summer',
        month %in% c(9, 10, 11) ~ 'fall',
        T ~ NA_character_ 
      )
    ), 
    origin = as.factor(origin), 
  ) %>% 
  select(arr_delay, dep_delay, was_delayed, origin, season, everything())

# PART O
lpm_data = lpm_data %>% 
  dplyr::filter(carrier %in% c("UA","B6","EV")) %>% 
  select(was_delayed, season, hour, origin, air_time, distance) %>% 
  drop_na()

lpm_data$origin <- relevel(lpm_data$origin, ref = "JFK")
lpm_data$season <- relevel(lpm_data$season, ref = "fall")

# run a linear probability model with robust standard errors. You didn't need
# to know this for the course but I am include it here to show you some of what
# your new found data cleaning skills can do for you in the end
model <- lm_robust(
  was_delayed ~ season + hour + origin + air_time + distance, 
  data = lpm_data, se_type = 'HC1'
)

# lets take a look at the model
tidy_model <- model %>% broom::tidy() %>% as_tibble()

knitr::kable(tidy_model)

# Let's make a nice looking graph of the results. You can learn more about
# how to do this in one of the data visualization courses
tidy_model %>%
  dplyr::filter(term != '(Intercept)') %>%
  mutate(
    term = str_remove(term, '^season'),
    term = str_remove(term, '^origin'),
    term = str_replace(term, '_', ' '),
    # regular expressions and stringr coming in handy here
    term = if_else(str_detect(term, '[EWRLGA]{3}'), term, str_to_title(term))
  ) %>%
  ggplot(aes(x = reorder(term, estimate), y = estimate)) +
  geom_point(size = 3) +
  geom_linerange(aes(ymin = conf.low, ymax = conf.high)) +
  geom_hline(yintercept = 0, color = 'red', linetype = 'dashed') +
  labs(
    title = 'Effect of Variables on Flight Delay',
    x = 'Independent Variable', y = 'Estimated Effect with Confidence Intervals'
  ) +
  theme_classic() +
  theme(
    axis.title.x = element_text(face = 'bold', margin = margin(t = 20, b = 10)),
    axis.title.y = element_text(face = 'bold', margin = margin(r = 20, l = 10)),
    plot.title = element_text(
      hjust = .5, margin = margin(t = 25, b = 15), face = 'bold'
    )
  ) + coord_flip()

# Looks like flights are delayed much more in summer, winter, and spring
# compared to the fall and that Newark has a much higher rate of delays compared
# to JFK airport.
