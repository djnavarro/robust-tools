# Practice Exercise 05
#
# Create the ugliest plot you possibly can using only the mpg
# data set. You can choose whichever variables you like, and
# whatever geoms you think will look the worst. 
#
# Make a plot truly ugly, you will want to investigate the theme()
# function to modify specific aspects to the theme to be as 
# unpleasant as possible. For example, one of the theme elements
# is "panel.background" which controls the rectangular area on 
# which the plot is drawn. If I wanted to convert this from the 
# boring light grey background to a hot pink colour with a thick
# green border, I could do this:
#
# ggplot(
# data = mpg,
# mapping = aes(
#   x = cty, 
#   y = hwy
# )
# ) + 
#   geom_point() + 
#   theme(panel.background = element_rect(
#     colour = "green", fill = "hotpink", size = 5
#   ))
#
# This is an open ended exercise. Try to be as creative as 
# possible in making a truly horrible chart!
