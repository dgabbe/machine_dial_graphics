library(circlize)

circos.clear() # remember to always start w/this call
circos.par(track.height = 1/length(spindle_pulley_diameters),
           clock.wise = TRUE,
           start.degree = start_angle,
           gap.after = stop_angle - start_angle)
circos.initialize(factors = "speeds1", xlim = c(min(speeds1), max(speeds1)))
circos.track(ylim = c(0, 1))
circos.text(speeds1, rep(0.5, length(speeds1)), speeds1, facing = "inside")
circos.info()
