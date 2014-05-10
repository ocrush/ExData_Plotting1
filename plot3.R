require(sqldf)

## Reads only the needed 92007-02-01 and 2007-02-02) data 
## using the sqldf package.
## Plots multiple data sets on one device and adds a legend to topright.
## generates plot3.png in the working directory

## Assumes data is available and this file is run from the data dir
## setwd(<data_dir>)

#get data for dates 2007-02-01 and 2007-02-02.  
#file data format is dd/mm/yyyy and separated by ;
query = "select * from file where Date='1/2/2007' OR Date='2/2/2007'"  
data <- read.csv.sql("household_power_consumption.txt",query,sep=";")
#create datatime column.  Handy when plotting.
DateTime=strptime(paste(data$Date,data$Time),"%d/%m/%Y %H:%M:%S")
data <- cbind(DateTime,data)

#save plot as png 480 x 480.  Default is 480x480 so no need to sepcify it. 
png(filename= "plot3.png")

#plot setup for mutiple data sets on one graph
plot(data$DateTime,data$Sub_metering_1,
     type="n",
     xlab="",
     ylab="Energy sub metering")

lines(data$DateTime,data$Sub_metering_1,type='l',col='black')
lines(data$DateTime,data$Sub_metering_2,type='l',col='red')
lines(data$DateTime,data$Sub_metering_3,type='l',col='blue')
legend("topright",
       legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1),
       col=c("black","red","blue"))
dev.off()