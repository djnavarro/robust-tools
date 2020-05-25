# The final practice exercises has three parts: 
#
# 1. Create a tibble called "star_table" that contains one row per author
#    and has only two variables: "author" is the name of the author, and
#    "star" is TRUE if that author has more than one book in the top 100,
#    FALSE otherwise.
#
# 2. Join the "star_table" data with the "gutenberg_clean" data so that 
#    for every book the "star" variable indicates whether that book was
#    written by one of the star authors (i.e., those with multiple books
#    in the top 100)
#
# 3. Take the output from step #2, remove all books written by non-star
#    authors, remove all variables except the book title and the author
#    name, and sort data by the name of the author

library(tidyverse)


# authors with more than one book in the top 100 --------------------------

star_table <- read_csv("data_gutenberg100_author.csv") %>% 
  mutate(star = n_books > 1) %>% 
  select(author, star)


# make a copy of the original data with star status added -----------------

all_stars <- read_csv("data_gutenberg100_clean.csv") %>% 
  left_join(star_table, by = "author")



# top 100 books that were written by a star author ------------------------

only_stars <- all_stars %>% 
  filter(star == TRUE) %>% 
  select(title, author) %>% 
  arrange(author)


