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
new<-paste(consumpD$Date,consumpD$Time)
consumpD$dateTime<-strptime(new, format="%Y-%m-%d %H:%M:%S")

#Plot
png(filename = "plot2.png",
        width = 480, height = 480, units = "px")
plot(consumpD$dateTime, consumpD$Global_active_power,xlab="",ylab="Global Active Power (Killowatts)",type="l")
dev.off()
