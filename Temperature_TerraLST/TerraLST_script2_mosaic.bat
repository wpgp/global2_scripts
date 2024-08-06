:: TerraLST_script2_mosaic.bat - script 2, run on translated TerraLST .tif files
:: This script will change mosaic corresponding TerraLST .tif files based on year.
:: The specific file year must be input when requested. Output files are matched to the Global 2 mastergrid extent.
:: Path to out directory is set in the script below. Update this path accordingly, or alternatively remove from script ensuring variables are removed from gdal functions (e.g. %outpath%).
:: This script will run from OSGeo4W Shell ensure that the script and input raw TerraLST .tif files are located in the inpath directory, navigate to this directory using the cd command, then run.

:: By Tom McKeen 14/11/2023

@ECHO on
SETLOCAL EnableDelayedExpansion

SET mypath=F:\Global2\TerraLST\mosaics\

SET /p year="Enter any year between 2015-2023 (e.g. 2015): "

echo year=%year%
echo mypath=%mypath%
echo About to mosaic rasters for each TerraLST category for the year %year%.

gdalwarp -wo NUM_THREADS=8 -te -180.00 -59.99999942 179.999998559 84.00 -ot Float32 -srcnodata -99999 -dstnodata -99999 -wo SKIP_NOSOURCE=YES -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -wo OPTIMIZE_SIZE=true lst_%year%-0000000000-0000000000.tif lst_%year%-0000000000-0000023296.tif !mypath!lst_%year%_tavg.tif

ECHO .
ECHO end of script