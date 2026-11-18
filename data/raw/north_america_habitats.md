# North American habitat profiles

The North America world uses `north_america_habitats.json` on top of the existing
CEC ecoregion grid and `north_america.elevation.gz`. No new raster is needed.
The profile pass only replaces open and forested wilderness outside the atlas
urban footprints. It leaves the road network, rivers, lakes, coastline, and
placed settlements and specials intact. It does not rewrite saved regions.

- `regions` matches existing CEC codes. An empty list allows local landmarks
  to span multiple ecoregions. `bounds` is west, south, east, north in degrees.
- `groves` entries are longitude, latitude and radius in kilometres.
  `corridor` uses longitude and latitude along an approximate axis, with a
  maximum distance in `corridor_width_km`. These describe broad areas, not
  surveyed boundaries. More specific profiles are listed first.
- Elevation and height relative to treeline may both restrict a profile.
  The treeline is interpolated between latitude and height pairs for each
  mountain system. `transition_m` mixes neighbouring cover types around the
  height limits using a repeatable map coordinate hash.
- Field, forest and wetland map generation provide the base. The plant and
  ground palettes weight local species and cover. Existing water and furniture
  are retained. Canyon relief comes from the existing DEM; the canyon profiles
  add exposed rock, dry scrub, and rim woodland without carving another channel.
- Cloudberry and lingonberry follow the existing `fruit_climate` rules. Their
  degree days, water requirements, and storage life are game estimates; the
  calorie and vitamin values describe a 100 g serving.

References used for the regions and species:

- [CEC: Terrestrial ecoregions of North America](https://www.cec.org/north-american-environmental-atlas/terrestrial-ecoregions-level-ii/)
- [NPS: Olympic temperate rain forests](https://www.nps.gov/olym/learn/nature/temperate-rain-forests.htm)
- [USDA Forest Service: Giant sequoia](https://research.fs.usda.gov/silvics/giant-sequoia)
  and [California State Parks: Coast redwood](https://www.parks.ca.gov/?page_id=22257)
- [USFWS: Great Dismal Swamp peat and forest communities](https://www.fws.gov/refuge/great-dismal-swamp/what-we-do)
- [NPS: Denali ecosystem](https://www.nps.gov/im/cakn/dena.htm)
  and [CONANP: Nevado de Toluca management program](https://simec.conanp.gob.mx/pdf_libro_pm/40_libro_pm.pdf)
- [NPS: Grand Canyon life zones](https://www.nps.gov/grca/learn/nature/naturalfeaturesandecosystems.htm),
  [NPS: Mojave plant communities](https://www.nps.gov/moja/learn/nature/plants.htm),
  and [USGS: Badlands ecology](https://www.usgs.gov/geology-and-ecology-of-national-parks/ecology-badlands-national-park)
- USDA Forest Service species reviews for [cloudberry](https://research.fs.usda.gov/feis/species-reviews/rubcha)
  and [lingonberry](https://research.fs.usda.gov/feis/species-reviews/vacvit);
  USDA [Alaska Native entries](https://www.ars.usda.gov/ARSUserFiles/80400525/Data/SR/SR28/reports/sr28fg35.pdf)
  for cloudberry energy; Norwegian Food Composition Table for [cloudberry](https://www.matvaretabellen.no/en/cloudberries-raw/)
  and [lingonberry](https://www.matvaretabellen.no/en/lingonberries-cowberries-raw/).
