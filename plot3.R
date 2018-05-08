rm(list=ls()) 
library("data.table")
library("ggplot2")

setwd("C:/Users/Niyati/Documents/GitHub/ExploratoryDataAnalysis/Project2")

SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
#print(head(NEI))

# Subset NEI data by Baltimore
baltimoreNEI <- NEI[fips=="24510",]
#print(head(baltimoreNEI))

png("plot3.png",width = 600, height = 500)

g3plot <- ggplot(baltimoreNEI,aes(x=factor(year),Emissions,fill=type)) 
g3plot + geom_bar(stat="identity") + #geom_text(aes(label=Emissions),vjust=-0.2) +
  theme_bw() + guides(fill=FALSE) + 
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

dev.off()
