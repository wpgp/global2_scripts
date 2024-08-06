@ECHO on
SETLOCAL EnableDelayedExpansion

:: Written by Alex Cunningham 24/05/2023

:: VIIRS_script1.bat is the first script used to process VIIRS NTL v2.1/2.2. This script prepares the annual average radiance (masked) global datasets from the Earth Observation Group for the WorldPop 100m mastergrid. This script then changes the extent and resolution of the input data, before dealing with the nodata band introduced by extending the raw data further North.

:: Change the path below to the location of the input VIIRs v2.1/2.2 (annual average masked) data. To avoid GDAL issues, also save (and run) this batch file from the same folder. This folder should house each annual raster to be processed, using the naming scheme found upon download. The For loops below will then run the process for each years raster that is found in the folder.

:: MODIFY AND INSERT BELOW 'X:\LOCATION OF VIIRS DATA\'
SET mypath= 

:: Each section will loop through the named rasters in the folder and save the output file to the same folder.



:: Give raster a nodata value - it is unassigned upon download
FOR %%i IN (VNL_*_vcmslcfg_*average_masked.dat.tif) DO (
	
	SET infile=%%i
	SET outfile=!infile:.tif=A.tif!
	
	gdal_translate -a_nodata -999999 !infile! !outfile! -co COMPRESS=LZW -co BIGTIFF=YES
)


:: Change cell size and extent to 100m mastergrid v2 specifications, using bilinear resampling

FOR %%i IN (VNL_*_vcmslcfg_*average_masked.datA.tif) DO (
	
	SET infile=%%i
	SET outfile=!infile:A.tif=_bilB.tif!
	
	gdalwarp -wo NUM_THREADS=8 -ot Float32 -te -180 -60.99999942 179.999999856 84 -tr 0.00083333333 0.00083333333 -r bilinear -srcnodata -999999 -dstnodata -999999 -co COMPRESS=LZW -co BLOCKXSIZE=512 -co BLOCKYSIZE=512 -co TILED=YES -co PREDICTOR=2 -co BIGTIFF=YES -wo SKIP_NOSOURCE=YES -wo OPTIMIZE_SIZE=true -of gtiff !infile! %mypath%!outfile!
)


:: Change nodata value in input dataset (nodata=-999999) to an actual value (-999999)
FOR %%i IN (VNL_*_vcmslcfg_*average_masked.dat_bilB.tif) DO (
	
	SET infile=%%i
	SET outfile=!infile:B.tif=C.tif!
	
	gdal_translate -a_nodata none !infile! !outfile! -co COMPRESS=LZW -co BIGTIFF=YES
)


:: Convert value of -999999 to 0 --> remove nodata stripe. Set nodata value in output to -999999
FOR %%i IN (VNL_*_vcmslcfg_*average_masked.dat_bilC.tif) DO (
	
	SET infile=%%i
	SET outfile=!infile:C.tif=D.tif!
	
	call gdal_calc -A !infile! --outfile=!outfile! --calc="A*(A > -20000)" --NoDataValue=-999999 --co BIGTIFF=YES --co COMPRESS=LZW
)

:: Change occurences of -0 to 0
FOR %%i IN (VNL_*_vcmslcfg_*average_masked.dat_bilD.tif) DO (
	
	SET infile=%%i
	SET outfile=!infile:D.tif=E.tif!
	
	call gdal_calc -B !infile! --outfile=!outfile! --calc="(B+1)-1" --NoDataValue=-999999 --co BIGTIFF=YES --co COMPRESS=LZW
)

:: Please move on to script 2 for next steps: burning to coastlines

ECHO end of script