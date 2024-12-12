#' Plot Gamma Distribution Fit
#'
#' This function generates a histogram of the data and overlays the fitted Gamma distribution density curve.
#'
#' @param x A numeric vector representing the data.
#' @param alpha_est The estimated shape parameter of the Gamma distribution.
#' @param beta_est The estimated scale parameter of the Gamma distribution.
#' @return A ggplot object showing the histogram and the fitted Gamma distribution.
#' @examples
#' set.seed(1234)
#' x <- rgamma(100, shape = 5, scale = 2)
#' alpha_est <- 5
#' beta_est <- 2
#' plot_gamma_fit(x, alpha_est, beta_est)
#' @export
plot_gamma_fit <- function(x, alpha_est, beta_est) {
  if (!is.numeric(x)) stop("Input must be a numeric vector.")
  if (length(alpha_est) != 1 || length(beta_est) != 1)
    stop("alpha_est and beta_est must be single numeric values.")

  # Plot histogram
  hist(x, breaks = 15, probability = TRUE, col = "lightblue",
       main = "Histogram and Fitted Gamma Distribution",
       xlab = "x", ylab = "Density")

  # Overlay Gamma density curve
  curve(dgamma(x, shape = alpha_est, scale = beta_est),
        col = "red", lwd = 2, add = TRUE)

  # Add legend
  legend("topright", legend = c("Fitted Gamma Distribution"),
         col = c("red"), lwd = c(2), bty = "n")
}
