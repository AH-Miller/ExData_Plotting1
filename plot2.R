# Install required libraries
library(lubridate)
library(dplyr)

# Download data, set correct data types, filter dates 2007-02-01 and 2007-02-02.
power_data <- read.table("household_power_consumption.txt", header = TRUE,
                         sep = ";", na.strings = "?") %>%
  mutate(datetime = dmy_hms(paste(Date, Time))) %>%
  filter(between(datetime, ymd("2007-02-01"), ymd("2007-02-03")))

# Create plot 2, a line chart of Global Active Power over time, saved as a png
png("plot2.png")
with(power_data, {
  plot(datetime, Global_active_power, type = "l", xaxt = "n",
       xlab = "", ylab = "Global Active Power (kilowatts)")
  axis(1, at = seq(min(datetime), max(datetime), by = "1 day"), 
       labels = c("Thu", "Fri", "Sat"))
})
dev.off()