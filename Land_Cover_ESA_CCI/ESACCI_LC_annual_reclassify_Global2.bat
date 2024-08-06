:: ESACCI_LC_annual_reclassify_Global2.bat - script number 2, to be run on the annual ESA CCI Landcover tiffs 2000-2022.
:: This script will aggregate land cover classes in line with Global 1 project
:: This script has to be run from within OSGeo4W Shell, have script in inpath directory, navigate to it with cd command, then run 
:: echos of dirname filename and basename only work during first iteration but all files throughout all iterations are produced correctly.
:: Ensure correct input/output folder are specified dependend on whether processing years 2000 to 2015 or 2016 to 2022

:: The next scripts to run are ESACCI_LC_annual_aggregateAllClasses_2016to2022_Global2.bat. and ESACCI_LC_annual_aggregateAllClasses_2015_Global2.bat.

:: by Dorothea Woods 06/02/2023




setlocal enabledelayedexpansion
@echo off

set "INPATH=X:/Projects/WP519091_Global2/Working/WP1/TheaW/Land_Cover_ESA_CCI/processed/2000to2015/tiffs/"
set "OUTPATH=X:/Projects/WP519091_Global2/Working/WP1/TheaW/Land_Cover_ESA_CCI/processed/2000to2015/tiffs/reclass/"

echo %INPATH%

for %%i IN (%INPATH%*.tif) do (

    set dirname=%%~dpi 
	set filename=%%~nxi
	set basename=%%~ni
	
	echo !dirname!
	echo !filename!
	echo !basename!
	
	:: Aggregate classes 10, 11, 12, 20, 30, 40 to new value of 11, create binary raster
	gdal_calc -A %INPATH%%%~nxi --outfile=%OUTPATH%%%~ni_UINT8_RECLASSIFIED_11.tif --calc="11*(A<=45)" --NoDataValue=255 --co COMPRESS=LZW --co PREDICTOR=2 --co BIGTIFF=YES --overwrite --quiet
	
	:: Aggregate classes 50, 60, 61, 62, 70, 71, 72, 80, 81, 82, 90, 100 to new value of 40, create binary raster
	gdal_calc -A %INPATH%%%~nxi --outfile=%OUTPATH%%%~ni_UINT8_RECLASSIFIED_40.tif --calc="40*((A>45)*(A<=105))" --NoDataValue=255 --co COMPRESS=LZW --co PREDICTOR=2 --co BIGTIFF=YES --overwrite --quiet
	
	:: Aggregate classes 120, 121, 122 to new value of 130, create binary raster
	gdal_calc -A %INPATH%%%~nxi --outfile=%OUTPATH%%%~ni_UINT8_RECLASSIFIED_130.tif --calc="130*((A>119)*(A<=123))" --NoDataValue=255 --co COMPRESS=LZW --co PREDICTOR=2 --co BIGTIFF=YES --overwrite --quiet
	
	:: Aggregate classes 110, 130, 140 to new value of 140, create binary raster
	gdal_calc -A %INPATH%%%~nxi --outfile=%OUTPATH%%%~ni_UINT8_RECLASSIFIED_140.tif --calc="140*((A>129)*(A<=141))+140*(A==110)" --NoDataValue=255 --co COMPRESS=LZW --co PREDICTOR=2 --co BIGTIFF=YES --overwrite --quiet
	
	:: Aggregate classes 150, 151, 152, 153 to new value of 150, create binary raster
	gdal_calc -A %INPATH%%%~nxi --outfile=%OUTPATH%%%~ni_UINT8_RECLASSIFIED_150.tif --calc="150*((A>149)*(A<=154))" --NoDataValue=255 --co COMPRESS=LZW --co PREDICTOR=2 --co BIGTIFF=YES --overwrite --quiet
	
	:: Aggregate classes 160, 170, 180 to new value of 160, create binary raster
	gdal_calc -A %INPATH%%%~nxi --outfile=%OUTPATH%%%~ni_UINT8_RECLASSIFIED_160.tif --calc="160*((A>159)*(A<=181))" --NoDataValue=255 --co COMPRESS=LZW --co PREDICTOR=2 --co BIGTIFF=YES --overwrite --quiet
	
	:: Aggregate classes 190 to new value of 190, create binary raster
	gdal_calc -A %INPATH%%%~nxi --outfile=%OUTPATH%%%~ni_UINT8_RECLASSIFIED_190.tif --calc="190*(A==190)" --NoDataValue=255 --co COMPRESS=LZW --co PREDICTOR=2 --co BIGTIFF=YES --overwrite --quiet
	
	:: Aggregate classes 200, 201, 202 to new value of 200, create binary raster
	gdal_calc -A %INPATH%%%~nxi --outfile=%OUTPATH%%%~ni_UINT8_RECLASSIFIED_200.tif --calc="200*((A>199)*(A<=205))" --NoDataValue=255 --co COMPRESS=LZW --co PREDICTOR=2 --co BIGTIFF=YES --overwrite --quiet
	
	:: Aggregate classes 210, 220 to new value of 210, create binary raster
	gdal_calc -A %INPATH%%%~nxi --outfile=%OUTPATH%%%~ni_UINT8_RECLASSIFIED_210.tif --calc="210*((A>209)*(A<=225))" --NoDataValue=255 --co COMPRESS=LZW --co PREDICTOR=2 --co BIGTIFF=YES --overwrite --quiet
	
)

ECHO.
ECHO end of script reached for script ESACCI_LC_annual_reclassify_Global2.bat

