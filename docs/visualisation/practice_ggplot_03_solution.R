# Practice Exercise 03
#
# Start with the plot you created in Exercise 02. Again, here is the snippet 
# of code I provided in that exercise:
#
# ggplot(
#   data = economics,
#   mapping = aes(
#     x = date, 
#     y = uempmed
#   )
# ) + 
#   geom_line()
#
# In the original plot, the raw data are plotted as a line. In
# this exercise you are asked to change this to a set of points 
# (i.e., make it a scatter plot) and add a smoothed curve the
# way we did in class. 
#
# Note that the default output of this plot does not look "right".
# The regression line looks wrong and the dot points are visually
# unpleasant. In your answer you should fix this. Some hints: 
#
# 1. Google some help for geom_smooth() and look at the "span" 
#    argument.
# 2. You can set "size" as an argument to geom_point. Remember 
#    that if you want to map a plot aesthetic to something in 
#    your data you use the mapping = aes(BLAH BLAH BLAH), but 
#    if you're just setting a fixed value you can set an 
#    argument like "size" directly.

# Solution to exercise 3 of the data visualisation component
# Author: Danielle Navarro (d.navarro@unsw.edu.au)
# Date: 11 March 2020

# load packages
library(tidyverse)

# create plot
picture_03 <- ggplot(
  data = economics,
  mapping = aes(
    x = date, 
    y = uempmed
  )
) + 
  geom_point(size = 1) + 
  geom_smooth(span = .1) + 
  xlab("Date") + 
  ylab("Unemployment rate") + 
  ggtitle("US unemployment data, 1967-2015") + 
  theme_minimal() + 
  ylim(0, 30)
  

# draw the plot
print(picture_03)