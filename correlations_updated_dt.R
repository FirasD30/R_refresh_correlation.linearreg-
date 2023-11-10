# R examples for Correlation
# Download Schoenemann.csv to your computer from Brightspace/Example files
# Note that you will also need to install the ppcor library from CRAN

# Read in the data. Change this directory to the location where the Schoenemann.csv file
# has been downloaded to on your computer
sch.df <-read.csv("C:/Users/firas/OneDrive/Desktop/BIOL4062/2_Correlation and linear reg/Data/Schoenemann.csv",header=T)
  
# Summarize the data  
summary(sch.df)

# Log-transform data and add to the data frame
sch.df$lFat <- log(sch.df$Fat)
sch.df$lCNS <- log(sch.df$CNS)
sch.df$lMass <- log(sch.df$Mass)
sch.df$lMuscle <-log(sch.df$Muscle)

# Attach the data frame for ease of access
attach(sch.df)


# Plot and visualise the data. Note the log scale
plot(CNS ~ Muscle, log="xy",ylab="CNS",xlab="Fat/Muscle",col="black",pch=19)
points(CNS ~ Fat, col="red",pch=20)
legend("topleft",legend=c("Muscle","Fat"),col=c("black","red"),pch=19:20)



# Make scatterplot
# Remove non log-transformed data first, to make it more interpretable
summary(sch.df)
sch.df <- sch.df[,-c(1:12)]
summary(sch.df)
plot(sch.df)

# Correlation. Default is pearson. This is useful for examining the correlations
# between all of your variables
cor(sch.df)
cor(sch.df,method = "spearman")

# Now do a NHST on correlations to get a p-value
cor.test(lCNS,lFat,method = "pearson")

# Partial correlation between lCns and lFat controlling for lMass
# Firstly the hard way
corm <- cor(sch.df)
corlCNSlFat <- (corm[1,2]-corm[1,3]*corm[2,3])/sqrt((1-corm[1,3]^2)*(1-corm[2,3]^2))
print(corlCNSlFat)

# Now the easy way. Note that we are restricting to just 3 columns of the matrix
# to match the example above
library(ppcor)
pcor(sch.df)
pcor(sch.df[,c(1,2,3)])
print(pcor(sch.df[,c(1,2,3)])$estimate[1,2])


# Semi-partial correlation between lCns and lMuscle controlling lMuscle for lMass
(corm[1,4]-corm[1,3]*corm[4,3])/sqrt(1-corm[4,3]^2)