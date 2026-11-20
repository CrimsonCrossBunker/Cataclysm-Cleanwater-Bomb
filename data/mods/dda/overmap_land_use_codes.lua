local ccb = require("ccb")
local content = ccb.content

-- Native overmap land-use codes
do
local definition = content.OvermapLandUseCode {
    id = "",
    code = 0,
    name = "",
    description = "",
    symbol = "#",
    color = "white",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "cropland",
    code = 1,
    name = "Cropland",
    description = "Generally tilled land used to grow row crops.  Boundaries follow the shape of the fields and include associated buildings (e.g., barns).  This category also includes turf farms that grow sod.",
    symbol = ".",
    color = "yellow_yellow",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "pasture",
    code = 2,
    name = "Pasture",
    description = "Fields and associated facilities (barns and other outbuildings) used for animal grazing and for the growing of grasses for hay.",
    symbol = ".",
    color = "green_yellow",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "forest",
    code = 3,
    name = "Forest",
    description = "Areas where tree canopy covers at least 50% of the land.  Both coniferous and deciduous forests belong to this class.",
    symbol = "F",
    color = "green_yellow",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "wetland",
    code = 4,
    name = "Non-Forested Wetland",
    description = "DEP Wetlands (1:12,000) WETCODEs 4, 7, 8, 12, 23, 18, 20, and 21.",
    symbol = "~",
    color = "light_blue_cyan",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "mining",
    code = 5,
    name = "Mining",
    description = "Includes sand and gravel pits, mines and quarries.  The boundaries extend to the edges of the site's activities, including on-site machinery, parking lots, roads and buildings.",
    symbol = "M",
    color = "red_white",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "open_land",
    code = 6,
    name = "Open Land",
    description = "Vacant land, idle agriculture, rock outcrops, and barren areas.  Vacant land is not maintained for any evident purpose and it does not support large plant growth.",
    symbol = ".",
    color = "brown",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "recreation_participation",
    code = 7,
    name = "Participation Recreation",
    description = "Facilities used by the public for active recreation.  Includes ball fields, tennis courts, basketball courts, athletic tracks, ski areas, playgrounds, and bike paths plus associated parking lots.  Primary and secondary school recreational facilities are in this category, but university stadiums and arenas are considered Spectator Recreation.  Recreation facilities not open to the public such as those belonging to private residences are mostly labeled with the associated residential land use class not participation recreation.  However, some private facilities may also be mapped.",
    symbol = "!",
    color = "red_magenta",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "recreation_spectator",
    code = 8,
    name = "Spectator Recreation",
    description = "University and professional stadiums designed for spectators as well as zoos, amusement parks, drive-in theaters, fairgrounds, race tracks and associated facilities and parking lots.",
    symbol = "!",
    color = "green_magenta",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "recreation_water",
    code = 9,
    name = "Water-Based Recreation",
    description = "Swimming pools, water parks, developed freshwater and saltwater sandy beach areas and associated parking lots.  Also included are scenic areas overlooking lakes or other water bodies, which may or may not include access to the water (such as a boat launch).  Water-based recreation facilities related to universities are in this class.  Private pools owned by individual residences are usually included in the Residential category.  Marinas are separated into code 29.",
    symbol = "!",
    color = "cyan_magenta",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "residential_multi",
    code = 10,
    name = "Multi-Family Residential",
    description = "Duplexes (usually with two front doors, two entrance pathways, and sometimes two driveways), apartment buildings, condominium complexes, including buildings and maintained lawns.  Note: This category was difficult to assess via photo interpretation, particularly in highly urban areas.",
    symbol = "H",
    color = "light_green_green",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "residential_high",
    code = 11,
    name = "High Density Residential",
    description = "Housing on smaller than 1/4 acre lots.  See notes below for details on Residential interpretation.",
    symbol = "H",
    color = "light_green",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "residential_medium",
    code = 12,
    name = "Medium Density Residential",
    description = "Housing on 1/4 - 1/2 acre lots.  See notes below for details on Residential interpretation.",
    symbol = "h",
    color = "light_green_green",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "residential_low",
    code = 13,
    name = "Low Density Residential",
    description = "Housing on 1/2 - 1 acre lots.  See notes below for details on Residential interpretation.",
    symbol = "h",
    color = "light_green",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "wetland_saltwater",
    code = 14,
    name = "Saltwater Wetland",
    description = "DEP Wetlands (1:12,000) WETCODEs 11 and 27.",
    symbol = "~",
    color = "light_cyan",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "commercial",
    code = 15,
    name = "Commercial",
    description = "Malls, shopping centers and larger strip commercial areas, plus neighborhood stores and medical offices (not hospitals).  Lawn and garden centers that do not produce or grow the product are also considered commercial.",
    symbol = "$",
    color = "cyan",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "industrial",
    code = 16,
    name = "Industrial",
    description = "Light and heavy industry, including buildings, equipment and parking areas.",
    symbol = "#",
    color = "white",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "transitional",
    code = 17,
    name = "Transitional",
    description = "Open areas in the process of being developed from one land use to another (if the future land use is at all uncertain).  Formerly identified as Urban Open.",
    symbol = "?",
    color = "dark_gray",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "transportation",
    code = 18,
    name = "Transportation",
    description = "Airports (including landing strips, hangars, parking areas and related facilities), railroads and rail stations, and divided highways (related facilities would include rest areas, highway maintenance areas, storage areas, and on/off ramps).  Also includes docks, warehouses, and related land-based storage facilities, and terminal freight and storage facilities.  Roads and bridges less than 200 feet in width that are the center of two differing land use classes will have the land use classes meet at the center line of the road (i.e., these roads/bridges themselves will not be separated into this class).",
    symbol = "*",
    color = "light_gray",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "waste_disposal",
    code = 19,
    name = "Waste Disposal",
    description = "Landfills, dumps, and water and sewage treatment facilities such as pump houses, and associated parking lots.  Capped landfills that have been converted to other uses are coded with their present land use.",
    symbol = "W",
    color = "red",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "water",
    code = 20,
    name = "Water",
    description = "DEP Wetlands (1:12,000) WETCODEs 9 and 22.",
    symbol = "~",
    color = "light_blue",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "cranberry_bog",
    code = 23,
    name = "Cranberry bog",
    description = "Both active and recently inactive cranberry bogs and the sandy areas adjacent to the bogs that are used in the growing process.  Impervious features associated with cranberry bogs such as parking lots and machinery are included.  Modified from DEP Wetlands (1:12,000) WETCODE 5.",
    symbol = "~",
    color = "light_blue_red",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "powerline_utility",
    code = 24,
    name = "Powerline/Utility",
    description = "Powerline and other maintained public utility corridors and associated facilities, including power plants and their parking areas.",
    symbol = "z",
    color = "yellow",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "saltwater_sandy_beach",
    code = 25,
    name = "Saltwater Sandy Beach",
    description = "DEP Wetlands (1:12,000) WETCODEs 1, 2, 3, 6, 10, 13, 17, and 19",
    symbol = "~",
    color = "cyan_yellow",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "golf_course",
    code = 26,
    name = "Golf Course",
    description = "Includes the greenways, sand traps, water bodies within the course, associated buildings and parking lots.  Large forest patches within the course greater than 1 acre are classified as Forest (class 3).  Does not include driving ranges or miniature golf courses.",
    symbol = "G",
    color = "light_green_green",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "marina",
    code = 29,
    name = "Marina",
    description = "Include parking lots and associated facilities but not docks (in class 18)",
    symbol = "M",
    color = "yellow_cyan",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "urban_public_institutional",
    code = 31,
    name = "Urban Public/Institutional",
    description = "Lands comprising schools, churches, colleges, hospitals, museums, prisons, town halls or court houses, police and fire stations, including parking lots, dormitories, and university housing.  Also may include public open green spaces like town commons.",
    symbol = "#",
    color = "red",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "cemetery",
    code = 34,
    name = "Cemetery",
    description = "Includes the gravestones, monuments, parking lots, road networks and associated buildings.",
    symbol = "+",
    color = "white",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "orchard",
    code = 35,
    name = "Orchard",
    description = "Fruit farms and associated facilities.",
    symbol = "f",
    color = "red_green",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "nursery",
    code = 36,
    name = "Nursery",
    description = "Greenhouses and associated buildings as well as any surrounding maintained lawn.  Christmas tree (small conifer) farms are also classified as Nurseries.",
    symbol = "f",
    color = "light_green_green",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "wetland_forest",
    code = 37,
    name = "Forested Wetland",
    description = "DEP Wetlands (1:12,000) WETCODEs 14, 15, 16, 24, 25, and 26.",
    symbol = "F",
    color = "green_cyan",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "residential_very_low",
    code = 38,
    name = "Very Low Density Residential",
    description = "Housing on > 1 acre lots and very remote, rural housing.  See notes below for details on Residential interpretation.",
    symbol = "h",
    color = "light_green",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "junkyard",
    code = 39,
    name = "Junkyard",
    description = "Includes the storage of car, metal, machinery and other debris as well as associated buildings as a business.",
    symbol = "#",
    color = "yellow_white",
}
content.add(definition)
end
do
local definition = content.OvermapLandUseCode {
    id = "brushland",
    code = 40,
    name = "Brushland/Successional",
    description = "Predominantly (> 25%) shrub cover, and some immature trees not large or dense enough to be classified as forest.  It also includes areas that are more permanently shrubby, such as heath areas, wild blueberries or mountain laurel.",
    symbol = "f",
    color = "brown_green",
}
content.add(definition)
end
