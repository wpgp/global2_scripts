:: TerraClimate_script1_translate.bat - script 1, run on raw TerraClimate precipitation .netcdf files
:: This script will extract each monthly band from an annual TerraClimate precipitation .tif raster and save as a distinct file.
:: Each monthly extract will be in Float32 datatype.
:: The specific file year must be input when requested. Repeat script with different year input for multiple years.
:: Path to out directory is set in the script below. Update this path accordingly, or alternatively remove from script ensuring variables are removed from gdal functions (e.g. %outpath%).
:: This script will run from OSGeo4W Shell ensure that the script and input raw TerraClimate .tif files are located in the inpath directory, navigate to this directory using the cd command, then run.

:: By Tom McKeen 14/11/2023

@ECHO on
SETLOCAL EnableDelayedExpansion

SET mypath=F:\Global2\TerraClimate\translated\

SET /p year="Enter any year between 2015-2023 (e.g. 2015): "

echo year=%year%
echo mypath=%mypath%
echo About to translate netCDF band for each TerraClimate raster for the year %year%.

FOR %%i in (TerraClimate_ppt_%year%.nc) DO (

	SET infile=%%i
	SET "January=%mypath%TerraClimate_ppt_%year%_1.tif"
	SET "February=%mypath%TerraClimate_ppt_%year%_2.tif"
	SET "March=%mypath%TerraClimate_ppt_%year%_3.tif"
	SET "April=%mypath%TerraClimate_ppt_%year%_4.tif"
	SET "May=%mypath%TerraClimate_ppt_%year%_5.tif"
	SET "June=%mypath%TerraClimate_ppt_%year%_6.tif"
	SET "July=%mypath%TerraClimate_ppt_%year%_7.tif"
	SET "August=%mypath%TerraClimate_ppt_%year%_8.tif"
	SET "September=%mypath%TerraClimate_ppt_%year%_9.tif"
	SET "October=%mypath%TerraClimate_ppt_%year%_10.tif"
	SET "November=%mypath%TerraClimate_ppt_%year%_11.tif"
	SET "December=%mypath%TerraClimate_ppt_%year%_12.tif"
	
	gdal_translate -ot Float32 -of GTiff -b 1 -projwin_srs EPSG:4326 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES !infile! !January!
	gdal_translate -ot Float32 -of GTiff -b 2 -projwin_srs EPSG:4326 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES !infile! !February!
	gdal_translate -ot Float32 -of GTiff -b 3 -projwin_srs EPSG:4326 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES !infile! !March!
	gdal_translate -ot Float32 -of GTiff -b 4 -projwin_srs EPSG:4326 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES !infile! !April!
	gdal_translate -ot Float32 -of GTiff -b 5 -projwin_srs EPSG:4326 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES !infile! !May!
	gdal_translate -ot Float32 -of GTiff -b 6 -projwin_srs EPSG:4326 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES !infile! !June!
	gdal_translate -ot Float32 -of GTiff -b 7 -projwin_srs EPSG:4326 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES !infile! !July!
	gdal_translate -ot Float32 -of GTiff -b 8 -projwin_srs EPSG:4326 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES !infile! !August!
	gdal_translate -ot Float32 -of GTiff -b 9 -projwin_srs EPSG:4326 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES !infile! !September!
	gdal_translate -ot Float32 -of GTiff -b 10 -projwin_srs EPSG:4326 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES !infile! !October!
	gdal_translate -ot Float32 -of GTiff -b 11 -projwin_srs EPSG:4326 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES !infile! !November!
	gdal_translate -ot Float32 -of GTiff -b 12 -projwin_srs EPSG:4326 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES !infile! !December!
	)

ECHO .
ECHO end of script