# Modified from http://digitheadslabnotebook.blogspot.com/2012/07/linear-regression-by-gradient-descent.html

a <- runif(1000, -5, 5)
b <- a + rnorm(1000) + 3

built_in_regression <- function() {
  linreg <- lm( b ~ a )
  print(linreg)
  plot(a, b)
  abline(linreg, col='red')
}
built_in_regression()

cost <- function(A, b, x) {
  sum( (A %*% x - b)^2 ) / (2 * length(b))
}

# Hyperparameters
eta <- 0.01
num_iters <- 1000

# History
cost_history <- double(num_iters)
x_history <- list(num_iters)

# Initialize weights
x <- matrix(c(1, 2), nrow=2)

# add a column of 1's for the intercept coefficient
A <- cbind(1, matrix(a))

# gradient descent
for (i in 1:num_iters) {
  error <- (A %*% x - b)
  delta <- t(A) %*% error / length(b)
  x <- x - eta * delta
  cost_history[i] <- cost(A, b, x)
  x_history[[i]] <- x
}

print(x)

# plot data and converging fit
plot(a,b, col=rgb(0.2,0.4,0.6,0.4), main='Linear regression by gradient descent')
for (i in c(1,3,6,10,14,seq(20,num_iters,by=10))) {
  abline(coef=x_history[[i]], col=rgb(0.8,0.0,0,0.3))
}
abline(coef=x, col='blue')