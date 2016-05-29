# Example to windowed a timeseries object and then apply seasonality plots
# install.packages("fma")
library(fma)

############################################################
# Monthly total of people on unemployed benefit in australia
first15 <- window( fma::dole, start=1950, end=1974 )
last15 <- window( fma::dole, start=1975)
par(mfrow=c(2,2))
plot( first15 )
plot( last15)

# plot by month - seasonal plot
# help identify if any seasonality effect exists
seasonplot(first15, year.labels = TRUE, year.labels.left = TRUE, col=1:20, pch=19)
seasonplot(last15, year.labels = TRUE, year.labels.left = TRUE, col=1:20, pch=19)
