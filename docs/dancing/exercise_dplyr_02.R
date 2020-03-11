# Exercise 02 from "dplyr, or a dance with data"
#
# Author: Danielle Navarro (d.navarro@unsw.edu.au)
# Date: 11 March 2020


# preliminaries -----------------------------------------------------------

# load packages
library(tidyverse)

# import the data... notice this is all one "pipeline
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

# YOUR TURN...

# The backwards associates to the word "woman" correspond to the rows of
# swow where the *response* is "woman", rather than when the *cue* is 
# "woman". 
#
# Create a new variable woman_bck that contains the backwards associates.
# Make sure to filter it so that we only include cases where "woman" 
# appeared as the response word more than once.

