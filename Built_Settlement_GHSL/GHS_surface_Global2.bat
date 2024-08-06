@ECHO on
SETLOCAL EnableDelayedExpansion

:: Written by Alex Cunningham July 2023
:: This script matches GHS built volume total and non-residential rasters (2010, 2015, 2020, 2025 and 2030) to our mastergrid via resampling and clipping to coastlines
::, producing ten output rasters. These rasters are then used to create a residential settlement layer for each year by subtracting non-residential from total for mathing years, resulting in fifteen built surface rasters matching the WP grid in total.
:: A binary version of each of the three files for each year is then made (total, non residential and residential) for a total of fifteen binary files.

:: Ensure mastergrid is placed into the same folder as GHS_BUILT_S data

:: MODIFY AND INSERT BELOW 'X:\LOCATION OF 'GHS_volume_Global2.bat'' (with downloaded input rasters in same folder)
SET mypath=X:\

::-s_srs ESRI:54009 is the default projection for older GHSL downloads
::-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
::Reproject covariate to WGS84 if using -s_srs ESRI:54009 projected rasters


:: Each section will loop through the named rasters in the folder and save the output file to the same folder.
FOR %%i IN (GHS_BUILT_V_*_GLOBE_R2023A_54009_100_V1_0.tif) DO (
	
	SET infile=%%i
	SET outfile=!infile:0.tif=0_4326.tif!
	gdalwarp -wo NUM_THREADS=8 -s_srs ESRI:54009 -t_srs EPSG:4326 -r bilinear -wo SKIP_NOSOURCE=YES -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -wo OPTIMIZE_SIZE=true !infile! %MYPATH%!outfile!
)

::-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
::Resample covariate to MG specs

FOR %%i IN (GHS_BUILT_V_*_GLOBE_R2023A_54009_100_V1_0_4326.tif) DO (
	
	SET infile=%%i
	SET outfile=!infile:4326.tif=4326_resample.tif!	
	gdalwarp -wo NUM_THREADS=8 -ot UInt16 -te -180.00 -59.99999942 179.999998559 84.00 -tr 0.00083333333 0.00083333333 -r bilinear -srcnodata 65535 -dstnodata 65535 -co COMPRESS=LZW -co BLOCKXSIZE=512 -co BLOCKYSIZE=512 -co TILED=YES -co PREDICTOR=2 -co BIGTIFF=YES -wo SKIP_NOSOURCE=YES -wo OPTIMIZE_SIZE=true -of gtiff !infile! %mypath%!outfile!
)
::-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
::Make MG base v3 file type match input covariate

gdalwarp -wo NUM_THREADS=8 -te -180.00 -59.99999942 179.999998559 84.00 -tr 0.00083333333 0.00083333333 -ot UInt16 -srcnodata 255 -dstnodata 65535 -wo SKIP_NOSOURCE=YES -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -wo OPTIMIZE_SIZE=true WP_mastergrid_base_2023_v3.tif WP_mastergrid_base_2023_v3_A.tif

gdal_translate -ot UInt16 -a_nodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -of gtiff WP_mastergrid_base_2023_v3_A.tif WP_mastergrid_base_2023_v3_B.tif

::-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
::Clip to MG base v3 coastlines - the first gdal warp defines the coastline, and the second gdal warp fills in nodata present on areas where our MG says there should be land (and a value) with '0'. Effectively filling the land pixels out to our boundary.

FOR %%i IN (GHS_BUILT_V_*_GLOBE_R2023A_54009_100_V1_0_4326_resample.tif) DO (

	SET infile=%%i
	SET outfile_A=!infile:.tif=_NoData.tif!
	SET outfile_B=!infile:.tif=_0_NoData.tif!
	
	call gdalwarp -wo NUM_THREADS=8 -te -180.00 -59.99999942 179.999998559 84.00 -tr 0.00083333333 0.00083333333 -ot UInt16 -dstnodata 65535 -wo SKIP_NOSOURCE=YES -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -wo OPTIMIZE_SIZE=true !infile! WP_mastergrid_base_2023_v3_B.tif !outfile_A!
	call gdalwarp -wo NUM_THREADS=8 -te -180.00 -59.99999942 179.999998559 84.00 -tr 0.00083333333 0.00083333333 -ot UInt16 -dstnodata 65535 -wo SKIP_NOSOURCE=YES -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -wo OPTIMIZE_SIZE=true WP_mastergrid_base_2023_v3.tif !outfile_A! !outfile_B!
)

