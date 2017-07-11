library(data.table)
consump <- fread("C:/Users/User/Desktop/ExplotaryDataAnalysis/exdata_2Fdata%2Fhousehold_power_consumption/household_power_consumption.txt",
              sep=';',
             nrows = -1,
             na.strings = c("NA","N/A",""),
             stringsAsFactors=FALSE)

consumpD<-data.frame(consump)
consumpD$Date<-as.Date(consumpD$Date,"%d/%m/%Y")
consumpD<-consumpD[consumpD$Date=='2007-02-01' |consumpD$Date=='2007-02-02',]

library(chron)
consumpD$Time<- chron(times=consumpD$Time)
consumpD[3:9] <- lapply(consumpD[3:9], as.numeric) 

#Plot
png(filename = "plot1.png",
    width = 480, height = 480, units = "px")
hist(consumpD$Global_active_power,main="Global Active Power", xlab="Global Active Power(kilowatt)",ylab = "Frequency",col = "red")
dev.off()
