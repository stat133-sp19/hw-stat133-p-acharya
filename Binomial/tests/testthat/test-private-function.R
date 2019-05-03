# context with one test that groups expectations
context("check_prob, check_trials, check_success")

test_that("checkers work as expected ", {
  prob <- 1
  trials <- 5
  success <- 3

  expect_equal(check_prob(prob), TRUE)
  expect_length(check_prob(prob), 1)
  expect_error(check_prob(-0.5))

  expect_equal(check_trials(trials), TRUE)
  expect_length(check_trials(trials), 1)
  expect_error(check_trials(-0.5))

  expect_equal(check_success(success, trials), TRUE)
  expect_length(check_success(success, trials), 1)
  expect_error(check_success(6, trials))
})

