rm(list=ls()) 

library("data.table")

setwd("C:/Users/Niyati/Documents/GitHub/ExploratoryDataAnalysis/Project2")

SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
#print(head(NEI))

# filter on NEI
NEI[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]
#print(head(NEI))
# filter on fips code for Baltimore City
totalNEI <- NEI[fips=="24510", lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]
#print(head(totalNEI))

png("plot2.png")

barplot(totalNEI[, Emissions]
        , names = totalNEI[, year]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years in Baltimore City")

dev.off()
