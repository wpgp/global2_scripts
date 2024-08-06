:: WDPA_script2_mosaic_postgis.bat - script 2, run on GeoTIFFs of IUCN epochs.
:: This script will (1) mosaic 1999-and-prior rasters, based on a list of input datasets from the indicated .txt file; (2) incrementally mosaic each year post-1999 to the previous years' mosaic.
:: Four rasters are produced for each epoch: 2 land (one IUCN category 1; one IUCN category others) and 2 marine (one IUCN category 1; one IUCN category others). Total of 92 rasters.
:: This script will run from OSGeo4W Shell ensure that the script, .txt files, and input rasters are located in the inpath directory, navigate to this directory using the cd command, then run.

:: The next script to run is WDPA_script3_clip_land.bat.

:: By Tom McKeen 09/02/2023


@ECHO on
SETLOCAL EnableDelayedExpansion

SET mypath=E:\WDPA\mosaic_postgis\
SET inpath=E:\WDPA\rasterised_postgis\


:: PRE-1999 LAND (incl. YEAR 0)
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff --optfile LAND_1_list.txt WDPA_pre1999_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff --optfile LAND_0_list.txt WDPA_pre1999_LAND_0.tif
:: PRE-1999 MARINE (incl. YEAR 0)
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff --optfile MARINE_1_list.txt WDPA_pre1999_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff --optfile MARINE_0_list.txt WDPA_pre1999_MARINE_0.tif

:: PRE-2000 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre1999_LAND_1.tif %inpath%WDPA_2000_LAND_1.tif WDPA_pre2000_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre1999_LAND_0.tif %inpath%WDPA_2000_LAND_0.tif WDPA_pre2000_LAND_0.tif
:: PRE-2000 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre1999_MARINE_1.tif %inpath%WDPA_2000_MARINE_1.tif WDPA_pre2000_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre1999_MARINE_0.tif %inpath%WDPA_2000_MARINE_0.tif WDPA_pre2000_MARINE_0.tif

:: PRE-2001 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2000_LAND_1.tif %inpath%WDPA_2001_LAND_1.tif WDPA_pre2001_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2000_LAND_0.tif %inpath%WDPA_2001_LAND_0.tif WDPA_pre2001_LAND_0.tif
:: PRE-2001 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2000_MARINE_1.tif %inpath%WDPA_2001_MARINE_1.tif WDPA_pre2001_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2000_MARINE_0.tif %inpath%WDPA_2001_MARINE_0.tif WDPA_pre2001_MARINE_0.tif

:: PRE-2002 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2001_LAND_1.tif %inpath%WDPA_2002_LAND_1.tif WDPA_pre2002_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2001_LAND_0.tif %inpath%WDPA_2002_LAND_0.tif WDPA_pre2002_LAND_0.tif
:: PRE-2002 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2001_MARINE_1.tif %inpath%WDPA_2002_MARINE_1.tif WDPA_pre2002_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2001_MARINE_0.tif %inpath%WDPA_2002_MARINE_0.tif WDPA_pre2002_MARINE_0.tif

:: PRE-2003 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2002_LAND_1.tif %inpath%WDPA_2003_LAND_1.tif WDPA_pre2003_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2002_LAND_0.tif %inpath%WDPA_2003_LAND_0.tif WDPA_pre2003_LAND_0.tif
:: PRE-2003 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2002_MARINE_1.tif %inpath%WDPA_2003_MARINE_1.tif WDPA_pre2003_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2002_MARINE_0.tif %inpath%WDPA_2003_MARINE_0.tif WDPA_pre2003_MARINE_0.tif

:: PRE-2004 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2003_LAND_1.tif %inpath%WDPA_2004_LAND_1.tif WDPA_pre2004_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2003_LAND_0.tif %inpath%WDPA_2004_LAND_0.tif WDPA_pre2004_LAND_0.tif
:: PRE-2004 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2003_MARINE_1.tif %inpath%WDPA_2004_MARINE_1.tif WDPA_pre2004_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2003_MARINE_0.tif %inpath%WDPA_2004_MARINE_0.tif WDPA_pre2004_MARINE_0.tif

:: PRE-2005 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2004_LAND_1.tif %inpath%WDPA_2005_LAND_1.tif WDPA_pre2005_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2004_LAND_0.tif %inpath%WDPA_2005_LAND_0.tif WDPA_pre2005_LAND_0.tif
:: PRE-2005 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2004_MARINE_1.tif %inpath%WDPA_2005_MARINE_1.tif WDPA_pre2005_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2004_MARINE_0.tif %inpath%WDPA_2005_MARINE_0.tif WDPA_pre2005_MARINE_0.tif

