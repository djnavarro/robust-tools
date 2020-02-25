# Exercise 5
#
# This is a minor extension to Exercise 4. Your first task is to read through]
# the code below... for the most part, it should look very familiar because it
# is the solution to Exercise 4!
#
# However, there are two new changes, on lines 22 and 29-30. Make sure you 
# check that part especially carefully! At the end of this script there are
# some discussion questions and a coding exercise.

# Load the required packages
library(tidyverse)

# Read the forensic data into R
forensic <- read_csv("data_forensic.csv")

# Just like last time we'll group the data, compute some summary statistics, 
# and then ungroup. However, this time I'll add a third grouping variable, 
# "handwriting_expert" so that we can keep track of the expert vs novice 
# difference
forensic_banded <- forensic %>%
  group_by(participant, band, handwriting_expert)  %>%
  summarise(mean_est = mean(est), sd_est = sd(est)) %>%
  ungroup()

# Okay, now... remember last time we got that annoying "Band NA" result? Let's
# use the "filter()" function -- which we are about to encounter in the class --
# to remove all those cases, because those are all errors in the data set!
forensic_banded <- forensic_banded %>%
  filter(band != "Band NA")

# Now let's draw the same plot...
pic <- ggplot(data = forensic_banded) + 
  geom_violin(mapping = aes(x = band, y = mean_est)) + 
  xlab("Stimulus Band") + 
  ylab("Responses") + 
  ggtitle("Distribution of responses")

plot(pic)


# Discussion topics -------------------------------------------------------

# - On line 30 there is a code snipped that reads `band != "Band NA"`. What 
#   do you think this means? In particular, what do you thing `!=` means?
#
# - On line 22 you'll see that I included the `handwriting_expert` variable.
#   Let's modify our plot so that it separates the novices from the experts.
#   To do this what we need to do is split our two plots into "facets", using
#   the `facet_wrap()` function. This is one that I haven't shown you before
#   so here's what you need to do: 
#
#   1. First, add a `+` to the end of line 37 so that R knows that there's 
#      one more line it needs to add to the plot
#
#   2. Second, add the code `facet_wrap(vars(handwriting_expert))` on line
#      38. Don't include the back ticks (i.e., ``). I've included those in
#      these comments ONLY to indicate that the thing inside the backticks
#      is supposed to be R code (that's a convention you'll see people use
#      a lot)
#
# - What conclusions do you draw about experts and novices by looking at 
#   the resulting plot?