::-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
::Create residential only layer by taking non-residential layer away from total layer

SET "2010_total=%mypath%GHS_BUILT_V_E2010_GLOBE_R2023A_54009_100_V1_0_4326_resample_0_NoData.tif"
SET "2010_NRES=%mypath%GHS_BUILT_V_NRES_E2010_GLOBE_R2023A_54009_100_V1_0_4326_resample_0_NoData.tif"
SET "2015_total=%mypath%GHS_BUILT_V_E2015_GLOBE_R2023A_54009_100_V1_0_4326_resample_0_NoData.tif"
SET "2015_NRES=%mypath%GHS_BUILT_V_NRES_E2015_GLOBE_R2023A_54009_100_V1_0_4326_resample_0_NoData.tif"
SET "2020_total=%mypath%GHS_BUILT_V_E2020_GLOBE_R2023A_54009_100_V1_0_4326_resample_0_NoData.tif"
SET "2020_NRES=%mypath%GHS_BUILT_V_NRES_E2020_GLOBE_R2023A_54009_100_V1_0_4326_resample_0_NoData.tif"
SET "2025_total=%mypath%GHS_BUILT_V_E2025_GLOBE_R2023A_54009_100_V1_0_4326_resample_0_NoData.tif"
SET "2025_NRES=%mypath%GHS_BUILT_V_NRES_E2025_GLOBE_R2023A_54009_100_V1_0_4326_resample_0_NoData.tif"
SET "2030_total=%mypath%GHS_BUILT_V_E2030_GLOBE_R2023A_54009_100_V1_0_4326_resample_0_NoData.tif"
SET "2030_NRES=%mypath%GHS_BUILT_V_NRES_E2030_GLOBE_R2023A_54009_100_V1_0_4326_resample_0_NoData.tif"

call gdal_calc -A !2010_total! -B !2010_NRES! --outfile=GHS_BUILT_V_RES_E2010_GLOBE_R2023A_54009_100_V1_0_4326_resample_0_NoData.tif --calc="A-B" --co BIGTIFF=YES --co COMPRESS=LZW
call gdal_calc -C !2015_total! -D !2015_NRES! --outfile=GHS_BUILT_V_RES_E2015_GLOBE_R2023A_54009_100_V1_0_4326_resample_0_NoData.tif --calc="C-D" --co BIGTIFF=YES --co COMPRESS=LZW
call gdal_calc -E !2020_total! -F !2020_NRES! --outfile=GHS_BUILT_V_RES_E2020_GLOBE_R2023A_54009_100_V1_0_4326_resample_0_NoData.tif --calc="E-F" --co BIGTIFF=YES --co COMPRESS=LZW
call gdal_calc -G !2025_total! -H !2025_NRES! --outfile=GHS_BUILT_V_RES_E2025_GLOBE_R2023A_54009_100_V1_0_4326_resample_0_NoData.tif --calc="G-H" --co BIGTIFF=YES --co COMPRESS=LZW
call gdal_calc -I !2030_total! -J !2030_NRES! --outfile=GHS_BUILT_V_RES_E2030_GLOBE_R2023A_54009_100_V1_0_4326_resample_0_NoData.tif --calc="I-J" --co BIGTIFF=YES --co COMPRESS=LZW

::-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: create binary version of total, residential and non-residental covariates

FOR %%i IN (GHS_BUILT_V_*_GLOBE_R2023A_54009_100_V1_0_4326_resample_0_NoData.tif) DO (
	
	SET infile=%%i
	SET outfile=!infile:_0_NoData.tif=_0_NoData_1_0.tif!
	
	call gdal_calc -A !infile! --outfile=!outfile! --calc="1*(A > 0)" --co BIGTIFF=YES --co COMPRESS=LZW
)

:: convert to Byte file type, and change nodata to 255 (max for this file type)
FOR %%i IN (GHS_BUILT_V_*_GLOBE_R2023A_54009_100_V1_0_4326_resample_0_NoData_1_0.tif) DO (
	
	SET infile=%%i
	SET outfile=!infile:1_0.tif=binary.tif!
	gdalwarp -wo NUM_THREADS=8 -ot Byte -dstnodata 255 -wo SKIP_NOSOURCE=YES -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -wo OPTIMIZE_SIZE=true !infile! %MYPATH%!outfile!
)


ECHO .
ECHO end of script