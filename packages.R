# packages in R

install.packages('tibble')
library(tibble)

my_tibble = tibble(
  name = c('robert', 'john', 'cynthia'),
  age = c(35L, 54L, 19L),
  income = c(10.25, 30.00, 18.50),
  gender = c('male', 'male', 'female')
)
