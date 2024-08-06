:: TerraClimate_script2_translate.bat - script 2, run on translated TerraClimate precipitation monthly .tif files
:: This script will calculate average precipitation for a year.
:: The specific file year must be input when requested. Repeat script with different year input for multiple years.
:: Path to out directory is set in the script below. Update this path accordingly, or alternatively remove from script ensuring variables are removed from gdal functions (e.g. %outpath%).
:: This script will run from OSGeo4W Shell ensure that the script and input raw TerraClimate .tif files are located in the inpath directory, navigate to this directory using the cd command, then run.

:: By Tom McKeen 14/11/2023

@ECHO on
SETLOCAL EnableDelayedExpansion

SET mypath=F:\Global2\TerraClimate\computed\

SET /p year="Enter any year between 2015-2023 (e.g. 2015): "

echo year=%year%
echo mypath=%mypath%
echo About to compute yearly average precipitation using TerraClimate monthly precipitation for the year %year%.

SET "January=TerraClimate_ppt_%year%_1.tif"
SET "February=TerraClimate_ppt_%year%_2.tif"
SET "March=TerraClimate_ppt_%year%_3.tif"
SET "April=TerraClimate_ppt_%year%_4.tif"
SET "May=TerraClimate_ppt_%year%_5.tif"
SET "June=TerraClimate_ppt_%year%_6.tif"
SET "July=TerraClimate_ppt_%year%_7.tif"
SET "August=TerraClimate_ppt_%year%_8.tif"
SET "September=TerraClimate_ppt_%year%_9.tif"
SET "October=TerraClimate_ppt_%year%_10.tif"
SET "November=TerraClimate_ppt_%year%_11.tif"
SET "December=TerraClimate_ppt_%year%_12.tif"

call gdal_calc -A !January! -B !February! -C !March! -D !April! -E !May! -F !June! -G !July! -H !August! -I !September! -J !October! -K !November! -L !December! --outfile=%mypath%TerraClimate_ppt_%year%_yravg.tif --calc="(A+B+C+D+E+F+G+H+I+J+K+L)/12" --co BIGTIFF=YES --co COMPRESS=LZW --NoDataValue=-99999 --type=Float32 --format=GTiff

ECHO .
ECHO end of script