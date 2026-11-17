# North America elevations

Atlas worlds use metres above sea level for weather, oxygen, land grade and
the overmap coordinates and survey display. The physical range is -16,384
to 16,384 metres. The atlas projection treats one map square as one
horizontal metre. Each structural level represents four metres from local
grade. The overmap cursor and debug travel use that datum for height, and
debug travel rounds to the nearest available level. The local map loads a
bounded window of levels around destinations outside the original range.
New strata use the ordinary rock and open-air terrain. Existing buildings,
basements and utility tunnels use their original layouts. Classic worlds
and mod dimensions use the original structural range.

House floors use a level site at the centre of their overmap tile. City
generation rejects larger building footprints with more than one floor of
height difference between the surface lots. Lakes have a flat waterline
estimated from shoreline elevations. Mapped river reaches follow a downhill
profile fitted to their centreline, with the bank and water positions still
set by the existing atlas. This is a profile for each mapped reach, without
a hydraulic network simulation of flow or confluence heights.

The portable data asset uses a light continental elevation grid, with
interpolation between samples. It models the broad slope and altitude of
terrain and cannot reconstruct individual cuts, embankments or cliffs.
Walking costs increase on climbs and steep descents. ASCII arrows on open
ground point uphill in eight directions. The 2D renderer shades slope
with a light direction and a surface normal, using the existing tile grid.

## Terrain source and format

[Mapzen Terrain Tiles](https://registry.opendata.aws/terrain-tiles/) from the
public AWS Terrarium layer, zoom 6, accessed November 17, 2026. Elevation
samples are nearest-pixel readings converted to whole metres and stored in
a gzip stream. After the eight-byte magic `CCBDEM1\n`, there are 2,341
south-to-north rows, each with 5,671 signed, little-endian 16-bit values
from west to east. Sample centres start at latitude 6 + 1/120 degrees and
longitude -195 + 1/120 degrees, advancing by 1/30 degree in both axes.
Wrap longitude to [-180, 180) before looking up Terrarium pixels. Use the
standard Web Mercator pixel transform at 16,384 pixels worldwide, take the
floor of each pixel coordinate, and decode `R * 256 + G + B / 256 - 32768`.

Source credits follow the [Mapzen attribution guide](https://github.com/tilezen/joerd/blob/master/docs/attribution.md):

- ArcticDEM terrain data DEM(s) were created from DigitalGlobe, Inc., imagery
  and funded under National Science Foundation awards 1043681, 1559691, and 1542736.
- Canada terrain data contains information licensed under the Open Government Licence - Canada.
- Mexico terrain data source: INEGI, Continental relief, 2016.
- Global ETOPO1 terrain data: U.S. National Oceanic and Atmospheric Administration.
- United States 3DEP (formerly NED) and global GMTED2010 and SRTM terrain data
  courtesy of the U.S. Geological Survey.
- European terrain data uses Copernicus data and information funded by the
  European Union - EU-DEM layers. Norway terrain data: Kartverket.

## Weather and movement

A regional climate station's optional `elevation_m` is the elevation of its
temperature record. When absent, the atlas samples the DEM at the station
location. Neighbouring stations' reference heights use the same weights as
their monthly temperatures. The standard lapse correction applies the height
difference from that reference to the destination. Underground temperature
tends toward the annual mean at the surface directly above with reduced
seasonal and daily swings.

Oxygen availability uses the ratio of local to sea-level pressure, with the
oxygen fraction held constant. Wind combines a bounded terrain exposure
estimate and a height-above-ground power law. The existing weather-system
pressure variable continues to represent synoptic weather. The grade cost is
a bounded gameplay approximation of the measured increase in the work of
walking uphill and braking on steep descents.

- [NASA standard atmosphere model](https://www1.grc.nasa.gov/beginners-guide-to-aeronautics/earth-atmosphere-equation-metric/)
- [NREL Wind Resource Assessment Handbook](https://nrel.gov/docs/legosti/fy97/22223.pdf)
- [Minetti et al., Energy cost of walking and running at extreme uphill and downhill slopes](https://doi.org/10.1152/japplphysiol.01177.2001)
- [USGS DEM surface treatments](https://www.usgs.gov/ngp-standards-and-specifications/lidar-base-specification-digital-elevation-model-surface)
