# Practice Exercise 3 focuses on filter(), arrange() and select().
# There is a data set called "data_gutenberg100_author.csv" that contains
# the author grouped data (i.e., what the data should look like at the end of
# Exercise 2). Read that data into R. 
#
# 1. Create a new tibble called "author_rank" that has one row per author
#    but only those authors whose total downloads (across all books) 
#    exceeded 1000. Arrange the tibble so that the authors appear in 
#    descending order of total downloads.
#
# 2. Take the author_rank data, and try these two commands: 
#
#      author_rank %>% select(author)
#      author_rank %>% pull(author)
#
#    Look at the output. In what ways are the outputs the same, and in
#    what ways are they different? 

library(tidyverse)

author_rank <- read_csv("data_gutenberg100_author.csv")  %>% 
  filter(n_downloads >= 1000) %>% 
  arrange(desc(n_downloads))

author_tibble <- author_rank %>% select(author)  # a 15x1 tibble
author_vector <- author_rank %>% pull(author)    # a length 15 vector
