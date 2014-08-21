# EDA - Course Project 2 - Plot 6

# Compare emissions from motor vehicle sources in Baltimore City(fips == "24510") with emissions 
#from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

library(plyr)
library(ggplot2)

# Read the data file
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Extract all source codes corresponding to vehicles
SCC.Vehicles <- subset(SCC, grepl("vehicles", SCC.Level.Two, ignore.case=TRUE))
NEI.City <- NEI[NEI$fips=="24510"|NEI$fips=="06037",]

#inner join
data <- merge(SCC.Vehicles, NEI.City, by="SCC")

# Add columnsTranslate Code into City Full Name
data$city[data$fips=="24510"] <- "Baltimore"
data$city[data$fips=="06037"] <- "Los Angeles"

#Plot Data
plotdata<-ddply(data, c("year", "city"),summarize, totalPM25=sum(Emissions))

png(filename = "plot6.png", width = 480, height = 480, units = 'px')
q<-qplot(year, totalPM25, 
         data=plotdata,
         group=city,
         color=city,
         geom = c("line"),
         xlab="year",
         ylab="Total PM25 Emissions",
         main="Comparison in Vehicles Emission, Baltimore City Vs LA County")
q <- q + geom_point(shape=16, size=5) + geom_smooth(color="blue", method="lm")
print(q)
dev.off()