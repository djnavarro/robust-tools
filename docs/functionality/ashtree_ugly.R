
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


# worker functions --------------------------------------------------------


# the very first shoot is the "sapling"
grow_sapling <- function() {
  
  sapling <- tibble(
    old_x = 0,  # sapling grows from the origin
    old_y = 0,  # sapling grows from the origin
    new_x = 0,  # sapling doesn't grow horizontally
    new_y = 1,  # sapling does grow vertically
    angle = 90, # angle from horizontal is 90 degrees
    scale = 1,  # length of the sapling is 1
    cycle = 1,  # the sapling grows on the first cycle
    child = 1   # the sapling is the only child at this point
  )
  return(sapling)
}

grow_from <- function(..split, tips, settings) {
  
  growth_this_split <- tips %>%
    mutate(
      scale = adjust_scale(scale, settings$scales), # change segment length
      angle = adjust_angle(angle, settings$angles), # change segment angle
      old_x = new_x,                                # begin where last seg ended
      old_y = new_y,                                # begin where last seg ended
      new_x = adjust_x(old_x, scale, angle),        # end where this seg ends!
      new_y = adjust_y(old_y, scale, angle),        # end where this seg ends!
      split = ..split                               # store the split number
    )
  return(growth_this_split)
}



# for each shoot in the existing tree grow a new shoot
grow_many <- function(..growth, ..cycle, settings) {
  
  SPLIT <- 1:settings$splits
  
  growth_this_cycle <- map_dfr(
    .x = SPLIT,          # SPLIT is the vector over which we will iterate
    .f = grow_from,      # grow_from() is called for each value of SPLIT     
    growth = ..growth,   # passed to grow_from(), always the same value
    settings = settings  # passed to grow_from(), always the same value
  ) %>% 
    mutate(cycle = ..cycle)  # store the cycle number
  
  return(growth_this_cycle)
}



# to grow the whole tree we need to "accumulate" the growth: starting with
# the sapling (a single shoot) we grow the second layer; the set of shoots
# that make the second layer are then used to grow the third later; and so on
grow_tree <- function(settings) {
  
  GROWTH <- grow_sapling()
  CYCLES <- 2:settings$cycles
  
  tree <- CYCLES %>% 
    accumulate(
      .f = grow_many,      # grow_many() accumulates GROWTH across CYCLES
      .init = GROWTH,      # the sapling is the initial GROWTH
      settings = settings  # the settings list is passed to grow_many()
    )
  
  tree <- bind_rows(tree)  # collapse to a single tibble
  
  return(tree)
}



# let's do something! -----------------------------------------------------

settings <- list(
  seed = 1,
  cycles = 13,
  splits = 2,
  scales = c(.8, .9, .95),
  angles = c(-10, -5, 5, 10, 20, 25)
)

set.seed(settings$seed)

tree <- grow_tree(settings)

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
