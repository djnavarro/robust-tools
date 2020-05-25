# setup -------------------------------------------------------------------

# packages
library(tidyverse)
library(ambient) 
library(scico)
library(here)

# load the helper functions
source(file = here("whirlpool_functions.R"))


# parameters that define the artwork --------------------------------------

seed <- 3      # the random number generator needs a "seed" value
width <- 1600  # width of the image in pixels
height <- 900  # height of the image in pixels
scale <- -5    # a scaling parameter for the "noise" 

circle <- list(
  x = 800,     # center of the circle, x-coordinate
  y = 450,     # center of the circle, y-coordinate
  d = 400      # diameter of the circle
)

palette_name <- "berlin"   # type scico_palette_show() to see options
distinct_colors <- 1000    # how many distinct colors should we allow

filename <- here("whirlpool_01.png")


# make the artwork --------------------------------------------------------

# colors use a scico palette
style <- scico(
  n = distinct_colors, 
  palette = palette_name
)

# initialise the image as a (long form) grid of pixels
image_grid <- long_grid(
  x = seq(from = 0, to = width),
  y = seq(from = 0, to = height)
)

# mutate the grid
image_grid <- image_grid %>% 
  mutate(
    distance = circle_distance(x, y, circle),
    value = whirlpool_value(x, y, distance, scale, seed),
    color = to_color(value, style)
  )

# create the image file
make_image(
  grid = image_grid, 
  filename = filename, 
  width = width, 
  height = height
)

