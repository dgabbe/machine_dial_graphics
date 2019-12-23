suppressPackageStartupMessages(library(circlize))

mm_to_in <- function(mm) {return(mm / 25.4)}
pt_to_in <- function(pt) {return(pt / 72)}

speeds1 <- c(700, 800, 1000, 1200, 1400, 1600, 1800, 2000, 2235)
speeds2 <- c(480, 600, 800, 1000, 1200, 1400, 1530)
speeds3 <- c(300, 400, 500, 600, 700, 800, 965)
speeds4 <- c(170, 200, 250, 300, 350, 400, 450, 500, 555)

mounting_hole_dia_in <- 0.375
dial_outer_edge_dia_in <- 3.426
dial_gap_mm <- 2 # leave space around outside of dial
dial_diameter_in <- mm_to_in(45 + 2 * dial_gap_mm)
dial_rotation <- 312 # degrees
start_angle <- 270 - (360 - dial_rotation)/2
stop_angle <- 270 + (360 - dial_rotation)/2
spindle_pulley_diameters <- c(7.25, 6.25, 5.25, 4.5)

# Code from circlize-test-run chunk
# Define some parameters
font_size <- 15 #pt
scale_height <-
  (dial_outer_edge_dia_in - dial_diameter_in) / length(spindle_pulley_diameters)
gap_after = stop_angle - start_angle
cell_padding <- c(0.00, 1.00, 0.00, 1.00)

# Start the dial
# circos.clear() # remember to always start w/this call
circos.par(
  clock.wise = TRUE,
  start.degree = start_angle,
  gap.after = gap_after,
  cell.padding = cell_padding
)

# Outermost track/highest speeds
circos.initialize(factors = "speeds1", xlim = c(min(speeds1), max(speeds1)))
circos.track(
  ylim = c(0, 1),
  bg.border = "light blue",
  track.height = convert_length(scale_height, "in")
)
circos.text(speeds1, rep(0.5, length(speeds1)), speeds1, facing = "outside", niceFacing = TRUE, cex = fontsize(font_size), font = 2, family = "serif")
circos.clear()

# plot exists at this point.
# Add center mark
# par(new = TRUE)
lines(x = c(-0.1, 0.1), y = c(0, 0), fg = "lightgray")
lines(x = c(0, 0), y = c(-0.1, 0.1), fg = "lightgray")

# faint boundary for dial and shaft
symbols(c(0, 0), c(0, 0),
        circles = c(dial_diameter_in / 2, mounting_hole_dia_in / 2),
        fg = "lightgray", add = TRUE)

#circlize:::get_most_inside_radius() # For better setting canvas limits

# 2nd highest speeds
par(new = TRUE) # See code for fig 6.4, "Circular Visualization in R", https://jokergoo.github.io/circlize_book/book/advanced-layout.html#arrange-multiple-plots
xy_canvas_lim <- 1.16
circos.par(
  canvas.xlim = c(-xy_canvas_lim, xy_canvas_lim),
  canvas.ylim = c(-xy_canvas_lim, xy_canvas_lim),
  clock.wise = TRUE,
  start.degree = start_angle,
  gap.after = gap_after,
  cell.padding = cell_padding
)
circos.initialize(factors = "speeds2",
                  xlim = c(min(speeds2), max(speeds2)))
circos.track(
  ylim = c(0, 1),
  bg.border = "yellow",
  track.height = convert_length(scale_height, "in"),
  panel.fun = function(x, y) {
    circos.text(
      speeds2,
      rep(0.5, length(speeds2)),
      speeds2,
      facing = "outside",
      niceFacing = TRUE,
      cex = fontsize(font_size),
      font = 2,
      family = "serif"
    )
  }
)
circos.par()
circos.clear()

# 3nd highest speeds
par(new = TRUE)
xy_canvas_lim <- 1.4
circos.par(
  canvas.xlim = c(-xy_canvas_lim, xy_canvas_lim),
  canvas.ylim = c(-xy_canvas_lim, xy_canvas_lim),
  clock.wise = TRUE,
  start.degree = start_angle,
  gap.after = gap_after,
  cell.padding = cell_padding
)
circos.initialize(factors = "speeds3",
                  xlim = c(min(speeds3), max(speeds3)))
circos.track(
  ylim = c(0, 1),
  bg.border = "red",
  track.height = convert_length(scale_height, "in"),
  panel.fun = function(x, y) {
    circos.text(
      speeds3,
      rep(0.5, length(speeds3)),
      speeds3,
      facing = "outside",
      niceFacing = TRUE,
      cex = fontsize(font_size),
      font = 2,
      family = "serif"
    )
  }
)
circos.clear()

# 4th highest speeds
par(new = TRUE)
xy_canvas_lim <- 1.75
circos.par(
  canvas.xlim = c(-xy_canvas_lim, xy_canvas_lim),
  canvas.ylim = c(-xy_canvas_lim, xy_canvas_lim),
  clock.wise = TRUE,
  start.degree = start_angle,
  gap.after = gap_after,
  cell.padding = cell_padding
)
circos.initialize(factors = "speeds4",
                  xlim = c(min(speeds4), max(speeds4)))
circos.track(
  ylim = c(0, 1),
  bg.border = "purple",
  track.height = convert_length(scale_height, "in"),
  panel.fun = function(x, y) {
    circos.text(
      speeds4,
      rep(0.5, length(speeds4)),
      speeds4,
      facing = "outside",
      niceFacing = TRUE,
      cex = fontsize(font_size),
      font = 2,
      family = "serif"
    )
  }
)
circos.clear()

