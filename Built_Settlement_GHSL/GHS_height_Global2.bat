@ECHO on
SETLOCAL EnableDelayedExpansion

:: Written by Alex Cunningham July 2023
:: This script matches GHS height rasters (gross height and net height files) to our mastergrid via resampling and clipping to coastlines - producing two final rasters (one for gross height and another for net height).
:: Ensure mastergrid is placed into the same folder as GHS_BUILT_H data

:: MODIFY AND INSERT BELOW 'X:\LOCATION OF 'GHS_height_Global2.bat'' (with downloaded input rasters in same folder)
SET mypath=X:\

::-s_srs ESRI:54009 is the default projection for older GHSL downloads
::-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
::Reproject covariate to WGS84 if using -s_srs ESRI:54009 projected rasters


:: Each section will loop through the named rasters in the folder and save the output file to the same folder.
FOR %%i IN (GHS_BUILT_H_*_E2018_GLOBE_R2023A_54009_100_V1_0.tif) DO (
	
	SET infile=%%i
	SET outfile=!infile:0.tif=0_4326.tif!
	gdalwarp -wo NUM_THREADS=8 -s_srs ESRI:54009 -t_srs EPSG:4326 -r bilinear -wo SKIP_NOSOURCE=YES -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -wo OPTIMIZE_SIZE=true !infile! %MYPATH%!outfile!
)

::-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
::Resample covariate to MG specs

FOR %%i IN (GHS_BUILT_H_*_E2018_GLOBE_R2023A_54009_100_V1_0_4326.tif) DO (
	
	SET infile=%%i
	SET outfile=!infile:4326.tif=4326_resample.tif!	
	gdalwarp -wo NUM_THREADS=8 -ot Float32 -te -180.00 -59.99999942 179.999998559 84.00 -tr 0.00083333333 0.00083333333 -r bilinear -dstnodata -999999 -co COMPRESS=LZW -co BLOCKXSIZE=512 -co BLOCKYSIZE=512 -co TILED=YES -co PREDICTOR=2 -co BIGTIFF=YES -wo SKIP_NOSOURCE=YES -wo OPTIMIZE_SIZE=true -of gtiff !infile! %mypath%!outfile!
)
::-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
::Make MG base v3 file type match input covariate

gdalwarp -wo NUM_THREADS=8 -te -180.00 -59.99999942 179.999998559 84.00 -tr 0.00083333333 0.00083333333 -ot Float32 -srcnodata 255 -dstnodata -999999 -wo SKIP_NOSOURCE=YES -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -wo OPTIMIZE_SIZE=true WP_mastergrid_base_2023_v3.tif WP_mastergrid_base_2023_v3_A.tif

gdal_translate -ot Float32 -a_nodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -of gtiff WP_mastergrid_base_2023_v3_A.tif WP_mastergrid_base_2023_v3_B.tif

::-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
::Clip to MG base v3 coastlines - the first gdal warp defines the coastline, and the second gdal warp fills in nodata present on areas where our MG says there should be land (and a value) with '0'. Effectively filling the land pixels out to our boundary.

FOR %%i IN (GHS_BUILT_H_*_E2018_GLOBE_R2023A_54009_100_V1_0_4326_resample.tif) DO (

	SET infile=%%i
	SET outfile_A=!infile:.tif=_NoData.tif!
	SET outfile_B=!infile:.tif=_0_NoData.tif!
	
	call gdalwarp -wo NUM_THREADS=8 -te -180.00 -59.99999942 179.999998559 84.00 -tr 0.00083333333 0.00083333333 -ot Float32 -dstnodata -999999 -wo SKIP_NOSOURCE=YES -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -wo OPTIMIZE_SIZE=true !infile! WP_mastergrid_base_2023_v3_B.tif !outfile_A!
	call gdalwarp -wo NUM_THREADS=8 -te -180.00 -59.99999942 179.999998559 84.00 -tr 0.00083333333 0.00083333333 -ot Float32 -dstnodata -999999 -wo SKIP_NOSOURCE=YES -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -wo OPTIMIZE_SIZE=true WP_mastergrid_base_2023_v3.tif !outfile_A! !outfile_B!
)


ECHO .
ECHO end of script