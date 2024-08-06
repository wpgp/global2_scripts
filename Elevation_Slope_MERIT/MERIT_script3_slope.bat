:: MERIT_script3_slope.bat - script 3, run on clipped MERIT elevation GeoTIFF raster.
:: This script will take the clipped elevation covariate, and calculate slope using the gdaldem slope tool.
:: In this case MERIT elevation rasters are processed.
:: This script will run from OSGeo4W Shell, ensure the script and the input clipped elevation raster are located in the inpath directory. Navigate to this directory using the cd command, then run.

:: The next script to run is [insert Maksym's nibble script].

:: By Tom McKeen 15/08/2023

@ECHO on
SETLOCAL EnableDelayedExpansion

:: calculate for *_elevation_0_NoData.tif
gdaldem slope -s 111120 -compute_edges -of GTiff -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES merit_elevation_0_NoData.tif merit_slope_0_NoData.tif

:: calculate for *_elevation_NoData.tif
gdaldem slope -s 111120 -compute_edges -of GTiff -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES merit_elevation_NoData.tif merit_slope_NoData.tif