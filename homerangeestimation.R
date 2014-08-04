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

#set it the the directory containing the folders of the shape file for the centroids
setwd("C:/Users/Dakota/Documents/GitHub/nc_homerange")

# Load data ----
#Load the coyote data
coyote <- readOGR("nc_coyote_centroids_dn","nc_coyote_centroids_dn")

#Make a kernel HR Estimation for day and night ----
ud <- kernelUD(coyote[,2], h="href")
#image(kernel)
ver <- getverticeshr(ud, 95)

# write out to a shape file ----
writeOGR(ver, "hr_coyote_centroids_dn", "hr_centroids_dn", "ESRI Shapefile")


