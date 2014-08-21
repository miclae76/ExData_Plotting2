# EDA - Course Project 2 - Plot 5

# Across the United States, how have emissions from vehicle sources changed from 1999-€“2008?

library(plyr)
library(ggplot2)

# Read the data file
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Extract all source codes corresponding to vehicles
SCC.Vehicles <- subset(SCC, grepl("vehicles", SCC.Level.Two, ignore.case=TRUE))
NEI.City <- NEI[NEI$fips=="24510",]

data <- merge(SCC.Vehicles, NEI.City, by="SCC")

#Plot Data
plotdata<-ddply(data, c("year"),summarize, totalPM25=sum(Emissions))

png(filename = "plot5.png", width = 480, height = 480, units = 'px')
q<-qplot(year, totalPM25, 
         data=plotdata, 
         geom = c("point", "line"),
         xlab="year",
         ylab="Total PM25 Emissions",
         main="Evolution Total PM25 - Vehicles in Baltimore City")
print(q)
dev.off()