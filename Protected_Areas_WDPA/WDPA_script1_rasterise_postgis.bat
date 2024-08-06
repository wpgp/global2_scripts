:: WDPA_script1_rasterise_postgis.bat - script 1, run on processed PostGIS database of WDPA vector polygons.
:: This script will incrementally rasterize polygons in decades up to the year 2000, then annually from 2000-22 inclusive.
:: Four rasters are produced for each epoch: 2 land (one IUCN category 1; one IUCN category others) and 2 marine (one IUCN category 1; one IUCN category others). Total of 116 rasters.
:: This script will run from OSGeo4W Shell, ensure that the script is located in the outpath directory, navigate to this directory using the cd command, then run.

:: The next script to run is WDPA_script2_mosaic_postgis.bat.

:: By Tom McKeen 09/02/2023


@ECHO on
SETLOCAL EnableDelayedExpansion

SET mypath=E:\WDPA\rasterised_postgis\


::FILE NAMES: WDPA_*YEAR*_*LAND/MARINE*_*CATEGORY*.tif


::YEAR 0 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=0 AND marine_int=0 AND category=1" %mypath%WDPA_0_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=0 AND marine_int=0 AND category=0" %mypath%WDPA_0_LAND_0.tif
::YEAR 0 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=0 AND marine_int>0 AND category=1" %mypath%WDPA_0_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=0 AND marine_int>0 AND category=0" %mypath%WDPA_0_MARINE_0.tif


::YEAR <1960 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr>0 AND status_yr<1960 AND marine_int=0 AND category=1" %mypath%WDPA_UPTO_1959_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr>0 AND status_yr<1960 AND marine_int=0 AND category=0" %mypath%WDPA_UPTO_1959_LAND_0.tif
::YEAR <1960 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr>0 AND status_yr<1960 AND marine_int>0 AND category=1" %mypath%WDPA_UPTO_1959_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr>0 AND status_yr<1960 AND marine_int>0 AND category=0" %mypath%WDPA_UPTO_1959_MARINE_0.tif


::YEAR 1960 - 1969 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr>=1960 AND status_yr<1970 AND marine_int=0 AND category=1" %mypath%WDPA_UPTO_1969_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr>=1960 AND status_yr<1970 AND marine_int=0 AND category=0" %mypath%WDPA_UPTO_1969_LAND_0.tif
::YEAR 1960 - 1969 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr>=1960 AND status_yr<1970 AND marine_int>0 AND category=1" %mypath%WDPA_UPTO_1969_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr>=1960 AND status_yr<1970 AND marine_int>0 AND category=0" %mypath%WDPA_UPTO_1969_MARINE_0.tif


::YEAR 1970 - 1979 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr>=1970 AND status_yr<1980 AND marine_int=0 AND category=1" %mypath%WDPA_UPTO_1979_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr>=1970 AND status_yr<1980 AND marine_int=0 AND category=0" %mypath%WDPA_UPTO_1979_LAND_0.tif
::YEAR 1970 - 1979 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr>=1970 AND status_yr<1980 AND marine_int>0 AND category=1" %mypath%WDPA_UPTO_1979_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr>=1970 AND status_yr<1980 AND marine_int>0 AND category=0" %mypath%WDPA_UPTO_1979_MARINE_0.tif


::YEAR 1980 - 1989 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr>=1980 AND status_yr<1990 AND marine_int=0 AND category=1" %mypath%WDPA_UPTO_1989_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr>=1980 AND status_yr<1990 AND marine_int=0 AND category=0" %mypath%WDPA_UPTO_1989_LAND_0.tif
::YEAR 1980 - 1989 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr>=1980 AND status_yr<1990 AND marine_int>0 AND category=1" %mypath%WDPA_UPTO_1989_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr>=1980 AND status_yr<1990 AND marine_int>0 AND category=0" %mypath%WDPA_UPTO_1989_MARINE_0.tif


::YEAR 1990 - 1999 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr>=1990 AND status_yr<2000 AND marine_int=0 AND category=1" %mypath%WDPA_UPTO_1999_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr>=1990 AND status_yr<2000 AND marine_int=0 AND category=0" %mypath%WDPA_UPTO_1999_LAND_0.tif
::YEAR 1990 - 1999 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr>=1990 AND status_yr<2000 AND marine_int>0 AND category=1" %mypath%WDPA_UPTO_1999_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr>=1990 AND status_yr<2000 AND marine_int>0 AND category=0" %mypath%WDPA_UPTO_1999_MARINE_0.tif

::YEAR 2000 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2000 AND marine_int=0 AND category=1" %mypath%WDPA_2000_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2000 AND marine_int=0 AND category=0" %mypath%WDPA_2000_LAND_0.tif
::YEAR 2000 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2000 AND marine_int>0 AND category=1" %mypath%WDPA_2000_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2000 AND marine_int>0 AND category=0" %mypath%WDPA_2000_MARINE_0.tif

