:: TerraLST_script1_translate.bat - script 1, run on raw TerraLST .tif files
:: This script will change the datatype from Float64 to Float32 and set the NoData value to -99999 for all TerraLST .tif files.
:: Path to out directory is set in the script below. Update this path accordingly, or alternatively remove from script ensuring variables are removed from gdal functions (e.g. %outpath%).
:: This script will run from OSGeo4W Shell ensure that the script and input raw TerraLST .tif files are located in the inpath directory, navigate to this directory using the cd command, then run.

:: By Tom McKeen 14/11/2023

@ECHO on
SETLOCAL EnableDelayedExpansion

SET mypath=F:\Global2\TerraLST\translated\

FOR %%i in (*.tif) DO (

	SET infile=%%i
	SET outfile=!infile:.tif=.tif!
	gdal_translate -ot Float32 -of GTiff -b 1 -projwin_srs EPSG:4326 -a_nodata -99999 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES !infile! %mypath%!outfile!
	)
	
ECHO .
ECHO end of script