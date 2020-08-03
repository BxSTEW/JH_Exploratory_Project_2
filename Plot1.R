#import data
NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

#get totals for all emissions for each year
totals <- aggregate(Emissions ~ year, NEI, sum)

#Create Plot
png('plot1.png', width = 480, height = 480)

barplot(height = (totals$Emissions)/10^6, names.arg = totals$year, xlab = 'Year', ylab = 'PM2.5 Emissions(10^6 Tons)',
        main = 'Total PM2.5 Emissions in the United States')

dev.off()