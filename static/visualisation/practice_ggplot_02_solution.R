# Practice Exercise 02 
#
# The ggplot2 package comes with a data set called "economics" that includes
# information about the US unemployment rate from 1967 to 2015. Your task in
# this exercise is to draw a simple line plot using this data and "make it
# pretty". Here is a code snippet that should help you draw the basic plot:
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
# You should add a title, give the plot some readable axis labels, and change
# the theme to something nicer than the default. For full marks you should 
# change the y-axis limits so that the chart starts at 0. (You may need to 
# google to find the answer to this)

# Solution to exercise 2 of the data visualisation component
# Author: Danielle Navarro (d.navarro@unsw.edu.au)
# Date: 11 March 2020

# load packages
library(tidyverse)

# create plot
picture_02 <- ggplot(
  data = economics,
  mapping = aes(
    x = date, 
    y = uempmed
  )
) + 
  geom_line() + 
  xlab("Date") + 
  ylab("Unemployment rate") + 
  ggtitle("US unemployment data, 1967-2015") + 
  theme_minimal() + 
  ylim(0, 30)
  

# draw the plot
print(picture_02)