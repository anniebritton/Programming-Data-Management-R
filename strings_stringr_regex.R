################################### Strings ####################################
library(tidyverse)

astring <- "This is a string"
length(astring) #gives length of vector
str_length(astring) #gives length of string

"The president's approval rating is low."
# for the above, you need to use "" on the outside because of the apostrophe

# Escaping - tell R to use the literal character using \
"this is a quote mark (\")"

# combine strings
paste('Hello', 'my name is', 'Annie') # puts in white space for you
paste0('Hello', 'my name is', 'Annie') # does not put in white space for you

########################## stringr Package Functions ###########################

# every stringr function starts with str_, and string is always the first arg

my_string = "welcome to stringr!"

str_length(my_string)

str_to_upper(my_string)

str_to_lower(my_string)

str_to_title(my_string)

# stringr functions work on vectors
my_string_vector = c('hello world', 'my name is Annie')
str_to_title(my_string_vector)

# extract something from the text
welc = str_extract(my_string, "welc")
welc

some_string = 'hello, my, name, is, Annie'
str_extract(some_string, ',') # returns a vector of just one item
str_extract_all(some_string, ',') # returns a list of all items - can always use unlist()

# remove elements from the string
str_remove(some_string, ',')
str_remove_all(some_string, ',')

# these function aren't really changing the original object
# so, you need to assign to a new variable

# detect a pattern in a string
some_string = 'hello, my, name, is, Annie'

str_detect(some_string, "Annie")
str_detect(some_string, "annie")
str_detect(some_string, "Robert")

str_detect(my_string_vector, "world") # gives a true/false value for each string

# detect and subset strings with a pattern
str_subset(my_string_vector, 'world') # gives back the strings that are TRUE

# count the number of occurences in a string
some_string = 'hello, my, name, is, Annie'
hello_world = 'Hello, world!'
str_count(c(some_string, hello_world), ',')

# split a string by a pattern (and optionally unlist)
some_string = 'hello, my, name, is, Annie'
str_split(some_string, ',')
str_split(some_string, 'm')

unlist(str_split(some_string, ','))

# stripping white space
x = "               my name is annie  "
str_trim(x, 'left')
str_trim(x, 'right')
str_trim(x, 'both')

# replace something in a string
str_replace(x, 'annie', "Annie" )

str_replace(some_string, ',', "-----" )
str_replace_all(some_string, ',', "-----" )

############################## Refactoring and Pipes ###########################

# see video 6.4 for details on this section

shopping_list <- paste0(
  '    steak, steak sauce, salt, pepepr, water, mashed potatoes, string beans,',
  'icecream, lettuce, tomatoes         '
)

# we can use pipes to manipulate strings more effectively
new_shopping_list <- str_trim(shopping_list, 'both') %>%
  str_to_upper(.) # you can add the data as a . or not

# you can chain together pipes
# remember , pipes always pass the innermost function out
new_shopping_list <- str_trim(shopping_list, 'both') %>%
  str_to_upper(.) %>%
  str_split(., ',') %>%
  unlist(.) %>%
  str_trim(., 'left') %>%
  str_to_title(.)

########################### Regular Expressions (RegEx) ########################

# a RegEx is a pattern that exists in a string that you might want to locate

contacts = "Annie - phone: 410-818-7152
Kyle - phone: 847-899-2690
Mom - phone: 410-818-9939
Dad - phone: 443-677-9614
Trevor - phone: 410-818-99345"

cat(contacts)

# extracting the phone numbers - they follow the same pattern
  # ddd-ddd-dddd

pattern = '\\d\\d\\d-\\d\\d\\d-\\d\\d\\d\\d'
str_extract_all(contacts, pattern) %>% unlist(.)

# but the above picks up Trevor's phone number which is wrong and we don't want
# find something that isn't a number
pattern = '\\d\\d\\d-\\d\\d\\d-\\d\\d\\d\\d\\D' # uppercase D requests not a number
str_extract_all(contacts, pattern) %>% unlist(.)

# find multiple numbers using {}
pattern = '\\d{3}-\\d{3}-\\d{4}' 
str_extract_all(contacts, pattern) %>% unlist(.)

# find between a range of numbers
pattern = '\\d{3}-\\d{3}-\\d{4,5}' #no spaces
str_extract_all(contacts, pattern) %>% unlist(.)

# find word characters (letters, numbers, _)
pattern = '\\w{3,7}'
str_extract(contacts, pattern)

# not a word character
pattern = '\\W'
str_extract(contacts, pattern)

# white space
pattern = '\\s'
str_extract(contacts, pattern)

# not white space
string = '     Hello'
pattern = '\\S'
str_extract(string, pattern)

# lowercase letters
string = 'Hello'
pattern = '[[:lower:]]{1,}'
str_extract(string, pattern)

# uppercase letters
string = 'heLlo'
pattern = '[[:upper:]]{1,}'
str_extract(string, pattern)

# any letter in the alphabet
string = "Annie Britton - phone: 410-818-7152"
pattern = '[[:alpha:]]{1,}\\s[[:alpha:]]{1,}'
str_extract(string, pattern)

# any punctuation
string = "Annie!! - #410-818-7152"
pattern = '[[:punct:]]{1,}'
str_extract(string, pattern)

############### RegEx quantifiers and other special symbols ####################

# the anything character (.) and the '0 or more times' character (*)
string = "today's date is 10/11/2022 and it is 4pm"
pattern = '\\d.*22'
str_extract(string, pattern)

# the one or more times symbol (+)
string = 'James Bond is 007'
pattern = '\\d+'
str_extract(string, pattern)

# the optional character (?)
string = "the president's approval rating is low"
string_2 = "the presidents approval rating is low"
pattern = "president'?s" # saying that the (') is optional
str_extract(string, pattern)
str_extract(string_2, pattern)

# the start of a string (^)
string = "Annie is my name"
string_2 = "my name is Annie"
pattern = "^Annie"
str_extract(string_2, pattern)

# end of a string ($)
string = "Annie is my name"
string_2 = "my name is Annie"
pattern = "Annie$"
str_extract(string, pattern)
str_extract(string_2, pattern)

# using brackets
string = "My SSN is 123457890"
string_2 = "My SSN is 123-45-7890"
pattern = "[0-9-]+"
str_extract(string, pattern)
str_extract(string_2, pattern)

# escaping special characters
string = "use the carat symbol (^) for exponents in R"
pattern = '\\S^\\S' #this won't work because it is taking the special meaning of ^
pattern_2 = '\\S\\^\\S' #add in \\ before
str_extract(string, pattern)
str_extract(string, pattern_2)
