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
# Plot of raw depth soundings

library(ggplot2)

# Plot raw data

rawdata <- ggplot() +
  geom_sf(data = mob_lake, fill = "blue") +
  geom_sf(data = points) +
  theme_minimal() +
  labs(title = "Sonar Sounding Transects at Moberly Lake (2019)",
       caption = "Data sourced from Ministry of Environment & Climate Change Strategy") +
  theme(plot.margin = unit(c(5,3,0,5), "mm"))

ggsave("out/raw-data-lake.png", plot = rawdata,
       width = 20, height = 8, units = "cm")

# ----------------------------------------------------

# Plot example of bathymetry estimates generated using random forest in the
# ranger package

temp <- data.frame(coordinates(rf_output), depth = values(rf_output))

depth_rf_plot <- ggplot() +
  geom_tile(data = temp, (aes(x = x, y = y, fill = depth ))) +
  scale_fill_continuous(trans = "reverse", na.value = grey(0.9)) +
  theme_minimal() +
  labs(title = "Example bathymetry predictions using random forest",
       caption = "Data sourced from Ministry of Environment & Climate Change Strategy")
depth_rf_plot
ggsave("out/depth_rf_plot.png", plot = depth_rf_plot)


# ----------------------------------------------------
# Plot  of grid design

sample_grid <- ggplot() +
geom_sf(data = mob_lake) +
geom_sf(data = lake_grid, fill = NA) +
  geom_sf(data = points) +
  theme_minimal() +
  labs(title = "Grid overlay for transect (30)",
       caption = "Data sourced from Ministry of Environment & Climate Change Strategy")

ggsave("out/grid_plot.png", plot = sample_grid,
       width = 20, height = 8, units = "cm")

