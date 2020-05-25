# Exercise 4
#
# Okay, this is getting absurd. I know it's a pain, but my daughter is 
# really obsessed with emojis, and now she's replaced all the ggplot2
# functions with 🎨. I'm really sorry about this, but could you please
# fix this for me so that it draws our pretty dinosaur picture?

# Our first script --------------------------------------------------------

library(tidyverse)

dino <- read_csv("data_dino.csv")
print(💖)

# Create a new "picture"...
picture <- 🎨(🙂 = 💖) + 
  🎨(🙂 = 🎨(🙂 = 💖, 🙂 = 💖))

# ... and plot it
plot(💖)