::YEAR 2001 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2001 AND marine_int=0 AND category=1" %mypath%WDPA_2001_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2001 AND marine_int=0 AND category=0" %mypath%WDPA_2001_LAND_0.tif
::YEAR 2001 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2001 AND marine_int>0 AND category=1" %mypath%WDPA_2001_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2001 AND marine_int>0 AND category=0" %mypath%WDPA_2001_MARINE_0.tif

::YEAR 2002 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2002 AND marine_int=0 AND category=1" %mypath%WDPA_2002_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2002 AND marine_int=0 AND category=0" %mypath%WDPA_2002_LAND_0.tif
::YEAR 2002 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2002 AND marine_int>0 AND category=1" %mypath%WDPA_2002_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2002 AND marine_int>0 AND category=0" %mypath%WDPA_2002_MARINE_0.tif

::YEAR 2003 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2003 AND marine_int=0 AND category=1" %mypath%WDPA_2003_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2003 AND marine_int=0 AND category=0" %mypath%WDPA_2003_LAND_0.tif
::YEAR 2003 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2003 AND marine_int>0 AND category=1" %mypath%WDPA_2003_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2003 AND marine_int>0 AND category=0" %mypath%WDPA_2003_MARINE_0.tif

::YEAR 2004 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2004 AND marine_int=0 AND category=1" %mypath%WDPA_2004_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2004 AND marine_int=0 AND category=0" %mypath%WDPA_2004_LAND_0.tif
::YEAR 2004 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2004 AND marine_int>0 AND category=1" %mypath%WDPA_2004_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2004 AND marine_int>0 AND category=0" %mypath%WDPA_2004_MARINE_0.tif

::YEAR 2005 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2005 AND marine_int=0 AND category=1" %mypath%WDPA_2005_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2005 AND marine_int=0 AND category=0" %mypath%WDPA_2005_LAND_0.tif
::YEAR 2005 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2005 AND marine_int>0 AND category=1" %mypath%WDPA_2005_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2005 AND marine_int>0 AND category=0" %mypath%WDPA_2005_MARINE_0.tif

::YEAR 2006 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2006 AND marine_int=0 AND category=1" %mypath%WDPA_2006_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2006 AND marine_int=0 AND category=0" %mypath%WDPA_2006_LAND_0.tif
::YEAR 2006 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2006 AND marine_int>0 AND category=1" %mypath%WDPA_2006_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2006 AND marine_int>0 AND category=0" %mypath%WDPA_2006_MARINE_0.tif

::YEAR 2007 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2007 AND marine_int=0 AND category=1" %mypath%WDPA_2007_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2007 AND marine_int=0 AND category=0" %mypath%WDPA_2007_LAND_0.tif
::YEAR 2007 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2007 AND marine_int>0 AND category=1" %mypath%WDPA_2007_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2007 AND marine_int>0 AND category=0" %mypath%WDPA_2007_MARINE_0.tif

::YEAR 2008 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2008 AND marine_int=0 AND category=1" %mypath%WDPA_2008_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2008 AND marine_int=0 AND category=0" %mypath%WDPA_2008_LAND_0.tif
::YEAR 2008 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2008 AND marine_int>0 AND category=1" %mypath%WDPA_2008_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2008 AND marine_int>0 AND category=0" %mypath%WDPA_2008_MARINE_0.tif

::YEAR 2009 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2009 AND marine_int=0 AND category=1" %mypath%WDPA_2009_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2009 AND marine_int=0 AND category=0" %mypath%WDPA_2009_LAND_0.tif
::YEAR 2009 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2009 AND marine_int>0 AND category=1" %mypath%WDPA_2009_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2009 AND marine_int>0 AND category=0" %mypath%WDPA_2009_MARINE_0.tif

::YEAR 2010 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2010 AND marine_int=0 AND category=1" %mypath%WDPA_2010_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2010 AND marine_int=0 AND category=0" %mypath%WDPA_2010_LAND_0.tif
::YEAR 2010 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2010 AND marine_int>0 AND category=1" %mypath%WDPA_2010_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2010 AND marine_int>0 AND category=0" %mypath%WDPA_2010_MARINE_0.tif

::YEAR 2011 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2011 AND marine_int=0 AND category=1" %mypath%WDPA_2011_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2011 AND marine_int=0 AND category=0" %mypath%WDPA_2011_LAND_0.tif
::YEAR 2011 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2011 AND marine_int>0 AND category=1" %mypath%WDPA_2011_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2011 AND marine_int>0 AND category=0" %mypath%WDPA_2011_MARINE_0.tif

