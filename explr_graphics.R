
explr_graphics <- function() {
  dev.list()
  dev.cur()
  dev.size(units = "in")
  par("din")
  par("mai")
  par("pin")
  par("usr")
}

par_decoder <- function() {
  p <- par()
  groups <- list("device", "panel", "figure", "margin", "plot", "usr", "annotation", "axes", "elements")
  message("Device params")
  message("Panel params")
  message("Margin params")
  message("Plot params")
  message("Usr coordinates")
  # decode the graphics parameters
  # device size
  # aspect ratio
  # panels
  # figure or plot
  # margins
  # plot area
  # usr coordinates
}
