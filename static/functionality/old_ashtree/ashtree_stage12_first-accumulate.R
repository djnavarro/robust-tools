
library(tidyverse)


# helper functions --------------------------------------------------------

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

grow_from <- function(tips) {
  
  # parameter values
  all_scales <- c(.8, .9, .95)
  all_angles <- c(-10, -5, 5, 10, 20, 25)
  
  # mutate the tips tibble
  new_growth <- tips %>%
    mutate(
      scale = adjust_scale(scale, all_scales),      # change segment length
      angle = adjust_angle(angle, all_angles),      # change segment angle
      old_x = new_x,                                # begin where last seg ended
      old_y = new_y,                                # begin where last seg ended
      new_x = adjust_x(old_x, scale, angle),        # end where this seg ends!
      new_y = adjust_y(old_y, scale, angle)         # end where this seg ends!
    )
  return(new_growth)
}


grow_many <- function(tips) {
  
  # parameter values
  splits <- 3

  new_tips <- map_dfr(1:splits, ~grow_from(tips))
  return(new_tips)
}


grow_tree <- function() {
  
  # parameter values
  cycles <- 4
  
  # initialise
  tips <- grow_sapling()
  
  # STAGE 12... the structure of our loop is trickier than last time
  # because the "tips" that are passed to each iteration are different
  # to the last one, AND they depend on the results of the grow_many()
  # process from last time!!!!!
  
  # grow tree in a loop
  tree <- accumulate(2:cycles, ~grow_many(.x), .init = tips)
  
  # STAGE 12... accumulate() is like map() and always returns a list, 
  # so we'll need to bind together...
  
  tree <- bind_rows(tree)
  
  return(tree)
}


draw_tree <- function(tree) {
  
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
  
  return(pic)
}

# do stuff ----------------------------------------------------------------

set.seed(1)

tree <- grow_tree()
pic <- draw_tree(tree)

plot(pic)