:: PRE-2006 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2005_LAND_1.tif %inpath%WDPA_2006_LAND_1.tif WDPA_pre2006_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2005_LAND_0.tif %inpath%WDPA_2006_LAND_0.tif WDPA_pre2006_LAND_0.tif
:: PRE-2006 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2005_MARINE_1.tif %inpath%WDPA_2006_MARINE_1.tif WDPA_pre2006_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2005_MARINE_0.tif %inpath%WDPA_2006_MARINE_0.tif WDPA_pre2006_MARINE_0.tif

:: PRE-2007 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2006_LAND_1.tif %inpath%WDPA_2007_LAND_1.tif WDPA_pre2007_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2006_LAND_0.tif %inpath%WDPA_2007_LAND_0.tif WDPA_pre2007_LAND_0.tif
:: PRE-2007 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2006_MARINE_1.tif %inpath%WDPA_2007_MARINE_1.tif WDPA_pre2007_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2006_MARINE_0.tif %inpath%WDPA_2007_MARINE_0.tif WDPA_pre2007_MARINE_0.tif

:: PRE-2008 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2007_LAND_1.tif %inpath%WDPA_2008_LAND_1.tif WDPA_pre2008_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2007_LAND_0.tif %inpath%WDPA_2008_LAND_0.tif WDPA_pre2008_LAND_0.tif
:: PRE-2008 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2007_MARINE_1.tif %inpath%WDPA_2008_MARINE_1.tif WDPA_pre2008_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2007_MARINE_0.tif %inpath%WDPA_2008_MARINE_0.tif WDPA_pre2008_MARINE_0.tif

:: PRE-2009 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2008_LAND_1.tif %inpath%WDPA_2009_LAND_1.tif WDPA_pre2009_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2008_LAND_0.tif %inpath%WDPA_2009_LAND_0.tif WDPA_pre2009_LAND_0.tif
:: PRE-2009 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2008_MARINE_1.tif %inpath%WDPA_2009_MARINE_1.tif WDPA_pre2009_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2008_MARINE_0.tif %inpath%WDPA_2009_MARINE_0.tif WDPA_pre2009_MARINE_0.tif

:: PRE-2010 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2009_LAND_1.tif %inpath%WDPA_2010_LAND_1.tif WDPA_pre2010_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2009_LAND_0.tif %inpath%WDPA_2010_LAND_0.tif WDPA_pre2010_LAND_0.tif
:: PRE-2010 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2009_MARINE_1.tif %inpath%WDPA_2010_MARINE_1.tif WDPA_pre2010_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2009_MARINE_0.tif %inpath%WDPA_2010_MARINE_0.tif WDPA_pre2010_MARINE_0.tif

:: PRE-2011 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2010_LAND_1.tif %inpath%WDPA_2011_LAND_1.tif WDPA_pre2011_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2010_LAND_0.tif %inpath%WDPA_2011_LAND_0.tif WDPA_pre2011_LAND_0.tif
:: PRE-2011 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2010_MARINE_1.tif %inpath%WDPA_2011_MARINE_1.tif WDPA_pre2011_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2010_MARINE_0.tif %inpath%WDPA_2011_MARINE_0.tif WDPA_pre2011_MARINE_0.tif

:: PRE-2012 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2011_LAND_1.tif %inpath%WDPA_2012_LAND_1.tif WDPA_pre2012_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2011_LAND_0.tif %inpath%WDPA_2012_LAND_0.tif WDPA_pre2012_LAND_0.tif
:: PRE-2012 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2011_MARINE_1.tif %inpath%WDPA_2012_MARINE_1.tif WDPA_pre2012_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2011_MARINE_0.tif %inpath%WDPA_2012_MARINE_0.tif WDPA_pre2012_MARINE_0.tif

:: PRE-2013 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2012_LAND_1.tif %inpath%WDPA_2013_LAND_1.tif WDPA_pre2013_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2012_LAND_0.tif %inpath%WDPA_2013_LAND_0.tif WDPA_pre2013_LAND_0.tif
:: PRE-2013 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2012_MARINE_1.tif %inpath%WDPA_2013_MARINE_1.tif WDPA_pre2013_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2012_MARINE_0.tif %inpath%WDPA_2013_MARINE_0.tif WDPA_pre2013_MARINE_0.tif

:: PRE-2014 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2013_LAND_1.tif %inpath%WDPA_2014_LAND_1.tif WDPA_pre2014_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2013_LAND_0.tif %inpath%WDPA_2014_LAND_0.tif WDPA_pre2014_LAND_0.tif
:: PRE-2014 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2013_MARINE_1.tif %inpath%WDPA_2014_MARINE_1.tif WDPA_pre2014_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2013_MARINE_0.tif %inpath%WDPA_2014_MARINE_0.tif WDPA_pre2014_MARINE_0.tif

