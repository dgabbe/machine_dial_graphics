library(tibble)

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
  groups <- list("device", "panel", "figure", "margin", "plot", "usr", "annotation", "axes", "elements", "text")

  decoder <- tribble(
    ~param, ~group, ~short_def,
    "adj", "text", "determines the way in which text strings are justified in text, mtext and title",
    "ann", "annotation", " annotate the plots with axis titles and overall titles",
    "ask", "", "deprecated - use devAskNewPage",
    "bg", "device", "background color of device region",
    "bty", "plot", "type of box drawn around plots",
    "cex", "text", "relative magnification of text & symbols to default",
    "cex.axis", "axes", "relative magnification of axis notation to cex",
    "cex.lab", "axes", "relative magnification of x & y labels to cex"
  )

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

par_verify <- function() {
  # compare number of items in par_decoder and par()
  message("Coming soon...")
}
