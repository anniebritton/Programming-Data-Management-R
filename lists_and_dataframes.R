
# limitations of vectors: they are flat, and don't nest
my_vector = c(5,6,7, c(6,7,8))
my_vector

# limitations of vectors: they can only contain one type
my_vector2 = c(5L, 5.6, 'hello', TRUE)
my_vector2

# That's where LISTS come in!
my_list = list(5, 6, 7, c(8, 9, 10))
my_list

length(my_list)

#  you can also nest lists inside of lists
my_list2 = list(5, 6, 7, list(8, 9, 10))
my_list2

length(my_list2)

# Lists can also contain more than one type
my_list3 = list(5L, 5.6, 'hello', TRUE)
my_list3

length(my_list3)

# Benefits of lists over vectors: can next, and organize data better than vectors
shopping_list = list(
  dairy_products = c('Milk', 'butter', 'eggs'),
  snacks = c('potato chips', 'candy bar')
)

length(shopping_list)

# how do we subset lists?
# index with single brackets, you get the list
shopping_list[1]
class(shopping_list[1])

# to just get the inner vector, index with double brackets
shopping_list[[1]]
class(shopping_list[[1]])

# you can also subset with names
shopping_list['snacks'] #using brackets returns a list
shopping_list$snacks #using the $ returns a vector when possible

# multiple subsetting
shopping_list = list(
  my_list = list(
    dairy_products = list('Milk', 'butter', 'eggs'),
    snacks = list('potato chips', 'candy bar')
  ),
  friend_list = list(
    dairy = list('skim milk', 'low fat butter', 'cottage cheese'),
    snacks = list('apples', 'oranges')
  )
)

shopping_list[[2]][[1]]
shopping_list[[2]][[1]][[3]]

# the above gets kind of annoying, so here is a solution
shopping_list$friend_list$dairy[[3]]

# you can also assign a variable
item = shopping_list[[2]]
item = item$dairy
item = item[[3]]
item


# list functions
# test if item is a list
is.list(shopping_list)

# can convert vector to list
my_vector
as.list(my_vector)
list(my_vector)

# can also convert a list to a vector
my_new_list = as.list(my_vector)
unlist(my_new_list)



# DATAFRAMES
# in dataframes, you can store rows and columns of diffferent types of data

shopping_list = list(
  dairy_products = c('Milk', 'butter', 'eggs'),
  snacks = c('potato chips', 'candy bar', 'popcorn')
)

# instead of this, we can store it in a dataframe
shopping_df = data.frame(
  dairy_products = c('milk', 'butter', 'eggs'),
  snacks = c('potato chips', 'candy bar', 'popcorn')
)

# need to make sure that each column as the same number of elements
# otherwise, error
shopping_df = data.frame(
  dairy_products = c('milk', 'butter', 'eggs'),
  snacks = c('potato chips', 'candy bar')
)

# you can add in other columns
shopping_df = data.frame(
  dairy_products = c('milk', 'butter', 'eggs'),
  snacks = c('potato chips', 'candy bar', 'popcorn'),
  price = c(2.99, 4.56, 8.79)
  stringsAsFactors = FALSE
)

class(shopping_df)

# under the hood, a dataframe is just a special list
is.list(shopping_df)

df = data.frame(
  name = c('robert', 'john', 'cynthia'),
  age = c(35L, 54L, 19L),
  income = c(10.25, 30.00, 18.50),
  gender = c('male', 'male', 'female'),
  stringsAsFactors = FALSE
)

# get columns
df$name
df$age

df[['name']]
df[['age']]

# get rows or specific colunms and rows
df[c(1,2), ]
df[c(1,2), c(1,2,3)]

# important data frame functions
dim(df) #shows the dimensions of the frame
nrow(df) #shows number of rows
ncol(df) #shows number of columns
length(df) #shows number of columns
colnames(df) #shows column names in order

# to change column names, do the following:
colnames(df) = c("Names", "Ages", "Incomes", "Sex")
df

