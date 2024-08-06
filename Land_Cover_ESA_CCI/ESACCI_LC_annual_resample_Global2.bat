:: ESACCI_LC_annual_resample_Global2.bat - script number 4, to be run on the reclassified and aggregated annual ESA CCI Landcover tiffs 2000-2022.
:: This script will resample to 100m resolution and the extent of Mastergrid v2
:: Ensure correct input and output paths are set on lines 16 and 17.
:: This script has to be run from within OSGeo4W Shell, have script in inpath directory, navigate to it with cd command, then run 

:: The next scripts to run are ESACCI_LC_annual_binary_Global2.bat.

:: by Dorothea Woods 08/02/2023




setlocal enabledelayedexpansion
@echo off

set "INPATH=X:/Projects/WP519091_Global2/Working/WP1/TheaW/Land_Cover_ESA_CCI/processed/2000to2015/tiffs/reclass/"
set "OUTPATH=X:/Projects/WP519091_Global2/Working/WP1/TheaW/Land_Cover_ESA_CCI/processed/2000to2015/tiffs/resampled/"
cd %inpath%

echo current directory:  %cd%
echo inpath: %INPATH%
echo outpath: %OUTPATH%

for %%i IN (*.tif) do (
	echo Inside the loop
	

	set dirname=%%~dpi 
	set filename=%%~nxi
	set basename=%%~ni

	
	echo %%~i
	echo dirname !dirname!
	echo filename with extension !filename!
	echo basename, without extension !basename!
	echo outpath !outpath!
	
	:: Resample to 100m resolution and extent of Mastergrid v2. This command will snap and clip to new extent.
	gdalwarp -wo NUM_THREADS=8 -s_srs EPSG:4326 -t_srs EPSG:4326 -te -180 -60.99999942 179.999999856 84 -tr 0.00083333333 0.00083333333 -srcnodata 255 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -wo SKIP_NOSOURCE=YES -wo OPTIMIZE_SIZE=true -of gtiff -overwrite %INPATH%%%~nxi %OUTPATH%%%~ni_100m.tif
	
)


ECHO.
ECHO end of script reached for script ESACCI_LC_annual_resample_Global2.bat
pause
