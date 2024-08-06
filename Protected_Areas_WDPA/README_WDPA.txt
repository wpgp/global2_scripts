Dataset: WDPA Protected Areas (Binary Footprints) ~ Created by Tom McKeen (Feb/Mar 2023)
Target Extent: Lower Left  (-180, -59.99999942); Upper Right (179.999999856,  84)
Target Resolution: 0.00083333333 x 0.00083333333 (approximately 100m at the Equator)
Data type: Byte GeoTIFF
No Data Value: 255, in practice there are no NoData pixels
SRS: EPSG:4326 (WGS84)

Ouput file names (years from 2015-2022):

- WDPA_pre<<year>>_cat1_100m_1_0_NoData.tif
(Pixel values of: 1=Protected area pixels, 0=Non-protected area land pixels, NoData=Non-protected area ocean pixels); 

- WDPA_pre<<year>>_cat0_100m_1_0_NoData.tif
(Pixel values of: 1=Protected area pixels, NoData=Non-protected area pixels).

***NOTE: These data were not tiled due to marine pixels not having a corresponding tile with which to set extents (tiles only cover areas in which land pixels are present).




Data description
***********************
WDPA Protected Areas data, with an annual temporal resolution (2015-2022), and reclassified according to a reduce number of IUCN category classes. Vector polygons extracted from file geodatabase and processed to have the same spatial resolution, extent and alignment as the WorldPop Global2 mastergrid.
Product user guide, is available at: http://wcmc.io/WDPA_Manual




Description of raw data
***********************
Format: ESRI File Geodatabase
Provider: Downloaded from https://www.protectedplanet.net/en on 06/02/2023 by Tom McKeen
Temporal Resolution: 1819-2022
Spatial Resolution: n/a
Extent: Global (marine and terrestrial)
Spatial Reference: WGS84 (EPSG:4326)
Size: 1.7GB unzipped
Recommended Citation: NEP-WCMC and IUCN (2023), Protected Planet: The World Database on Protected Areas (WDPA) and World Database on Other Effective Area-based Conservation Measures (WD-OECM) [Online], January 2023, Cambridge, UK: UNEP-WCMC and IUCN. Available at: www.protectedplanet.net.




Dataset preparation
***********************
Dataset detailing extent of protected areas (terrestrial and coastal/marine) incrementally over 8 epochs at 100m resolution.

The data preparation can be split into six stages:
(1) processing file geodatabase and import into PostGIS
(2) processing to create GeoTIFFs of Protected Area locations
(3) processing to produce 100m global mosaics
(4) processing to clip and overlay the WDPA Land epoch mosaics to the WorldPop Global2 mastergrid base
(5) processing to mosaic WDPA Marine/Coastal epoch mosaics to counterpart WDPA Land epoch (latter clipped and overlaid to WorldPop Global2 mastergrid in step 4)
(pending)(6) processing to calculate distance to WDPA protected area boundary

Each step is further explained:

* (1) Process file geodatabase and import into PostGIS 
13 records omitted from point layer due to missing geometry.
Remaining points buffered by 70m (geodesic rules), point buffers merged with polygon layer.
Import into PostGIS using 'ogr2ogr', check for geometry errors ('ST_IsValid' and 'ST_MakeValid' commands).
Total polygons after editing and removal of incompatible geometries = 285514
Two additional columns added to faciliate SQL queries when rasterizing vector polygons:
(i) 'marine_int' --> duplicate of 'marine' column in integer format (0=land vectors, 1=coastal vectors, 2=marine vectors)
(ii) 'category' --> reclassification of 'icun_cat' column in integer format (1=IUCN 1a and 1b, 0=other categories)


* (2) Convert geodatabase polygon features to GeoTIFFs
Polygons incrementally rasterized using 'gdal_rasterize' - decadally till 1999 inclusive (also including STATUS_YR=0), then annually from 2000 to 2022 inclusive.
script: .../global2_scipts/WDPA_script1_rasterise_postgis.bat/
Total of 116 rasters, four rasters per epoch 2000-2022:
(i) LAND, IUCN cat "others"
(ii) LAND, IUCN cat "1"
(iii) MARINE, IUCN cat "others"
(iv) MARINE, IUCN cat "1"


* (3) Produce 100m global mosaics
1999 and prior rasters were mosaicked together using 'gdal_warp'.
Each year after 1999 was then incrementally mosaicked to the previous years' mosaic using 'gdal_warp'. i.e. WDPA_pre2011_*.tif refers to the year 2001 AND prior, WDPA_pre2022_*.tif refers to the year 2022 and prior.
script: .../global2_scripts/WDPA_script2_mosaic_postgis.bat
Total of 32 rasters, four rasters per epoch 2015-2022


* (4) Clip and overlay onto mastergrid base
Land mosaics were clipped to the WorldPop Global2 mastergrid base.
The clipped land rasters were then overlaid onto the WorldPop Global 2 mastergrid base.
script: .../global2_scripts/WDPA_script3_clip_land.bat/


* (5) Mosaic Land and Marine counterparts
The clipped and overlaid land rasters were mosaicked to the marine rasters (it was not deemed necessary to clip marine rasters to the coastline, as the coastal protected areas straddle marine and terrestrial environments) resulting in 16 final rasters for the 2 categories.
scripts: .../global2_scripts/WDPA_script4_mosaic_marine.bat/


* pending (6) calculate distance to WDPA Protected Areas boundaries


Further details of the pre-processing and processing steps, along with instructions for running the scripts can be found in the scripts.

----
README updated 13/05/2024