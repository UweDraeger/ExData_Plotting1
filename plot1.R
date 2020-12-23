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

hist(span$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")

dev.copy(png, file = "plot1.png")

dev.off() 

