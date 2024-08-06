Dataset: Average Annual Precipitation (TerraClimate) ~ Created by Tom McKeen (Nov 2023)
Target Extent: Lower Left  (-180, -59.99999942); Upper Right (179.999999856,  84)
Target Resolution: 0.00083333333 x 0.00083333333 (approximately 100m at the Equator)
Data type: Float32 GeoTIFF
No Data Value: -99999
SRS: EPSG:4326 (WGS84)

Ouput file names (years from 2015-2023):

- TerraClimate_ppt_<<year>>_yravg_100m.tif




Data description
***********************
TerraClim Precipitation data, with an annual temporal resolution (2015-2023). Raw monthly data averaged to produce annual averages. Raster converted from netCDF file to GeoTIFF and processed to have the same spatial resolution, extent and alignment as the WorldPop Global2 mastergrid.




Description of raw data
***********************
Format: annual netCDF files (monthly data stored in bands)
Provider: Downloaded from https://climate.northwestknowledge.net/TERRACLIMATE/index_directDownloads.php on 08/11/2023 by Tom McKeen
Temporal Resolution: 1958-2023
Spatial Resolution: 1/24°, ~4-km 
Extent: Global
Spatial Reference: WGS84 (EPSG:4326)
Size: 1GB for 8 datasets
Recommended Citation: Abatzoglou, J.T., S.Z. Dobrowski, S.A. Parks, K.C. Hegewisch, 2018, Terraclimate, a high-resolution global dataset of monthly climate and climatic water balance from 1958-2015, Scientific Data DOI: 10.1038/sdata.2017.191 
Monthly climate and climatic water balance for global terrestrial surfaces. 




Dataset preparation
***********************
Dataset detailing average annual precipitation between 2015-2023 at 100m resolution.

The data preparation can be split into four stages:
(1) extract and translate monthly GeoTIFFs from annual netCDF files
(2) calculate average annual precipitation
(3) processing to resample and match extent to the WorldPop Global2 mastergrid
(4) clip and nibble to Global2 mastergrid

Each step is further explained:

* (1) Extract monthly precipitation rasters
Annual netCDF files downloaded, with monthly values stored in bands 1-12.
Extract each monthly band for each year and save to a unique GeoTIFF with gdal_translate.
Datatype saved as Float32, EPSG:4326.
script: .../global2_scripts/TerraClimate_script1_translate.bat/
12 rasters created for each year, 108 rasters in total for period 2015-2023.

* (2) Calculate annual average precipitation
Monthly precipitation rasters for each year totalled and divided by 12, using gdal_calc.
Set NoData value to -99999, Float32.
script: .../global2_scripts/TerraClimate_script2_compute.bat/
1 raster created per year, 9 rasters in total for the period 2015-2023.

* (3) Resample and match to mastergrid
Resample each annual average precipitation to match Global2 mastergrid (~100m), using bilinear method.
Match extent to Global2 mastergrid extent.
NoData = -99999, Float32, EPSG:4326
script: .../global2_scripts/TerraClimate_script3_resample.bat/
1 raster created per year, 9 rasters in total for the period 2015-2023.

* pending (4) nibble and clip to Global2 mastergrid coastlines

Further details of the pre-processing and processing steps, along with instructions for running the scripts can be found in the scripts.

----
README updated 14/05/2024