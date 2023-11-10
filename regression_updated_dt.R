# Simple linear regression in R
#Use Schoenemann data again

# Read in the data
# Read in the data. Change this directory to the location where the Schoenemann.csv file
# has been downloaded to on your computer
sch.df <-read.csv("C:/Users/derek/Work/Teaching/BIOL 4062/example data/Schoenemann.csv",header=T)

# Summarize the data  
summary(sch.df)

# Log-transform data and add to the data frame
sch.df$lFat <- log(sch.df$Fat)
sch.df$lCNS <- log(sch.df$CNS)
sch.df$lMass <- log(sch.df$Mass)
sch.df$lMuscle <-log(sch.df$Muscle)

# Attach the data frame for ease of access
attach(sch.df)

# Simple linear regression of CNS on body fat
model1 <-lm(lCNS ~ lFat)
summary(model1)

# Examine residuals & fitted values
residuals(model1)
fitted(model1)
plot(fitted(model1),residuals(model1), xlab = "Expected values", ylab = "Residuals", pch = 19)
abline(0,0, lty = 2)

# Plot a smoothed line (lowess smoother) to visualise linearity
lines(lowess(fitted(model1),residuals(model1), f = 2/3, iter = 3), col = "red")

# Then test for linearity using the resettest described in class
# This package is useful for applying lots of the statistical tests described in the lecture
library(lmtest)
resettest(model1)

# Or, plot it for lots of useful diagnostics on e.g. leverage
# Note that the first plot is identical to the one above that we made from scratch
dev.new()
plot(model1)

# Plot to check for normality
qqnorm(residuals(model1))

# Test to check for normality
shapiro.test(residuals(model1))

# Test to check for homoscedasticity
bptest(model1)

# Durbin-Watson test for independence. 
dwtest(lCNS~lFat) #Durbin-Watson test

plot(residuals(model1))
lines(residuals(model1),lty=2)

# Autocorrelation analysis
acf(residuals(model1))
