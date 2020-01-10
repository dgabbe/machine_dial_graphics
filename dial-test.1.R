# To-do
# - More research into R.devices package to handle plot generation in a uniform way.
#   Compare to trying to set RStudioGD device or using Quartz device (but Mac specific)
#   dev.new(…, noRStudioGD = FALSE) can control if RStudio device is used.
#   grDevices::quartz() check out parameters.
#
# - grDevices::convertXY to get info about differnt cordinate systems
# - R.devices - see how window or quartz works
# - Try font Format_1452 Medium (actually make a font selector book using 'facets' in plots)

# https://jokergoo.github.io/circlize_book/book/introduction.html

# Research articles:
# - http://www.melissaclarkson.com/resources/R_guides/documents/figure_layout_Ver1.pdf
# - http://www.gastonsanchez.com/stat133/slides/34-graphics-devices/34-graphics-devices.pdf
# - https://stackoverflow.com/questions/23621012/display-and-save-the-plot-simultaneously-in-r-rstudio
# - https://www.stat.auckland.ac.nz/~paul/RGraphics/chapter1.pdf

suppressPackageStartupMessages(library(circlize))
library(plotrix)
library(tibble)

mm_to_in <- function(mm) {return(mm / 25.4)}
pt_to_in <- function(pt) {return(pt / 72)}

#
# Change these parameters for the dial being made
#
is_save_to_file <- FALSE
mounting_hole_dia_in <- 0.375
dial_gap_mm <- 2 # leave space around outside of dial
dial_diameter_in <- mm_to_in(45 + 2 * dial_gap_mm)

font_size <- 18 #pt
scale_height <- pt_to_in(1.6 * font_size)
font_family <- "DIN Alternate"
# font_family <- "Neutra Cond Bold" # bad font - see FontForge warning message
# font_family <- "Fira Code Medium" #Likely hard to chemical etch
# font_family <- "DIN 1451 fette Breitschrift 1936"


#
# Helper functions
#
draw_outer_border <- function() {
  # There is another 4% available, check par("usr")
  x0 <- 0
  x1 <- 1
  y0 <- 0
  y1 <- 1
  lines(x = c(x0, x1), y = c(y0, y0), col = "lightgray") # bottom
  lines(x = c(x1, y0), y = c(x1, y1), col = "lightgray") # top
  lines(x = c(x0, x0), y = c(y0, y1), col = "lightgray") # left side
  lines(x = c(x1, x1), y = c(y0, y1), col = "lightgray") # right side
}

draw_center_mark <- function(mounting_hole_dia = mounting_hole_dia_in) {}

draw_dial_boundary <- function(dia = dial_diameter_in) {}

draw_credit <- function() {}

speeds1 <- c(700, 800, 1000, 1200, 1400, 1600, 1800, 2000, 2235)
speeds2 <- c(480, 600, 800, 1000, 1200, 1400, 1530)
speeds3 <- c(300, 400, 500, 600, 700, 800, 965)
speeds4 <- c(170, 200, 250, 300, 350, 400, 450, 500, 555)

dial_scales <- tribble(
  ~ band, ~ speeds,
  1, speeds1,
  2, speeds2,
  3, speeds3,
  4, speeds4
)

#xy_canvas_lims <- c(1, 1.16, 1.4, 1.72) # to nest independent plots
#xy_canvas_lims <- c(1, 1.16, 1.35, 1.6) # font size: 16pt
# xy_canvas_lims <- c(1, 1.16, 1.355, 1.65) # font size: 18pt

xy_canvas_lim <- 1 # init for outermost scale
dial_scales <- add_column(dial_scales, bg_color = c("light blue", "yellow", "red", "purple")) # debugging
dial_scales <- add_column(dial_scales, xy_canvas_lim = xy_canvas_lims)
dial_scales <- add_column(dial_scales, type_adj = c(20, 16, 12, 8))
dial_scales <- add_column(dial_scales, line_width = c(4, 3, 2.5, 1.75))
dial_scales <- add_column(dial_scales, line_color = c("#000000", "#222222", "#444444", "#666666"))

dial_outer_edge_dia_in <- 3.426 # 246.67px, width of the flat part of the chasis cover
dial_rotation <- 312 # degrees
start_angle <- 270 - (360 - dial_rotation)/2
stop_angle <- 270 + (360 - dial_rotation)/2
spindle_pulley_diameters <- c(7.25, 6.25, 5.25, 4.5)

# Code from circlize-test-run chunk

# Definitions that should not be changed
gap_after = stop_angle - start_angle
cell_padding <- c(0.00, 1.00, 0.00, 1.00)


#
# Start the dial
#
if (is_save_to_file) {
  svg(
    filename = "./dials/4-speeds.%03d.svg",
    onefile = TRUE #,
    # width = dial_outer_edge_dia_in + mm_to_in(2),
    # height = dial_outer_edge_dia_in + mm_to_in(2)
  )
}

