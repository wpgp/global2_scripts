:: MERIT_script1_mosaic_resample.bat - script 1, run on raw MERIT .tif files.
:: This script will (1) build a VRT of elevation tiles (.tif files); (2) convert this VRT into a single GeoTIFF raster; (3) resample and standardise the extent.
:: Path to out directory is set in the script below. Update this path accordingly, or alternatively remove from script ensuring variables are removed from gdal functions (e.g. %outpath%).
:: This script will run from OSGeo4W Shell ensure that the script and input raw Viewfinder .hgt files are located in the inpath directory, navigate to this directory using the cd command, then run.

:: The next script to run is MERIT_script2_clip.bat.

:: By Tom McKeen 17/07/2023

@ECHO on
SETLOCAL EnableDelayedExpansion

SET outpath=E:\MERIT_DEM\processed_mastergridv2\

:: create text file list of .tif tiles to be processed
dir /b *.tif > tile_list.txt
:: build VRT of .tif tiles (nearest neighbour resample method)
call gdalbuildvrt -srcnodata -9999 -vrtnodata -9999 -r nearest -input_file_list tile_list.txt %outpath%merit_elevation.vrt

:: convert VRT into GeoTIFF
call gdal_translate -of GTiff -ot Float32 -co COMPRESS=LZW -co PREDICTOR=2 -co BLOCKXSIZE=512 -co BLOCKYSIZE=512 -co TILED=YES -co BIGTIFF=YES -a_nodata -9999 %outpath%merit_elevation.vrt %outpath%merit_elevation_1.tif

:: resample (bilinear) and standardise extent, set ND value = -999999
call gdalwarp -wo NUM_THREADS=8 -co COMPRESS=LZW -co PREDICTOR=2 -co BLOCKXSIZE=512 -co BLOCKYSIZE=512 -co TILED=YES -co BIGTIFF=YES -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 -srcnodata -9999 -dstnodata -999999 -r bilinear -ot Float32 -wo SKIP_NOSOURCE=YES -wo OPTIMIZE_SIZE=true %outpath%merit_elevation_1.tif %outpath%merit_elevation_2.tif