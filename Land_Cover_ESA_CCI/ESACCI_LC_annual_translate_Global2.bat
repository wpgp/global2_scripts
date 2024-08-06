:: ESACCI_LC_annual_format_Global2.bat - script number 1, to be run on the annual ESA CCI Landcover NetCDF files 2016-2022 in order to convert them to geotiffs. 
:: Also, works for 2000-2015 file.
:: This script will ask the user to drag and drop a folder containing the NetCDF files into the command prompt, and converts all of them to tiffs. Names remain, just extension gets changed.
:: This script can be run from the command line, it will take circa 15minutes per dataset.
:: The next script to run is ESACCI_LC_annual_reclassiy_Global2.bat.
:: 26/01/2023 by Dorothea Woods & Andy Harfoot.
:: 
:: input folder 2016-2022: X:\Personal\dh2r15\Global2\LandCover_ESA_CCI\download\LandCover_ESA_CCI_2016to2022
:: input folder 2000-2015: X:\Personal\dh2r15\Global2\LandCover_ESA_CCI\download\LandCover_ESA_CCI_2015
:: 
:: After processing, move output tiffs to X:\Personal\dh2r15\Global2\LandCover_ESA_CCI\processed\YEAR\tiffs

@ECHO off
SETLOCAL EnableDelayedExpansion

REM check for and call OSGeo4W to define environments, this is needed to command line is aware of gdal commands 
REM Find install of QGIS
for /d %%d in ("C:\OSGeo4W64*" "C:\OSGeo4W*" "C:\Program Files\QGIS*" 
"C:\Program Files (x86)\QGIS*") do (
     echo Using OSGeo4W instance here: %%d
     call "%%d\OSGeo4W.bat" echo.
     goto :QGIS_ENV_SET
)

:QGIS_ENV_SET
@echo off

if not defined OSGEO4W_ROOT (
     echo QGIS not found, cannot continue
     pause
     goto :EOF
)





echo Drag and drop the folder containing NetCDF files to process
SET /P "INPATH=:"

pushd !INPATH!

for %%i IN (*.nc) do (
	REM echo %%i
	echo %inpath%
	gdalmdimtranslate -array lccs_class NETCDF:%%i %%~dpni.tif
		
)

echo Script completed
pause