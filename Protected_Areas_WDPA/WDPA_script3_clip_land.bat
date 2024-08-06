:: WDPA_script3_clip_land.bat - script 3, run on Land mosaics 2015-2022.
:: This script will (1) create an inverted 'cookie-cutter' mastergrid base; (2) standardise the extent and clip a binary covariate to the mastergrid base (using 'cookie-cutter'); (3) mosaic the clipped covariate to the mastergrid base.
:: In this case WDPA Protected Areas Land for the 2015-2022 epoch are processed. Total of 16 rasters input, total of 32 rasters output: 
:: 		(i) "outfile_A" --> 1=Protected area Land pixels, NoData=Non-protected area pixels
:: 		(ii) "outfile_B" --> 1=Protected area land pixels, 0=Non-protected area land pixels, NoData=Ocean pixels
:: Two rasters are produced for each epoch: 2 land (one IUCN category 1; one IUCN category others) and 2 marine (one IUCN category 1; one IUCN category others).
:: Path to mastergrid base and path to out directory are set in the script below. Update these paths accordingly, or alternatively remove from script ensuring variables are removed from gdal functions (e.g. %mgrid_path%). If removed, these rasters must be located in the inpath directory.
:: This script will run from OSGeo4W Shell ensure that the script and input WDPA Land mosaics are located in the inpath directory, navigate to this directory using the cd command, then run.

:: The next script to run is WDPA_script4_mosaic_marine.bat.

:: By Tom McKeen 01/06/2023

@ECHO on
SETLOCAL EnableDelayedExpansion

:: set path to mastergrid base location
SET mgrid_path=F:\Global2\MasterGrid\
:: set path to out directory location
SET outdir_path=F:\Global2\WDPA\processed_mastergrid_base_v3\

:: construct inverted mastergrid base with identical datatype & NoData value to mosaic to WDPA covariate (i.e. 'cookie-cutter')
:: mastergrid datatype & NoData value already matches WDPA covariate (i.e. Byte, 255)
:: invert nodata selection of mastergrid
gdal_translate -ot Byte -a_nodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -of gtiff %mgrid_path%WP_mastergrid_base_2023_v3.tif WP_mastergrid_base_2023_v3_A.tif

:: loop through WDPA Land rasters for epoch 2015-2022, including both IUCN category 1 and category 'others'
FOR %%i IN (WDPA_*_LAND_*.tif) DO (

	SET infile=%%i
	SET outfile_A=!infile:.tif=_A.tif!
	SET outfile_B=!infile:.tif=_B.tif!
	
	:: mosaic inverted base mastergrid ('cookie-cutter') to WDPA Land mosaics
	:: this will standardise the extent and clip the coastlines to match mastergrid base (WDPA land = 1, non-WDPA pixels = 0)
	call gdalwarp -wo NUM_THREADS=8 -te -180.00 -59.99999942 179.999998559 84.00 -tr 0.00083333333 0.00083333333 -ot Byte -dstnodata 255 -wo SKIP_NOSOURCE=YES -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -wo OPTIMIZE_SIZE=true !infile! WP_mastergrid_base_2023_v3_A.tif %outdir_path%!outfile_A!
	:: mosaic new clipped WDPA Land rasters to original mastergrid (overlay on 0 values; WDPA land = 1, non-WDPA land = 0, sea = NoData (255))
	call gdalwarp -wo NUM_THREADS=8 -te -180.00 -59.99999942 179.999998559 84.00 -tr 0.00083333333 0.00083333333 -ot Byte -dstnodata 255 -wo SKIP_NOSOURCE=YES -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -wo OPTIMIZE_SIZE=true %mgrid_path%WP_mastergrid_base_2023_v3.tif %outdir_path%!outfile_A! %outdir_path%!outfile_B!
)