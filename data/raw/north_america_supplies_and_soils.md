# North American supplies and soil

On the North America atlas, newly generated shops and pantries get
regional stock from `north_america_supplies.json`. There is one
row for each of the 96 jurisdictions. A row selects representative produce,
a pantry profile and an outerwear profile. The local selections are
weighted alongside the original food and clothing groups, including on
supermarket shelves, in produce crates and in household refrigerators.
Data authors can use IDs such as `fresh_produce-CA-QC`,
`small_crate_of_fruits-MX-MIC` and `coats_unisex-US-AK`. Regional colors,
weights and selected game items are gameplay approximations of local stock.

Sources for food include the [USDA state agricultural
overviews](https://data.nass.usda.gov/Statistics_by_State/Ag_Overview/index.php),
[Statistics Canada fruit and vegetable production](https://www150.statcan.gc.ca/n1/daily-quotidien/250217/dq250217b-eng.htm)
and [maple production](https://www150.statcan.gc.ca/n1/daily-quotidien/241212/dq241212d-eng.htm),
and Mexico's [SIAP state agricultural summaries](https://www.gob.mx/agricultura/dgsiap/acciones-y-programas/panorama-agroalimentario-258035)
and [Michoacán avocado program](https://www.gob.mx/agricultura/es/articulos/el-aguacate-de-michoacan-ya-es-un-patrimonio-protegido).
Production guides the choice of featured goods. The authored retail weights
also account for shared supply chains and the long-distance transport used
by northern communities.

The same scope assigns Canadian or Mexican flags to newly generated civic
flagpoles. The national stock of fictional police and military armories uses
representative service equipment and compatible ammunition. For example, the
Canadian rifle and squad support slots use existing game counterparts for the
C7/C8 and C9, and the Mexican stock uses a 5.56 service rifle analogue for
the FX-05 alongside the game's G3. Carried drops on police, tactical, and
military monsters select service weapons and spare magazines from the same
country's profile. The choice and weight of each kit are
independent of any real facility's stocks. [Canadian Army equipment
catalogue](https://www.canada.ca/en/army/services/equipment/weapons.html),
[RCMP public service-pistol program](https://canadabuys.canada.ca/documents/pub/att/2022/07/27/a5a921e7ce0cd3a586db85b98195e5e1/ABES.PROD.PW__BM.B030.E28752.EBSU001.PDF),
[Mexican SEDENA equipment reference](https://dof.gob.mx/2024/SEDENA/SEDENA_150724.pdf).

Regenerate the three item group files with
`python tools/generate_regional_supplies.py`. The existing group IDs are
the fallbacks for classic worlds and when a regional group cannot be loaded.

The shipped `north_america.soils` grid samples the
[USDA Global Soil Regions map](https://services.arcgis.com/BG6nSlhZSAWtExvp/arcgis/rest/services/USDA_Global_Soil_Regions/FeatureServer/0)
at quarter-degree cell centres. Mapped classes are grouped into eleven
gameplay surfaces. The class mapping draws on the
[USDA dominant soil order overview](https://www.nrcs.usda.gov/sites/default/files/2025-04/AgHandbook296_508.pdf),
the [Canadian Chernozemic classification](https://sis.agr.gc.ca/cansis/taxa/cssc3/chpt05.html)
and [INEGI's Mexican soil survey](https://www.inegi.org.mx/contenidos/productos/prod_serv/contenidos/espanol/bvinegi/productos/geografia/tematicas/Edafologia_hist/1_4_000_000/702825691684.pdf).
Chernozems and related grassland soils map to dark prairie soil. Wet
organic soils, volcanic units, leached forest soils and other mapped classes
also have their own terrain and tilled variants.

Only bare surface dirt in newly generated terrain is replaced. Unmapped
cells use standard dirt. Each variant inherits the corresponding dirt or
dirt mound functions, and tilling and planting preserve the soil type.
Placement uses the existing planting and crop growth rules for all soil
classes.

To reproduce the grid, export the USDA layer as GeoJSON in EPSG:4326
with the `soilRegionName` field, envelope `-170,10,-50,84` and a
`maxAllowableOffset` of `0.02` degrees. Then run
`python tools/generate_north_america_soils.py usda-soils.geojson data/raw/north_america.soils`
with Rasterio 1.5.0. Both generators accept `--check`.
