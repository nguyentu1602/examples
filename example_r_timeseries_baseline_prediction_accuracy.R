# Example to load a timeseries and use baseline forecast ------------------
# Calculate different accuracy measures
# Residual analysis, test autocorrelation

# IBM close ---------------------------------------------------------------
install.packages("fma")
require(fma)
mdata <- fma::ibmclose
train <- window(mdata, end=300)
test <- window(mdata, start=301)

par(mfrow=c(2,1))
plot(mdata)
plot(train)
plot(test)

# Plot the train set and various baseline prediction ----------------------
plot( train , main = "IBM daily close", xlab="Day", xlim=c(2, length(mdata)), ylim = c(300, 600), type="l")

# use the average over the whole period, the last price in train, and then the extension of the first and last point
lines( y=meanf(train, h=length(test))$mean, x= seq(length(train), by = 1, length.out = length(test)), col=4 )
lines( y=rwf(train, h=length(test))$mean, x= seq(length(train), by = 1, length.out = length(test)), col=2 )
lines( y=rwf(train, drift=TRUE, h=length(test))$mean, x= seq(length(train), by = 1, length.out = length(test)), col=3 )

legend( "bottomleft", lty=1, col=c(4,2,3), legend=c("Mean method", "Naive Method", "Drift Method"))

# Show that the drift is just an extension of the line connecting the first and last points
segments(x0=0, y0=train[1], x1=length(train), y1=train[length(train)], col=19)

# Add back the test set to compare:
lines( y=test, x= seq(length(train) + 1, by = 1, length.out = length(test)), col=1 )


# calculate different accuracy measures -----------------------------------
forecast::accuracy(forecast::meanf(train, h=length(test)), test)
forecast::accuracy(forecast::rwf(train, h=length(test)), test)
forecast::accuracy(forecast::rwf(ibm_y, h=length(test), drift=TRUE), test)


# Residuals analysis ------------------------------------------------------
res <- residuals(naive(test))
plot( res, type="l")
hist( res, nclass = "FD")

# Testing the residuals for autocorrelation
Acf( res )

# Portmanteau tests for autocorrelation:
Box.test(res, lag=10, fitdf=0 )
Box.test(res, lag=10, fitdf=0, type = "Lj")


