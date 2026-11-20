# North America ground and transport

In North America worlds, press **Shift+Y** on the overmap to open the continent chart.
Move with the overmap direction controls, zoom with the overmap zoom bindings,
and use **Shift+Y** or the quit binding to return. Read a state, province,
territory, or federal district road map to unlock its road, river, lake, and
city details for the character. Debug mode displays all details. The usual
road-map loot rolls still apply. Local charts get the highest weight.

## Ground and temperature

The grass, forest-floor, and moss variants preserve the USDA soil class
underneath them. Their original movement, cover, grazing, and plowing rules
come from the corresponding terrain definitions.

The frozen-ground layer is sampled at 0.5° from the North American subset of
the GGD318 Permaice shapefile. Its continuous, discontinuous, sporadic, and
isolated classes set deterministic patch coverage at z=-1. Frozen ground
replaces natural solid rock and preserves open underground rooms and tunnels.

Brown, J., Ferrians, O., Heginbottom, J. A., and Melnikov, E. (2002).
*Circum-Arctic Map of Permafrost and Ground-Ice Conditions, Version 2*.
NASA National Snow and Ice Data Center DAAC. Permaice shapefile, North American
grid. Accessed 2026-11-15. [Dataset and citation](https://doi.org/10.7265/skbg-kf16)

Ground temperature tends to the local annual climate normal. Seasonal and
daily variations decay at different rates with depth. Each underground level is four metres below local grade. See the
[atlas elevation notes](north_america_elevation.md) for the datum and climate model.
[Very shallow soil temperature model](https://doi.org/10.1186/s40517-019-0135-6)

## Roads and settlements

The transport file uses the same projection and one-metre world scale as
`north_america.atlas`. Natural Earth supplies the continental road network.
Its alignments are generalized. Local streets and connections from procedural
towns to mapped roads still use the game generator. Intersections and road
crossings are simplified at the overmap grid resolution. The chart uses the
same roads and the existing Natural Earth river, lake, and city layers.
[Natural Earth cultural vectors](https://www.naturalearthdata.com/downloads/10m-cultural-vectors/)
[Natural Earth physical vectors](https://www.naturalearthdata.com/downloads/10m-physical-vectors/)

Mapped routes are laid across water even when an overmap contains no dry land.
The [NYC Street Centerline](https://data.cityofnewyork.us/d/inkn-q76z) fills gaps
in the East River crossings, the Harlem River Washington Bridge, the FDR Drive,
West Street, and sections of the Henry Hudson Parkway. The supplemental
`north_america_nyc.transport` uses the same projected segment format as the
main transport file. It also includes generalized George Washington and
Queensboro bridge decks and their approaches. Parallel carriageways on the
major East River bridges share a centreline. Mapped crossings use raised
decks, original bridges and bridgeheads, with curved deck sections joining
turns in the mapped routes. [NYC DOT bridge inventory](https://www.nyc.gov/html/dot/html/infrastructure/bridges.shtml)

Road width uses the expressway class and the population of nearby cities in
areas without lane counts. The Ontario Road Network segment layer supplies
the Highway 401 core and collector road geometry and lane counts from Milton
through Mississauga. The game uses a single centerline there and compresses the
12-lane cross section to fit a 24-square overmap tile. Broad highway spawns
face along the road and are placed to the right of their direction of travel.
[Ontario Highway 401 widening](https://news.ontario.ca/en/release/1002578/ontario_expands_highway_401_in_mississauga_and_milton)
[Ontario Road Network Composite](https://data.ontario.ca/en/dataset/ontario-road-network-orn-composite)
Contains information licensed under the [Open Government Licence – Ontario](https://www.ontario.ca/page/open-government-licence-ontario).

Military bases use country and jurisdiction density weights informed by
public national and provincial summaries. Their individual sites are generated
by the game. The counts in these catalogs cover different categories and the
density weights are a gameplay approximation for large bases. [U.S. DoD
FY2024 financial report](https://comptroller.defense.gov/Portals/45/Documents/afr/fy2024/DoD_FY24_Agency_Financial_Report.pdf)
[Canadian Armed Forces footprint](https://www.canada.ca/en/department-national-defence/corporate/reports-publications/proactive-disclosure/welcome-package-minister-national-defence/canadian-armed-forces/introduction-canadian-armed-forces/department-national-defence-canadian-armed-forces-footprint.html)
[Mexico military zones summary](https://transparencia.sedena.gob.mx/pdf/Informe_Rendicion_cuentas_2018-2024/MEMORIA%20DOCUMENTAL/SDN_MD-13.pdf)

Classic random worlds keep their procedural highway grid, original military
base rule, and generic road-map stock. Previously generated sections retain
their terrain. Physical roads and frozen ground appear on newly generated map
tiles.

## Regenerating data

Use the same GIS dependencies as the original atlas. Download the Natural Earth
`ne_10m_roads.zip` and `ne_10m_admin_1_states_provinces.zip` archives, and the
GGD318 `permaice.shp`, `.shx`, `.dbf`, and `.prj` files. The Ontario input is
a GeoJSON export of the Ontario Road Network Composite Segment FeatureServer
layer 5 with envelope `-79.87,43.50,-79.55,43.68` in EPSG:4326, filter
`ROUTE_NUMBER LIKE '%401%' AND ROAD_CLASS = 'Freeway'`, and fields
`FULL_STREET_NAME,ROAD_CLASS,ROUTE_NUMBER,NUMBER_OF_LANES`. Use EPSG:4326 for
the export.

```sh
python tools/generate_north_america_ground.py --permafrost /path/permaice.shp
python tools/generate_north_america_transport.py /path/ne_10m_roads.zip /path/ne_10m_admin_1_states_provinces.zip /path/ontario-401.geojson
```

Both commands accept `--check`.
