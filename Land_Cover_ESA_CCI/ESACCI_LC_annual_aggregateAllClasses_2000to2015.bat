:: ESACCI_LC_annual_aggregateAllClasses_2000to2015_Global2.bat - script number 3, to be run on the reclassified ESA CCI Landcover tiffs 2000 to 2015.
:: This script will create one summary file which aggregates all land cover classes together.
:: This script has to be run from within OSGeo4W Shell, have script in inpath directory, navigate to it with cd command, then run. 

:: The next script to run is ESACCI_LC_annual_resample_Global2.bat.

:: by Dorothea Woods 22/02/2023

@echo off
setlocal enabledelayedexpansion


set "INPATH=X:/Projects/WP519091_Global2/Working/WP1/TheaW/Land_Cover_ESA_CCI/processed/2000to2015/tiffs/reclass/"
REM set "OUTPATH=X:/Projects/WP519091_Global2/Working/WP1/TheaW/Land_Cover_ESA_CCI/processed/2000to2015/tiffs/reclass/"

:: need to input the data year here (on following line) to be between 2000 and 2015 - make sure there are no trailing spaces
SET year=2014
echo inpath=%INPATH%
echo All land cover classes are now being aggregated together for year %year%. This will take several minutes, please wait...
	
gdal_calc -A %INPATH%ESACCI-LC-L4-LCCS-Map-300m-P1Y-%year%-v2.0.7cds_UINT8_RECLASSIFIED_11.tif -B %INPATH%ESACCI-LC-L4-LCCS-Map-300m-P1Y-%year%-v2.0.7cds_UINT8_RECLASSIFIED_40.tif -C %INPATH%ESACCI-LC-L4-LCCS-Map-300m-P1Y-%year%-v2.0.7cds_UINT8_RECLASSIFIED_130.tif -D %INPATH%ESACCI-LC-L4-LCCS-Map-300m-P1Y-%year%-v2.0.7cds_UINT8_RECLASSIFIED_140.tif -E %INPATH%ESACCI-LC-L4-LCCS-Map-300m-P1Y-%year%-v2.0.7cds_UINT8_RECLASSIFIED_150.tif -F %INPATH%ESACCI-LC-L4-LCCS-Map-300m-P1Y-%year%-v2.0.7cds_UINT8_RECLASSIFIED_160.tif -G %INPATH%ESACCI-LC-L4-LCCS-Map-300m-P1Y-%year%-v2.0.7cds_UINT8_RECLASSIFIED_190.tif -H %INPATH%ESACCI-LC-L4-LCCS-Map-300m-P1Y-%year%-v2.0.7cds_UINT8_RECLASSIFIED_200.tif -I %INPATH%ESACCI-LC-L4-LCCS-Map-300m-P1Y-%year%-v2.0.7cds_UINT8_RECLASSIFIED_210.tif --outfile=%INPATH%ESACCI-LC-L4-LCCS-Map-300m-P1Y-%year%-v2.0.7cds_UINT8_RECLASSIFIED.tif --calc="A+B+C+D+E+F+G+H+I" --NoDataValue=255 --co COMPRESS=LZW --co PREDICTOR=2 --co BIGTIFF=YES --overwrite --quiet
		
ECHO Processing completed for the year %year%.
ECHO.
ECHO.
ECHO.
ECHO End of script reached for script ESACCI_LC_annual_aggregateAllClasses_2000to2015.bat