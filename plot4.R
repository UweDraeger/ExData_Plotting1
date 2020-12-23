library(tidyverse)
library(readr)
library(lubridate)

household_power_consumption <- 
        read_delim("household_power_consumption.txt",
                   ";", 
                   escape_double = FALSE, 
                   na = "?",
                   trim_ws = TRUE)

span <- household_power_consumption %>% 
        filter(Date == "1/2/2007" | Date == "2/2/2007")

rm(household_power_consumption)

span <- span %>% 
        mutate(datum = dmy_hms(paste(Date, Time))) %>%
        select(datum, 
               Global_active_power, 
               Global_reactive_power, 
               Voltage, 
               Global_intensity, 
               Sub_metering_1, 
               Sub_metering_2, 
               Sub_metering_3)

par(mfrow = c(2,2))

with(span, 
     plot(datum, Global_active_power, 
          col = "black",
          type = "l",
          ylab = "Global_active_power"))

with(span, 
     plot(datum, Voltage, 
          col = "black",
          type = "l",
          xlab = "datetime",
          ylab = "Voltage"))

with(span, 
     plot(datum, Sub_metering_1,
          col = "black",
          type = "l",
          xlab = "",
          ylab = "Energy sub metering"))

with(span, 
     lines(datum, Sub_metering_2,
           col = "red"))

with(span, 
     lines(datum, Sub_metering_3, 
           col = "blue"))
legend("topright",
       pch = "_",
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


with(span, 
     plot(datum, Global_reactive_power, 
          col = "black",
          type = "l",
          xlab = "datetime",
          ylab = "Global_reactive_power"))


dev.copy(png, file = "plot4.png", 
         width = 480, 
         height = 480, 
         units = "px")

dev.off() 