:: WDPA_script4_mosaic_marine.bat - script 4, run on clipped Land rasters overlaid on the mastergrid base.
:: This script will mosaic WDPA marine rasters to clipped and standardised WDPA land counterpart rasters.
:: Two rasters are produced for each epoch, total of 16 rasters: (i) one IUCN category 1 raster and (ii) one IUCN category 'others' raster:
:: 	(i) WDPA_pre2015_cat1_100m_1_0_NoData.tif.....WDPA_pre2022_cat1_100m_1_0_NoData.tif (1=Protected area pixels, 0=Non-protected area land pixels, NoData=Non-protected area ocean pixels)
:: 	(ii)WDPA_pre2015_cat0_100m_1_0_NoData.tif.....WDPA_pre2022_cat0_100m_1_0_NoData.tif (1=Protected area pixels, NoData=Non-protected area pixels)
:: Path to WDPA marine mosaics for the epoch 2015-22 are set in the script below. Update this path accordingly, or alternatively remove from script ensuring variables are removed from gdal functions (e.g. %MYPATH%). If removed, these rasters must be located in the inpath directory.
:: This script will run from OSGeo4W Shell ensure that the script and input clipped/overlaid Land rasters are located in the inpath directory, navigate to this directory using the cd command, then run. Will need to input desired epoch year to be run when requested.

:: The next script to run is [insert Maksym's dist-to script name].

:: By Tom McKeen 01/06/2023

@ECHO on
SETLOCAL EnableDelayedExpansion

:: set path to marine rasters epoch 2015-2022
SET "MYPATH=F:\Global2\WDPA\processed_mastergridv2\mosaic_postgis\"

:: need to input the data year here (on following line) - make sure there are no trailing spaces
SET /p year="Enter any year between 2015-2022 (e.g. 2015): "

echo year=%year%
echo mypath=%MYPATH%
echo About to mosaic LAND and MARINE rasters for each ICUN category for the year %year%.

:: complete for IUCN category 1
gdalwarp -wo NUM_THREADS=8 -te -180.00 -59.99999942 179.999998559 84.00 -tr 0.00083333333 0.00083333333 -ot Byte -dstnodata 255 -wo SKIP_NOSOURCE=YES -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -wo OPTIMIZE_SIZE=true WDPA_pre%year%_LAND_1_B.tif %MYPATH%WDPA_pre%year%_MARINE_1.tif WDPA_pre%year%_cat1_100m_1_0_NoData.tif
:: complete for IUCN category 'others'
gdalwarp -wo NUM_THREADS=8 -te -180.00 -59.99999942 179.999998559 84.00 -tr 0.00083333333 0.00083333333 -ot Byte -dstnodata 255 -wo SKIP_NOSOURCE=YES -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -wo OPTIMIZE_SIZE=true WDPA_pre%year%_LAND_0_B.tif %MYPATH%WDPA_pre%year%_MARINE_0.tif WDPA_pre%year%_cat0_100m_1_0_NoData.tif

ECHO.
ECHO.
ECHO.
ECHO end of script reached.
ECHO run for the year %year%
ECHO end of script.