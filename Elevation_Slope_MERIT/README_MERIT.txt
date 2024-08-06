Dataset: MERIT Elevation + Slope Z Created by Tom McKeen (Jul/Aug 2023)
Target Extent: Lower Left  (-180, -59.99999942); Upper Right (179.999999856,  84)
Target Resolution: 0.00083333333 x 0.00083333333 (approximately 100m at the Equator)
Data type: Float32 GeoTIFF
No Data Value: Elevation -999999, Slope -9999
SRS: EPSG:4326 (WGS84)

Ouput file names (years from 2015-2022):

- merit_elevation_0_NoData.tif
- merit_elevation_NoData.tif
- merit_slope_0_NoData.tif
- merit_slope_NoData.tif




Data description
***********************
MERIT DEM (Multi-Error-Removed Improved-Terrain DEM) created using methodology to eliminate major error components from multiple existing DEMs (SRTM3, JAXA AW3D, Viewfinder Panoramas). Absolute bias, stripe noise, speckle noise and tree height bias are separated using thee multiple satellite datassets and filtering techniques. Additional info, is available at: http://hydro.iis.u-tokyo.ac.jp/~yamadai/MERIT_DEM
MERIT DEM 5° x 5° tiles merged and processed into GeoTIFF raster with the same spatial resolution, extent and alignment as the WorldPop Global2 mastergrid. Slope covariate calculated using elevation convariate and gdaldem slope tool.




Description of raw data
***********************
Format: GeoTIFF Tiles (5° by 5° tiles); Float32
Provider: Downloaded from http://hydro.iis.u-tokyo.ac.jp/~yamadai/MERIT_DEM on 02/03/2023 by Tom McKeen (password required)
Temporal Resolution: 1987-2011
Spatial Resolution: 3 arc-seconds (~100m at the equator)
Extent: Near Global (90°N to 56°S)
Spatial Reference: WGS84 (EPSG:4326)
Size: ~100GB archive
Recommended Citation: Yamazaki D., D. Ikeshima, R. Tawatari, T. Yamaguchi, F. O'Loughlin, J.C. Neal, C.C. Sampson, S. Kanae & P.D. Bates. A high accuracy map of global terrain elevations. Geophysical Research Letters, vol.44, pp.5844-5853, 2017 doi: 10.1002/2017GL072874




Dataset preparation
***********************
Dataset detailing elevation and slope over earth's surface at 100m resolution.

The data preparation can be split into three stages:
(1) 
(2)
(3)

Each step is further explained:

* (1) Create standard global raster layer
Build a virtual raster table (VRT) of elevation GeoTIFF tiles. Convert VRT into global GeoTIFF.
Resample, match extent to WorldPop Global2 mastergrid and set NoData = -999999.
script: .../global2_scripts/MERIT_script1_mosaic_resample.bat/

* (2) Clip and overlay onto mastergrid base
Global elevation layer was clipped to the WorldPop Global2 mastergrid base.
The clipped global elevation layer was then overlaid onto the WorldPop Global 2 mastergrid base.
script: .../global2_scripts/MERIT_script2_clip.bat/

* (3) Calculate slope
Calculate slope covariate using clipped global elevation layer and gdaldem slope tool.
script: .../global2_scripts/MERIT_script3_slope.bat/

* (4) Nibble covariates
*MB*