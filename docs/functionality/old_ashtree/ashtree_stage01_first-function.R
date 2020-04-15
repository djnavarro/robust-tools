
library(tidyverse)

# STAGE 1: describe how to write a function...

radians <- function(degree) {
  prop <- degree / 360
  rads <- 2 * pi * prop
  return(rads)
}

