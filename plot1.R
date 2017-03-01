
## set url1 for data set and temporary file name
url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "UCData.zip"

## Download and unzip file if not already in working directory
if(!file.exists(filename)){
  download.file(url1,filename,method = "curl")
  unzip(filename)
}

## Read data, format date, subset on Feb 1st and 2nd
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date,"%d/%m/%Y")
data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

## set Global_active_power to numeric for historgram
data$Global_active_power <- as.numeric(data$Global_active_power)

## create plot
with(data,
     hist(Global_active_power,
          main = "Global Active Power",
          xlab = "Global Active Power (kilowatts)",
          ylab = "Frequency",
          col = "red",
          breaks = 12
     )
)
## Export to PNG
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
