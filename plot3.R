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
par(mar = c(3, 4.1, 1, 1),
    cex = .7)

## create plot
with(data,
     plot(Date, Sub_metering_1,
          type = "l",
          col = "black",
          xlab = "",
          ylab = "Energy sub metering"
     )
)

## red lines
with(data, points(Date, Sub_metering_2,
       type = "l",
       col = "red"
       )
)

## blue lines
with(data, points(Date, Sub_metering_3,
                  type = "l",
                  col = "blue"
                  )
)

## write legend
legend("topright", 
       lty = 1, 
       col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
)
     
## Export to PNG
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()


     
