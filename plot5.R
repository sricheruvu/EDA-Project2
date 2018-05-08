rm(list=ls())
library("data.table")
library("ggplot2")

setwd("C:/Users/Niyati/Documents/GitHub/ExploratoryDataAnalysis/Project2")

SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

# Gather the subset of the NEI data which corresponds to vehicles
vehiclesSCC <- SCC[grepl("vehicle", SCC.Level.Two, ignore.case=TRUE), SCC]
vehiclesNEI <- NEI[NEI[, SCC] %in% vehiclesSCC,]

# Subset the vehicles NEI data to Baltimore's fip
baltimoreVehiclesNEI <- vehiclesNEI[fips=="24510",]

png("plot5.png",width = 700, height = 500)

g5plot<- ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions))
g5plot + geom_bar(stat="identity", fill ="orange" ,width=0.75) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

dev.off()