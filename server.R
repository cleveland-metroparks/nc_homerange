library(shiny)
require(adehabitatHR)
require(rgdal)
require(RAtmosphere)

#calculates 
calcDayNight <- function(x) {
  #if time is greater than the sunrise time or less than the sunset time, apply DAY
  suntime <- suncalc(as.numeric(as.Date(x["LMT_DATE"], format="%m-%d-%y") - as.Date("2013-01-01")), Lat=41.6, Long=-81.4)
  coytime <- as.numeric(strptime(x["LMT_TIME"], "%T") - strptime("00:00:00", "%T"))
  
  if(coytime > suntime$sunrise & coytime < suntime$sunset){
    x["dayornight"] <- "DAY"
  } else x["dayornight"] <- "NIGHT"
}

setwd("~/Documents/GitHub/")
coyote.centroids <- readOGR("nc_homerange/nc_coyote_centroids_dn","nc_coyote_centroids_dn")
coyote <- readOGR("nc_homerange/nc_clipped_data_for_CM", "NC_Clipped_Data")
coyote <- subset(coyote, as.Date(GMT_DATE, format="%m-%d-%y") < as.Date("2013-06-23") )

coyote@data$coyid <- "coyote"
coyote@data$dayornight <- as.factor(apply(coyote@data, 1, calcDayNight))
#Make a kernel HR Estimation for day and night ----
ud <- kernelUD(coyote[,48], h="href")
#image(kernel)
ver <- getverticeshr(ud, 95)

#map <- readOGR("nc_homerange", "metroparkstiles.xml")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically
  #     re-executed when inputs change
  #  2) Its output type is a plot

  output$distPlot <- renderPlot({
#    x    <- faithful[, 2]  # Old Faithful Geyser data
#    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
#    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  plot(coyote[input$coy[1]:input$coy[2],])
  plot(ver, add=T)
      
    })

})
