library(tidyverse)
library(lubridate)
library(nycflights13)
library(estimatr)


############################# Question 1 (XX Points)  ##########################

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


df = test
a_factor = 'sex'

  # if the df is not a data.frame or tibble, then throw an error
  if (!is.data.frame(df) && !is.tibble(df)) {
    stop("'df' must be a data.frame or tibble.")
  }
  
  # make a copy of the data call it 'new_df'
  new_df <- df
  
  # select out only the factor variable we want to make dummies for and name
  # it 'my_factor', the result should be a tibble with a single variable 
  # called 'my_factor'
  
  my_factor <- as.factor(new_df[[a_factor]])
  
  
  # if this 'my_factor' variable is not a factor then throw an error
  if (!is.factor(my_factor)) {
    stop("'a_factor' must be a factor variable.")
  }
  
  # grab the levels of the 'my_factor' variable and store them in a variable
  # called 'factor_levels'. this variable will NOT be inside 'new_df' it will
  # just be a normal variable on its own
  factor_levels <- levels(my_factor)
  
  for (i in 1:length(factor_levels)) {
    # for each level of 'factor_levels', test if that level is equal to
    # each element in 'my_factor'
    level_dummy <- my_factor == factor_levels[i]
    
    # convert the level name to a valid R variable name
    level_name <- make.names(factor_levels[i])
    
    # convert that logical vector to an integer and append it to the 'new_df'
    new_df[[paste0(level_name, "_dummy")]] <- as.numeric(level_dummy)
    
  }
  
  if (.keep == TRUE) {
    # If the use specifies .keep to be true then do the following
    new_df <- new_df %>%
      # bring over the original factor variable into 'new_df'
      bind_cols(my_factor) %>%
      # Make this variable the first variable in dataset
      select(a_factor, everything()) %>%
      # change its name so that it has the same name as the variable in the
      # original df
      rename(!!a_factor := a_factor) %>%
      # we are done, return this new_df
      return()
  }