
check_prob <- function(prob) {
  if (prob >= 0 && prob <= 1) {
    return (TRUE)
  } else {
    stop("invalid prob value")
  }
}

check_trials <- function(trials) {
  if (trials >= 0) {
    return (TRUE)
  } else {
    stop("invalid trials value")
  }
}

check_success <- function(success, trials) {
  result <- success <= trials
  if (all(result)) {
    return (TRUE)
  } else {
    stop("invalid success value")
  }
}

aux_mean <- function(trials, prob) {
  return (trials * prob)
}

aux_variance <- function(trials, prob) {
  return ((trials*prob) * (1- prob))
}

aux_mode <- function(trials, prob) {
  return (floor(trials * prob + prob))
}

aux_skewness <- function(trials, prob) {
  return ((1 - 2*prob)/(sqrt((trials * prob)*(1- prob))))
}

aux_kurtosis <- function(trials, prob) {
  kurtosis = (1-(6*prob*(1-prob)))/(trials*prob*(1-prob))
  return(kurtosis)
}

#' @title bin_choose
#' @description calculates prob
#' @param n a number
#' @param k a number or vector
#'
#' @return a number
#' @export
#'
#' @examples
#' bin_choose(n = 5, k = 2)
#' bin_choose(5, 0)
#' bin_choose(5, 1:3)
bin_choose <- function(n, k) {
  if (any(n > k)) {
    return (factorial(n)/(factorial(k)*factorial(n-k)))
  } else {
    stop("k cannot be greater than n")
  }
}


#' @title bin_prob
#' @description calculates prob
#' @param success a number
#' @param trials a number
#' @param prob a number
#'
#' @return a number, binomial probability
#' @export
#'
#' @examples
#' bin_probability(success = 2, trials = 5, prob = 0.5)
#' bin_probability(success = 0:2, trials = 5, prob = 0.5)
#' bin_probability(success = 55, trials = 100, prob = 0.45)

bin_probability <- function(success, trials, prob) {
  if (check_trials(trials) && check_prob(prob) && check_success(success, trials)) {
    bin_choose(trials, success)*prob^(success)*(1-prob)^(trials-success)
  } else {
    stop("invalid argument values")
  }
}




#' @title bin_distribution
#' @description calculates distribution
#' @param trials a number
#' @param prob a number
#'
#' @return a dataframe
#' @export
#'
#' @examples
#' bin_distribution(trials = 5, prob = 0.5)

bin_distribution <- function(trials, prob) {
  success <- 0:trials
  probability <- bin_probability(success, trials, prob)
  returndata <- data.frame('success' = success, 'probability' = probability)
  class(returndata) <-  c("bindis",
                          "data.frame")
  return (returndata)
}




#' Title
#' @import ggplot2
#' @export
plot.bindis <- function(bindis) {
  ggplot(data = bindis, mapping = aes(x = success, y = probability)) +
    geom_bar(stat = "identity")
  # return (barplot(xlab = bindis$success, ylab = bindis$probability))
}




#' @title bin_cum
#' @description calculates cummulative prob
#' @param trials a number
#' @param prob a number
#'
#' @return a number
#' @export
#'
#' @examples bin_cumulative(trials = 5, prob = 0.5)

bin_cumulative <- function(trials, prob) {
  success <- 0:trials
  probability <- bin_probability(success, trials, prob)
  cumulative <- cumsum(probability)
  returndata <- data.frame('success' = success, 'probability' = probability, 'cumulative' = cumulative)
  class(returndata) <-  c("bincum",
                          "data.frame")
  return (returndata)
}




#' Title
#'
#' @export
plot.bincum <- function(bincum) {
  abc <- plot(bincum$success, bincum$cumulative, xlab = "success", ylab = "probability", type = "o")
  return (abc)
}

#' @title bin_var
#' @description returns a data frame of probs
#' @param trialsa number
#' @param prob a number
#'
#' @return returns a binvar
#' @export
#'
#' @examples bin1 <- bin_variable(trials = 10, p = 0.3)

bin_variable <- function(trials, prob) {
  if (check_trials(trials) && check_prob(prob)) {
    returndata <- data.frame('trials' = trials, 'prob' = prob)
    class(returndata) <-  c("binvar",
                            "data.frame")
    return (returndata)
  }
}



#' Title
#'
#' @export
print.binvar <- function(X) {
  cat("Binomial variable")

  cat("\n\n", append = TRUE)
  cat("Parameters", append = TRUE)
  cat("\n - number of trials: ", X$trials, append = TRUE)
  cat("\n - prob of success : ", X$prob, "\n", append = TRUE)
}


#' @export
print.summary.binvar <- function(X) {
  mean <- aux_mean(X$trials, X$prob)
  variance <- aux_variance(X$trials, X$prob)
  mode <- aux_mode(X$trials, X$prob)
  skewness <- aux_skewness(X$trials, X$prob)
  kurtosis <- aux_kurtosis(X$trials, X$prob)

  cat("Summary variable")

  cat("\n\n", append = TRUE)
  cat("Parameters", append = TRUE)
  cat("\n - number of trials: ", X$trials, append = TRUE)
  cat("\n - prob of success : ", X$prob, "\n", append = TRUE)

  cat("\n\n", append = TRUE)
  cat("Measures", append = TRUE)
  cat("\n - mean: ", mean, append = TRUE)
  cat("\n - variance : ", variance, append = TRUE)
  cat("\n - mode: ", mode, append = TRUE)
  cat("\n - skewness: ", skewness, append = TRUE)
  cat("\n - kurtosis: ", kurtosis, "\n", append = TRUE)
}




#' Title
#' @title mean
#' @param trials a number
#' @param prob a numer
#' @return mean
#' @export
bin_mean <- function(trials, prob) {
  if (check_trials(trials) && check_prob(prob)) {
    return (aux_mean(trials, prob))
  }
}

#' Title
#' @title variance
#' @param trials a number
#' @param prob a numer
#' @return variance
#' @export
bin_variance <- function(trials, prob) {
  if (check_trials(trials) && check_prob(prob)) {
    return (aux_variance(trials, prob))
  }
}

#' Title
#' @title mode
#' @param trials a number
#' @param prob a numer
#' @return mode
#' @export
bin_mode <- function(trials, prob) {
  if (check_trials(trials) && check_prob(prob)) {
    return (aux_mode(trials, prob))
  }
}

#' Title
#' @title skewness
#' @param trials a number
#' @param prob a numer
#' @return skewness
#' @export
bin_skewness <- function(trials, prob) {
  if (check_trials(trials) && check_prob(prob)) {
    return (aux_skewness(trials, prob))
  }
}

#' Title
#' @title kurtosis
#' @param trials a number
#' @param prob a numer
#' @return kurtosis
#' @export
bin_kurtosis <- function(trials, prob) {
  if (check_trials(trials) && check_prob(prob)) {
    return (aux_kurtosis(trials, prob))
  }
}


