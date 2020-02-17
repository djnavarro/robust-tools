# Exercise 6
#
# This is the code that we came up with in Exercise 9. What you
# can see is that the "true" frequencies come in 5 distinct "bands".
# That was part of the experimental design. It doesn't make a lot
# of sense to draw a scatterplot when the data on the x-asis come 
# in discrete "bins" like this, does it?
#
# In this exercise, what we want to do is modify the code below so
# that instead of plotting the raw value "true" on the x-axis, we 
# use the "band" variable instead.
#
# Try that now. Do you see a problem?

library(tidyverse)
forensic <- read_csv("data_forensic.csv")

picture <- ggplot(data = forensic) + 
  geom_point(mapping = aes(x = true, y = est))

plot(picture)


# If I tell you that there is a function called geom_boxplot(),
# can you work out how to fix the problem? 
#
# What if I also tell you there is a function called geom_violin()?
# Would you consider using that instead of geom_boxplot()? If yes, why?
# If not, why not?



