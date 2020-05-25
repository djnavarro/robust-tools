# Exercise 05 from "dplyr, or a dance with data"
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
  select(cue, response, strength, id) %>%
  mutate(
    rank = rank(-strength),  # rank the data by strength
    type = "forward",        # this is forward associate (i.e., it's woman_FWD)
    word = "woman",          # the word is "woman" (i.e., it's WOMAN_fwd)
    associate = response     # for forward associations, the RESPONSE is the asociate
  )

woman_bck <- swow %>%
  filter(response == "woman", n_response > 1)  %>%
  arrange(desc(strength)) %>%
  select(cue, response, strength, id) %>%
  mutate(
    rank = rank(-strength),  # rank the data by strength
    type = "backward",       # this is backward associate (i.e., it's woman_BCK)
    word = "woman",          # the word is "woman" (i.e., it's WOMAN_bck)
    associate = cue          # for backward associations, the CUE is the associate
  )


man_fwd <- swow %>%
  filter(cue == "man", n_response > 1)  %>%
  select(-n_response, -n_total)  # ... the minus sign means "remove"-

man_bck <- swow %>%
  filter(response == "man", n_response > 1) %>%
  arrange(desc(strength)) %>%
  select(-starts_with("n_"))  # ... remove variables starting with "n_"


# YOUR TURN...
#
# I have added the mutate() code required to create the new variables we need
# but only for the "woman_fwd" and "woman_bck" variables. Your task is to add
# the corrresponding mutate() commands to the "man_fwd" and "man_bck" pipelines