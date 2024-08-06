:: MERIT_script2_clip.bat - script 2, run on resampled MERIT GeoTIFF raster.
:: This script will (1) create an inverted 'cookie-cutter' mastergrid base; (2) standardise the extent and clip a covariate to the mastergrid base (using 'cookie-cutter'); (3) mosaic the clipped covariate to the mastergrid base.
:: In this case MERIT DEM rasters are processed.
:: 		(i) "outfile_A" --> >1=MERIT pixels, NoData=Non-MERIT pixels
:: 		(ii) "outfile_B" --> >1=MERIT pixels, 0=Non-MERIT land pixels, NoData=Ocean pixels
:: Path to out directory and mastergrid location are set in the script below. Update these paths accordingly, or alternatively remove from script ensuring variables are removed from gdal functions (e.g. %outpath%).
:: This script will run from OSGeo4W Shell ensure that the script and resampled MERIT raster are located in the inpath directory, navigate to this directory using the cd command, then run.

:: The next script to run is MERIT_script3_slope.bat.

:: By Tom McKeen 17/07/2023

@ECHO on
SETLOCAL EnableDelayedExpansion

SET mypath=F:\Global2\MasterGrid\
SET outpath=F:\Global2\MERIT_DEM\processed_mastergrid_base_v3\

:: construct inverted mastergrid base with identical datatype & NoData value to mosaic to MERIT covariate (i.e. 'cookie-cutter')
:: match datatype and NoData value to match MERIT covariate (i.e. int16, -9999)
gdalwarp -wo NUM_THREADS=8 -te -180.00 -59.99999942 179.999998559 84.00 -tr 0.00083333333 0.00083333333 -ot float32 -srcnodata 255 -dstnodata -999999 -wo SKIP_NOSOURCE=YES -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -wo OPTIMIZE_SIZE=true %mypath%WP_mastergrid_base_2023_v3.tif %outpath%WP_mastergrid_base_2023_v3_A.tif
:: Set NoData value to 0 (i.e. invert NoData value selection from -9999 to 0)
gdal_translate -ot float32 -a_nodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -of gtiff %outpath%WP_mastergrid_base_2023_v3_A.tif %outpath%WP_mastergrid_base_2023_v3_B.tif

:: mosaic inverted base mastergrid ('cookie-cutter') to MERIT covariate
:: this will standardise the extent and clip the coastlines to match mastergrid base (MERIT elevation = >1, non-MERIT elevation pixels = 0)
gdalwarp -wo NUM_THREADS=8 -te -180.00 -59.99999942 179.999998559 84.00 -tr 0.00083333333 0.00083333333 -ot float32 -dstnodata -999999 -wo SKIP_NOSOURCE=YES -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -wo OPTIMIZE_SIZE=true merit_elevation_2.tif %outpath%WP_mastergrid_base_2023_v3_B.tif %outpath%merit_elevation_3.tif
:: mosaic new clipped MERIT rasters to original mastergrid (overlay on 0 values; MERIT elevation = >1, non-MERIT elevation land pixels = 0, sea = NoData (-9999))
gdalwarp -wo NUM_THREADS=8 -te -180.00 -59.99999942 179.999998559 84.00 -tr 0.00083333333 0.00083333333 -ot float32 -dstnodata -999999 -wo SKIP_NOSOURCE=YES -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -wo OPTIMIZE_SIZE=true %mypath%WP_mastergrid_base_2023_v3.tif %outpath%merit_elevation_NoData.tif %outpath%merit_elevation_0_NoData.tif