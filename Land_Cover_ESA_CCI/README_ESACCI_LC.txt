Dataset: ESA CCI Landcover (annual datasets v.2.0.7 for years 2000-2015 and v2.1.1 for years 2016-2022) ~ Created by Dorothea Woods (Jan/Feb 2023)
Target Extent: Lower Left (-180, -60.99999942); Upper Right (179.999999856,  84)
Target Resolution: 0.00083333333 x 0.00083333333 (approximately 100m at the Equator)
Data type: 8 bit unsigned integer GeoTiff
No Data Value: 255 as per metadata, in practice there are no noData pixels
SRS: EPSG:4326 (WGS84)

Ouput file names (examples from 2016-2022 files): 

- global mosaics (all classes): 
	file names take the format of <<ESACCI-LC-L4-LCCS-Map-300m-P1Y-yr>><<year e.g. 2000>><<-v2.1.1_UINT8_RECLASSIFIED_100m.tif>>
	e.g. ESACCI-LC-L4-LCCS-Map-300m-P1Y-2016-v2.1.1_UINT8_RECLASSIFIED_100m.tif

- global mosaics (single classes):
	1. Binary mosaic (1, 0, nodata):
	file names take the format of <<C3S-LC-L4-LCCS-Map-300m-P1Y-yr>><<year e.g. 2000>><<-v2.1.1_UINT8_RECLASSIFIED_clsXX>><<where RECLASSIFIED_clsXX is the reclassified class number>><<_res>><<where res is resampled resolution in m>><<_binary.tif>>
	e.g. C3S-LC-L4-LCCS-Map-300m-P1Y-2016-v2.1.1_UINT8_RECLASSIFIED_11_100m_binary.tif
	




Data description
*******************
ESA CCI landcover data, with an annual temporal resolution (2015-2022), reclassified to a reduced number of classes and processed to have the same spatial resolution, extent and alignment as the WorldPop Global2 mastergrid. 
The annual rasters are produced from the ESA CCI 300m annual global land cover time series v2.0.7, released in April 2017 and v2.1.1, released in June 2021.
Both version were produced with the same processing chain and can be used as coherent time series.
The product user guide, including details of the data used to generate the annual time series, is available at: https://datastore.copernicus-climate.eu/documents/satellite-land-cover/D5.3.1_PUGS_ICDR_LC_v2.1.x_PRODUCTS_v1.1.pdf 


Dataset preparation
*******************
ESA CCI 300m annual global land cover time series data have a spatial coverage between latititudes of 90S and 90N and a spatial resolution of 10 arc-seconds (approximately 300m at the Equator), with a raster in netCDF format supplied for each year (2015-2020 inclusive). These data were downloaded from https://cds.climate.copernicus.eu/cdsapp#!/dataset/satellite-land-cover?tab=doc by Dorothea Woods (Jan/Feb 2023).

The data preparation can be split into five stages:
(1) changing NetCDF format to Geotiff format, 
(2) producing reclassified datasets with reduced number of classes,
(3) aggregating the classes into one file per year containing all 9 reclassified classes,
(4) standardising to mastergrid, and 
(5) creating binary files for each aggregated land cover class.


Each step is further explained:

* (1) Changing NetCDF format to Geotiff format  
Conversion of NetCDF files to Geotiffs: 
script: ...\ProcessingScriptsESACCI\ESACCI_LC_annual_translate_Global2.bat


* (2) Producing reclassified datasets with reduced number of classes
Reclassify classes into aggregated classification, using the following reclassification:
Classes 10, 11, 12, 20, 30, 40 					--> Reclassified class 11
Classes 50, 60, 61, 62, 70, 71, 72, 80, 81, 82, 90, 100 	--> Reclassified class 40
Classes 120, 121, 122 						--> Reclassified class 130
Classes 110, 130, 140 						--> Reclassified class 140
Classes 150, 151, 152, 153 					--> Reclassified class 150
Classes 160, 170, 180 						--> Reclassified class 160
Classes 190 							--> Reclassified class 190
Classes 200, 201, 202 						--> Reclassified class 200
Classes 210, 220 						--> Reclassified class 210

Output is one tiff per year and reclassified class. At this point the original land cover class value is maintained in the output. See also "...\ESACCI-LC-Legend-Aggregation.xlsx" 
script: ...\ProcessingScriptsESACCI\ESACCI_LC_annual_reclassify_Global2.bat


* (3) Aggregating the classes into one file per year containing all 9 reclassified classes.
script for years 2016-2022: ...\ProcessingScriptsESACCI\ESACCI_LC_annual_aggregateAllClasses_2016to2020.bat 
script for year 2015:...\ProcessingScriptsESACCI\ESACCI_LC_annual_aggregateAllClasses_2000to2015.bat


* (4) Standardising to mastergrid
a) Standardise global rasters to 100m (resample using nearest neighbour and snap to 100m mastergrid raster)
b) Change the nodata value to be the maximum value of the 8 bit unsigned integer data type (255)
c) Assign EPSG:4326
script ...\ProcessingScriptsESACCI\ESACCI_LC_annual_resample_Global2.bat


* (5) Creating binary files for each aggregated land cover class
For reclassified classes 11, 40, 130, 140, 150, 160, 190, 200, 210 produce a binary (1,0,nodata).
script: ...\ProcessingScriptsESACCI\ESACCI_LC_annual_binary_Global2.bat 


Further details of the pre-processing and processing steps, along with instructions for running the scripts can be found in the scripts.

----
README updated 10/06/2024