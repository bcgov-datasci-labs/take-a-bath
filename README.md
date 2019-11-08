<a id="devex-badge" rel="Exploration" href="https://github.com/BCDevExchange/assets/blob/master/README.md"><img alt="Being designed and built, but in the lab. May change, disappear, or be buggy." style="border-width:0" src="https://assets.bcdevexchange.org/images/badges/exploration.svg" title="Being designed and built, but in the lab. May change, disappear, or be buggy." /></a>[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## take-a-bath
This respository contains scripts for reading in sonar bathymetry data for a water body, building a raster bathymetry surface, and evaluating the optimal number of transects to build an accurate surface. The scripts were developed as part of the BC Government North Area R Geospatial Workshop Hackathon.

### The Plan
#### Phase 1 - Test case
1.   Read in the data
       + Read in sonar transect data from single lake
       + Get the lake boundary from bcdata
2.   Create raster bathymetry surface from data subsets of varying number of transects
       + Exploring Saga, marmap, and Machine Learning
3.   Compare bathymetry surfaces to determine the optimal number of transects to get an accurate bathymetry surface
       + Difference raster layers and calculate mean difference
       + Create plot of data amount vs difference
       + Provide suggestion for number of transects

#### Phase 2 - Improvements
1. Get lake boundary from satellite imagery for current lake boundary
       + classify satellite imagery and extract lake polygon
2. Upload user lake polygon

### Usage

Data used for **Phase 1 - Test Case** is point sonar bathymetry data collected in transects supplied by BC Government staff. User data should be added to the ```data``` folder.

Describe how to run. Eg:

There are four core scripts that are required for the analysis, they need to be run in order:

-   01\_load.R
-   02\_clean.R
-   03\_analysis.R
-   04\_output.R

#### Example

This is a basic example which shows you how to solve a common problem:

``` r
## basic example code
```

### Project Status

Currently working on Phase 1 development.

### Getting Help or Reporting an Issue

To report bugs/issues/feature requests, please file an [issue](https://github.com/bcgov/take-a-bath/issues/).

### How to Contribute

If you would like to contribute, please see our [CONTRIBUTING](CONTRIBUTING.md) guidelines.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

### License

```
Copyright 2019 Province of British Columbia

Licensed under the Apache License, Version 2.0 (the &quot;License&quot;);
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an &quot;AS IS&quot; BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and limitations under the License.
```
---
*This project was created using the [bcgovr](https://github.com/bcgov/bcgovr) package.* 
