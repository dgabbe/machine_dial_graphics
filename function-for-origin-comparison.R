mm_to_in <- function(mm) {return(mm * 25.4)}
width <- 3.426
par(mai = c(0.5, 0.5, 0.5, 0.5), xaxs = "i", yaxs = "i")
par(omi = c(0, 0, 0, 0), mfrow = c(2, 2))

compare_coords <- function(title, width = width, x0, x1, y0, y1, origin, scale_factor = 1) {

}


carpenter <- function() {
  range <- c(0, width)
  title <- paste("Carpenter\n(", range[1], "-", range[2], ")")
  plot(
    main = title,
    x = c(range[1], range[2]),
    y = c(range[1], range[2]),
    asp = 1,
    type = "n",
    ann = FALSE,
    xaxs = "i",
    yaxs = "i"
  )
  title(main = title)
  zero <- width / 2
  segments(
    x0 = c(zero - 0.5, zero),
    x1 = c(zero + 0.5, zero),
    y0 = c(zero, zero - 0.5),
    y1 = c(zero, zero + 0.5),
    col = "red"
  )
  text(0, 0.7, adj = 0, labels = explr_graphics(), col = "blue")
}
machinst <- function() {
  range <- c(-width/2, width/2)
  title <- paste("Machinist\n(", range[1], "-", range[2], ")")
  plot(
    main = title,
    x = c(range[1], range[2]),
    y = c(range[1], range[2]),
    asp = 1,
    type = "n",
    ann = FALSE,
    xaxs = "i",
    yaxs = "i"
  )
  title(main = title)
  zero <- 0
  segments(
    x0 = c(zero - 0.5, zero),
    x1 = c(zero + 0.5, zero),
    y0 = c(zero, zero - 0.5),
    y1 = c(zero, zero + 0.5),
    col = "red"
  )
  text(-1.7, -1, adj = 0, labels = explr_graphics(), col = "blue")
}
engineer <- function() {
  range <- c(-1, 1)
  title <- paste("Engineer\n(", range[1], "-", range[2], ")")
  plot(
    main = title,
    x = c(range[1], range[2]),
    y = c(range[1], range[2]),
    asp = 1,
    type = "n",
    ann = FALSE,
    xaxs = "i",
    yaxs = "i"
  )
  title(main = title)
  sf = 2 / width
  zero <- 0
  segments(
    x0 = c(zero - 0.5 * sf, zero),
    x1 = c(zero + 0.5 * sf, zero),
    y0 = c(zero, zero - 0.5 * sf),
    y1 = c(zero, zero + 0.5 * sf),
    col = "red"
  )
  text(-1, -0.6, adj = 0, labels = explr_graphics(), col = "blue")
}

carpenter()
machinst()
engineer()
