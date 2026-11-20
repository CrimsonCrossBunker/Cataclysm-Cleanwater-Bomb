local ccb = require("ccb")
local content = ccb.content

-- Native composable overmap-vision profiles
do
local definition = content.OvermapVision {
    id = "isolated_building",
}
definition:appearance {
    name = "building",
    symbol = "c",
    color = "brown",
    looks_like = "cabin",
}
definition:appearance {
    name = "building",
    symbol = "c",
    color = "brown",
    looks_like = "cabin",
}
definition:appearance {
    name = "building",
    symbol = "c",
    color = "brown",
    looks_like = "cabin",
}
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "city_building",
}
definition:appearance {
    name = "city",
    symbol = "c",
    color = "light_gray",
}
definition:appearance {
    name = "city building",
    symbol = "b",
    color = "light_gray",
}
definition:appearance {
    name = "city building",
    symbol = "b",
    color = "light_gray",
}
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "alien_tower",
}
definition:appearance {
    name = "tall alien building",
    symbol = "a",
    color = "pink",
}
definition:appearance {
    name = "alien tower",
    symbol = "a",
    color = "pink",
}
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "isolated_tower",
}
definition:appearance {
    name = "tall building",
    symbol = "t",
    color = "light_gray",
}
definition:appearance {
    name = "tower",
    symbol = "t",
    color = "light_gray",
}
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "isolated_camp",
}
definition:appearance {
    name = "tent",
    symbol = "t",
    color = "light_gray",
    looks_like = "campsite",
}
definition:appearance {
    name = "camp",
    symbol = "c",
    color = "light_gray",
    looks_like = "campsite",
}
definition:appearance {
    name = "camp",
    symbol = "c",
    color = "light_gray",
    looks_like = "campsite",
}
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "isolated_electronics",
}
definition:appearance {
    name = "infrastructure",
    symbol = "i",
    color = "light_gray",
}
definition:appearance {
    name = "electrical infrastructure",
    symbol = "a",
    color = "light_gray",
}
definition:appearance {
    name = "electrical infrastructure",
    symbol = "a",
    color = "light_gray",
}
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "industrial_building",
}
definition:appearance {
    name = "building",
    symbol = "b",
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
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "warehouse",
}
definition:appearance {
    name = "building",
    symbol = "b",
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
content.replace(definition)
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
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "wreckage",
}
definition:appearance {
    name = "wreckage",
    symbol = "w",
    color = "dark_gray",
}
definition:appearance {
    name = "wreckage",
    symbol = "w",
    color = "dark_gray",
}
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "forested",
}
definition:appearance {
    name = "forest",
    symbol = "#",
    color = "light_green",
    looks_like = "forest_thick",
}
definition:appearance {
    name = "forest",
    symbol = "#",
    color = "light_green",
    looks_like = "forest_thick",
}
definition:appearance {
    name = "forest",
    symbol = "#",
    color = "light_green",
    looks_like = "forest_thick",
}
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "first_glance_forest",
}
definition:appearance {
    name = "forest",
    symbol = "#",
    color = "light_green",
    looks_like = "forest_thick",
}
definition:appearance {
    name = "managed forest",
    symbol = "#",
    color = "light_green",
    looks_like = "forest",
}
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "forested_swampy",
}
definition:appearance {
    name = "forest",
    symbol = "#",
    color = "light_green",
    looks_like = "forest_thick",
}
definition:appearance {
    name = "swamp",
    symbol = "#",
    color = "light_cyan",
    looks_like = "forest_water",
}
definition:appearance {
    name = "swamp",
    symbol = "#",
    color = "light_cyan",
    looks_like = "forest_water",
}
content.replace(definition)
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
content.replace(definition)
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
    color = "brown",
}
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "large_pavement",
}
definition:blend_adjacent()
definition:appearance {
    name = "pavement",
    symbol = "-",
    color = "dark_gray",
    looks_like = "s_lot",
}
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "single_water",
}
definition:appearance {
    name = "water",
    symbol = "#",
    color = "blue",
    looks_like = "pond_field",
}
definition:appearance {
    name = "water",
    symbol = "#",
    color = "blue",
    looks_like = "pond_field",
}
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "water_body",
}
definition:appearance {
    name = "water body",
    symbol = "~",
    color = "blue",
    looks_like = "river_center",
}
definition:appearance {
    name = "water body",
    symbol = "~",
    color = "blue",
    looks_like = "river_center",
}
content.replace(definition)
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
content.replace(definition)
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
    symbol = "b",
    color = "black",
}
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "underground_stone",
}
definition:appearance {
    name = "underground",
    symbol = "#",
    color = "dark_gray",
}
definition:appearance {
    name = "basement",
    symbol = "b",
    color = "black",
}
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "large_building",
}
definition:appearance {
    name = "large building",
    symbol = "b",
    color = "white",
}
definition:appearance {
    name = "large building",
    symbol = "b",
    color = "white",
}
definition:appearance {
    name = "large building",
    symbol = "b",
    color = "white",
}
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "large_city_building",
}
definition:appearance {
    name = "city",
    symbol = "c",
    color = "light_gray",
}
definition:appearance {
    name = "large building",
    symbol = "b",
    color = "light_gray",
}
definition:appearance {
    name = "large building",
    symbol = "b",
    color = "light_gray",
}
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "large_industrial_building",
}
definition:appearance {
    name = "large industrial building",
    symbol = "l",
    color = "light_gray",
}
definition:appearance {
    name = "large industrial building",
    symbol = "l",
    color = "light_gray",
}
definition:appearance {
    name = "large industrial building",
    symbol = "l",
    color = "light_gray",
}
content.replace(definition)
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
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "large_ship",
}
definition:appearance {
    name = "ship",
    symbol = "#",
    color = "red",
}
definition:appearance {
    name = "ship",
    symbol = "#",
    color = "red",
}
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "large_outcropping",
}
definition:appearance {
    name = "stone outcropping",
    symbol = "o",
    color = "light_gray",
}
definition:appearance {
    name = "stone outcropping",
    symbol = "o",
    color = "light_gray",
}
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "natural_outcropping",
}
definition:blend_adjacent()
definition:appearance {
    name = "outcropping",
    symbol = "o",
    color = "brown",
}
definition:appearance {
    name = "outcropping",
    symbol = "o",
    color = "brown",
}
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "natural_depression",
}
definition:blend_adjacent()
definition:appearance {
    name = "depression",
    symbol = "u",
    color = "brown",
}
definition:appearance {
    name = "depression",
    symbol = "u",
    color = "brown",
}
content.replace(definition)
end
do
local definition = content.OvermapVision {
    id = "unusual_structure",
}
definition:appearance {
    name = "unusual structure",
    symbol = "u",
    color = "pink",
}
definition:appearance {
    name = "unusual structure",
    symbol = "u",
    color = "pink",
}
content.replace(definition)
end
