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

library(sf)
library(bcdata)
library(mapview)

# ----------------------------------------------------

# Load lake survey points from the data directory

file_path <- "data/moberly.zip"

# Unzip depth points file
raw_data <- unzip(file_path, exdir = "data")

# Load shapefile
points <- st_read(raw_data[endsWith(raw_data,".shp")], quiet = TRUE)
points

# View map in mapview
mapview(points)

# ----------------------------------------------------
# Get lake polygon from Freshwater Atlas Lakes in B.C. Data Catalogue
# using bcdata package

mob_lake <- bcdc_query_geodata('cb1e3aba-d3fe-4de1-a2d4-b8b6650fb1f6') %>%
  filter(INTERSECTS(points)) %>%
  filter(AREA_HA > 10) %>%
  collect()

mapview(mob_lake)

# ----------------------------------------------------
# Transform points data to projection of lake data

points <- st_transform(points, st_crs(mob_lake))


