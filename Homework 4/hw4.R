library(MASS)
file_path <- "./data_mcycle.txt"
data <- read.table(file_path, header = TRUE)

dfs <- seq(5, 20, by = 0.5)
cv_errors <- numeric(length(dfs))

# Initialize an empty list to store spline fits
splines <- list()

for (i in 1:length(dfs)) {
    splines[[i]] <- smooth.spline(data$time, data$accel, df = dfs[i])
    cv_errors[i] <- splines[[i]]$cv.crit
}

optimal_index <- which.min(cv_errors)
optimal_df <- dfs[optimal_index]
optimal_spline <- splines[[optimal_index]]

# plot (a): Observation points and the optimal smoothing spline fit
dev.copy(png, file = "./hw4_plot_a.png")
plot(data$time, data$accel, pch = 16, cex = 0.5, col = "blue", xlab = "time", ylab = "acceleration")
lines(optimal_spline, col = "red", lwd = 2)
dev.off()

# Plot (b): Observation points and smoothing splines for df = 5, 10, 15
dev.copy(png, file = "./hw4_plot_b.png")
plot(data$times, data$accel, main = "Smoothing Splines (df = 5, 10, 15)", xlab = "Time", ylab = "Acceleration", pch = 20)
colors <- c("red", "green", "blue")
for (df_val in c(5, 10, 15)) {
    spline_fit <- smooth.spline(x = data$times, y = data$accel, df = df_val)
    lines(spline_fit, col = colors[df_val %/% 5])
}
legend("topright", legend = c("df=5", "df=10", "df=15"), col = colors, lty = 1)
dev.off()

# Plot (c): Cross-validation errors against different dfs
dev.copy(png, file = "./hw4_plot_c.png")
plot(dfs, cv_errors, type = "b", main = "Cross-validation Errors for Different dfs", xlab = "Degree of Freedom (df)", ylab = "Cross-validation Error")
dev.off()

# Output the optimal df, lambda, and CV error
cat("Optimal df:", optimal_df, "\nLambda (smoothing parameter):", optimal_spline$spar, "\nCV Error:", optimal_spline$cv.crit)
