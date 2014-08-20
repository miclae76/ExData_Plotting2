# EDA - Course Project 2 - Plot 4

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-€“2008?

library(plyr)
library(ggplot2)

# Read the data file
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Extract all source codes corresponding to coal combustion , required logical value then I used
# grepl to return a logical vector (match or not for each element of x).
SCC.Comb <- subset(SCC, grepl("Combustion", SCC.Level.One, ignore.case=TRUE))
SCC.CombCoal <- subset(SCC.Comb, grepl("Coal", SCC.Level.Three, ignore.case=TRUE))

# inner join NEI with combustion coal subset
NEI.CombCoal <- merge(SCC.CombCoal, NEI, by="SCC")

#Summarize - Compute Aggregates Emissions PM25 by year
data <- ddply(NEI.CombCoal, c("type", "year"), summarize, totalPM25=sum(Emissions))

png(filename = "plot4.png", width = 480, height = 480, units = 'px')
q<-qplot(year, totalPM25, 
         data=data,
         group=type,
         color=type, 
         geom = c("point", "line"),
         xlab="year",
         ylab="Total PM25 Emissions",
         main="Evolution Total PM 25 by Pollutant Type - Combustion Coal")
print(q)
dev.off()
