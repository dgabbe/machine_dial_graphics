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
    ~param, ~group, ~short_def, ~read_only,
    "adj", "text", "determines the way in which text strings are justified in text, mtext and title", FALSE,
    "ann", "annotation", " annotate the plots with axis titles and overall titles", FALSE,
    "ask", "", "deprecated - use devAskNewPage", FALSE,
    "bg", "device", "background color of device region", FALSE,
    "bty", "plot", "type of box drawn around plots", FALSE,
    "cex", "text", "relative magnification of text & symbols to default", FALSE,
    "cex.axis", "axes", "relative magnification of axis notation to cex", FALSE,
    "cex.lab", "axes", "relative magnification of x & y labels to cex", FALSE,
    "cex.main", "axes", "TBI", FALSE,
    "cex.sub", "axes", "TBI", FALSE,
    "cin", "text", "character size - inches. Same as 'cra'", TRUE,
    "col", "plot", "default plotting color", FALSE,
    # other col.*
    "cra", "text", "character size - pixels. Same as 'cin'", TRUE

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
