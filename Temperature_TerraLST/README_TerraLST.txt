Dataset: Average Annual Temperature (TerraLST) ~ Created by Tom McKeen (Nov 2023)
Target Extent: Lower Left  (-180, -59.99999942); Upper Right (179.999999856,  84)
Target Resolution: 0.00083333333 x 0.00083333333 (approximately 100m at the Equator)
Data type: Float32 GeoTIFF
No Data Value: -99999
SRS: EPSG:4326 (WGS84)

Ouput file names (years from 2015-2023):

- lst_<<year>>_tavg_100m.tif




Data description
***********************
TerraLST Temperature data, with an annual resolution (2015-2023). Raw monthly data averaged to produce annual averages. Raster processed to have the same spatial resolution, extent and alignment as the WorldPop Global2 mastergrid.




Description of raw data
***********************
Format: annual GeoTIFF files, Float64
Provider: Downloaded from https://developers.google.com/earth-engine/datasets/catalog/MODIS_061_MOD21C3 on 07/11/2023 by Rhorom Priyatikanto
Temporal Resolution: 2000-2023 (TerraMODIS collection, monthly resolution).
Spatial Resolution: ~1000m 
Extent: Global
Spatial Reference: WGS84 (EPSG:4326)
Size: ~4GB for 8 years (2015-2022)
Info: https://lpdaac.usgs.gov/documents/1398/MOD21_User_Guide_V61.pdf




Dataset preparation
***********************
Dataset detailing average annual temperature between 2015-2022 at 100m resolution.

The data preparation can be split into four stages:
(1) translate annual GeoTIFFs from Float64 to Float32
(2) mosaic rasters for corresponding years
(3) processing to resample and match extent to the WorldPop Global2 mastergrid
(4) clip and nibble to Global2 mastergrid

Each step is further explained:

* (1) Translate annual GeoTIFFs
Translate annual GeoTIFFs, Float64 to Float32, set NoData value to -99999, using gdal_translate.
script: .../global2_scripts/TerraLST_script1_translate.bat/
2 rasters created for each year, 16 rasters total for period 2015-2022.

* (2) Mosaic corresponding annual rasters
Mosaic corresponding raster files for each year, using gdalwarp.
Match to Global2 mastergrid extent.
NoData value set to -99999, Float32.
script: .../global2_scripts/TerraLST_script2_mosaic.bat/
1 raster created for each year, 8 rasters in total for the period 2015-2022. 

* (3) Resample and match to mastergrid
Resample each annual average temperature raster to 100m, using bilinear method. 
Match extent to Global2 mastergrid extent 
NoData = -99999, Float32, EPSG:4326.
script: .../global2_scripts/TerraLST_script3_resample.bat/
1 raster created per year, 8 rasters in total for the period 2015-2022. 

* pending (4) nibble and clip to Global2 mastergrid coastlines

Further details of the pre-processing and processing steps, along with instructions for running the scripts can be found in the scripts.

----
README updated 14/05/2024