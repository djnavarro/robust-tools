
library(tidyverse)


# ashtree functions -------------------------------------------------------


radians <- function(degree) {
  2 * pi * degree / 360
}

grow_sapling <- function() {
  
  sapling <- tibble(
    old_x = 0,  # sapling grows from the origin
    old_y = 0,  # sapling grows from the origin
    new_x = 0,  # sapling doesn't grow horizontally
    new_y = 1,  # sapling does grow vertically
    angle = 90, # angle from horizontal is 90 degrees
    scale = 1,  # length of the sapling is 1
  )
  return(sapling)
}




# do stuff ----------------------------------------------------------------


# STAGE 3: structure our code so that all of our "ashtree" functions are
# defined up the top, before we do anything; also add code so that it 
# draws a picture!

set.seed(1)

tree <- grow_sapling()

pic <- ggplot(
  data = tree,
  mapping = aes(
    x = old_x, 
    y = old_y, 
    xend = new_x, 
    yend = new_y
  )
) + 
  geom_segment(show.legend = FALSE) + 
  theme_void() + 
  coord_equal()

plot(pic)
