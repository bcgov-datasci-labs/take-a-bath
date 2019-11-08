# Copyright 2019 Province of British Columbia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.

# ----------------------------------------------------
# This is exploring using marmap to make a bethy map so that we don't have
# to do this ourselves


library(dplyr)
library(sf)
library(marmap)

#example from marmap
data(irregular)
irregular

# This is converting a points layer to a raster using the raster package
reg <- griddify(irregular, nlon = 40, nlat = 60)
class(reg)
plot(reg)

# This is applyng a bilinear smoother
bat <- as.bathy(reg)
class(bat)
plot(bat, image = TRUE, lwd = 0.1)

# ----------------------------------------------------
#try this out with the lake data

str(irregular)
str(points)

points.wgs <- st_transform(points, crs = 4326)

pt.setup <- points %>%
  mutate(lon = LONGTITUDE) %>%
  mutate(lat = LATITUDE) %>%
  mutate(depth = DEPTH) %>%
  select(lon, lat, depth)

str(pt.setup)
df.points <- st_drop_geometry(pt.setup)
str(df.points)
lk <- griddify(df.points, nlon=60, nlat=60)
lake.bathy <- as.bathy(lk)

plot(lake.bathy, image = TRUE, lwd = 0.1)


# ----------------------------------------------------
# Convert lake polygon and depth points into matching rasters
# depth_raster is raster of depth values from points file
# mob_lake_raster is raster of lake polygon


library(raster)

r <- raster(ext = extent(mob_lake), res = 100, crs = crs(mob_lake))

mob_lake_spdf <- as(mob_lake, "Spatial")
mob_lake_raster <- rasterize(mob_lake, r)

points_spdf <- as(points, "Spatial")

depth_raster <- rasterize(points_spdf,r, field = "DEPTH")
plot(depth_raster)

# ----------------------------------------------------
# Try distance analysis, will only work with raster res >=100 m
# This works but it has limited resolution

library(ranger)

# Function to do spatial random forest using depth points and lake polygon as inputs
# raster resolution cannot be higher than 100 m

try_bath_rf <- function(depth, lake, res = 100){

  r <- raster(ext = extent(lake), res = res, crs = crs(lake))

  lake_raster <- rasterize(lake, r)

  depth_spdf <- as(depth, "Spatial")

  depth_raster <- rasterize(depth_spdf, r, field = "DEPTH")

  raster_data <- data.frame(cell = 1:ncell(depth_raster), coordinates(depth_raster), DEPTH = values(depth_raster))
  idx <- which(!is.na(raster_data$DEPTH))

  dist_mat <- pointDistance(coordinates(depth_raster), lonlat = F, allpairs = T)

  dist_mat <- dist_mat[,idx]

  mod_data <- na.omit(data.frame(DEPTH = raster_data$DEPTH, dist_mat))

  mod_rf <- ranger(DEPTH ~ ., data = mod_data)
  temp <- predict(mod_rf, data.frame(dist_mat))
  temp$predictions

  rf_output <- depth_raster
  values(rf_output) <- temp$predictions
  values(rf_output)[is.na(values(lake_raster))] <- NA
  rf_output
}

rf_result <- try_bath_rf(depth = points, lake = mob_lake, res = 100)
plot(rf_result)

# ----------------------------------------------------

