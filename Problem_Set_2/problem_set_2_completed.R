library(readr)
library(tidyverse)
library(tibble)

############################# Load in the data (5pts) ##########################

text <- read_file("~/Documents/R_Programming/Assignment_Scripts/Problem_Set_2/msnbc_text.TXT")

################ Split the string on the common pattern (10pts) ################

doc_pattern <- '\\d{1,3}\\s[[:alpha:]]{2}\\s\\d{3}\\s[[:alpha:]]{9}'
# str_view(text, doc_pattern) #check

text <- unlist(str_split(text, doc_pattern))
length(text) == 132 #check

text <- str_trim(text[2:132], 'both')
length(text) == 131 #check

############################ Extract the dates (15pts) #########################
date_pattern <- '[[:alpha:]]{4,9}\\s\\d{1,2},\\s\\d{4}'
# str_view(text, date_pattern) #check

date <- str_extract(text, date_pattern) %>%
  as.Date(., format = "%B %d, %Y")

length(date) == 131 #check

############################ Extract the shows (15pts) #########################
show_pattern <- '[[:alpha:]]{4}:\\D+'
# str_view(text, show_pattern) #check

show <- str_extract(text, show_pattern) %>%
  str_extract(., '\\s\\D+') %>%
  str_trim(., 'both') %>%
  str_to_title(.)

show #check
length(show) == 131 #check

########################## Extract the length (15pts) ##########################
length_pattern <- '[[:alpha:]]{6}:\\s\\d+'
# str_view(text, length_pattern) #check

length <- str_extract(text, length_pattern) %>%
  str_extract(., '\\d+') %>%
  str_trim(., 'left') %>%
  as.numeric(.)


length #check
is.numeric(length) #check
length(length) == 131 #check
########################## Replace whitespace (10pts) ##########################
text <- str_replace_all(text, '\\s+', " ")

text[1] #check
length(text) == 131 #check
##################### Create a tibble with the data (5pts) #####################
df <- tibble(date, show, length, text)
df

####################### Convert strings to factors (25pts) #####################
show <- as.factor(df$show) %>%
  fct_collapse(., 
            Up = "Up With Steve Kornacki",
            Other = c("Melissa Harris-Perry", 
                      "Politics Nation",
                      "All In With Chris Hayes",
                      "The Rachel Maddow Show",
                      "The Last Word With Lawrence O`Donnell",
                      "Msnbc Special")) 

is.factor(show) #check

final_df <- tibble(date, show, length, text)
final_df
