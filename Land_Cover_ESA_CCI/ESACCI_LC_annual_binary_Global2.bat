:: ESACCI_LC_annual_binary_Global2.bat - script number 5, to be run on the resampled ESA CCI Landcover tiffs 2015-2022.
:: This script produces binary files with 1 depicting the land cover class of interest, and all other pixels set to 0. 
:: Files are created in the input folder. Move them to the desired output directory once script has finished.
:: by Dorothea Woods 16/02/2023



@echo off
setlocal enabledelayedexpansion


REM set "INPATH=X:/Projects/WP519091_Global2/Working/WP1/TheaW/Land_Cover_ESA_CCI/2016to2020/processed/tiffs/resampled/"
REM set "OUTPATH=X:/Projects/WP519091_Global2/Working/WP1/TheaW/Land_Cover_ESA_CCI/2016to2020/processed/tiffs/binary/"

REM echo %INPATH%



echo Drag and drop the folder containing resampled tif files to process
SET /P "INPATH=:"

pushd !INPATH!

for %%i IN (*.tif) do (
	echo Processing %%~i 
	echo This will take approximately 30mins. Please wait...
	echo !INPATH!
	gdal_calc -A %%~i --outfile=%%~ni_binary.tif --calc="1*((A>=1)*(A<=245))" --NoDataValue=255 --co COMPRESS=LZW --co PREDICTOR=2 --co BIGTIFF=YES --overwrite --quiet
	echo Output file completed: %%~ni_binary.tif
	echo. 	
)

echo Loop completed
pause



ECHO.
ECHO end of script reached for script ESACCI_LC_annual_binary_Global2.bat

