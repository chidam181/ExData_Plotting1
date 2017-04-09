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
# Plot as required
with(household_table, plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering" , axes = F, frame.plot=TRUE))
axis(1, at=c(as.numeric(min(household_table$DateTime))), labels=c("Thu", "Fri", "Sat"))
axis(2, yaxs = "r")
with(household_table, points(DateTime, Sub_metering_1, type = "l"))
with(household_table, points(DateTime, Sub_metering_2, type = "l", col = "red"))
with(household_table, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("top", pch = "-", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# Save it as a .png file, default is 480x480
dev.copy(png,filename="plot3.png");
dev.off ();

