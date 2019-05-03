

# context with one test that groups expectations
context("aux_mean , aux_variance , aux_mode , aux_skewness , aux_kurtosis")

test_that("Check that summary measures are correct", {
  trials <- 10
  probs <- 0.3

  expect_equal(aux_mean(trials, probs), 3)
  expect_equal(aux_mean(-1, probs), -0.3)
  expect_length(aux_mean(trials, probs), 1)

  expect_equal(aux_variance(trials, probs), 2.1)
  expect_equal(aux_variance(-1, probs), -0.21)
  expect_length(aux_variance(trials, probs), 1)

  expect_equal(aux_mode(trials, probs), 3)
  expect_equal(aux_mode(-1, probs), 0)
  expect_length(aux_mode(trials, probs), 1)

  expect_equivalent(aux_skewness(trials, probs), 0.2760262, 0.1)
  expect_equal(aux_skewness(-1, probs), NaN)
  expect_length(aux_skewness(trials, probs), 1)

  expect_equivalent(aux_kurtosis(trials, probs), -0.1238095, 0.1)
  expect_equivalent(aux_kurtosis(-1, probs), 1.24, 0.1)
  expect_length(aux_kurtosis(trials, probs), 1)

})
