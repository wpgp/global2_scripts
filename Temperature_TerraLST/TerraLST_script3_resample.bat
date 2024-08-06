:: TerraLST_script3_resample.bat - script 3, run on TerraLST .tif mosaics
:: This script will resample TerraLST mosaics to 100m resolution, using bilinear method.
:: Output files are matched to the Global 2 mastergrid extent.
:: Path to out directory is set in the script below. Update this path accordingly, or alternatively remove from script ensuring variables are removed from gdal functions (e.g. %outpath%).
:: This script will run from OSGeo4W Shell ensure that the script and input raw TerraLST .tif files are located in the inpath directory, navigate to this directory using the cd command, then run.

:: By Tom McKeen 14/11/2023

@ECHO on
SETLOCAL EnableDelayedExpansion

SET mypath=F:\Global2\TerraLST\resampled\

FOR %%i in (*.tif) DO (

	SET infile=%%i
	SET outfile=!infile:.tif=_100m.tif!
	
	gdalwarp -wo NUM_THREADS=8 -te -180.00 -59.99999942 179.999998559 84.00 -tr 0.00083333333 0.00083333333 -r bilinear -ot Float32 -srcnodata -99999 -dstnodata -99999 -wo SKIP_NOSOURCE=YES -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -wo OPTIMIZE_SIZE=true !infile! %mypath%!outfile!
	)

ECHO .
ECHO end of script