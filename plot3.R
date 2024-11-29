# Install required libraries
library(lubridate)
library(dplyr)

# Download data, set correct data types, filter dates 2007-02-01 and 2007-02-02.
power_data <- read.table("household_power_consumption.txt", header = TRUE,
                         sep = ";", na.strings = "?") %>%
  mutate(datetime = dmy_hms(paste(Date, Time))) %>%
  filter(between(datetime, ymd("2007-02-01"), ymd("2007-02-03")))

# Create plot 3, a line chart of Energy sub metering over time for each
# sub-meter, saved as a png
png("plot3.png")
with(power_data, {
  plot(datetime, Sub_metering_1, type = "l", xaxt = "n", 
       xlab = "", ylab = "Energy sub metering")
  lines(datetime, Sub_metering_2, col = "red")
  lines(datetime, Sub_metering_3, col = "blue")
  legend("topright", col = c("black", "red", "blue"), lty = 1, 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  axis(1, at = seq(min(datetime), max(datetime), by = "1 day"), 
       labels = c("Thu", "Fri", "Sat"))
})
dev.off()