:: PRE-2015 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2014_LAND_1.tif %inpath%WDPA_2015_LAND_1.tif WDPA_pre2015_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2014_LAND_0.tif %inpath%WDPA_2015_LAND_0.tif WDPA_pre2015_LAND_0.tif
:: PRE-2015 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2014_MARINE_1.tif %inpath%WDPA_2015_MARINE_1.tif WDPA_pre2015_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2014_MARINE_0.tif %inpath%WDPA_2015_MARINE_0.tif WDPA_pre2015_MARINE_0.tif

:: PRE-2016 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2015_LAND_1.tif %inpath%WDPA_2016_LAND_1.tif WDPA_pre2016_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2015_LAND_0.tif %inpath%WDPA_2016_LAND_0.tif WDPA_pre2016_LAND_0.tif
:: PRE-2016 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2015_MARINE_1.tif %inpath%WDPA_2016_MARINE_1.tif WDPA_pre2016_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2015_MARINE_0.tif %inpath%WDPA_2016_MARINE_0.tif WDPA_pre2016_MARINE_0.tif

:: PRE-2017 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2016_LAND_1.tif %inpath%WDPA_2017_LAND_1.tif WDPA_pre2017_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2016_LAND_0.tif %inpath%WDPA_2017_LAND_0.tif WDPA_pre2017_LAND_0.tif
:: PRE-2017 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2016_MARINE_1.tif %inpath%WDPA_2017_MARINE_1.tif WDPA_pre2017_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2016_MARINE_0.tif %inpath%WDPA_2017_MARINE_0.tif WDPA_pre2017_MARINE_0.tif

:: PRE-2018 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2017_LAND_1.tif %inpath%WDPA_2018_LAND_1.tif WDPA_pre2018_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2017_LAND_0.tif %inpath%WDPA_2018_LAND_0.tif WDPA_pre2018_LAND_0.tif
:: PRE-2018 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2017_MARINE_1.tif %inpath%WDPA_2018_MARINE_1.tif WDPA_pre2018_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2017_MARINE_0.tif %inpath%WDPA_2018_MARINE_0.tif WDPA_pre2018_MARINE_0.tif

:: PRE-2019 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2018_LAND_1.tif %inpath%WDPA_2019_LAND_1.tif WDPA_pre2019_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2018_LAND_0.tif %inpath%WDPA_2019_LAND_0.tif WDPA_pre2019_LAND_0.tif
:: PRE-2019 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2018_MARINE_1.tif %inpath%WDPA_2019_MARINE_1.tif WDPA_pre2019_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2018_MARINE_0.tif %inpath%WDPA_2019_MARINE_0.tif WDPA_pre2019_MARINE_0.tif

:: PRE-2020 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2019_LAND_1.tif %inpath%WDPA_2020_LAND_1.tif WDPA_pre2020_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2019_LAND_0.tif %inpath%WDPA_2020_LAND_0.tif WDPA_pre2020_LAND_0.tif
:: PRE-2020 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2019_MARINE_1.tif %inpath%WDPA_2020_MARINE_1.tif WDPA_pre2020_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2019_MARINE_0.tif %inpath%WDPA_2020_MARINE_0.tif WDPA_pre2020_MARINE_0.tif

:: PRE-2021 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2020_LAND_1.tif %inpath%WDPA_2021_LAND_1.tif WDPA_pre2021_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2020_LAND_0.tif %inpath%WDPA_2021_LAND_0.tif WDPA_pre2021_LAND_0.tif
:: PRE-2021 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2020_MARINE_1.tif %inpath%WDPA_2021_MARINE_1.tif WDPA_pre2021_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2020_MARINE_0.tif %inpath%WDPA_2021_MARINE_0.tif WDPA_pre2021_MARINE_0.tif

:: PRE-2022 LAND
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2021_LAND_1.tif %inpath%WDPA_2022_LAND_1.tif WDPA_pre2022_LAND_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2021_LAND_0.tif %inpath%WDPA_2022_LAND_0.tif WDPA_pre2022_LAND_0.tif
:: PRE-2022 MARINE
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2021_MARINE_1.tif %inpath%WDPA_2022_MARINE_1.tif WDPA_pre2022_MARINE_1.tif
call gdalwarp -wo NUM_THREADS=ALL_CPUS -s_SRS EPSG:4326 -t_srs EPSG:4326 -tr 0.00083333333 0.00083333333 -te -180.00 -60.99999942 179.999999856 84.00 -srcnodata 0 -dstnodata 0 -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -ot Byte -wo OPTIMIZE_SIZE=true -wo SKIP_NOSOURCE=YES -of gtiff WDPA_pre2021_MARINE_0.tif %inpath%WDPA_2022_MARINE_0.tif WDPA_pre2022_MARINE_0.tif