::YEAR 2012 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2012 AND marine_int=0 AND category=1" %mypath%WDPA_2012_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2012 AND marine_int=0 AND category=0" %mypath%WDPA_2012_LAND_0.tif
::YEAR 2012 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2012 AND marine_int>0 AND category=1" %mypath%WDPA_2012_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2012 AND marine_int>0 AND category=0" %mypath%WDPA_2012_MARINE_0.tif

::YEAR 2013 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2013 AND marine_int=0 AND category=1" %mypath%WDPA_2013_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2013 AND marine_int=0 AND category=0" %mypath%WDPA_2013_LAND_0.tif
::YEAR 2013 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2013 AND marine_int>0 AND category=1" %mypath%WDPA_2013_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2013 AND marine_int>0 AND category=0" %mypath%WDPA_2013_MARINE_0.tif

::YEAR 2014 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2014 AND marine_int=0 AND category=1" %mypath%WDPA_2014_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2014 AND marine_int=0 AND category=0" %mypath%WDPA_2014_LAND_0.tif
::YEAR 2014 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2014 AND marine_int>0 AND category=1" %mypath%WDPA_2014_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2014 AND marine_int>0 AND category=0" %mypath%WDPA_2014_MARINE_0.tif

::YEAR 2015 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2015 AND marine_int=0 AND category=1" %mypath%WDPA_2015_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2015 AND marine_int=0 AND category=0" %mypath%WDPA_2015_LAND_0.tif
::YEAR 2015 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2015 AND marine_int>0 AND category=1" %mypath%WDPA_2015_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2015 AND marine_int>0 AND category=0" %mypath%WDPA_2015_MARINE_0.tif

::YEAR 2016 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2016 AND marine_int=0 AND category=1" %mypath%WDPA_2016_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2016 AND marine_int=0 AND category=0" %mypath%WDPA_2016_LAND_0.tif
::YEAR 2016 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2016 AND marine_int>0 AND category=1" %mypath%WDPA_2016_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2016 AND marine_int>0 AND category=0" %mypath%WDPA_2016_MARINE_0.tif

::YEAR 2017 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2017 AND marine_int=0 AND category=1" %mypath%WDPA_2017_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2017 AND marine_int=0 AND category=0" %mypath%WDPA_2017_LAND_0.tif
::YEAR 2017 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2017 AND marine_int>0 AND category=1" %mypath%WDPA_2017_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2017 AND marine_int>0 AND category=0" %mypath%WDPA_2017_MARINE_0.tif

::YEAR 2018 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2018 AND marine_int=0 AND category=1" %mypath%WDPA_2018_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2018 AND marine_int=0 AND category=0" %mypath%WDPA_2018_LAND_0.tif
::YEAR 2018 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2018 AND marine_int>0 AND category=1" %mypath%WDPA_2018_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2018 AND marine_int>0 AND category=0" %mypath%WDPA_2018_MARINE_0.tif

::YEAR 2019 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2019 AND marine_int=0 AND category=1" %mypath%WDPA_2019_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2019 AND marine_int=0 AND category=0" %mypath%WDPA_2019_LAND_0.tif
::YEAR 2019 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2019 AND marine_int>0 AND category=1" %mypath%WDPA_2019_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2019 AND marine_int>0 AND category=0" %mypath%WDPA_2019_MARINE_0.tif

::YEAR 2020 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2020 AND marine_int=0 AND category=1" %mypath%WDPA_2020_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2020 AND marine_int=0 AND category=0" %mypath%WDPA_2020_LAND_0.tif
::YEAR 2020 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2020 AND marine_int>0 AND category=1" %mypath%WDPA_2020_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2020 AND marine_int>0 AND category=0" %mypath%WDPA_2020_MARINE_0.tif

::YEAR 2021 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2021 AND marine_int=0 AND category=1" %mypath%WDPA_2021_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2021 AND marine_int=0 AND category=0" %mypath%WDPA_2021_LAND_0.tif
::YEAR 2021 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2021 AND marine_int>0 AND category=1" %mypath%WDPA_2021_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2021 AND marine_int>0 AND category=0" %mypath%WDPA_2021_MARINE_0.tif

::YEAR 2022 LAND
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2022 AND marine_int=0 AND category=1" %mypath%WDPA_2022_LAND_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2022 AND marine_int=0 AND category=0" %mypath%WDPA_2022_LAND_0.tif
::YEAR 2022 MARINE
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2022 AND marine_int>0 AND category=1" %mypath%WDPA_2022_MARINE_1.tif
call gdal_rasterize -at -ot Byte -co COMPRESS=LZW -co PREDICTOR=2 -co BIGTIFF=YES -burn 1 -te -180.00 -60.99999942 179.999999856 84.00 -tr 0.00083333333 0.00083333333 PG:"host=localhost user=postgres password=password dbname=wdpa" -sql "SELECT * from wdpa_complete WHERE status_yr=2022 AND marine_int>0 AND category=0" %mypath%WDPA_2022_MARINE_0.tif