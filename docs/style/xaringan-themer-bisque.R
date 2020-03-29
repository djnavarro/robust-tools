# load packages ----------------------------------------------------------------

library(xaringanthemer)


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

# set colors -------------------------------------------------------------------
duo_accent(
  primary_color      = col2hex("bisque4"), 
  secondary_color    = col2hex("bisque3"),
  header_font_google = google_font("Raleway"),
  text_font_google   = google_font("Raleway", "300", "300i"),
  code_font_google   = google_font("Fira Code"),
  text_font_size     = "30px",
  outfile            = "~/GitHub/courses/robust-tools/docs/style/xaringan-themer-bisque.css"
)
