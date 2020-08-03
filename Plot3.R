#import packages
library(ggplot2)
library(scales)

#import data
NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

#Subset data for Baltimore
Balt <- subset(NEI, fips == '24510')

#Merge Baltimore subset and SCC classifications
Balt <- merge(Balt, SCC, by = 'SCC')

#Create plot
png('plot3.png', height = 800, width = 800)

ggp <- ggplot(Balt, aes(year, Emissions, fill = type)) + geom_bar(stat = 'identity') +
        facet_grid(.~type,scales = "free",space="free") + labs(x='Year', y='Total PM2.5 Emissions (Tons)') +
        labs(title = 'Total PM2.5 Emissions by Type for Baltimore during 1999 through 2008') + 
        scale_x_continuous(breaks = c(1999, 2002, 2005, 2008))

print(ggp)

dev.off()