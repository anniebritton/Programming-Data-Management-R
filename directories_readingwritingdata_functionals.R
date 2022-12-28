############################ working directories ###############################


# set current working directory
setwd("C:/Users/annie/Documents/R_Programming/Week_9_Scripts")

# figure out what the current working directory is
# getwd()

# list files in the working directory
# list.files()

########################### reading and writing data ###########################
library(tidyverse)


# the 'here' package
library(here)

here()
here() %>% setwd(.)
getwd()

library(lubridate) #there is a here() function in lubridate, so be careful!
here() 

here::here() # this is how you say you want a function from a certain package, 
# ie here, from the here package

# writing functions to disk
mtcars
df = mtcars %>% as_tibble()
df

# write to csv
readr::write_csv(df, "mtcars_data.csv")

# write to excel
install.packages("writexl")
library(writexl)
write_xlsx(df, "mtcars_data.xlsx")

# write to stata and spss
library(haven)
write_sav()
write_dta()

# write to .rds
write_rds()

# read in all of this data with...
read_csv()
read_excel()
read_sav()
read_dta()
read_rds()


############################## important functions #############################

# I'm only writing down the ones I don't know off the top of my head :)

x = c(1, 2, 3, 4, 5)
x_na = c(1, 2, NA, 3, 4, 5)

mean(x_na, na.rm = T)

rev(x) # reverses the order
seq(from = 1, to = 10, by = 0.5) #generate a sequence

x = c(5, 4, 2, 3, 1)
sort(x)

round()
sample()

rnorm(100, 0, 1)


################################## functionals #################################

# functionals take a vector/list as one arg and another function as the other arg

my_vector = c(
  "Hello", "I'm Annie", "Welcome to class"
)

str_to_upper(my_vector)


my_function = function(x) {
  if (str_length(x) <= 10) {
    return (str_to_lower(x))
  } else {
    return(str_to_upper(x))
  }
}

# this won't work the way we want
my_function(my_vector)

# we can write a loop
my_new_vector = c()
for (i in 1:length(my_vector)) {
  my_new_vector = c(my_new_vector, my_function(my_vector[i]))
}

my_new_vector

# an even better solution is to use a function, then we don't have to set up a 
# new variable and don't have to use a loop in R, which is inefficient

sapply(my_vector, my_function, USE.NAMES = F) # displays the output as a vector
lapply(my_vector, my_function) # displays the output as a list 













