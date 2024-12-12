#' Maximum Likelihood Estimation for Gamma Distribution Parameters
#'
#' Implements the Newton-Raphson algorithm for maximum likelihood estimation (MLE)
#' of the parameters of a Gamma distribution.
#'
#' @param x A numeric vector of data points.
#' @param max_iter The maximum number of iterations for the Newton-Raphson algorithm. Default is 1000.
#' @param tol The convergence tolerance for the parameter estimates. Default is 1e-10.
#' @return A list containing:
#' \describe{
#'   \item{alpha}{The estimated shape parameter of the Gamma distribution.}
#'   \item{beta}{The estimated scale parameter of the Gamma distribution.}
#'   \item{lhood}{The value of the log-likelihood function at the estimated parameters.}
#' }
#' @examples
#' set.seed(1234)
#' x <- rgamma(100, shape = 5, scale = 2)
#' res <- gamma_mle_nr(x, max_iter = 1000, tol = 1e-10)
#' print(res)
#' @export
gamma_mle_nr <- function (x, max_iter = 1000, tol = 1e-10) {
  # sufficient statistics
  xbar <- mean(x)
  logxbar <- mean(log(x))
  n <- length(x)

  # Initial estimates via method of moments
  beta <- var(x) / xbar
  alpha <- xbar / beta
  param <- c(alpha, beta)

  # Log-likelihood
  lhood <- n*(-alpha*log(beta) - lgamma(alpha) + (alpha-1)*logxbar - xbar/beta)

  # Newton-Raphson iterations
  for (i in 1:max_iter) {
    # Gradient and Hessian
    alpha_grad1 <- n*(logxbar - log(beta) - digamma(alpha))
    beta_grad1 <- n*(xbar/beta^2 - alpha/beta)

    alpha_grad2 <- -n*trigamma(alpha)
    beta_grad2 <- -n*(2*xbar/beta^3 + alpha/beta^2)
    alpha_beta_grad <- -n/beta

    gradient <- c(alpha_grad1, beta_grad1)
    Hessian <- matrix(c(alpha_grad2, alpha_beta_grad,
                        alpha_beta_grad, beta_grad2), nrow=2)

    I = -Hessian
    I_inv = solve(I)

    param_new <- param + I_inv %*% gradient
    alpha_new <- param_new[1]
    beta_new <- param_new[2]

    criterio <- sqrt(t(param_new-param)%*%(param_new-param))
    message("[", i, "] alpha = ", alpha_new, " | beta = ", beta_new, " | criterio = ", criterio)

    if (criterio < tol) break

    alpha <- alpha_new
    beta <- beta_new
    param <- param_new
  }

  list(alpha = alpha, beta = beta, lhood = lhood)
}
