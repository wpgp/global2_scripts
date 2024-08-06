VIIRS NTL v2.1/2.2 Average radiance (masked). 

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Description of raw data:
-------------------------


VIIRS average radiance (masked) represents night-time lights average annual radiance values per pixel on a global scale, with values considered to be noise removed. Higher values represent greater radiance and therein, brightness of observed lights.

Format: TIF 

Provider: Downloaded from https://eogdata.mines.edu/nighttime_light/annual/v21/ February 2023 for VIIRs 2.1 (2015-2021), and  July 2023 /May 2024 for VIIRs 2.2 (2022 and 2023 respectively).

Temporal Resolution: Annual datasets for 2015-2023 inclusive. 2022 and 2023 now added from VIIRS NTL 2.2 (2.2 only has these years, and these years are only in 2.2).
 
Spatial Resolution: ~500m at the equator 

Extent: Global, however does exclude polar regions, and cuts off land beyond 75 degrees North. 

Spatial Reference: WGS84 (EPSG:4326) 

Size: ~11GB each upon download 

Pixel Type: 32 bit Float 

Nodata value: Unassigned, however there are no nodata pixels in practice.

Info: https://eogdata.mines.edu/products/vnl/ 

Paper to Cite: https://www.mdpi.com/2072-4292/13/5/922 

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  

Accompanying scripts will resample and match the raw VIIRs rasters to the cell size and extent of the WorldPop mastergrid, before burning them to match mastergrid coastlines, leaving the seas as nodata, producing an output that can be stacked with other covariates which have undergone their own pre-processing.
  
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Processing scripts: 
-------------------------

The scripts used to process the data were written for GDAL and are batch files intended to be run from the OSGeo4W Shell, which works and can be obtained alongside QGIS.


SCRIPT 1. "VIIRS_NTL_script1_Global2.bat"
  

1) Assign raster a nodata value (script1) 

Use gdaltranslate to give raster a nodata value (-999999) as upon download it is unassigned. Output file: *A.tif 

  

2) Resample to Mastergrid extent and resolution (script1) 

Resample using nearest neighbor/bilinear and change to 100m Mastergrid v3 extent and resolution. Output file: *B.tif 

  

3) Convert nodata to zero's (script1) 

The change in extent from step 2 introduces a large band of nodata at the northernmost extent (75-84 degrees). To avoid issues later, these are to be converted to '0' instead. This is done using the following: 

Change nodata value  to an actual value (-999999) using gdaltranslate. Output file: *C.tif 

Change actual value of -999999 to 0 using gdalcalc. Output file: *D.tif 

Use gdalcalc once more to eliminate occurences of '-0' and make them '0'. Output file: *E.tif 

Results in one raster per year (2015-23 inclusive). 


SCRIPT 2.

4) Clip to Coastline / Water Mask (script2) 

Clip to Mastergrid coastlines, leaving sea as nodata and land as values. Output file: *F.tif 




SCRIPT 3. (from MB)

5) Create alternative version which filters out extreme values from flares/fire missed in raw data.
 

 