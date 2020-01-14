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
  message_nolf(paste0(indent, "devices:  "))
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
  message()

  #
  # Parameters
  #
  message()
  message_nolf(paste0(indent, "dev.size (in): "))
  message(paste(format(dev.size(units = "in"), digits = 3, nsmall = 3), collapse = " "))

  message_nolf(paste0(indent, "din: "))
  message(paste(format(par("din"), digits = 3, nsmall = 3), collapse = " "))

  message_nolf(paste0(indent, "mai: "))
  message(paste(par("mai"), collapse = " "))

  message_nolf(paste0(indent, "pin: "))
  message(paste(format(par("pin"), digits = 3, nsmall = 3), collapse = " "))

  message_nolf(paste0(indent, "usr: "))
  message(paste(par("usr"), collapse = " "))

  message()
}


par_decoder <- function(params) {
  # test param to be a string or list of strings
  # check options
  # optional group param
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
    "col.axis", "axes", "add description", FALSE,
    "col.lab", "annotation", "add description", FALSE,
    "col.main", "annotation", "add description", FALSE,
    "col.sub", "annotation", "add description", FALSE,
    "cra", "text", "character size - pixels. Same as 'cin'", TRUE,
    "crt", "text", "add description", FALSE,
    "csi", "text", "add description", TRUE,
    "cxy", "text", "add description", TRUE,
    "din", "device", "add description", TRUE,
    "err", "", "Unimplemented", FALSE,
    "family", "text", "add description", FALSE,
    "fg", "plot", "add description", FALSE,
    "fig", "figure", "add description", FALSE,
    "fin", "figure", "add description", FALSE,
    "font", "text", "add description", FALSE,
    "font.axis", "axes", "add description", FALSE,
    "font.lab", "annotation", "add description", FALSE,
    "font.main", "annotation", "add description", FALSE,
    "font.sub", "annotation", "add description", FALSE,
    "lab", "axes", "add description", FALSE,
    "las", "axes", "add description", FALSE,
    "lend", "element", "add description", FALSE,
    "lheight", "text", "add description", FALSE,
    "ljoin", "element", "add description", FALSE,
    "lmitre", "element", "add description", FALSE,
    "lty", "element", "add description", FALSE,
    "lwd", "element", "add description", FALSE,
    "mai", "margin", "add description", FALSE,
    "mar", "margin", "add description", FALSE,
    "mex", "text", "add description", FALSE,
    "mfcol", "panel", "add description", FALSE,
    "mfg", "panel", "add description", FALSE,
    "mfrow", "panel", "add description", FALSE,
    "mgp", "axes", "add description", FALSE,
    "mkh", "", "Ignored", FALSE,
    "new", "plot", "add description", FALSE,
    "oma", "panel", "add description", FALSE,
    "omd", "panel", "add description", FALSE,
    "omi", "panel", "add description", FALSE,
    "page", "plot", "add description", TRUE,
    "pch", "text", "add description", FALSE,
    "pin", "plot", "add description", FALSE,
    "plt", "plot", "add description", FALSE,
    "ps", "text", "add description", FALSE,
    "pty", "plot", "add description", FALSE,
    "smo", "", "Unimplemented", FALSE,
    "srt", "text", "add description", FALSE,
    "tck", "axes", "add description", FALSE,
    "tcl", "axes", "add description", FALSE,
    "usr", "usr", "add description", FALSE,
    "xaxp", "axes", "add description", FALSE,
    "xaxs", "axes", "add description", FALSE,
    "xaxt", "axes", "add description", FALSE,
    "xlog", "plot", "add description", FALSE,
    "xpd", "plot", "add description", FALSE,
    "yaxp", "axes", "add description", FALSE,
    "yaxs", "axes", "add description", FALSE,
    "yaxt", "axes", "add description", FALSE,
    "ylbias", "axes", "add description", FALSE,
    "ylog", "plot", "add description", FALSE
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
