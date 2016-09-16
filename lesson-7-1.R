# Reading shapefiles into R

library(rgdal) #open source geographical data file

counties_md <- readOGR("data/cb_500k_maryland", #path to file
                       "cb_500k_maryland")      #layer name, usually the same
summary(counties_md)

# Basic spatial plots

plot(counties_md)

howard <- counties_md[counties_md[["NAME"]] == "Howard", ]
plot(howard, col='red', add = TRUE) #add=TRUE to add to existing plot
text(coordinates(counties_md),        #pulls center point
     labels = counties_md[["NAME"]], 
     cex = 0.7)                       #reduce text size by 70%
#text adds to existing plot only

# Exercise
# Starting from a fresh map, print numbers on each county in order of
# the smallest (1) to largest (24) in land area ("ALAND" attribute). 
# Hint: Use `rank(x)` to get ranks from a numeric vector x.

plot(counties_md)
text(coordinates(counties_md), labels = rank(counties_md[["ALAND"]]), cex = 0.7) 

# Reading rasters into R

library(raster)

nlcd <- raster("data/nlcd_agg.grd")

plot(nlcd) #but can't add county outlines if not same coord system

attr_table <- nlcd@data@attributes[[1]] #returns RGB values for each cell

# Change projections

proj4string(counties_md)
proj4string(nlcd)

counties_proj <- spTransform(counties_md, proj4string(nlcd)) #make it match!

plot(nlcd)
plot(counties_proj, add = TRUE)


# Masking a raster

landtype = 82
# landname = attr_table[landtype,6]
landplot <- mask(nlcd, nlcd == landtype, maskvalue = FALSE) #see attr_table for defs
plot(landplot)
# text(.5, .9, labels = landname, col='white')

# Exercise

# Create a mask for a different land cover class. 
#  Look up the numeric ID for a specific class in attr_table.

...


# Adding data to maps with tmap

library(tmap)      #thematic map

qtm(counties_proj) #quick thematic map

qtm(counties_proj, fill = "AWATER", text = "NAME")

map1 <- tm_shape(counties_proj) + #import spatial object
            tm_borders() +
            tm_fill("AWATER", title = "Water Area (sq. m)") +
            tm_text("NAME", size = 0.7)
map1

map1 +
    tm_style_classic(legend.frame = TRUE) +
    tm_scale_bar(position = c('left','top'))


# Exercise

# The color scales in tmap are divided into bins by default. 
# Look at the help file for tm_fill: help("tm_fill") to find which argument
#  controls the binning scale. How can you change it to a continuous gradient?

map2 <- tm_shape(counties_proj) + #import spatial object
  tm_borders() +
  tm_fill("AWATER", title = "Water Area (sq. m)", style = 'cont') +
  tm_text("NAME", size = 0.7) +
  tm_style_classic(legend.frame = TRUE) +
  tm_scale_bar(position = c('left','top'))
map2

# Interactive maps with leaflet

library(leaflet) #javascript with interactive online library!

imap <- leaflet() %>%
            addTiles() %>%
            setView(lng = -76.505206, lat = 38.9767231, zoom = 7)
imap
#OR
setView(addTiles(leaflet()), lng = -76.505206, lat = 38.9767231, zoom = 7)

imap %>%
  addWMSTiles(
    "http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0r.cgi",
    layers = "nexrad-n0r-900913", group = "base_reflect",
    options = WMSTileOptions(format = "image/png", transparent = TRUE),
    attribution = "Weather data © 2012 IEM Nexrad"
  )