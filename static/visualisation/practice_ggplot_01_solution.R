# Practice Exercise 1. 
#
# Create a scatterplot using the mpg data that plots the city mileage against
# the highway mileage; the colour of the dots should correspond to the class of
# drive (e.g., compact).
#
# Note 1: Your answers should be self-contained R scripts, one for each exerise. 
# I should be able to source your script in a fresh R session and have it draw 
# the plot. You may assume that my machine has the relevant packages, but you 
# should NOT assume that I already have them loaded. Your code should include
# appropriate comments.
#
# Note 2: In most cases there are multiple valid ways of creating the plot. As
# long as your code generates the right answer and is commented well enough for
# me (or another person) to understand, it is okay.

# Solution to practice exercise 1 of the data visualisation component
# Author: Danielle Navarro (d.navarro@unsw.edu.au)
# Date: 11 March 2020

# load packages
library(tidyverse)

# create plot
picture_01 <- ggplot(
  data = mpg,
  mapping = aes(
    x = cty, 
    y = hwy, 
    colour = class
  )
) + 
  geom_point()

# draw the plot
print(picture_01)