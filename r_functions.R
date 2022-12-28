# Step 1 - Build or create the function
# Step 2 - Call the function

# creating variables that are some number * 2
number_10 <- 5 * 2
number_15 <- 7.5 * 2
number_20 <- 10 * 2
number_30 <- 15 * 2 
number_40 <- 20 * 2 
number_50 <- 25 * 2 

# DRY - don't repeat yourself
# a functions takes in an input, does something, and returns an output

multiply_by_2 <- function(any_number) { 
    result <- any_number * 2
    return(result)
  }

# The above is the building process
# below is how to actually run the function

multiply_by_2(10)
multiply_by_2(7.5)
multiply_by_2(123020)

# Functions can have no inputs (or "parameters") one, or many
# create a function that multiplies two numbers

multiply_two_numbers <- function(number_1, number_2) { #number_1 and number_2 are parameters
  result <- number_1 * number_2
  return(result)
}

multiply_two_numbers(5,7) # 5 and 7 are arguments

## Function scope - everything lives in an environment
# global scope is separate from the function scope - R will always look inside
# of the function first, and then to the global scope if necessary for variables
# functions create their own environment that R looks in first when running the
# function
# also, what happens inside of a function stays inside of the function,
# and doesn't impact the global scope

## Function parameters
# can call them whatever you want, as long as you call them correctly within
# the functino
# Function arguments are inputs for the parameters when they are being called

## Default Parameters - if the user doesn't put in a second number, the function
# below will assume that it should be 2
# if you do supply two numbers, it will take the numbers you supply

multiply_2_numbers <- function(num1, num2 = 2) {
  result <- num1 * num2
  return(result)
}

multiply_2_numbers(6, 5)
multiply_2_numbers(6)

# Chaining Functions - combining multiple functions together
# R will always run inner functions first, and then work its way out

multiply_by_2(multiply_two_numbers(5, multiply_2_numbers(7, 6)))
