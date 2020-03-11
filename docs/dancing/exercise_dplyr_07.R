# Exercise 06 from "dplyr, or a dance with data"
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
  select(-n_response, -n_total)   %>%
  mutate(
    rank = rank(-strength),  # rank of the association
    type = "forward",        # direction of the association
    word = "man",            # word being "associated to"
    associate = response     # word that is the "associate of"
  )

man_bck <- swow %>%
  filter(response == "man", n_response > 1) %>%
  arrange(desc(strength)) %>%
  select(-starts_with("n_")) %>% # ... remove variables starting with "n_"
  mutate(
    rank = rank(-strength),  # rank of the association
    type = "backward",       # direction of the association
    word = "man",            # word being "associated to"
    associate = cue          # word that is the "associate of"
  )



# combine the data sets ---------------------------------------------------

gender <- bind_rows(woman_fwd, woman_bck, 
                    man_fwd, man_bck) %>%
  select(id:associate) %>%
  filter(associate != "man", associate != "woman")



# create and plot gender_fwd ----------------------------------------------

gender_fwd <- gender %>% 
  filter(
    type == "forward"
  ) %>% 
  pivot_wider(
    id_cols = associate, 
    names_from = word, 
    values_from = rank
  ) %>%
  mutate(
    woman = replace_na(1/woman, 0),
    man = replace_na(1/man, 0), 
    diff = woman - man
  )  %>%  
  arrange(diff) 


picture_fwd <- ggplot(
  data = gender_fwd,
  mapping = aes(
    x = associate %>% reorder(diff), 
    y = diff
  )) + 
  geom_col() + 
  coord_flip()

plot(picture_fwd)



# create and plot gender_bck ----------------------------------------------


# YOUR TURN...
#
# 1. The previous section contains all the code that I used in the slides
#    to draw the plot of gender_fwd. Source this script to check that it 
#    works.
#
# 2. The code in the previous section has one very bad flaw... there are
#    no comments. Try to add comments to this code so that when YOU have
#    to read it again in a few weeks (months) times, you can work out 
#    what it is doing
#
# 3. In THIS section, try to modify the code from the previous section
#    so that it creates and plots of the "gender_bck" variable. Your result
#    should look the same as the figure shown in the slide



