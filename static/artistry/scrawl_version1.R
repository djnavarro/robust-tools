

# preliminaries -----------------------------------------------------------


# Load the packages we need
library(tidyverse)
library(ambient) 
library(scico)
library(here)

# Store the parameters that specify the piece in a list. In each case the 
# parameters should be a positive integer
art_par <- list(
  seed = 17,        # seed for the random number generator
  n_paths = 1000,   # number of distinct paths to draw
  n_steps = 400,    # number of steps along each path
  sz_step = 100,   # what is the size of a typical step?
  sz_slip = 5     # what is the size of a typical slip?
)


# initialising the canvas -------------------------------------------------


# To ensure reproducibility, set the "seed" of the pseudorandom number 
# generator to the value specified in the parameter list
set.seed(art_par$seed)

# To start drawing our scrawl we need to specify the "state" of the picture
# after the first "step". Each of the paths starts at a random location on 
# the canvas (varibles: x and y), and has a hidden z co-ordinate that is 
# initially set to 0 for every path.
state <- tibble(
  x = runif(art_par$n_paths, min = 0, max = 2), # uniform random number between 0 and 2
  y = runif(art_par$n_paths, min = 0, max = 2), # uniform random number between 0 and 2
  z = 0
)

# It is good practice to assign each path a specific identifier number (path_id)
# and similarly we should assign each step its own id (this is the first step so
# step_id = 1 for all paths)
state <- state %>% 
  mutate(
    path_id = 1:art_par$n_paths,
    step_id = 1
  )

# Finally, we'll create a new variable art_dat in which data for every step will
# accumulate as we apply our "brush" repeatedly
art_dat <- state



# creating the artwork data -----------------------------------------------


# Create a "dummy" variable called stop_painting. This is a logical variable
# that tells R whether we should continue to paint, or whether we should stop!
stop_painting <- FALSE

while(stop_painting == FALSE) {
  
  # This is a little bit of magic... it takes the tibble corresponding to
  # the current "state" and generates a new "step" tibble with x, y and z
  # values that tell us how to move our brush...
  step <- curl_noise(
    generator = gen_simplex,
    x = state$x,
    y = state$y,
    z = state$z,
    seed = c(1, 1, 1) * art_par$seed
  )
  
  # Use the "step" data to mutate/modify the current state, moving the x and y
  # co-ordinates of the brush(es) and possibly "slipping" a little distance in
  # the z dimension...
  state <- state %>% 
    mutate(
      x = x + step$x * art_par$sz_step / 10000, # step along x
      y = y + step$y * art_par$sz_step / 10000, # step along y
      z = z + step$z * art_par$sz_slip / 10000, # step (invisibly) along z
      step_id = step_id + 1                     # increment the step number!
    )
  
  # Append the new data to the bottom of the art_dat tibble
  art_dat <- bind_rows(art_dat, state)
  
  # The value of step_id in the last row in art_dat tells us
  # how many steps we have taken so far
  current_step <- last(art_dat$step_id)
  
  # If we have taken as many steps as were specified in the
  # parameter list, then we should stop the painting!
  if(current_step >= art_par$n_steps) {
    stop_painting <- TRUE
  }
}


# use art_dat as the basis for a ggplot -----------------------------------


art_pic <- ggplot(
  data = art_dat,     # the data
  mapping = aes(
    x = x,            # plot the x-value
    y = y,            # plot the y-value
    group = path_id,  # each "path_id" is a distinct "group" (i.e. its own line) 
    color = step_id   # the color of the line should change according to the step
  )
) + 
  geom_path(
    size = .5,     # width of the lines
    alpha = .5,    # transparency of the lines
    show.legend = FALSE
  ) + 
  coord_equal() +  # ensure x and y coordinates are on the same scale 
  theme_void() +   # use a blank theme 
  scale_color_scico(palette = "grayC") # set the color scheme



# save the ggplot to a png file -------------------------------------------

# size of the image in pixels (or "dots")
pixels_wide <- 5000
pixels_high <- 5000

# what shall we call our image?
filename <- art_par %>% 
  str_c(collapse = "-") %>% 
  str_c("scrawl_", ., ".png", collapse = "-")

# it to file
ggsave(
  filename = filename,        # the filename
  path = here("img"),         # the folder to save it in
  plot = art_pic,             # the ggplot object to draw to the file
  width = pixels_wide / 300,  # width of the image in "inches"
  height = pixels_high / 300, # height of the image in "inches"
  dpi = 300                   # dpi = "dots (pixels) per inch"  
)



