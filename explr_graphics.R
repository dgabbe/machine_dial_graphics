library(dplyr)
library(tibble)

par_params <- tribble(
  ~param, ~group, ~short_def, ~read_only, ~decimals,
  "adj", "text", "jtext, mtext and title justification", FALSE, 1,
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
  "din", "device", "device dimensions in inches", TRUE, 3,
  "err", "", "Unimplemented", FALSE, NA,
  "family", "text", "add description", FALSE, NA,
  "fg", "plot", "foreground plot color", FALSE, NA,
  "fig", "figure", "figure region in NDC", FALSE, 1,
  "fin", "figure", "figure region in inches", FALSE, 3,
  "font", "text", "add description", FALSE, 0,
  "font.axis", "axes", "add description", FALSE, 8,
  "font.lab", "annotation", "add description", FALSE, 0,
  "font.main", "annotation", "add description", FALSE, 0,
  "font.sub", "annotation", "add description", FALSE, 0,
  "lab", "axes", "add description", FALSE, 8,
  "las", "axes", "add description", FALSE, 8,
  "lend", "element", "add description", FALSE, 8,
  "lheight", "text", "add description", FALSE, 8,
  "ljoin", "element", "add description", FALSE, 8,
  "lmitre", "element", "add description", FALSE, 8,
  "lty", "element", "add description", FALSE, 8,
  "lwd", "element", "add description", FALSE, 8,
  "mai", "margin", "margin size in inches", FALSE, 2,
  "mar", "margin", "margin size in lines", FALSE, 1,
  "mex", "text", "convertion factor between 'mar' & 'mai'", FALSE, 1,
  "mfcol", "panel", "panel columns", FALSE, 0,
  "mfg", "panel", "figure being drawn", FALSE, 1,
  "mfrow", "panel", "panel rows", FALSE, 0,
  "mgp", "axes", "mex units for margin line", FALSE, 0,
  "mkh", "", "Ignored", FALSE, NA,
  "new", "plot", "not clean frame before drawing", FALSE, NA,
  "oma", "panel", "add description", FALSE, 1,
  "omd", "panel", "add description", FALSE, 1,
  "omi", "panel", "add description", FALSE, 1,
  "page", "plot", "start new page for next new plot", TRUE, NA,
  "pch", "text", "add description", FALSE, 8,
  "pin", "plot", "plot dimenions in inches", FALSE, 3,
  "plt", "plot", "plot region coords as fractions of figure region", FALSE, 5,
  "ps", "text", "add description", FALSE, 8,
  "pty", "plot", "type of plot region", FALSE, NA,
  "smo", "", "Unimplemented", FALSE, NA,
  "srt", "text", "add description", FALSE, 8,
  "tck", "axes", "add description", FALSE, 8,
  "tcl", "axes", "add description", FALSE, 8,
  "usr", "usr", "user coordinates of plotting region", FALSE, 0,
  "xaxp", "axes", "coord and interval between tick marks", FALSE, 0,
  "xaxs", "axes", "add description", FALSE, 8,
  "xaxt", "axes", "add description", FALSE, 8,
  "xlog", "plot", "logarithmic scale", FALSE, NA,
  "xpd", "plot", "clip to plot or figure region", FALSE, NA,
  "yaxp", "axes", "coord and interval between tick marks", FALSE, 0,
  "yaxs", "axes", "add description", FALSE, 8,
  "yaxt", "axes", "add description", FALSE, 8,
  "ylbias", "axes", "add description", FALSE, 1,
  "ylog", "plot", "logarithmic scale", FALSE, NA
)


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

  message() # init
  msg <- "" # init

  m <- "  devices:  "
  message_nolf(paste0(m))
  msg <- paste0(msg, m)
  if (is.null(d)) {
    message_nolf(paste("NULL"))
    msg <- paste(msg, "NULL")
  } else {
    for (i in 1:length(d)) {
      if (i == dc_index) {
        m <- paste0(">> ", d[[i]], ":", dn[[i]], " <<  ")
        message_nolf(m)
        msg <- paste0(msg, m)
      } else {
        m <- paste0(d[[i]], ":", dn[[i]], " ")
        message_nolf(m)
        msg <- paste0(msg, m)
      }
    }
  }

  #
  # Parameters
  #
  message()
  msg <- paste0(msg, "\n")

  m <- paste0(indent, "dev.size (in): ")
  message_nolf(m)
  msg <- paste0(msg, m)

  m <- paste(format(dev.size(units = "in"), digits = 3, nsmall = 3), collapse = " ")
  message(m)
  msg <- paste0(msg, m, "\n")

  lapply(
    list("din", "mai", "pin", "usr"),
    function(p) {
      m <- paste0(indent, p, ": ")
      message_nolf(m)
      msg <<- paste0(msg, m)

      m <- paste(format(par(p), digits = 3, nsmall = filter(par_params, param == p)[["decimals"]]), collapse = " ")
      message(m)
      msg <<- paste(msg, m, "\n")
    }
  )

  message()
  return(msg)
}


pretty_print_par <- function(p = names(par())) {
  buffer <- ""
  lapply(
    p,
    function(p) {
      p_p <- filter(par_params, param == p)
      ro <- if (p_p[["read_only"]]) {" [RO]: "} else {": "}
      if (!is.na(p_p[["decimals"]]) && is.numeric(p_p[["decimals"]]) == TRUE) {
        v <- paste(format(par(p), digits = 3, nsmall = p_p[["decimals"]]), collapse = " ")
      } else {
        v <- par(p)
      }
      buffer <<- paste0(buffer, paste0(p, ro, v, " - ", p_p[["short_def"]]), "\n" )
    }
  )
  cat(buffer)
}

par_decoder <- function(params) {
  # test param to be a string or list of strings
  # check options
  # optional group param
  p <- par()
  groups <- list("device", "panel", "figure", "margin", "plot", "usr", "annotation", "axes", "elements", "text")


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
