#import data
NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

#Subset data for Baltimore
Balt <- subset(NEI, fips == '24510')

#Get total emissions for Baltimore
totbal <- aggregate(Emissions ~ year, Balt, sum)

#Create plot
png('plot2.png', width = 480, height = 480)

barplot(height = totbal$Emissions, names.arg = totbal$year, xlab = 'Year', ylab = 'PM2.5 Emissions',
        main = 'Total PM2.5 Emissions in Baltimore')

dev.off()