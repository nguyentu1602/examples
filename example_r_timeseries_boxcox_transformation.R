# Example of doing a Box-cox transformation on the data

# Box-Cox tranformation include both logarithm and power:
# wt = if( lambda =0 )  log(yt)  : (yt^lambda - 1)/lambda
#
# Then you can back-transform:
#   yt = if( lambda = 0 ) exp(wt)  : (lamda*wt + 1)^(1/lambda)
library(fma)
library(forecast)

# Monthly total of people on unemployed benefit in australia
first15 <- window( fma::dole, start=1950, end=1974 )
par(mfrow=c(3,1))
plot( first15 )

# transformation using Box-Cox
# In R, the forecast::BoxCox.lambda(x) function will choose a lambda for you
lambda <- forecast::BoxCox.lambda(first15)

# Then you can transform the series using Box-cox
bctransformed_series <- forecast::BoxCox(first15, lambda)
plot( bctransformed_series )

# Then you can inverse transform the series - which could be done on the predicted
# series as well
inv_series <- InvBoxCox(bctransformed_series, lambda)
plot( inv_series )

# prove that the inverted series is identical to the original series
print( sum( inv_series - first15 ) < 0.000001 )

