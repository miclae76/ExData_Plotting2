# EDA - Course Project 2 - Plot 3

library("ggplot2")
library("plyr")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")


#Summarize - Compute Aggregates Emissions PM25 by year
data <- ddply(NEI[which(NEI$fips == "24510"), ], c("type", "year"), summarize, 
              totalPM25=sum(Emissions))

## Open device
png(filename = "plot3.png", width = 480, height = 480, units = 'px')
q<-qplot(year, totalPM25, 
        data=data,
        group=type,
        color=type, 
        geom = c("point", "line"),
        xlab="year",
        ylab="Total PM25 Emissions",
        main="Evolution Total PM 25 by Pollutant Type - Baltimore City")
print(q)
dev.off()