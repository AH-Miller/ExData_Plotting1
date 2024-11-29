# Install required libraries
library(lubridate)
library(dplyr)

# Download data, set correct data types, filter dates 2007-02-01 and 2007-02-02.
power_data <- read.table("household_power_consumption.txt", header = TRUE,
                         sep = ";", na.strings = "?") %>%
  mutate(datetime = dmy_hms(paste(Date, Time))) %>%
  filter(between(datetime, ymd("2007-02-01"), ymd("2007-02-03")))

# Create plot 1, a histogram of Global Active Power, saved as a png
png("plot1.png")
hist(power_data$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()