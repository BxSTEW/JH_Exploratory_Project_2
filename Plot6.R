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
vehiclesBaltimoreNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]
vehiclesBaltimoreNEI$city <- "Baltimore City"

#Subset data for LA County
vehiclesLANEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
vehiclesLANEI$city <- "Los Angeles County"

#combine Baltimore and LA
bothNEI <- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)

#create plot
png('plot6.png', height = 480, width = 650)

p <- ggplot(bothNEI, aes(year, Emissions, fill = city)) +geom_bar(aes(fill = year), stat = 'identity') + 
        facet_grid(scales="free", space="free", .~city) +
        labs(x='Year', y= 'Total PM2.5 Emissions Tons') +
        labs(title = 'Total PM2.5 Motor Vehicle Emissions in Baltimore City and Los Angeles County (1999-2008)') + 
        theme(legend.position = 'none') +
        scale_x_continuous(breaks = c(1999, 2002, 2005, 2008))

print(p)

dev.off()