# NC Coyote Home Range Estimation
# Cleveland Metroparks Department of Planning, Design, and Natural Resources
# Author: Dakota Benjamin
# Github repo: http://github.com/dakotabenjamin/nc_homerange

#This script will produce day/night home range estimations for the North Chagrin coyote project.

# Initialization ----
rm(list=ls())
#load packages
require(adehabitatHR)
require(rgdal)
require(RAtmosphere)


#set it the the directory containing the folders of the shape file for the centroids
setwd("C:/Users/Dakota/Documents/GitHub/nc_homerange")

# Load data ----
#Load the coyote data
coyote.centroids <- readOGR("nc_coyote_centroids_dn","nc_coyote_centroids_dn")
coyote <- readOGR("nc_clipped_data_for_CM", "NC_Clipped_Data")
coyote <- subset(coyote, as.Date(GMT_DATE, format="%m-%d-%y") < as.Date("2013-06-23") )

coyote@data$coyid <- "coyote"
coyote@data$dayornight <- as.factor(apply(coyote@data, 1, calcDayNight))

#Make a kernel HR Estimation for day and night ----
ud <- kernelUD(coyote[,48], h="href")
#image(kernel)
ver <- getverticeshr(ud, 95)
plot(ver)

# write out to a shape file ----
writeOGR(ver, "hr_coyote", "hr_daynight", "ESRI Shapefile")
writeOGR(coyote, "hr_coyote","dn_points", "ESRI Shapefile")

#calculates 
calcDayNight <- function(x) {
  #if time is greater than the sunrise time or less than the sunset time, apply DAY
  suntime <- suncalc(as.numeric(as.Date(x["LMT_DATE"], format="%m-%d-%y") - as.Date("2013-01-01")), Lat=41.6, Long=-81.4)
  coytime <- as.numeric(strptime(x["LMT_TIME"], "%T") - strptime("00:00:00", "%T"))
  
  if(coytime > suntime$sunrise & coytime < suntime$sunset){
    x["dayornight"] <- "DAY"
  } else x["dayornight"] <- "NIGHT"
}

