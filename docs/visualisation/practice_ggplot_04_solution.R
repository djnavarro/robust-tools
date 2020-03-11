# Practice Exercise 4. 
#
# Again, create a scatterplot using the mpg data that plots the city mileage 
# against the highway mileage; the colour of the dots should correspond to the 
# class of drive (e.g., compact). 
#
# For this exercise you should break the plot into separate facets, one for 
# each vehicle class. Make sure you add a sensible x-axis label, y-axis label
# and chart title. When you look at the resulting plot you should see that 
# it is redundant: the legend on the right hand side is unnecessary because
# the panels all have individual titles. See if you can get rid of the 
# legend entirely. (Hint: you may need to google to find the answer to this)

# Solution to practice exercise 4 of the data visualisation component
# Author: Danielle Navarro (d.navarro@unsw.edu.au)
# Date: 11 March 2020

# load packages
library(tidyverse)

# create plot
picture_04 <- ggplot(
  data = mpg,
  mapping = aes(
    x = cty, 
    y = hwy,
    colour = class
  )
) +
  geom_point(aes(colour = class), show.legend = FALSE) + 
  facet_wrap(vars(class)) + 
  xlab("City Mileage") + 
  ylab("Highway Mileage") + 
  ggtitle("City and highway mileage by vehicle class") 

# draw the plot
print(picture_04)