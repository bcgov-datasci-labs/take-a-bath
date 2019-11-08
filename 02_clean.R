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

library(dplyr)

## Sub-sampling points along transects for a sonar measurements for a lake

# make grid over transects
lake_grid <- points %>%
  st_make_grid(n = c(30, 1)) %>%
  st_sf() %>%
  mutate(grid_number = 1:30)

# check grid
ggplot() +
geom_sf(data = mob_lake) +
geom_sf(data = lake_grid, fill = NA) +
  geom_sf(data = points)

# join grid to transect points
points_by_grid <- points %>%
  st_join(lake_grid)

# subsample points by grid
grids <- unique(points_by_grid$grid_number)
fewer_grids <- grids[c(TRUE, FALSE)]

half_sampling <- points_by_grid %>%
  filter(grid_number %in% fewer_grids)




