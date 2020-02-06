# Exercise 2
#
# Oh no! This script is *supposed* to be the same as the last one, but 
# unfortunately my daughter has found a way to insert emojis where there 
# should be code. 💖
#
# Can please fix this? You can always look back at Exercise 1 to see what
# the answers should be, but try not to do that 

# Our first script --------------------------------------------------------

library(tidyverse)

dino <- read_csv("data_dino.csv")
print(💖)

# Create a new "picture"...
picture <- ggplot(data = 💖) + 
  geom_point(mapping = aes(x = 💖, y = 💖))

# ... and plot it
plot(💖)
