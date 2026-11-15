# North America atlas

In the world creation options, **Map generation** defaults to **North America**
for the default surface region. Select **Classic random** to generate rivers,
lakes, forests, and settlements with the original procedural generator.
Configured custom regions and pregenerated maps retain their own generation.
The choice is fixed once the world starts generating terrain, and existing
saves continue with their saved map mode.

`north_america.atlas` is the bundled geographic terrain source. In a North
America world, the city selector is available during character creation with
the displayed Starting city action (Shift+C by default).
The default search starts near Bedford/Hanscom, west of Boston. When a city
is selected, the scenario's usual starting buildings are searched in its
overmap and up to three overmaps away.

The atlas includes North American land, major lakes and rivers, and city
centres for the continental US and Alaska, Canada, and Mexico. Data come
from Natural Earth's public-domain 1:10m
[land, lakes, and river centreline layers](https://www.naturalearthdata.com/downloads/10m-physical-vectors/)
and [populated places layer](https://www.naturalearthdata.com/downloads/10m-cultural-vectors/).
See the [Natural Earth terms of use](https://www.naturalearthdata.com/about/terms-of-use/).

The metric grid is a spherical azimuthal equidistant projection centred at
42.47° N, 71.2894° W, with a radius of 6,371,000 m. One map square equals
one projected metre, and one overmap terrain tile equals 24 projected metres.
Distances from Bedford are preserved. Scale away from Bedford varies by
direction, and small shoreline details are limited by the source and the
120 m simplification tolerance. River width is rendered as a narrow corridor
around the source centerline. Cities seed the existing procedural city
generator. Street layouts, individual buildings, and elevation are outside
the geographic data.

To regenerate, download the following Natural Earth ZIPs to one directory:
`ne_10m_land.zip`, `ne_10m_lakes.zip`,
`ne_10m_rivers_lake_centerlines.zip`, and `ne_10m_populated_places.zip`.
With Python 3.10+, pyshp 3.1.8, pyproj 3.8.0, and Shapely 2.2.0 installed, run:

```sh
python tools/generate_north_america.py /path/to/zips data/raw/north_america.atlas
```

Use `--check` to compare the file against a regeneration from the same sources.