rm(list=ls()) 
library("data.table")
library("ggplot2")

setwd("C:/Users/Niyati/Documents/GitHub/ExploratoryDataAnalysis/Project2")

SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

# Gather the subset of the NEI data which corresponds to vehicles
condition <- grepl("vehicle", SCC[, SCC.Level.Two], ignore.case=TRUE)
vehiclesSCC <- SCC[condition, SCC]
vehiclesNEI <- NEI[NEI[, SCC] %in% vehiclesSCC,]

# Subset the vehicles NEI data by each city's fip and add city name.
NEI_baltimoreVehicles <- vehiclesNEI[fips == "24510",]
NEI_baltimoreVehicles[, city := c("Baltimore City")]

NEI_LAVehicles <- vehiclesNEI[fips == "06037",]
NEI_LAVehicles[, city := c("Los Angeles")]

# Combine data.tables into one data.table
bothNEI <- rbind(NEI_baltimoreVehicles,NEI_LAVehicles)

png("plot6.png",width = 600, height = 500)

g6plot <- ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) 
 g6plot + geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

dev.off()