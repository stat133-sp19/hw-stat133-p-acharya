### Binomial Distribution
The Binomial distribution is perhaps the most famous probability distribution among discrete
random variables. This is the theoretical probability model that we use when calculating
probabilities about the number of successes in a fixed number of random trials performed
under identical conditions (assuming a constant probability of success on each trial).

### Motivation
I come up with the idea to illustrate the concept famously used so that everyone can use it!

### Installation

development version from GitHub:
> #install.packages("devtools") 

install "cointoss" (without vignettes)
>devtools::install_github("gastonstat/cointoss")

install "cointoss" (with vignettes)
> devtools::install_github("gastonstat/cointoss", build_vignettes = TRUE)

### Functions
* bin_choose()
  + calculates the number of combinations in which k successes can occur in n trials
* bin_probability()
  + finds a probability given values of trials, success, and probability
* bin_distribution()
  + finds a probability distribution given values of trials, success, and probability
* plot.bindis()
  + plot the result from bin_distribution()
* bin_cumulative()
  + create a cumulative probability distribution
* plot.bincum()
  + plot the result from bin_cumulative()
* bin_var()
  + Creates an object of trials and success
* print.binvar()
  + Prints the trials and success of bin_var() 
* summary.binvar()
  + summarize the trials and success of bin_var() 
* print.summary.binvar()
  + prints the summarization the trials and success of bin_var() 
* bin_mean()
  + mean given trials and probability of success
* bin_variance()
  + variance given trials and probability of success
* bin_mode()
  + mode given trials and probability of success
* bin_skewness()
  + skewness given trials and probability of success
* bin_kurtosis()
  + kurtosis given trials and probability of success