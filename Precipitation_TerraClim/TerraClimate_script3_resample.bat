:: TerraClimate_script3_resample.bat - script 3, run on TerraClimate yearly average precipitation .tif files.
:: This script will resample TerraClimate yearly average precipitation .tif files to 100m resolution, using bilinear method.
:: Output files are matched to the Global 2 mastergrid extent.
:: Path to out directory is set in the script below. Update this path accordingly, or alternatively remove from script ensuring variables are removed from gdal functions (e.g. %outpath%).
:: This script will run from OSGeo4W Shell ensure that the script and input raw TerraClimate .tif files are located in the inpath directory, navigate to this directory using the cd command, then run.

:: By Tom McKeen 14/11/2023

@ECHO on
SETLOCAL EnableDelayedExpansion

SET mypath=F:\Global2\TerraClimate\resampled\

FOR %%i in (TerraClimate_ppt_*_yravg.tif) DO (

	SET infile=%%i
	SET outfile=!infile:.tif=_100m.tif!
	call gdalwarp -wo NUM_THREADS=8 -te -180.00 -59.99999942 179.999998559 84.00 -tr 0.00083333333 0.00083333333 -r bilinear -ot Float32 -srcnodata -99999 -dstnodata -99999 -wo SKIP_NOSOURCE=YES -wo OPTIMIZE_SIZE=true -co BLOCKXSIZE=512 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -co BLOCKYSIZE=512 -co TILED=YES -of gtiff !infile! %mypath%!outfile!
	)

ECHO .
ECHO end of script