library(tidyverse)

# functions allow you to take a function and apply it over every item in a 
# list or vector
x = c(1, 2, 3, 4, 5)

square = function(item) {
 return(item * item) 
}

lapply(x, square)
sapply(x, square)

map(x, square) #always returns a list
map(x, function(item) item * item)
map(x, ~ . * .)

# we can specify the output type
map_dbl(x, square) #return must be numeric
map_int(x, square) #error, return is double not integer
map_int(x, ~ as.integer(square(.)))

map_chr(x, ~ as.character(square(.)))

map_lgl(x, square) #error
map_lgl(x, ~ square(.) %>% as.logical())

# the walk functions work the same way as map() except we only use them when
# we don't want to return something
print_names = function(name) {
  result = str_c('Hello ', name, '!', collapse = ' ')
  print(result)
}

names = c('Robert', 'Elizabeth', 'John')
walk(names, print_names)

# what if we want to map over 2 variables instead of 1
x = c(1, 2, 3, 4, 5)
y = c(6, 7, 8, 9, 10) #vectors need to be the same length

map2(x, y, ~ . + .) # won't work because tilde means take in one peice of data
map2(x, y, function(x, y) x + y) 

# map2 also works with underscore functions to specify type
map2_dbl(x, y, function(x, y) x + y) 

name = c('Robert', 'Elizabeth', 'John')
age = c(25, 63, 45)

name_age_function <- function(some_name, some_age) {
  result <- str_interp(
    '${some_name} is ${some_age} years old' #str_interp allows the use of ${} to add in
  )
  return(result)
}

map2_chr(name, age, name_age_function)

# what if we have more than two variables/arguments to pass to the function?
# we can use pmap for that

name = c('Robert', 'Elizabeth', 'John')
age = c(25, 63, 45)
occupation = c('Teacher', 'Doctor', 'Lawyer')

name_age_occ_function = function(some_name, some_age, some_occ) {
  result = str_interp(
    '${some_name} is ${some_age} years old and works as a ${some_occ}'
  )
  return(result)
}

pmap(list(name, age, occupation), name_age_occ_function)
pmap_chr(list(name, age, occupation), name_age_occ_function)

# we can use map inside of dplyr functions
my_tibble = tibble(
  name = c('Robert', 'Elizabeth', 'John'),
  age = c(25, 63, 45),
  occupation = c('Teacher', 'Doctor', 'Lawyer')
)

my_tibble %>% 
  mutate(description = map2_chr(name, age, function(x, y) paste(x, y)))

my_tibble %>% 
  mutate(description = pmap_chr(list(name, age, occupation), function(x, y, z) paste(x, y, z)))

# map functions work nicely for iterating over tibbles/dataframes
my_tibble

square_numbers = function(x) {
  if (!is.numeric(x)) {
    return(x)
  } else {
    return(x * x)
  }
}

my_tibble %>% map(square_numbers)

# but we want it as a tibble, two ways to accomplish this
my_tibble %>%  
  map_df(square_numbers)

my_tibble[] = my_tibble %>% map(square_numbers) # to actually get this to hold
my_tibble

# look up safely() and possibly() in purr for more info
