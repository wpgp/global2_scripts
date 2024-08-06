@ECHO on
SETLOCAL EnableDelayedExpansion

:: Written by Alex Cunningham 06/06/2023

:: Ensure mastergrid is placed into the same folder as VIIRS data output from script 1.

:: VIIRS_script2.bat is the second script used to process VIIRS NTL 2.1/2.2

:: Change the path below to the location of the input VIIRs v2.1/2.2 (annual average masked) data. To avoid GDAL issues, also save (and run) this batch file from the same folder. This folder should house each annual raster to be processed, using the naming scheme found upon download. The For loops below will then run the process for each years raster that is found in the folder.

:: The input global mastergrid will need to be located in the same folder as the VIIRS rasters.

:: MODIFY AND INSERT BELOW 'X:\LOCATION OF Script 1 OUTPUT DATA\'
SET mypath=

:: Have input mastergrid match the file type, pixel type and nodata value of VIIRS data
gdalwarp -wo NUM_THREADS=8 -te -180.00 -59.99999942 179.999998559 84.00 -tr 0.00083333333 0.00083333333 -ot Float32 -srcnodata 255 -dstnodata -999999 -wo SKIP_NOSOURCE=YES -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -wo OPTIMIZE_SIZE=true WP_mastergrid_base_2023_v3.tif WP_mastergrid_base_2023_v3_A.tif
:: Set No Data Value to 0 (i.e. invert No Data Value selection from -9999 to 0)
gdal_translate -ot Float32 -a_nodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -of gtiff WP_mastergrid_base_2023_v3_A.tif WP_mastergrid_base_2023_v3_B.tif

:: Each section will loop through the named rasters in the folder and save the output file to the same folder.

:: Mosaic inverted mastergrid base to VIIRS covariate (i.e. burn in Coastline No Data Value)
FOR %%i IN (VNL_*_vcmslcfg_*average_masked.dat_bilE.tif) DO (
	
	SET infile=%%i
	SET outfile=!infile:E.tif=F.tif!
	gdalwarp -wo NUM_THREADS=8 -te -180.00 -59.99999942 179.999998559 84.00 -tr 0.00083333333 0.00083333333 -ot float32 -dstnodata -999999 -wo SKIP_NOSOURCE=YES -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -wo OPTIMIZE_SIZE=true !infile! WP_mastergrid_base_2023_v3_B.tif %mypath%!outfile!

)


ECHO end of script