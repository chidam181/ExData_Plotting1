# Load library
library(data.table)
# Set working directory
setwd("C:\\Users\\Nishanth\\Desktop\\Learning R programing")
# Read table removing '?'s and at the required days.
household_table<-fread("household_power_consumption.txt",sep=";",na.strings=c("?","NA"),colClasses="character"
)[,Date:=as.Date(Date,format="%d/%m/%Y")][Date %in% seq(from=as.Date("2007-02-01"),to=as.Date("2007-02-02"),by="day")]
# Sapply to all the other columns 
for( i in 3:9 ){
       household_table[[i]] <- sapply(household_table[[i]], as.character)
       household_table[[i]] <- sapply(household_table[[i]], as.numeric)
}
# Open windows graphics device on the required size
win.graph()
# Convert the date format
household_table$Date <- as.Date(household_table$Date, format = '%d/%m/%Y')
# Combine date and time
household_table$DateTime <- as.POSIXct(paste(household_table$Date, household_table$Time))
plot(household_table$DateTime, household_table$Global_active_power, type="l", col="black", xlab="", ylab="Global active power (kiloWatts)")
# Save it as a .png file, default is 480x480
dev.copy(png,filename="plot2.png");
dev.off ();

