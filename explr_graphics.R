library(tibble)

explr_graphics <- function() {
  #
  # Device list
  #
  indent = "    "
  d <- dev.list()
  dn <- names(d)
  dc <- dev.cur()
  dcn <- names(dc)
  dc_index <- which(dcn %in% dn)

  message_nolf <- function(...){
    message(..., appendLF = FALSE)
  }

  message()
  message_nolf(paste0("  devices:  "))
  if (is.null(d)) {
    message_nolf(paste("NULL"))
  } else {
    for (i in 1:length(d)) {
      if (i == dc_index) {
        message_nolf(paste0(">> ", d[[i]], ":", dn[[i]], " <<  "))
      } else {
        message_nolf(paste0(d[[i]], ":", dn[[i]], " "))
      }
    }
  }
  # message()

  #
  # Parameters
  #
  message()
  message_nolf(paste0(indent, "dev.size (in): "))
  message(paste(format(dev.size(units = "in"), digits = 3, nsmall = 3), collapse = " "))

  lapply(
    list("din", "mai", "pin", "usr"),
    function(p) {
      message_nolf(paste0(indent, p, ": "))
      message(paste(format(par(p), digits = 3, nsmall = 3), collapse = " "))
    }
  )

  message()
}


par_decoder <- function(params) {
  # test param to be a string or list of strings
  # check options
  # optional group param
  p <- par()
  groups <- list("device", "panel", "figure", "margin", "plot", "usr", "annotation", "axes", "elements", "text")

  decoder <- tribble(
    ~param, ~group, ~short_def, ~read_only, ~decimals,
    "adj", "text", "determines the way in which text strings are justified in text, mtext and title", FALSE, 1,
    "ann", "annotation", " annotate the plots with axis titles and overall titles", FALSE, NA,
    "ask", "", "deprecated - use devAskNewPage", FALSE, NA,
    "bg", "device", "background color of device region", FALSE, NA,
    "bty", "plot", "type of box drawn around plots", FALSE, NA,
    "cex", "text", "relative magnification of text & symbols to default", FALSE, 1,
    "cex.axis", "axes", "relative magnification of axis notation to cex", FALSE, 1,
    "cex.lab", "axes", "relative magnification of x & y labels to cex", FALSE, 1,
    "cex.main", "axes", "TBI", FALSE, 1,
    "cex.sub", "axes", "TBI", FALSE, 1,
    "cin", "text", "character size - inches. Same as 'cra'", TRUE, 2,
    "col", "plot", "default plotting color", FALSE, NA,
    "col.axis", "axes", "add description", FALSE, NA,
    "col.lab", "annotation", "add description", FALSE, NA,
    "col.main", "annotation", "add description", FALSE, NA,
    "col.sub", "annotation", "add description", FALSE, NA,
    "cra", "text", "character size - pixels. Same as 'cin'", TRUE, 1,
    "crt", "text", "add description", FALSE, 1,
    "csi", "text", "add description", TRUE, 1,
    "cxy", "text", "add description", TRUE, 5,
    "din", "device", "add description", TRUE, 3,
    "err", "", "Unimplemented", FALSE, NA,
    "family", "text", "add description", FALSE, NA,
    "fg", "plot", "add description", FALSE, NA,
    "fig", "figure", "add description", FALSE, 1,
    "fin", "figure", "add description", FALSE, 3,
    "font", "text", "add description", FALSE, 0,
    "font.axis", "axes", "add description", FALSE, 8,
    "font.lab", "annotation", "add description", FALSE, 8,
    "font.main", "annotation", "add description", FALSE, 8,
    "font.sub", "annotation", "add description", FALSE, 8,
    "lab", "axes", "add description", FALSE, 8,
    "las", "axes", "add description", FALSE, 8,
    "lend", "element", "add description", FALSE, 8,
    "lheight", "text", "add description", FALSE, 8,
    "ljoin", "element", "add description", FALSE, 8,
    "lmitre", "element", "add description", FALSE, 8,
    "lty", "element", "add description", FALSE, 8,
    "lwd", "element", "add description", FALSE, 8,
    "mai", "margin", "add description", FALSE, 2,
    "mar", "margin", "add description", FALSE, 1,
    "mex", "text", "add description", FALSE, 1,
    "mfcol", "panel", "add description", FALSE, 0,
    "mfg", "panel", "add description", FALSE, 1,
    "mfrow", "panel", "add description", FALSE, 0,
    "mgp", "axes", "add description", FALSE, 8,
    "mkh", "", "Ignored", FALSE, NA,
    "new", "plot", "add description", FALSE, NA,
    "oma", "panel", "add description", FALSE, 1,
    "omd", "panel", "add description", FALSE, 1,
    "omi", "panel", "add description", FALSE, 1,
    "page", "plot", "add description", TRUE, NA,
    "pch", "text", "add description", FALSE, 8,
    "pin", "plot", "add description", FALSE, 8,
    "plt", "plot", "add description", FALSE, 5,
    "ps", "text", "add description", FALSE, 8,
    "pty", "plot", "add description", FALSE, NA,
    "smo", "", "Unimplemented", FALSE, NA,
    "srt", "text", "add description", FALSE, 8,
    "tck", "axes", "add description", FALSE, 8,
    "tcl", "axes", "add description", FALSE, 8,
    "usr", "usr", "add description", FALSE, 0,
    "xaxp", "axes", "add description", FALSE, 8,
    "xaxs", "axes", "add description", FALSE, 8,
    "xaxt", "axes", "add description", FALSE, 8,
    "xlog", "plot", "add description", FALSE, NA,
    "xpd", "plot", "add description", FALSE, 8,
    "yaxp", "axes", "add description", FALSE, 8,
    "yaxs", "axes", "add description", FALSE, 8,
    "yaxt", "axes", "add description", FALSE, 8,
    "ylbias", "axes", "add description", FALSE, 8,
    "ylog", "plot", "add description", FALSE, NA
  )

  message("Group: param [RO for read-only]: value - brief description")
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
