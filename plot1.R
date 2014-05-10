require(sqldf)

## Reads only the needed 92007-02-01 and 2007-02-02) data 
## using the sqldf package.
## Plots a histogram for Global Active power.
## generates a plot1.png in the working directory

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
png(filename= "plot1.png")
hist(data$Global_active_power,
     xlab="Global Active Power (kilowatts)",
     col='red',
     main='Global Active Power')
dev.off()