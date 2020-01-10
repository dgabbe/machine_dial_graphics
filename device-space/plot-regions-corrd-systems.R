# Draw the various plot parameters, device & user corrdinates

#
# circos.initialize() starts plots with:
#  plot(circos.par("canvas.xlim"), circos.par("canvas.ylim"), type = "n", ann = FALSE, axes = FALSE, asp = 1)
#

dial_outer_edge_dia_in <- 3.426 # 246.67px, width of the flat part of the chasis cover

x <- c(0, dial_outer_edge_dia_in)
y <- c(0, dial_outer_edge_dia_in)

par(mai = rep(0, 4))
plot(x, y, asp = 1, type = "n", ann = FALSE, axes = FALSE)

#par(no.readonly = TRUE)

box_types <- c("plot", "figure", "inner", "outer")
line_type <- c("solid")
box(which = "plot", lty = "solid")
box(which = "figure", col = "red")
box(which = "inner", col = "green")
box(which = "outer", col = "blue")

abline(h = x/2)
abline(v = x/2)
