############################# Relational Operators #############################

# Equality operator ( == )
5 == 5

# Not equal ( !=, ! + = )
5 != 6

# Greater and less than ( < > )
5 < 6

# Greater/less than / equal to ( <= >= )
5 <= 5

# These work on all values within a vector
x = c(1, 2, 3, 4, 5)
x < 4
x == 5

y = c(1, 2, 3, 4, 5)

x == y

# identical function
identical(x, y)

# all and any
all(y < 6)
any(y > 3)

############################### Logical Operators ##############################

# And operator (&)
5 == 5 & 4 == 4

# Or operator (|)
5 == 6 | 4 == 4

# Not operator (!)
!(5 == 6 | 4 == 4)


################################# Control Flow #################################

some_calc = function(x) {
  if (x < 0) {
    stop('Cannot use a negative number with this fuction!')
  } else if (x == 0) {
    stop('Cannot divide by 0.')
  } else if (!is.numeric(x)) {
    stop('This function only takes numbers.')
  } else {
    result = sqrt(x) / x
    return(result)
  }
}

some_calc('hello')


################################## For Loops ###################################

for (number in 1:5) {
  print(number)
}

our_mean_function = function(x) {
  if (!(is.numeric(x) & is.atomic(x))) {
    stop('The input should be a numeric vector.')
  }
  total = 0
  for (number in x) {
    total = total + number
  }
  
  return(total / length(x))
}

mean(1:5)
our_mean_function(1:5)


################################# While Loops ##################################

x = 0

while (x < 10) {
  print(x)
  x = x + 1
}


################################ Break & Next ##################################

x = 0

while (TRUE) {
  if (x >= 10) {
    break
  }
  print(x)
  x = x + 1
}


x = sample(1:100, 50, T)

for (i in x) {
  if (i %% 2 == 0) {
    print (i)
  } else {
    next
  }
}


############################### Error Handling #################################

x <- list(1, 2, '3', 4, '5', 6, 7)
x * 2

result <- c()

for (i in x) {
  result <- c(result, i * 2)
}



x <- list(1, 2, '3', 4, '5', 6, 7)
result <- c()

for (item in x) {
  tryCatch(
    result <- c(result, item * 2),
    error = function(e) {
      result <- c(result, as.numeric(item) * 2)
    }
  )
}





















