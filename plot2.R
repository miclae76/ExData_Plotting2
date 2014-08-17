# EDA - Course Project 2 - Plot 2

##Use plyr package for data manipulation : http://cran.r-project.org/web/packages/plyr/plyr.pdf
library("plyr")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")


#Summarize - Compute Aggregates Emissions PM25 by year
data <- ddply(NEI[which(NEI$fips == "24510"), ], c("year"), summarize, 
              sum=sum(Emissions))

## Open device
png(filename = "plot2.png", width = 480, height = 480, units = 'px')

par(pch=16)
plot(data$year, data$sum,
     type="n",
     lab=c(10,5,0),
     xlab="year",
     ylab="total PM2.5 Emission")
lines(data$year, data$sum, type="b", lwd=1.5)

dev.off()