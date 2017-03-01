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


## create plot
with(data,
     plot(data$Date, data$Global_active_power,
          type = "l",
          xlab = "",
          ylab = "Global Active Power (kilowatts)"
     )
)

## Export to PNG
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
head(data$Date)

     
