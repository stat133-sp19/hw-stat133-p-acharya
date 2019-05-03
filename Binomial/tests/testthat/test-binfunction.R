# context with one test that groups expectations
context("bin_mean , bin_variance , bin_mode , bin_skewness , bin_kurtosis")

test_that("Check that binomial measures are correct", {
  trials <- 10
  probs <- 0.3

  expect_equal(bin_mean(trials, probs), 3)
  expect_error(bin_mean(-1, probs))
  expect_length(bin_mean(trials, probs), 1)

  expect_equal(bin_variance(trials, probs), 2.1)
  expect_error(bin_variance(-1, probs))
  expect_length(bin_variance(trials, probs), 1)

  expect_equal(bin_mode(trials, probs), 3)
  expect_error(bin_mode(-1, probs))
  expect_length(bin_mode(trials, probs), 1)

  expect_equivalent(bin_skewness(trials, probs), 0.2760262, 0.1)
  expect_error(bin_skewness(-1, probs))
  expect_length(bin_skewness(trials, probs), 1)

  expect_equivalent(bin_kurtosis(trials, probs), -0.1238095, 0.1)
  expect_error(bin_kurtosis(-1, probs))
  expect_length(bin_kurtosis(trials, probs), 1)


})

