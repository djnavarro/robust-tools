
library(tidyverse)

radians <- function(degree) {
  2 * pi * degree / 360
}


# STAGE 2: talk about the structure of a function, the idea of internal 
# variables and the return values for a function

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
