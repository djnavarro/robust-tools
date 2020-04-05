
circle_distance <- function(x, y, circle) {
  
  # For each point (x,y), calculate its deviation from the origin 
  x_deviation <- x - circle$x
  y_deviation <- y - circle$y
  
  # I find it easier to think about circles in terms of their diameter
  # but mathematically it's more convenient to use the radius
  radius <- circle$d / 2
  
  # The formula for a circle is x^2 + y^2 = r^2, so we can compute the 
  # (squared) distance from the perimeter as follows:
  squared_deviation <- (x_deviation ^ 2) + (y_deviation ^ 2) - (radius ^ 2)
  
  # The value of squared_deviation is positive for points outside the 
  # circle and negative for points inside the circle. Create a value
  # "interior" that is TRUE for interior points and FALSE otherwise
  interior <- squared_deviation < 0
  
  # All points inside the circle are deemed to have "deviation" zero
  squared_deviation[interior] <- 0
  
  # Now convert to distance by taking the square root
  deviation <- sqrt(squared_deviation)
  
  # Finally, let's return the "deviation" to the user
  return(deviation)
}


whirlpool_value <- function(x, y, distance, scale, seed) {
  
  value <- gen_worley(
    x = x * distance, 
    y = y * distance, 
    seed = seed, 
    value = "distance2",
    frequency = 10^scale
  )
  return(value)
  
}

to_color <- function(value, theme) {
  
  n <- length(theme)
  index <- 1 + round((n - 1) * normalise(value))
  color <- theme[index]
  return(color)
}

make_image <- function(grid, filename, width, height) {
  pic <- 
    ggplot() + 
    geom_raster(mapping = aes(x,y, fill = color), data = grid) +
    scale_fill_identity() + 
    theme_void()
  
  ggsave(filename, pic, width = width/300, height = height/300, dpi = 300)
}


# make_image <- function(grid, filename, width, height) {
#   
#   # create a "graphics device" for the image file we want to write
#   png(filename = filename, width = width, height = height)
#   
#   # set the "graphical parameters" of the device to margin 0 on all sides
#   par(mar = c(0, 0, 0, 0))
# 
#   # plot the image "on" this device
#   plot(as.raster(grid, value = color))
# 
#   # turn "off" the graphics device to close and save
#   dev.off()
# }
