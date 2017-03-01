## set url1 for data set and temporary file name
url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "UCData.zip"

## Download and unzip file if not already in working directory
if(!file.exists(filename)){
  download.file(url1,filename,method = "curl")
  unzip(filename)
}

## Read data, format date/time, subset on Feb 1st and 2nd
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)
data$Date <- strptime(paste(data$Date,data$Time," "),"%d/%m/%Y %H:%M:%S")
data <- subset(data, Date >= "2007-02-01" & Date < "2007-02-03")



## adjust margins and font size
par(mfrow = c(2,2),
    mar = c(5.1,4.1,1,1),
    cex = .6
    )

## Plot (1, 1)
with(data,
     plot(Date, Global_active_power,
          type = "l",
          xlab = "",
          ylab = "Global Active Power (kilowatts)"
     )
)

## Plot (1,2)
with(data,
     plot(Date, Voltage,
          type = "l",
          xlab = "datetime"
     )
)

## Plot (2,1)
with(data,
     plot(Date, Sub_metering_1,
          type = "l",
          col = "black",
          xlab = "",
          ylab = "Energy sub metering"
     )
     
)
with(data, 
     points(Date, Sub_metering_2,
            type = "l",
            col = "red"
     )
)
with(data, 
     points(Date, Sub_metering_3,
            type = "l",
            col = "blue"
     )
                  
)
legend("topright", 
       lty = 1, 
       col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty = "n"
)

## Plot (2,2)
with(data,
     plot(Date, Global_reactive_power,
          type = "l",
          xlab = "datetime"
     )
)

## Export to PNG
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()


     
