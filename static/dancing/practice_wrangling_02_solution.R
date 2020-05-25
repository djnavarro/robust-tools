# Practice Exercise 2 is about group_by(), summarise(), and ungroup(). 
# There is a data set called "data_gutenberg100_clean.csv" that contains
# the cleaned data (i.e., what the data should look like at the end of
# Exercise 1). Read that data into R. 
#
# Use group_by() and summarise() to create a new tibble called 
# "gutenberg_by_author" that contains one row for each author in the 
# data set. For each author it should contain their name (i.e., the 
# "author" column) and two new columns that summarise their contribution to
# the top 100: 
#
# - the "n_books" variable should count the number of books that author 
#   has in the top 100.
#
# - the "n_downloads" variable should calculate the sum() of all downloads
#   of books by that author, calculated across all books they have in the
#   top 100
#
# For the sake of neatness, remember to ungroup() at the end.

library(tidyverse)

gutenberg <- read_csv("data_gutenberg100_clean.csv") 

gutenberg_by_author <- gutenberg %>% 
  group_by(author) %>% 
  summarise(
    n_downloads = sum(downloads),
    n_books = n()
  ) %>% 
  ungroup()

