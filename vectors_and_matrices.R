################################################################################
# # VECTORS
################################################################################

# c() is a function that creates a vector
ages = c(25, 32, 54)

# in vectors, the order is always maintained, so order matters
# any operation done on the vector will be applied to each element

ages/2

# vectors are always flat, so you can't next vectors within vectors
new_ages = c(25, 32, 54, c(1, 2))
new_ages
new_ages2 = c(25, 32, 54, 1, 2)
new_ages2
# the above gives you the same thing

integer_vector = c(1L, 2L, 3L)
#  capital L indicates that R makes sure it is an integer, but isn't necessary
one_through_one_hundred = c(1:100)

# use the sequence function to create a sequence
one_through_thousand = seq(1,1000, 1)
# help documentation for seq()
?seq

# double (numeric) type
numeric_vector = c(3.3, 2.2, 9.7)

numeric_vector * integer_vector

#  string vectors are their own type, and need to be worked with differently
string_vector = c('hello', 'class')

# boolean (logical) vectors - true or false
boolean_vector = c(TRUE, FALSE)

# find the type of vector
typeof(boolean_vector)
typeof(numeric_vector)
typeof(string_vector)

# check if the vector is a certain type
is.integer(integer_vector)
is.integer(string_vector)

is.numeric(numeric_vector)

is.character(string_vector)

is.logical(boolean_vector)

# vectors can only contain one type, no mixing and matching!
# we can convert types with "as"
as.integer(c(1.2, 2.3, 4.5))
test = as.numeric(c(3, 4, 5, 6))
typeof(test)

# Missing values - NA
missing_vector = c(1, 2, NA)


################################################################################
# # FACTORS - variables with no inherent numerical values
################################################################################

# create a factor using strings
sex = c('Male', 'Female', 'Female', 'Female', 'Male')
sex = factor(sex, levels = c('Female', 'Male'), labels = c('Female', 'Male'))
typeof(sex)

# create a factor using integers
sex = c(2, 1, 1, 1, 2)
sex = factor(sex, levels = c(1, 2), labels = c('Female', 'Male'))

#  use class() instead of typeof() to see if something is a factor
typeof(sex)
class(sex)
# you can basically just use class() for everything


################################################################################
# # INDEXING AND SUBSETTING
################################################################################

students = c('victor', 'robert', 'jessica', 'cindy', 'michael', 'elizabeth')

#  get only a certain element of a vector
students[1]

# you can always check out the length
length(students)
last_index = length(students)
students[last_index]

# get multiple elements out of a vector
students[c(1,3)]
students[1:3]

# change the value of an element in a vector
students[1] = 'john' #replace victor with john
students

# change the value of multiple elements in a vector
students[2:4] = c('tim', 'jim', 'sarah')
students

# using negative indexing
students[-c(1,3)]

# using logical subsetting
logical_vector = c(TRUE, FALSE, FALSE, TRUE, TRUE, TRUE)

students[logical_vector]

# another example
values = c(1, 10, 20)
items_i_want = values < 15



################################################################################
# # MATRICES
################################################################################

# creating matrices - can't mix and match data types!
my_matrix = matrix(c(1, 2, 3, 4, 5, 6), nrow = 3)

# indexing matrices single brackets - first number is row, second number is column
my_matrix[3, 2]
my_matrix[6]

# you can also specific multiple rows and columns
my_matrix[c(1,3), 2]

my_matrix[c(1,3), c(1,2)]







