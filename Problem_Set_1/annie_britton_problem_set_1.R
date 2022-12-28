################################################################################
########################### Challenge #1 (10 points) ###########################
################################################################################

############################## Part I (5 points) ###############################
# write a function called hello_world
hello_world <- function(){
  print("Hello, World!")
}

# print 'Hello, World!' to the console
hello_world()


############################# Part II (5 points) ###############################
# write a function called greeting 
greeting <- function(name) {
  paste("Hello, ", name, "!",  sep = "") 
  #using sep = "" argument  removes the space the passed name and the '!'
}

# pass through an argument
greeting("Annie")


################################################################################
########################### Challenge #2 (15 points) ###########################
################################################################################
# create function to calculate the probability of observing 
# some value within a normal distribution
prob_of_normal_dist <- function(x, mu = 0, sigma = 1) {
  piece_1 <- 1 / (sigma * sqrt(2 * pi))
  piece_2 <- -(x - mu) ^ 2
  piece_3 <- 2 * sigma ^ 2
  result <- piece_1 * exp(piece_2/ piece_3)
  result
}

# check to ensure that probabilities match using dnorm()
prob_of_normal_dist(1) 
dnorm(1) 


################################################################################
########################### Challenge #3 (20 points) ###########################
################################################################################
# write a function called unique_nona() which takes in a vector and returns the 
# unique values of the vector without any NA values
unique_nona <- function(vector) {
  vector <- vector[!is.na(vector)]
  unique_values <- unique(vector)
  unique_values
}

# pass through a vector and return unique values without NA
unique_nona(c(1, 1, 2, 2, NA, 7, NA, 7))


################################################################################
########################### Challenge # 4 (30 points) ##########################
################################################################################

############################## Part I (15 points) ##############################
# write a function called append_to_vector
append_to_vector <- function(original_vector, addition) {
  new_vector <- c(original_vector, addition)
  new_vector
}

# call the function to test it
original_vector <- c(1, 2, 3)
append_to_vector(original_vector, 4)


############################# Part II (15 points) ##############################
# write a function called append_to_list
append_to_list <- function(original_list, addition) {
  original_list[length(original_list) + 1] <- list(addition)
  new_list <- original_list
  new_list
}

# define original list
original_list <- list(1, 2, 3)

# call the function to test it
append_to_list(original_list, 4)
append_to_list(original_list, matrix(c(1,2,3,4), nrow = 2))


################################################################################
########################### Challenge # 5 (15 points) ##########################
################################################################################

# create my_vector
my_vector <- sample(1:100, 2065, T)

# write code to find the length of my_vector
length(my_vector)

# what is the value of the 1000th element of my_vector
my_vector[1000]

# create a new vector called my_new_vector which is the 100th though 200th 
# elements of my_vector, use the : to do this subsetting
my_new_vector <- my_vector[100:200]

## find the number of NA values in my_vector 
# determine what values are NA
my_vector_na <- is.na(my_vector)

# convert boolean to integer
my_vector_na <- as.integer(my_vector_na)

# sum the integer vector, with 0 indicating that there are no NA values
number_of_nas <- sum(my_vector_na)

# there are 0 NA values in my_vector
number_of_nas


################################################################################
########################### Challenge #6 (10 points) ###########################
################################################################################

# write code to install the tibble package
install.packages('tibble')

# write code to load the tibble package into your R session
library(tibble)

# load the mtcars dataset into R with this code data("mtcars") 
# and then print the mtcars dataset
data("mtcars")
print(mtcars)

# convert mtcars to a tibble with as_tibble() and save it in a new 
# binding called df
df <- as_tibble(mtcars)

# subset df where we only want rows 6-10 and the columns 'mpg', 'hp', and 'gear'
df[c(6:10), c('mpg', 'hp', 'gear')]


