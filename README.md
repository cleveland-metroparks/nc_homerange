# A Quick R Script for Homerange estimation

This script utilizes the [adehabitatHR Package]( http://cran.r-project.org/web/packages/adehabitatHR/index.html)

## It is very simple:

1. I imported the shapefile using rgdal.
2. I ran an Estimation of Kernel Home-Range (kernelUD). The smoothing parameter was set to the _ad hoc_ method. 
3. I extracted the home-range contour using a 95% estimation level (getverticeshr).
4. I exported the polygons to a shapefile (hr_centroids_dn.shp)

