# Example of dividing by numday in months to account for the fact that
# each month have different number of days

##############################################
# Monthly total of accidental deaths in the US
library(fma)
plot( fma::usdeaths )
length( fma::usdeaths ) # 72 / 12 it's 6 years

# account for the different month-length effect:
monthdays <- rep(c(31,28,31,30,31,30,31,31,30,31,30,31), 6)
# account for leap year
monthdays[38] <- 29
usdeaths_per_day <- fma::usdeaths/monthdays

par(mfrow=c(2,2))
plot( fma::usdeaths )
plot( usdeaths_per_day )
# plot by month - seasonal plot

seasonplot(fma::usdeaths, year.labels = TRUE, year.labels.left = TRUE, col=1:20, pch=19)
seasonplot(usdeaths_per_day, year.labels = TRUE, year.labels.left = TRUE, col=1:20, pch=19)

