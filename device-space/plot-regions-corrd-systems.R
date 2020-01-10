# Draw the various plot parameters, device & user corrdinates

#
# circos.initialize() starts plots with:
#  plot(circos.par("canvas.xlim"), circos.par("canvas.ylim"), type = "n", ann = FALSE, axes = FALSE, asp = 1)
#

dial_outer_edge_dia_in <- 3.426 # 246.67px, width of the flat part of the chasis cover
center <- dial_outer_edge_dia_in / 2
mounting_hole_dia_in <- 0.375
mounting_hole_rad <- mounting_hole_dia_in / 2
dial_diameter_in <- 1.929

x <- c(0, dial_outer_edge_dia_in)
y <- c(0, dial_outer_edge_dia_in)
# x <- c(0, 1)
# y <- c(0, 1)

# Setup parameters for plots
par(mai = rep(0, 4))

# Create a plot, in this case, an empty one
plot(x, y, asp = 1, type = "n", ann = FALSE, axes = FALSE)

#explr_graphics()
#par(no.readonly = TRUE)

box_types <- c("plot", "figure", "inner", "outer")
line_type <- c("solid")
box(which = "plot", lty = "solid")
box(which = "figure", col = "red")
box(which = "inner", col = "green")
box(which = "outer", col = "blue")

par(new = TRUE)
plot(c(-center, center), c(-center, center),
     asp = 1,
     type = "n",
     ann = FALSE,
     axes = FALSE
)

lines(c(-mounting_hole_rad - 0.06, mounting_hole_rad + 0.06), c(0, 0))
lines(c(0, 0), c(-mounting_hole_rad - 0.06, mounting_hole_rad + 0.06))

plotrix::draw.circle(
  0, 0,
  radius = mounting_hole_rad,
  border = "lightgray", lty = 1
)

plotrix::draw.circle(
  0, 0,
  radius = dial_diameter_in / 2,
  border = "lightgray", lty = 3
)
