test_that("gamma_mle_nr estimates parameters correctly", {
  set.seed(1234)
  x <- rgamma(100, shape = 5, scale = 2)

  res <- gamma_mle_nr(x, max_iter = 1000, tol = 1e-10)

  alpha_est <- res$alpha
  beta_est <- res$beta

  # Print results
  cat(sprintf(
    "Estimated parameters:\n  alpha: %.4f\n  beta: %.4f\n",
    alpha_est, beta_est
  ))

  expect_true(abs(alpha_est - 5) < 1)  # Check alpha
  expect_true(abs(beta_est - 2) < 1)   # Check beta
})
