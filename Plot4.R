#import packages
library(ggplot2)

#import data
NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

#Subset data based on emission type, Coal and Combustion
combustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustionRelated & coalRelated)
combustionSCC <- SCC[coalCombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

#create plot
png('plot4.png', height = 480, width = 480)

p <- ggplot(combustionNEI, aes(year, (Emissions / 10^5), fill = year)) + geom_bar(stat = 'identity') + 
        labs(x='Year', y= expression('Total PM2.5 Emissions (10^5 Tons)')) +
        labs(title = 'Total PM2.5 Coal Emissions in US during 1999 through 2008') + 
        theme(legend.position = 'none') +
        scale_x_continuous(breaks = c(1999, 2002, 2005, 2008))

print(p)

dev.off()