# Local farming, snow and buildings

A seed can define a `crop_climate` object. Old seeds and mods without
one keep their existing growth rules. Core crop profiles use degrees
Celsius and millimetres of water.

| Field | Meaning |
| --- | --- |
| `base_c` | Base temperature for accumulating growing-degree days |
| `optimum_c` | Temperature above which heat stress reduces growth |
| `min_c`, `max_c` | Daily cold and heat limits. Exceeding a limit pauses growth |
| `degree_days` | Heat units required to reach harvest |
| `growing_days` | Minimum growing span at full growth speed |
| `water_mm` | Approximate seasonal water requirement |
| `water_peak` | Stage of highest water demand, from 0 at sowing to 1 at ripeness |

The game samples the local weather history, including its regional rainfall
timing, and keeps a small soil-water store using existing seed item variables.
Rain and planter irrigation contribute to the store. Roofs prevent direct
rain. The existing crop-speed option, growth stages, harvest, and plant
callbacks continue to apply. Soil moisture, cultivar differences, and
hardiness are simplified. The temperature limits currently pause progress.

The profiles use crop base temperatures from the
[Ontario vegetable guide](https://www.ontario.ca/files/2024-02/omafra-guide-to-vegetable-production-in-ontario-en-2024-02-15.pdf)
and [Purdue's crop tables](https://mrcc.purdue.edu/VIP/cropspecs),
[Oregon State's Croptime trials](https://extension.oregonstate.edu/catalog/em-9305-vegetable-degree-day-models-introduction-farmers-gardeners),
[FAO crop water estimates](https://www.fao.org/4/S2022E/s2022e07.htm), and
[University of Minnesota crop and harvest windows](https://extension.umn.edu/vegetable-growing-guides-farmers/crop-and-field-planning-tools-vegetable-farmers).
Where no cultivar-specific figure was available, the values are gameplay
estimates based on similar crops, suitable temperatures and reported
growing periods.

Wild terrain may define `fruit_climate` with a `growth` profile, a
`harvest` ID and a `bearing_days` window. Perennial ripening is derived
from the local normal growing season. Harvested terrain becomes productive
again with a later ripe period. The ripe period and the item spoilage
timer represent different processes. Prickly pear portions use
[USDA nutrient data](https://www.ars.usda.gov/ARSUserFiles/80400535/Data/SR/SR28/reports/sr28fg09.pdf)
and the [UC Davis handling guidance](https://postharvest.ucdavis.edu/ar/produce-facts-sheets/cactus-prickly-pear).
Saguaro harvest timing and 50 g nutrition are based on
[NPS field material](https://irma.nps.gov/DataStore/Reference/Profile/2317829)
and the [University of Arizona Arboretum](https://arboretum.arizona.edu/sites/default/files/2025-04/PRINT-Edible-Landscapes-Self-Guided-Tour-Booklet.pdf).
The ambient spoilage timers are conservative gameplay estimates. Common
snowberry still provides wildlife habitat, as its fruit is
[poisonous to humans](https://plants.ces.ncsu.edu/plants/symphoricarpos-albus/).

Snow cover is drawn on exposed terrain and roofs at their respective
levels. Seasonal ground snow remains separate from falling snow, and roofed
tiles below an exposed roof stay clear.

Indoor temperatures near the player use a bounded four-direction enclosure
sample and a cached trailing outdoor mean. Walls and closed windows slow
temperature changes, with greater loss through windows and open gaps.
Nearby direct heat sources continue to use the existing radiation and
convection system. The model is inspired by
[EnergyPlus's zone air heat balance](https://energyplus.net/assets/nrel_custom/pdfs/pdfs_v23.2.0/EngineeringReference.pdf).
Buildings outside the local radius do not get an enclosure calculation
or independent thermal state.

Atlas cities lay out major four-lane streets within mapped built-up
districts. Local roads and building fronts use a bounded grid pass, and
intercity highway geometry continues to come from the transport atlas.
These changes affect newly generated overmaps.