# Set up the device
# Do not include 'new = "TRUE"' because there is no plot yet.
par(
  # Figure region in inches
  fin = c(dial_outer_edge_dia_in, dial_outer_edge_dia_in),
  # plot dimensions in inches
  pin = c(dial_outer_edge_dia_in, dial_outer_edge_dia_in),
  # margin size in inches
  mai = c(0, 0, 0, 0),
  # (NDC) coordinates of the figure region in the display region of the device.
  fig = c(0, 1, 0, 1), # wonder if this is the problem...
  # annotation - axis and overall titles
  ann = FALSE
)

# Create a new frame so RStudio doesn't overplot
plot.new(asp = 1)  # not creating a new plot in RStudio Plot pane...

# draw a border for printing
draw_outer_border()

cross_mark <- mounting_hole_dia_in / 2
lines(x = c(0.5 - cross_mark, 0.5 + cross_mark), y = c(0.5, 0.5), col = "lightgray")
lines(x = c(0.5, 0.5), y = c(0.5 - cross_mark, 0.5 + cross_mark), col = "lightgray")

# Outline for shaft hole
plotrix::draw.circle(
  c(0.5), c(0.5),
  radius = c(mounting_hole_dia_in / 2, dial_diameter_in / 2),
  border = c("lightgray", "lightgray"), lty = c(1, 3)
)

#
# Add the RPM scales
#
for (i in 1:nrow(dial_scales)) {
  speeds <- dial_scales[[i, "speeds"]]
  # xy_canvas_lim <- dial_scales[[i, "xy_canvas_lim"]]
  bg_color <- dial_scales[[i, "bg_color"]]
  type_adj <- dial_scales[[i, "type_adj"]]
  line_width <- dial_scales[[i, "line_width"]]
  line_color <- dial_scales[[i, "line_color"]]

  par(new = TRUE) # See code for fig 6.4, "Circular Visualization in R", https://jokergoo.github.io/circlize_book/book/advanced-layout.html#arrange-multiple-plots
  circos.par(
    canvas.xlim = c(-xy_canvas_lim, xy_canvas_lim),
    canvas.ylim = c(-xy_canvas_lim, xy_canvas_lim),
    clock.wise = TRUE,
    start.degree = start_angle,
    gap.after = gap_after,
    cell.padding = cell_padding
  )

  circos.initialize(factors = "speeds",
                    xlim = range(speeds))

    circos.track(
    ylim = c(0, 1),
    bg.border = NA, # Use bg_color for debugging
    track.height = convert_length(scale_height, "in"),
    panel.fun = function(x, y) {
      # Scale numbers
      circos.text(
        speeds,
        rep(0.5, length(speeds)),
        speeds,
        facing = "outside",
        niceFacing = TRUE,
        cex = fontsize(font_size),
        font = 2,
        family = font_family
      )
      # Scale delineation
      circos.lines(
        x = c(speeds[1] - type_adj, speeds[length(speeds)] + type_adj),
        y = c(1, 1),
        baseline = "top",
        col = line_color,
        lwd = line_width
      )
    }
  )

note(txt = paste("Scale", i, ": bottom radius: ",
    format(round(as.numeric(CELL_META$cell.bottom.radius), 4)),
    " xy_canvas_limit: ",
    format(round(as.numeric(xy_canvas_lim), 3)),
    " track.margin: ",
    CELL_META$track.margin,
    " inner most radius: ",
    format(round(as.numeric(circlize:::get_most_inside_radius()), 3))
    )) # debug

  # xy_canvas_lim <- xy_canvas_lim + 1 - CELL_META$cell.bottom.radius + CELL_META$track.margin
  xy_canvas_lim <- xy_canvas_lim + 1 - circlize:::get_most_inside_radius()

  circos.clear() # always end w/clear
}


# Add rectangular boundry, add canvas size

# Add dimensional marks
par(
  new = TRUE,
  fin = c(dial_outer_edge_dia_in, dial_outer_edge_dia_in),
  pin = c(dial_outer_edge_dia_in, dial_outer_edge_dia_in),
  mar = c(0, 0, 0, 0),
  fig = c(0, 1, 0, 1)
)

# cross_mark <- mounting_hole_dia_in / 2
# lines(x = c(-cross_mark, cross_mark), y = c(0, 0), col = "lightgray")
# lines(x = c(0, 0), y = c(-cross_mark, cross_mark), col = "lightgray")

# # Outline for shaft hole
# plotrix::draw.circle(c(0), c(0),
#                      radius = c(mounting_hole_dia_in / 2, dial_diameter_in / 2),
#                      border = c("lightgray", "lightgray"), lty = c(1, 3)
# )

# faint boundary for dial
# plotrix::draw.circle(c(0), c(0),
#         radius = c(dial_diameter_in / 2),
#         border = "lightgray", lty = 3)


if (is_save_to_file) {
  dev.off()
}
