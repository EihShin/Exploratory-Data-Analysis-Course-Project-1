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
png(filename = "plot3.png",
    width = 480, height = 480, units = "px")
par(cex=.64)
op <- par(cex=.64) 
plot(consumpD$dateTime, consumpD$Sub_metering_1,xlab="",ylab="Energy sub metering",type="l",col='grey')
lines(consumpD$dateTime, consumpD$Sub_metering_2,xlab="",type="l",col='red')
lines(consumpD$dateTime, consumpD$Sub_metering_3,xlab="",type="l",col='blue')
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=c(1,1,1), 
       lwd=c(2.5,2.5,2.5),col=c("grey","red","blue")) 
dev.off()
