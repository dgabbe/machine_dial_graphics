suppressPackageStartupMessages(library(circlize))
library(plotrix)
library(tibble)

mm_to_in <- function(mm) {return(mm / 25.4)}
pt_to_in <- function(pt) {return(pt / 72)}

speeds1 <- c(700, 800, 1000, 1200, 1400, 1600, 1800, 2000, 2235)
speeds2 <- c(480, 600, 800, 1000, 1200, 1400, 1530)
speeds3 <- c(300, 400, 500, 600, 700, 800, 965)
speeds4 <- c(170, 200, 250, 300, 350, 400, 450, 500, 555)

dial_scales <- tribble( ~band, ~speeds, ~bg_color,
                   1, speeds1, "light blue",
                   2, speeds2, "yellow",
                   3, speeds3, "red",
                   4, speeds4, "purple")

xy_canvas_lims <- c(1, 1.16, 1.4,  1.72)
dial_scales <- add_column(dial_scales, xy_canvas_lim = xy_canvas_lims)
dial_scales <- add_column(dial_scales, type_adj = c(16, 12, 9, 7))
dial_scales <- add_column(dial_scales, line_width = c(4, 3, 2.5, 1.75))
dial_scales <- add_column(dial_scales, line_color = c("#000000", "#222222", "#444444", "#666666"))

mounting_hole_dia_in <- 0.375
dial_outer_edge_dia_in <- 3.426 # 246.67px
dial_gap_mm <- 2 # leave space around outside of dial
dial_diameter_in <- mm_to_in(45 + 2 * dial_gap_mm)
dial_rotation <- 312 # degrees
start_angle <- 270 - (360 - dial_rotation)/2
stop_angle <- 270 + (360 - dial_rotation)/2
spindle_pulley_diameters <- c(7.25, 6.25, 5.25, 4.5)

# Code from circlize-test-run chunk
# Define some parameters
font_size <- 15 #pt
scale_height <- pt_to_in(1.6 * font_size)
font_family <- "DIN Alternate"
# font_family <- "DIN 1451 fette Breitschrift 1936"
gap_after = stop_angle - start_angle
cell_padding <- c(0.00, 1.00, 0.00, 1.00)

is_save_to_file <- TRUE

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
par(fin = c(dial_outer_edge_dia_in, dial_outer_edge_dia_in),
    pin = c(dial_outer_edge_dia_in, dial_outer_edge_dia_in),
    mar = c(0, 0, 0, 0),
    fig = c(0, 1, 0, 1))

# Create a new frame so RStudio doesn't overplot
plot.new()

# draw a border for printing
# There is another 4% available, check par("usr")
x0 <- 0
x1 <- 1
y0 <- 0
y1 <- 1
lines(x = c(x0, x1), y = c(y0, y0), col = "lightgray") # bottom
lines(x = c(x1, y0), y = c(x1, y1), col = "lightgray") # top
lines(x = c(x0, x0), y = c(y0, y1), col = "lightgray") # left side
lines(x = c(x1, x1), y = c(y0, y1), col = "lightgray") # right side

#
# Add the RPM scales
#
for (i in 1:nrow(dial_scales)) {
  speeds <- dial_scales[[i, "speeds"]]
  xy_canvas_lim <- dial_scales[[i, "xy_canvas_lim"]]
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
                    xlim = c(min(speeds), max(speeds)))

    circos.track(
    ylim = c(0, 1),
    bg.border = "white",
    track.height = convert_length(scale_height, "in"),
    panel.fun = function(x, y) {
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
      circos.lines(
        x = c(speeds[1] - type_adj, speeds[length(speeds)] + type_adj),
        y = c(1, 1),
        baseline = "top",
        col = line_color,
        lwd = line_width
      )
    }
  )

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

cross_mark <- mounting_hole_dia_in / 2
lines(x = c(-cross_mark, cross_mark), y = c(0, 0), col = "lightgray")
lines(x = c(0, 0), y = c(-cross_mark, cross_mark), col = "lightgray")

# Outline for shaft hole
plotrix::draw.circle(c(0), c(0),
                     radius = c(mounting_hole_dia_in / 2, dial_diameter_in / 2),
                     border = c("lightgray", "lightgray"), lty = c(1, 3)
)

# faint boundary for dial
# plotrix::draw.circle(c(0), c(0),
#         radius = c(dial_diameter_in / 2),
#         border = "lightgray", lty = 3)

# Add my info to dial
# par(new = TRUE)

circos.clear

if (is_save_to_file) {
  dev.off()
}
