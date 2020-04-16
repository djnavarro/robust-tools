

# convenience function ----------------------------------------------------

col2hex <- function(name) {
  col_matrix <- grDevices::col2rgb(name)
  col_string <- grDevices::rgb(
    red   = col_matrix[1, ]/255, 
    green = col_matrix[2, ]/255, 
    blue  = col_matrix[3, ]/255
  )
  return(col_string)
}
