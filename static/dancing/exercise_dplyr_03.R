# Exercise 03 from "dplyr, or a dance with data"
#
# Author: Danielle Navarro (d.navarro@unsw.edu.au)
# Date: 11 March 2020


# preliminaries -----------------------------------------------------------

# load packages
library(tidyverse)

# import data
swow <- "data_swow.csv.zip" %>%
  read_tsv() %>%           # read the data from file
  mutate(id = 1:n()) %>%   # add the "id" column
  rename(
    n_response = R1,       # nicer name for the response count
    n_total = N,           # nicer name for the total cue presentations
    strength = R1.Strength # nicer name for the estimated response strength  
  )


# words associated with "woman" -------------------------------------------

# forward associates to the word "woman"
woman_fwd <- swow %>%
  filter(cue == "woman", n_response > 1) 

# backwards associates to the word "woman", 
# arranged in descending order of strength
woman_bck <- swow %>%
  filter(response == "woman", n_response > 1) %>%
  arrange(desc(strength))



# words associated with "man" ---------------------------------------------

# YOUR TURN...
# 
# repeat the exercise above for the word "man", creating two new variables 
# "man_fwd" and "man_bck". Make sure to use arrange() to make sure the rows 
# are sorted in order of decreasing strength


