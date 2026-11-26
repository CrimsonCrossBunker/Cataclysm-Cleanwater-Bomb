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
| `vernalization_days` | Optional cold exposure needed for winter crops to head |
| `root_zone_water_mm` | Optional plant-available soil water before applying terrain modifiers |

The game samples the local weather history, including its regional rainfall
timing, and keeps a root-zone soil-water store using existing seed item variables.
Rain and planter irrigation contribute to the store. Roofs prevent direct
rain. The existing crop-speed option, growth stages, harvest, and plant
callbacks continue to apply. Soil moisture, cultivar differences, and
hardiness are simplified. The temperature limits currently pause progress.

Daily demand scales the reference seasonal water budget by local
Hargreaves reference evapotranspiration, including latitude, season, daily
temperature and temperature range. The reference budget corresponds to
4 mm/day reference ET. Root-zone storage follows terrain capacity, with
explicit values for supported cereals, vegetables, legumes, oil crops and
berries. See the
[FAO-56 meteorological equations](https://www.fao.org/4/X0490E/x0490e07.htm)
and [root depth and water-stress tables](https://www.fao.org/4/X0490E/x0490e0e.htm).
Water stress can slow establishment. Once established, crops accumulate
thermal development and minimum growing days without repeatedly losing
both counters to the same moisture deficit. A seasonal water deficit reduces
manual, mechanical and camp harvests with an approximate yield-response
coefficient of 1.1.

The explicit root-zone capacities are model estimates, calculated as
effective rooting depth times a reference 120 mm of plant-available water
per metre of soil, rounded to 10 mm. FAO-56 gives this reference for silty
clay in Example 36; the existing terrain capacity multiplier represents
local differences in soil. These capacities describe the available store,
not seasonal water demand or an irrigation allowance. Root depth is fixed
in the current model rather than expanding with plant age.

Representative depths within FAO-56 Table 22 supply the following profiles.
Edible grain, dried grain and dedicated seed profiles of a crop use the
same capacity; sweet corn and popcorn retain different effective depths.

| Crop | Reference depth (m) | Root-zone water (mm) |
| --- | --- | --- |
| Spring wheat, barley, oats | 1.2 | 140 |
| Winter wheat | 1.6 | 190 |
| Sweet corn / popcorn | 1.0 / 1.3 | 120 / 160 |
| Canola, sugar beet, soybean, tomato, eggplant | 1.0 | 120 |
| Dry/snap beans, lentils | 0.7 | 80 |
| Lettuce, radish, onion, garlic, spinach, celery | 0.4 | 50 |
| Cabbage | 0.65 | 80 |
| Broccoli, cauliflower, Brussels sprouts, potato | 0.5 | 60 |
| Carrot, chilli and bell peppers, artichoke | 0.75 | 90 |
| Cucumber, gherkin, hops | 1.0 | 120 |
| Zucchini, peas | 0.8 | 100 |
| Watermelon, melon, sunflower | 1.2 | 140 |
| Pumpkin | 1.25 | 150 |
| Cotton | 1.3 | 160 |
| Asparagus, grapes | 1.5 | 180 |
| Blackberry, raspberry | 0.8 | 100 |
| Strawberry | 0.25 | 30 |

Additional profiles use published crop-specific guidance:

| Crop | Reference depth (m) | Root-zone water (mm) | Source |
| --- | --- | --- | --- |
| Tobacco | 0.7 | 80 | [FAO rooting-depth annex](https://www.fao.org/4/y5749e/y5749e0j.htm) |
| Kale | 0.5 | 60 | [Colorado State irrigation guide](https://extension.colostate.edu/resource/determining-irrigation-run-times-with-drip-tape-on-specialty-crops/) |
| Blueberry | 0.4 | 50 | [WSU small-fruit handbook](https://extension.wsu.edu/pnw-gardeners-handbook/chapter-9-berries-and-small-fruits/) |
| Cranberry | 0.15 | 20 | [University of Maine cranberry guidance](https://extension.umaine.edu/gardening/2023/10/02/maine-home-garden-news-october-2023/) |
| Rhubarb | 0.4 | 50 | [University of Maine rhubarb guidance](https://extension.umaine.edu/publications/2514e/) |
| Buckwheat | 0.25 | 30 | [UC SAREP root observations](https://sarep.ucdavis.edu/covercrop/buckwheat) |
| Mustard | 0.8 | 100 | [University of Saskatchewan effective water-extraction depths](https://harvest.usask.ca/items/69384034-910c-4c78-87a2-954613517687) |
| Horseradish | 0.5 | 60 | [Utah State irrigation-depth guidance](https://extension.usu.edu/yardandgarden/research/horseradish-in-the-garden) |
| Bottle gourd | 0.6 | 70 | [Field-trial active root zone](https://dspace.emu.ee/server/api/core/bitstreams/33d2da5f-3dd5-4201-83f4-542281a2f55d/content) |

The buckwheat value represents the shallow zone with most observed root
volume, not the maximum depth of its taproot. Wild plants without suitable
root-depth data retain the existing default capacity. Mushrooms do not use
these crop root-zone profiles.

The profiles use crop base temperatures from the
[Ontario vegetable guide](https://www.ontario.ca/files/2024-02/omafra-guide-to-vegetable-production-in-ontario-en-2024-02-15.pdf)
and [Purdue's crop tables](https://mrcc.purdue.edu/VIP/cropspecs),
[Oregon State's Croptime trials](https://extension.oregonstate.edu/catalog/em-9305-vegetable-degree-day-models-introduction-farmers-gardeners),
[FAO crop water estimates](https://www.fao.org/4/S2022E/s2022e07.htm), and
[University of Minnesota crop and harvest windows](https://extension.umn.edu/vegetable-growing-guides-farmers/crop-and-field-planning-tools-vegetable-farmers).
Where no cultivar-specific figure was available, the values are gameplay
estimates based on similar crops, suitable temperatures and reported
growing periods.

Red winter wheat uses a 0 °C base, 1,700 °C-days to harvest, and a separate
grain-filling stage after heading. Its 460 mm seasonal demand is within
[K-State's crop water-use range](https://bookstore.ksre.k-state.edu/pubs/efficient-crop-water-use-in-kansas_MF3066.pdf),
and its thermal requirements are based on [Kansas Mesonet growth stages](https://mesonet.k-state.edu/agriculture/wheat/gdd/)
and the [Great Plains wheat production handbook](https://aes.colostate.edu/swrcr/wp-content/uploads/sites/92/2019/03/WheatProductionManual-1.pdf).
Pregame crops use the local seasonal weather simulation. Central Plains
weather includes monthly precipitation and wet-day counts for Goodland,
Dodge City, Salina and Wichita from the [NOAA 1991–2020 climate normals](https://www.ncei.noaa.gov/data/normals-monthly/1991-2020/access/).

Outdoor winter wheat can be relay-planted with corn from heading onward
when the weather is warm enough. The corn can establish under the wheat
canopy and resumes normal development after the wheat is harvested or cleared.

Newly generated, connected farm-field tiles in the same overmap special
share a crop and sowing date. The crop lottery uses varieties that could
already have been sown at the start of the Cataclysm.

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

## Atlas city streets and neighborhoods

Atlas cities use the built-up footprint and population bands to place
buildings on available street frontage. Larger buildings get first choice
of contiguous lots. Houses, shops and civic buildings fill remaining
frontage, and developed block interiors can contain courtyards and small
parks. The water mask and the existing intercity transport atlas still
determine shorelines and mapped crossings.

Street patterns vary with the municipality's region. New York uses a
slanted grid with unequal block lengths and a diagonal avenue. Winnipeg
uses intersecting grids with bends and a diagonal across its core. Several
regional layouts also use staggered blocks and short local streets.
Collectors and arterials carry traffic between neighborhoods. Straight
arterials can reserve an adjacent overmap tile for a 34-tile-wide,
four-lane paved surface and two sidewalks. They taper ahead of junctions,
on narrow waterfronts and at overmap edges. At a four-way junction, a
yellow stop line spans the incoming lanes before each wide zebra crossing.

Rural special entrances try nearby existing roads in order of distance,
using the native terrain-aware pathfinder and excluding mapped controlled-access
corridors as direct access points. Short extra links are allowed where an
existing road route requires a substantial detour. Rural scenery uses the
local ecology's trees and shrubs. Orchard blocks retain their cultivated
trees.

Every atlas settlement of at least 100,000 people gets a deterministic
downtown, commercial, industrial and institutional center, with housing
between them. The centers fit the settlement's built-up footprint.
Larger streets also carry retail frontage where density is high. If the
source has no built-up cells for a city, the game uses a small,
population-scaled footprint around its atlas point and uses the land mask
to exclude water. New York and Winnipeg also have approximate anchors for
actual districts. The existing Sinaloa record covers Mazatlán. The
fallback excludes the erroneous duplicate in Sonora, since the city is
in Sinaloa according to [INEGI](https://www.inegi.org.mx/contenidos/productos/prod_serv/contenidos/espanol/bvinegi/productos/nueva_estruc/889463911173.pdf).

The nine regional houses preserve their individual footprints and roofs.
Their furnished rooms use the shared domestic furniture and loot
palettes, including the ordinary variation in locks, damage and
tidiness. Kitchen, bathroom, bedroom and utility storage use the same
supply groups as other houses.

Design references include the [NYC Landmarks Preservation Commission's
description of the Manhattan grid](https://s-media.nyc.gov/agencies/lpc/lp/2097.pdf),
[New York's CBD zoning definition](https://zr.planning.nyc.gov/article-i/chapter-2/12-10),
[Winnipeg's downtown urban design guidelines](https://www.winnipeg.ca/ppd/Documents/CityPlanning/Downtown/UrbanDesignReview/Urban-Design-Guidelines.pdf),
[Winnipeg's industrial park information](https://www.winnipeg.ca/building-development/doing-business-city/city-property/property-sale),
[Boston's historic street network](https://content.boston.gov/departments/streets-cabinet/neighborhood-street-plazas),
[Mexico City's historic centre plan](https://jefaturadegobierno.cdmx.gob.mx/comunicacion/nota/tenemos-la-obligacion-de-cuidar-el-centro-historico-para-disfrutarlo-en-todas-sus-dimensiones-marti-batres-durante-presentacion-del-plan-integral-de-manejo-2023-2028)
and the [EPA's street network design guide](https://www.epa.gov/sites/default/files/2014-04/documents/best-development-practices.pdf).

The layout applies when a North American overmap is generated. Use a fresh
world to see a complete city with the new layout.


## Soil and recipes

Atlas soil types modify the crop root zone's available water, rain infiltration,
drainage, and root growth. Sandy and gravelly soils lose water sooner, fine clay
lets rain in more slowly, and prairie black soil has a larger water reserve.
Irrigated planters retain their existing growing medium. Soil and tilling
variants share a profile. The relative gameplay parameters draw on
[USDA NRCS material on available water capacity](https://www.nrcs.usda.gov/sites/default/files/2022-10/nrcs142p2_051590.pdf)
and [FAO soil texture and infiltration tables](https://www.fao.org/4/v9926e/v9926e04.htm).

Prickly pear and saguaro fruit are alternatives in the shared fresh sweet fruit
ingredient group, including recipes that use it for drying, preserves, and
juice. Fruit portions use one prickly pear or two 50 g saguaro servings.

## Regional houses

New residential lots in atlas cities can roll a local house based on the state's
or province's jurisdiction at the lot. The existing city house pool provides
the majority of homes and acts as a fallback. The geographic assignments are
inspirations for layout and materials, with simplified roof profiles.

| Region | Local variant and references |
| --- | --- |
| New England and Atlantic Canada | Compact, symmetrical wood cottage with a central stove. [Historic New England](https://www.historicnewengland.org/preservation/for-homeowners-communities/your-old-or-historic-home/architectural-style-guide/) |
| Pacific Coast | Craftsman bungalow with a broad covered porch. [Washington State DAHP](https://dahp.wa.gov/historic-preservation/historic-buildings/architectural-style-guide/bungalow) |
| Gulf Coast and parts of the Southeast | Narrow shotgun dwelling with aligned doors and a front porch. [NPS South Lakeview nomination](https://npgallery.nps.gov/NRHP/GetAsset/70a6649a-2bb9-4347-886f-d3b3883578a5) |
| Prairies and northern Plains | Wood farmhouse with a sheltered entry. [Parks Canada, Seven Oaks House](https://www.pc.gc.ca/apps/dfhd/page_nhs_eng.aspx?id=17493) |
| Great Lakes and parts of the Midwest and Northeast | Brick bungalow with a projecting front bay. [Chicago Landmarks](https://webapps1.chicago.gov/landmarksweb/static/pdf/Your_House_Has_A_History.pdf) |
| Southwestern United States and northern Mexico | Adobe house with parapets and an enclosed patio. [NPS Pueblo Revival](https://home.nps.gov/subjects/architecture/pueblo.htm), [INAH Chihuahua](https://inah.gob.mx/images/suplementos/gacetinah/58/web/20250401_GacetINAH_58.pdf) |
| Quebec | Stone dwelling with a gallery and central passage. [Canadian Register of Historic Places](https://www.historicplaces.ca/fr/rep-reg/place-lieu.aspx?id=12893&pid=0) |
| Other Mexican regions | Street entry opening onto an inner courtyard with rooms around it. [INAH domestic building record](https://catalogonacionalmhi.inah.gob.mx/consulta_publica/detalle/12250) |
| Other US regions | Low, wide suburban ranch with garage and rear patio. [NPS architectural survey](https://npgallery.nps.gov/GetAsset/5b084efe-c22d-4877-9b6b-66cfe86e6485) |
