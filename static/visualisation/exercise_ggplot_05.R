# Welcome to the exercises! Let's get started. 
#
# This file is an example of a "script", a text file with R code. 
# To make it "run", click on the "Source" button just above this 
# text on the right hand side of the panel. 
#
# <- Lines that start with "#" are comments: R ignores them 
#
# Read the code below, try to guess what it will do, and then click
# the "Source" button to run it. There are questions at the end...


# Our first script --------------------------------------------------------

# Load the tidyverse package using library(). You 
# should always make sure your scripts load the 
# resources they need.
library(tidyverse)

# Speaking of which, we need some data... 
dino <- read_csv("data_dino.csv")
print(dino)

# Create a new "picture"...
picture <- ggplot(data = dino) + 
  geom_point(mapping = aes(x = horizontal, y = vertical))

# ... and plot it
plot(picture)


# Paired discussion questions ---------------------------------------------

# - what does read_csv() do?
# - what do print() and plot() do?
# - why does my code say "x = horizontal" and "y = vertical"????
# - what does the "<-" thingy do?

