#import packages
library(ggplot2)

#Import data
NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

#Subset data for vehicle emissions production
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

#subset data for Baltimore
baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]

#create plot
png('plot5.png', height = 480, width = 560)

p <- ggplot(combustionNEI, aes(year, (Emissions / 10^5), fill = year)) + geom_bar(stat = 'identity') + 
        labs(x='Year', y= 'Total PM2.5 Emissions (10^5 Tons)') +
        labs(title = 'Total PM2.5 Motor Vehicle Emissions in Baltimore City during 1999 through 2008') + 
        theme(legend.position = 'none') +
        scale_x_continuous(breaks = c(1999, 2002, 2005, 2008))

print(p)

dev.off()