library(circlize)

speeds1 <- c(700, 800, 1000, 1200, 1400, 1600, 1800, 2000, 2235)
speeds2 <- c(480, 600, 800, 1000, 1200, 1400, 1530)
speeds3 <- c(300, 400, 500, 600, 700, 800, 965)
speeds4 <- c(170, 200, 250, 300, 350, 400, 450, 500, 555)
dial_rotation <- 312 # degrees
start_angle <- 270 - (360 - dial_rotation)/2
stop_angle <- 270 + (360 - dial_rotation)/2

circos.clear() # remember to always start w/this call
font_size <- 14 #pt

# Outermost track/highest speeds
circos.par(
  clock.wise = TRUE,
  start.degree = start_angle,
  gap.after = stop_angle - start_angle
)
circos.initialize(factors = "speeds1", xlim = c(min(speeds1), max(speeds1)))
circos.track(ylim = c(0, 1), bg.col = "light blue")
circos.text(speeds1, rep(0.6, length(speeds1)), speeds1, facing = "outside", niceFacing = TRUE, cex = fontsize(font_size), font = 2, family = "serif")
circos.clear()

# Add center mark
lines(x = c(-0.1, 0.1), y = c(0, 0), fg = "lightgray")
lines(x = c(0, 0), y = c(-0.1, 0.1), fg = "lightgray")

# faint boundary for dial and hole for pot shaft
symbols(c(0, 0), c(0, 0),
        circles = c(dial_diameter_in / 2, mounting_hole_dia_in / 2),
        fg = "yellow", add = TRUE)

#circlize:::get_most_inside_radius()

# 2nd highest speeds
par(new = TRUE) # See code for fig 6.4, "Circular Visualization in R", https://jokergoo.github.io/circlize_book/book/advanced-layout.html#arrange-multiple-plots
circos.par(
  canvas.xlim = c(-1.2, 1.2),
  canvas.ylim = c(-1.2, 1.2),
  clock.wise = TRUE,
  start.degree = start_angle,
  gap.after = stop_angle - start_angle
)
circos.initialize(factors = "speeds2",
                  xlim = c(min(speeds2), max(speeds2)))
circos.track(ylim = c(0, 1), bg.col = "yellow",
             panel.fun = function(x, y) {
               circos.text(speeds2, rep(0.6, length(speeds2)), speeds2, facing = "outside", niceFacing = TRUE, cex = fontsize(font_size))
             }
)
circos.clear()

# 3nd highest speeds
par(new = TRUE)
circos.par(
  canvas.xlim = c(-1.4, 1.4),
  canvas.ylim = c(-1.4, 1.4),
  clock.wise = TRUE,
  start.degree = start_angle,
  gap.after = stop_angle - start_angle
)
circos.initialize(factors = "speeds3",
                  xlim = c(min(speeds3), max(speeds3)))
circos.track(ylim = c(0, 1),
             bg.col = "red",
             panel.fun = function(x, y) {
               circos.text(speeds3, rep(0.6, length(speeds3)), speeds3, facing = "outside", niceFacing = TRUE, cex = fontsize(font_size))
             }
)
circos.clear()

# 4th highest speeds
par(new = TRUE)
circos.par(
  canvas.xlim = c(-1.6, 1.6),
  canvas.ylim = c(-1.6, 1.6),
  clock.wise = TRUE,
  start.degree = start_angle,
  gap.after = stop_angle - start_angle
)
circos.initialize(factors = "speeds4",
                  xlim = c(min(speeds4), max(speeds4)))
circos.track(ylim = c(0, 1),
             panel.fun = function(x, y) {
               circos.text(speeds4, rep(0.6, length(speeds4)), speeds4, facing = "outside", niceFacing = TRUE, cex = fontsize(font_size))
             }
)
circos.clear()
