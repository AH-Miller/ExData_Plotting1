# Install required libraries
library(lubridate)
library(dplyr)

# Function for adding x axis to plots, with labels for the start of each day
create_x_axis <- function(datetime) {
  axis(1, at = seq(min(datetime), max(datetime), by = "1 day"), 
       labels = c("Thu", "Fri", "Sat"))
}

# Download data, set correct data types, filter dates 2007-02-01 and 2007-02-02.
power_data <- read.table("household_power_consumption.txt", header = TRUE,
                         sep = ";", na.strings = "?") %>%
  mutate(datetime = dmy_hms(paste(Date, Time))) %>%
  filter(between(datetime, ymd("2007-02-01"), ymd("2007-02-03")))

# Create plot 4, comprised of four subplots
# To be comprised of plots 2 and 3, as well as two new plots as subplots
png("plot4.png")
par(mfrow = c(2, 2))

# Create line chart of Global Active Power over time (plot2)
with(power_data, {
  plot(datetime, Global_active_power, type = "l", xaxt = "n",
       xlab = "", ylab = "Global Active Power")
  create_x_axis(datetime)
})

# Create line chart of Voltage over time
with(power_data, {
  plot(datetime, Voltage, type = "l", xaxt = "n")
  create_x_axis(datetime)
})

# Create line chart of Energy sub metering over time for each sub meter (plot3)
with(power_data, {
  plot(datetime, Sub_metering_1, type = "l", xaxt = "n", 
       xlab = "", ylab = "Energy sub metering")
  lines(datetime, Sub_metering_2, col = "red")
  lines(datetime, Sub_metering_3, col = "blue")
  legend("topright", col = c("black", "red", "blue"), lty = 1, bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  create_x_axis(datetime)
})

# Create line chart of Global Reactive Power over time
with(power_data, {
  plot(datetime, Global_reactive_power, type = "l", xaxt = "n")
  create_x_axis(datetime)
})

dev.off()