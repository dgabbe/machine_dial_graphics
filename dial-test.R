suppressPackageStartupMessages(library(circlize))
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
scale_height <- pt_to_in(1.6 * font_size)
font_family <- "DIN Alternate"
# font_family <- "DIN 1451 fette Breitschrift 1936"
gap_after = stop_angle - start_angle
cell_padding <- c(0.00, 1.00, 0.00, 1.00)

#
# Start the dial
#
circos.clear()

#
# Add the scales
#
for (i in 1:nrow(dial_scales)) {
  speeds <- dial_scales[[i, "speeds"]]
  xy_canvas_lim <- dial_scales[[i, "xy_canvas_lim"]]
  bg_color <- dial_scales[[i, "bg_color"]]

  par(new = TRUE) # See code for fig 6.4, "Circular Visualization in R", https://jokergoo.github.io/circlize_book/book/advanced-layout.html#arrange-multiple-plots
  circos.clear() # remember to always start w/this call
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
    bg.border = bg_color,
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
    }
  )

}
circos.clear()

# Add rectangular boundry, add canvas size
# Add dimensional marks
#par(new = TRUE)
par()
cross_mark <- mounting_hole_dia_in / 2
abline(h = -cross_mark:cross_mark, v = -cross_mark:cross_mark)
# lines(x = c(-cross_mark, cross_mark), y = c(0, 0), col = "lightgray")
# lines(x = c(0, 0), y = c(-cross_mark, cross_mark), fg = "lightgray")

# Outline for shaft hole
symbols(c(0), c(0),
        circles = c(mounting_hole_dia_in / 2),
        fg = "red", add = TRUE)

# faint boundary for dial
symbols(c(0), c(0),
        circles = c(dial_diameter_in / 2),
        fg = "lightgray", lty = 3, add = TRUE)



