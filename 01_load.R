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
# Load points from the data directory

# Unzip depth points file
unzip("data/moberly.zip", exdir = "data")

# Load shapefile
points <- st_read("data/moberly_final.shp", quiet = TRUE)
points

# View map in mapview
mapview(points)

# ----------------------------------------------------
# Get lake polygon from BCDC

mob_lake <- bcdc_query_geodata('freshwater-atlas-lakes') %>%
  filter(INTERSECTS(points)) %>%
  filter(AREA_HA > 10) %>%
  collect()

mapview(mob_lake)

# ----------------------------------------------------
# Transform points data to projection of lake data

points <- st_transform(points, st_crs(mob_lake))
