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
png(filename = "plot4.png",
    width = 480, height = 480, units = "px")
par(mfrow=c(2,2))
plot(consumpD$dateTime, consumpD$Global_active_power,xlab="",ylab="Global Active Power (Killowatts)",type="l")
plot(consumpD$dateTime, consumpD$Voltage,xlab="datatime",ylab="Voltage",type="l")
par(cex=.64)
op <- par(cex=.64) 
plot(consumpD$dateTime, consumpD$Sub_metering_1,xlab="",ylab="Energy sub metering",type="l",col='grey')
lines(consumpD$dateTime, consumpD$Sub_metering_2,xlab="",type="l",col='red')
lines(consumpD$dateTime, consumpD$Sub_metering_3,xlab="",type="l",col='blue')
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=c(1,1,1), 
       lwd=c(2.5,2.5,2.5),col=c("grey","red","blue"),bty = 'n') 
plot(consumpD$dateTime, consumpD$Global_reactive_power,xlab="datatime",ylab="Global_reactive_power",type="l")
dev.off()
