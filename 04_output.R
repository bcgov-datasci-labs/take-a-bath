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

temp <- data.frame(coordinates(rf_result), depth = values(rf_result))

depth_rf_plot <- ggplot() +
  geom_tile(data = temp, (aes(x = x, y = y, fill = depth ))) +
  scale_fill_continuous(trans = "reverse", na.value = grey(0.9),  name = "Depth (m)") +
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

# ----------------------------------------------------
# Plot  of half data

half_data <- ggplot() +
geom_sf(data = mob_lake) +
geom_sf(data = lake_grid, fill = NA) +
  geom_sf(data = half_sampling) +
  theme_minimal() +
  labs(title = "Sub-sampled ~ half transects",
       caption = "Data sourced from Ministry of Environment & Climate Change Strategy")

ggsave("out/half_data_plot.png", plot = half_data,
       width = 20, height = 8, units = "cm")


# ----------------------------------------------------

# Plot example of bathymetry estimates generated using random forest with half the sampling transects
# ranger package

temp <- data.frame(coordinates(sub_result), depth = values(sub_result))

depth_sub_plot <- ggplot() +
  geom_tile(data = temp, (aes(x = x, y = y, fill = depth ))) +
  scale_fill_continuous(trans = "reverse", na.value = grey(0.9), name = "Depth (m)") +
  theme_minimal() +
  labs(title = "Example bathymetry predictions using 50% of transects",
       caption = "Data sourced from Ministry of Environment & Climate Change Strategy")
depth_sub_plot
ggsave("out/depth_sub_plot.png", plot = depth_sub_plot)

# ----------------------------------------------------

# Plot example of difference between sub_result and rf_result

temp <- data.frame(coordinates(diff_raster), depth = values(diff_raster))

diff_plot <- ggplot() +
  geom_tile(data = temp, (aes(x = x, y = y, fill = depth ))) +
  scale_fill_distiller(na.value = grey(0.9), palette = "YlOrRd", name = "Difference (m)") +
  theme_minimal() +
  labs(title = "Difference in bathymetry estimates using 50% of transects",
       caption = "Data sourced from Ministry of Environment & Climate Change Strategy")
diff_plot

ggsave("out/diff_plot.png", plot = diff_plot)

