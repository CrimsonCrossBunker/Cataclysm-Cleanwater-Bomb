local ccb = require("ccb")
local content = ccb.content

-- Native composable overmap-vision profiles
do
local definition = content.OvermapVision {
    id = "default",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "always_full",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "isolated_building",
}
definition:appearance {
    name = "building",
    symbol = "^",
    color = "light_gray",
    looks_like = "cabin",
}
definition:appearance {
    name = "building",
    symbol = "^",
    color = "light_gray",
    looks_like = "cabin",
}
definition:appearance {
    name = "building",
    symbol = "^",
    color = "light_gray",
    looks_like = "cabin",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "city_building",
}
definition:appearance {
    name = "city",
    symbol = "#",
    color = "light_gray",
}
definition:appearance {
    name = "city building",
    symbol = "O",
    color = "light_gray",
}
definition:appearance {
    name = "city building",
    symbol = "O",
    color = "light_gray",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "alien_tower",
}
definition:appearance {
    name = "tall alien building",
    symbol = "0",
    color = "pink",
}
definition:appearance {
    name = "alien tower",
    symbol = "0",
    color = "pink",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "isolated_tower",
}
definition:appearance {
    name = "tall building",
    symbol = "0",
    color = "light_gray",
}
definition:appearance {
    name = "tower",
    symbol = "0",
    color = "light_gray",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "isolated_camp",
}
definition:appearance {
    name = "tent",
    symbol = ";",
    color = "light_gray",
    looks_like = "campsite",
}
definition:appearance {
    name = "camp",
    symbol = "+",
    color = "light_gray",
    looks_like = "campsite",
}
definition:appearance {
    name = "camp",
    symbol = "+",
    color = "light_gray",
    looks_like = "campsite",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "isolated_electronics",
}
definition:appearance {
    name = "infrastructure",
    symbol = "&",
    color = "light_gray",
}
definition:appearance {
    name = "electrical infrastructure",
    symbol = "A",
    color = "light_gray",
}
definition:appearance {
    name = "electrical infrastructure",
    symbol = "A",
    color = "light_gray",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "industrial_building",
}
definition:appearance {
    name = "building",
    symbol = "^",
    color = "light_gray",
}
definition:appearance {
    name = "industrial building",
    symbol = "i",
    color = "light_gray",
}
definition:appearance {
    name = "industrial building",
    symbol = "i",
    color = "light_gray",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "warehouse",
}
definition:appearance {
    name = "building",
    symbol = "^",
    color = "light_gray",
}
definition:appearance {
    name = "warehouse",
    symbol = "w",
    color = "light_gray",
}
definition:appearance {
    name = "warehouse",
    symbol = "w",
    color = "light_gray",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "island",
}
definition:blend_adjacent()
definition:appearance {
    name = "island",
    symbol = "o",
    color = "brown",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "wreckage",
}
definition:appearance {
    name = "wreckage",
    symbol = "^",
    color = "dark_gray",
}
definition:appearance {
    name = "wreckage",
    symbol = "^",
    color = "dark_gray",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "forested",
}
definition:appearance {
    name = "forest",
    symbol = "F",
    color = "green",
    looks_like = "forest_thick",
}
definition:appearance {
    name = "forest",
    symbol = "F",
    color = "green",
    looks_like = "forest_thick",
}
definition:appearance {
    name = "forest",
    symbol = "F",
    color = "green",
    looks_like = "forest_thick",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "first_glance_forest",
}
definition:appearance {
    name = "forest",
    symbol = "F",
    color = "green",
    looks_like = "forest_thick",
}
definition:appearance {
    name = "managed forest",
    symbol = "F",
    color = "green",
    looks_like = "forest",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "forested_swampy",
}
definition:appearance {
    name = "forest",
    symbol = "F",
    color = "green",
    looks_like = "forest_thick",
}
definition:appearance {
    name = "swamp",
    symbol = "F",
    color = "cyan",
    looks_like = "forest_water",
}
definition:appearance {
    name = "swamp",
    symbol = "F",
    color = "cyan",
    looks_like = "forest_water",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "open_land",
}
definition:appearance {
    name = "field",
    symbol = ".",
    color = "brown",
    looks_like = "field",
}
definition:appearance {
    name = "field",
    symbol = ".",
    color = "brown",
    looks_like = "field",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "farm_field",
}
definition:appearance {
    name = "field",
    symbol = ".",
    color = "brown",
    looks_like = "field",
}
definition:appearance {
    name = "farm field",
    symbol = "#",
    color = "i_brown",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "large_pavement",
}
definition:blend_adjacent()
definition:appearance {
    name = "pavement",
    symbol = "O",
    color = "dark_gray",
    looks_like = "s_lot",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "single_water",
}
definition:appearance {
    name = "water",
    symbol = "O",
    color = "blue",
    looks_like = "pond_field",
}
definition:appearance {
    name = "water",
    symbol = "O",
    color = "blue",
    looks_like = "pond_field",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "water_body",
}
definition:appearance {
    name = "water body",
    symbol = "#",
    color = "blue",
    looks_like = "river_center",
}
definition:appearance {
    name = "water body",
    symbol = "#",
    color = "blue",
    looks_like = "river_center",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "roof_or_air",
}
definition:appearance {
    name = "open air",
    symbol = ".",
    color = "blue",
    looks_like = "open_air",
}
definition:appearance {
    name = "open air",
    symbol = ".",
    color = "blue",
    looks_like = "open_air",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "underground_dirt",
}
definition:appearance {
    name = "underground",
    symbol = "#",
    color = "brown",
}
definition:appearance {
    name = "basement",
    symbol = "O",
    color = "black",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "underground_stone",
}
definition:appearance {
    name = "underground",
    symbol = "#",
    color = "brown",
}
definition:appearance {
    name = "basement",
    symbol = "O",
    color = "black",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "large_building",
}
definition:appearance {
    name = "large building",
    symbol = "+",
    color = "i_white",
}
definition:appearance {
    name = "large building",
    symbol = "+",
    color = "i_white",
}
definition:appearance {
    name = "large building",
    symbol = "+",
    color = "i_white",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "large_city_building",
}
definition:appearance {
    name = "city",
    symbol = "#",
    color = "light_gray",
}
definition:appearance {
    name = "large building",
    symbol = "+",
    color = "i_light_gray",
}
definition:appearance {
    name = "large building",
    symbol = "+",
    color = "i_light_gray",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "large_industrial_building",
}
definition:appearance {
    name = "large industrial building",
    symbol = "^",
    color = "i_white",
}
definition:appearance {
    name = "large industrial building",
    symbol = "^",
    color = "i_white",
}
definition:appearance {
    name = "large industrial building",
    symbol = "^",
    color = "i_white",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "large_structure",
}
definition:appearance {
    name = "structure",
    symbol = "#",
    color = "light_gray",
}
definition:appearance {
    name = "structure",
    symbol = "#",
    color = "light_gray",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "large_ship",
}
definition:appearance {
    name = "ship",
    symbol = "#",
    color = "dark_gray",
}
definition:appearance {
    name = "ship",
    symbol = "#",
    color = "dark_gray",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "large_outcropping",
}
definition:appearance {
    name = "outcropping",
    symbol = "X",
    color = "light_gray",
}
definition:appearance {
    name = "outcropping",
    symbol = "X",
    color = "light_gray",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "natural_outcropping",
}
definition:blend_adjacent()
definition:appearance {
    name = "outcropping",
    symbol = "^",
    color = "brown",
}
definition:appearance {
    name = "outcropping",
    symbol = "^",
    color = "brown",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "natural_depression",
}
definition:blend_adjacent()
definition:appearance {
    name = "depression",
    symbol = "U",
    color = "brown",
}
definition:appearance {
    name = "depression",
    symbol = "U",
    color = "brown",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "unusual_structure",
}
definition:appearance {
    name = "unusual structure",
    symbol = "8",
    color = "i_brown",
}
definition:appearance {
    name = "unusual structure",
    symbol = "8",
    color = "i_brown",
}
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "blends_till_outlines",
}
definition:blend_adjacent()
content.add(definition)
end
do
local definition = content.OvermapVision {
    id = "blends_till_details",
}
definition:blend_adjacent()
definition:blend_adjacent()
content.add(definition)
end
