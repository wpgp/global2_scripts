:: ESACCI_LC_annual_reclassifyAllClasses_Global2.bat - script number 3, to be run on the reclassified ESA CCI Landcover tiffs 2016-2022.
:: This script will create one summary file per year which contains all 9 reclassified land cover classes.
:: This script has to be run from within OSGeo4W Shell, have script in inpath directory, navigate to it with cd command, then run. 

:: The next script to run is ESACCI_LC_annual_resample_Global2.bat.

:: by Dorothea Woods 07/02/2023

@echo off
setlocal enabledelayedexpansion


set "INPATH=X:/Projects/WP519091_Global2/Working/WP1/TheaW/Land_Cover_ESA_CCI/processed/2016to2020/tiffs/reclass/"
REM set "OUTPATH=X:/Projects/WP519091_Global2/Working/WP1/TheaW/Land_Cover_ESA_CCI/processed/tiffs/reclass/"

:: need to input the data year here (on following line) - make sure there are no trailing spaces
SET /p year="Enter any year between 2016 and 2022 (e.g. 2022): "

echo year=%year%
echo inpath=%INPATH%
echo All land cover classes are now aggregated together for year %year%. This will take several minutes, please wait...

gdal_calc -A %INPATH%C3S-LC-L4-LCCS-Map-300m-P1Y-%year%-v2.1.1_UINT8_RECLASSIFIED_11.tif -B %INPATH%C3S-LC-L4-LCCS-Map-300m-P1Y-%year%-v2.1.1_UINT8_RECLASSIFIED_40.tif -C %INPATH%C3S-LC-L4-LCCS-Map-300m-P1Y-%year%-v2.1.1_UINT8_RECLASSIFIED_130.tif -D %INPATH%C3S-LC-L4-LCCS-Map-300m-P1Y-%year%-v2.1.1_UINT8_RECLASSIFIED_140.tif -E %INPATH%C3S-LC-L4-LCCS-Map-300m-P1Y-%year%-v2.1.1_UINT8_RECLASSIFIED_150.tif -F %INPATH%C3S-LC-L4-LCCS-Map-300m-P1Y-%year%-v2.1.1_UINT8_RECLASSIFIED_160.tif -G %INPATH%C3S-LC-L4-LCCS-Map-300m-P1Y-%year%-v2.1.1_UINT8_RECLASSIFIED_190.tif -H %INPATH%C3S-LC-L4-LCCS-Map-300m-P1Y-%year%-v2.1.1_UINT8_RECLASSIFIED_200.tif -I %INPATH%C3S-LC-L4-LCCS-Map-300m-P1Y-%year%-v2.1.1_UINT8_RECLASSIFIED_210.tif --outfile=%INPATH%ESACCI-LC-L4-LCCS-Map-300m-P1Y-%year%-v2.1.1_UINT8_RECLASSIFIED.tif --calc="A+B+C+D+E+F+G+H+I" --NoDataValue=255 --co COMPRESS=LZW --co PREDICTOR=2 --co BIGTIFF=YES --overwrite --quiet


ECHO.
ECHO.
ECHO.
ECHO end of script reached for script ESACCI_LC_annual_aggregateAllClasses.bat
ECHO run for the year %year%
ECHO end of script