
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
# Plot a histogram
hist(household_table$Global_active_power, xlab = "Global active power (kiloWatts)", main = "Global active power", col = "red", ylim = c(0, 1200))
# Save it as a .png file
dev.copy(png,filename="plot1.png");
dev.off ();

