# Exercise 04 from "dplyr, or a dance with data"
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



# words associated with "man" and "woman" ---------------------------------

woman_fwd <- swow %>%
  filter(cue == "woman", n_response > 1) %>%
  select(cue, response, strength, id)

woman_bck <- swow %>%
  filter(response == "woman", n_response > 1) %>%
  arrange(desc(strength))

man_fwd <- swow %>%
  filter(cue == "man", n_response > 1) 

man_bck <- swow %>%
  filter(response == "man", n_response > 1) %>%
  arrange(desc(strength))

# YOUR TURN...
#
# Notice that for the "woman_fwd" variable I have used select() to
# keep four columns (i.e., cue, response, strength, id), which has
# caused the other two columns (i.e., n_response, n_total) to 
# disappear.
#
# Your task is to do the same thing for the other three variables,
# "woman_bck", "man_fwd" and "man_bck". Can you think of any way
# to do this other than the "select(cue, response, strength, id)"
# code that I've used on line 28?





