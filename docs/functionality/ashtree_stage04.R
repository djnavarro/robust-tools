
library(tidyverse)


# helper functions --------------------------------------------------------

# STAGE 4: we're going to need more "helper functions". I think of helpers
# as very simple functions that take only a couple of lines to write, but
# are useful for tidying the rest of the code!

radians <- function(degree) {
  2 * pi * degree / 360
}

adjust_scale <- function(s, scales) {
  s * sample(x = scales, size = length(s), replace = TRUE)
}

adjust_angle <- function(a, angles) {
  a + sample(x = angles, size = length(a), replace = TRUE)
}

adjust_x <- function(x, scale, angle) {
  x + scale * cos(radians(angle))
}

adjust_y <- function(y, scale, angle) {
  y + scale * sin(radians(angle))
}




# ashtree functions -------------------------------------------------------

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
