#Make a new column for night/day
#coyote@data$coyote <- "coyote"
#coyote@data$dayornight <- apply(coyote@data, 1, calcDayNight)
#writeOGR(coyote, "nc_clipped_data_for_CM", "nc_coyote_dn", "ESRI Shapefile")

#calculates 
calcDayNight <- function(x) {
  #if time is greater than the sunrise time or less than the sunset time, apply DAY
  suntime <- suncalc(as.numeric(as.Date(x["LMT_DATE"], format="%m-%d-%y") - as.Date("2013-01-01")), Lat=41.6, Long=-81.4)
  coytime <- as.numeric(strptime(x["LMT_TIME"], "%T") - strptime("00:00:00", "%T"))
  
  if(coytime > suntime$sunrise & coytime < suntime$sunset){
    x["dayornight"] <- "DAY"
  } else x["dayornight"] <- "NIGHT"
}
