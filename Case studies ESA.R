# ---
# `Case Studies on Event Study Analysis (ESA)`
# ---

###################################################
# Installing and Loading required Libraries
###################################################

install.packages(c("quantmod", "PerformanceAnalytics", "tidyverse", "tseries"))
library(quantmod)
library(PerformanceAnalytics)
library(tidyverse)
library(tseries)

##################################################################
# Defining the Event and estimation window and collecting required data
##################################################################

event_date <- as.Date("2020-11-08")  # Merger announcemnet by Reliance Industry
event_window <- 10       # 10 days before and after
estimation_window <- 60  # 60 days before event window

# collecting stocks and market index data
getSymbols(c("RELIANCE.NS", "^NSEI"), src = "yahoo", from = "2020-01-01", to = "2020-12-31")

##################################################################
# Data transformation
##################################################################

# Adjusted price for stocks and markets
stock_prices <- Ad(RELIANCE.NS)
market_prices <- Ad(NSEI)

# Compute daily returns 
stock_returns <- dailyReturn(stock_prices)
market_returns <- dailyReturn(market_prices)

plot(stock_returns)
plot(market_returns)

##################################################################
# Calculating Normal and Abnormal returns
##################################################################

# Filter data for estimation window
estimation_start <- event_date - estimation_window
estimation_end <- event_date - event_window - 1

# Subset data for estimation period
estimation_stock <- stock_returns[index(stock_returns) >= estimation_start & index(stock_returns) <= estimation_end]
estimation_market <- market_returns[index(market_returns) >= estimation_start & index(market_returns) <= estimation_end]

# Fit data for estimation period
market_model <- lm(estimation_stock ~ estimation_market)

# Get alpha and beta from the model 
alpha <- coef(market_model)[1]
beta <- coef(market_model)[2]

# Calculating Abnormal Returns in event window
event_start <- event_date - event_window
event_end <- event_date + event_window

event_stock <- stock_returns[index(stock_returns) >= event_start & index(stock_returns) <= event_end]
event_market <- market_returns[index(market_returns) >= event_start & index(market_returns) <= event_end]

expected_returns <- alpha + beta * event_market
abnormal_returns <- event_stock - expected_returns

##################################################################
# Calculating cumulative Abnormal returns
##################################################################

# Calculate cumulative abnormal returns (CAR)
cumulative_abnormal_returns <- cumsum(abnormal_returns)


##################################################################
# Visualizing Abnormal and Cumulative Abnormal returns
##################################################################

# plot ARs and CARs
plot(index(abnormal_returns), abnormal_returns, type = "h", col = "blue",
     main = "Abnormal Returns Around Event",
     xlab = "Date", ylab = "Abnormal Returns")
abline(h = 0, col = "red", lty = 2)

plot(index(cumulative_abnormal_returns), cumulative_abnormal_returns, type = "l", col = "green",
     main = "cumulative Abnormal Returns (CAR)",
     xlab = "Date", ylab = "Cumulative Abnormal Returns")
abline(h = 0, col = "red", lty = 2)


##################################################################
# Significance testing / Null Hypothesis testing for abnormal returns
##################################################################

# now we test whether these returns are sig or not

# Mean and sd of abnormal returns
mean_ar <- mean(abnormal_returns, na.rm = TRUE)
sd_ar <- sd(abnormal_returns, na.rm = TRUE)
n_ar <- length(abnormal_returns)

# T-Statistic calculation
t_stat <- mean_ar / (sd_ar / sqrt(n_ar))

# Perform one sample test
t_test_result <- t.test(abnormal_returns, mu = 0)

# Print results
cat("Mean of ARs:", mean_ar, "\n")
cat("Standard Deviation of ARs:", sd_ar, "\n")
cat("T-Statistic:", t_stat, "\n")
cat("P-value:", t_test_result$p.value, "\n")

# Check the significance
# H0: AR=0
if (t_test_result$p.value < 0.05) {
  cat("Reject the nul hypothesis: AR are significantly different from zero.\n")
} else {
  cat("Fail to reject the null hypothesis: AR are significantly different from zero.\n")
} 


##################################################################
# Significance testing / Null Hypothesis testing for  cumulative abnormal returns
##################################################################

# Mean and sd of abnormal returns
mean_car <- mean(cumulative_abnormal_returns, na.rm = TRUE)
sd_car <- sd(cumulative_abnormal_returns, na.rm = TRUE)
n_car <- length(cumulative_abnormal_returns)

# T-Statistic calculation
t_stat_car <- mean_car / (sd_car / sqrt(n_car))

# Performance one-sample t-test
t_test_result_car <- t.test(cumulative_abnormal_returns, mu = 0)

# Print results
cat("Mean of CARs:", mean_car, "\n")
cat("Standard Deviation of CARs:", sd_car, "\n")
cat("T-statistic (CAR):", t_stat_car, "\n")
cat("P-value (CAR):", t_test_result_car$p.value, "\n")

# Check significance
if (t_test_result_car$p.value < 0.05) {
  cat("Reject the nul hypothesis: CAR are significantly different from zero.\n")
} else {
  cat("Fail to reject the null hypothesis: CAR are significantly different from zero.\n")
}
# ----- Interpretation -----
# - since the p-val < 0.05, CAR are significantly different from zero
# - conclude that event has significant effect on cumulative abnormal returns
# - negative effct (mean = -0.03682665)
# - Announcement of merger has negative impact on the stock returns
