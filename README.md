
# GammaMLE

The **GammaMLE** package provides tools for estimating the parameters of
a Gamma distribution using the Newton-Raphson algorithm for Maximum
Likelihood Estimation (MLE). It also includes a function to visualize
the fitted distribution and the observed data.

## Features

- **`gamma_mle_nr`**: Implements the Newton-Raphson algorithm for
  estimating the shape (`alpha`) and scale (`beta`) parameters of a
  Gamma distribution.
- **`plot_gamma_fit`**: Visualizes the observed data as a histogram with
  the fitted Gamma distribution density curve overlayed.

## Installation

You can install the development version of `GammaMLE` from GitHub as
follows:

``` r
# install.packages("devtools")
devtools::install_github("your-username/GammaMLE")
```

Replace `your-username` with your GitHub username.

## Usage Example

### Maximum Likelihood Estimation

This example demonstrates how to estimate the parameters of a Gamma
distribution using the `gamma_mle_nr` function:

``` r
library(GammaMLE)

# Generate random data from a Gamma distribution
set.seed(1234)
x <- rgamma(100, shape = 5, scale = 2)

# Estimate parameters using Newton-Raphson MLE
res <- gamma_mle_nr(x, max_iter = 1000, tol = 1e-10)
print(res)
```

### Visualizing the Fitted Distribution

``` r
# Extract estimated parameters
alpha_est <- res$alpha
beta_est <- res$beta
# Plot histogram with fitted density curve
plot_gamma_fit(x, alpha_est, beta_est)
```

The resulting plot includes:

- A histogram of the data (`x`).
- The fitted Gamma density curve using the estimated parameters.

## Contributing

If you’d like to contribute to `GammaMLE`, feel free to fork the
repository and submit a pull request. Bug reports and feature requests
are welcome via the Issues tab on GitHub.

## License

This project is licensed under the MIT License - see the LICENSE file
for details.
