print('Loading packages ...')
import sys
import os
import geopandas as gpd
import json

def usage():
    print('============================================================')
    print('This script convert geometry data from TSV format into GPKG.')
    print('')
    print('Usage: python roads_tsv2gpkg.py -f path -t tlc')
    print('')
    print('Options:')
    print('-f [required] path to the TSV file')
    print('-t [required] three letter code of the selected country, ')
    print('              e.g., AIA')
    print('-h            show this message and exit')
    print('')
    print('Example: python roads_tsv2gpkg.py -f Carib.tsv -t AIA')
    print('============================================================')

def main():
    args = sys.argv
    if len(args) < 3:
        sys.exit(usage())

    for i in range(len(args)):
        if args[i] == '-f':
            path = args[i+1]
        elif args[i] == '-t':
            tlc = args[i+1]
        elif args[i] == '-h':
            sys.exit(usage())

    if not(os.path.isfile(path)):
        print('TSV file not found')
    if not(os.path.isdir('output')):
        print('Creating [output] directory ...')
        os.mkdir('output')

    with open(path, 'r') as f:
        i = 0
        gdf = gpd.GeoDataFrame()
        print('processing', tlc)
        for r in f:
            a = r.split('\t')
            if (a[0] != tlc):
                if (i > 1):
                    break
                else:
                    continue

            i += 1
            try:
                b = a[1].replace('\n', '')
                g = gpd.GeoDataFrame.from_features([json.loads(b)])
                gdf = gpd.pd.concat([gdf, g], ignore_index=True)
            except:
                print('ERROR', i, r)

            if (i%10000 == 0): 
                print('processing line', i)
            
    print('Exporting geopackage for', tlc);
    gdf = gdf[gdf.geometry.is_valid]
    gdf['ISO3'] = tlc
    gdf.to_file(f'output/{tlc}_roads.gpkg', driver='GPKG', index=False)

if __name__ == '__main__':
    sys.exit(main())