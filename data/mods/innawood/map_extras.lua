local ccb = require("ccb")
local content = ccb.content

-- Native map-extra definitions
do
local definition = content.MapExtra {
    id = "mx_grove_ravine",
    name = ccb.content.text("Grove"),
    description = ccb.content.text("This area is covered with a single type of trees."),
    generator_method = "map_extra_function",
    generator_id = "mx_grove",
    z_levels = { -2, -2 },
    symbol = "F",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_pond_ravine",
    name = ccb.content.text("Pond"),
    description = ccb.content.text("Small pond is here."),
    generator_method = "map_extra_function",
    generator_id = "mx_pond",
    z_levels = { -2, -2 },
    symbol = "p",
    color = "blue",
    autonote_visibility = "details",
}
definition:flag("CLASSIC")
definition:flag("WATER")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_pond_forest_ravine",
    name = ccb.content.text("basin"),
    description = ccb.content.text("Small basin is here."),
    generator_method = "update_mapgen",
    generator_id = "mx_pond_forest",
    z_levels = { -2, -2 },
}
definition:flag("CLASSIC")
definition:flag("WATER")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_pond_forest_2_ravine",
    name = ccb.content.text("basin"),
    description = ccb.content.text("Small basin is here."),
    generator_method = "update_mapgen",
    generator_id = "mx_pond_forest_2",
    z_levels = { -2, -2 },
}
definition:flag("CLASSIC")
definition:flag("WATER")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_shrubbery_ravine",
    name = ccb.content.text("Shrubbery"),
    description = ccb.content.text("This area is covered with a single type of shrubs."),
    generator_method = "map_extra_function",
    generator_id = "mx_shrubbery",
    z_levels = { -2, -2 },
    symbol = "s",
    color = "light_green",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_pond_swamp",
    name = ccb.content.text("bog"),
    description = ccb.content.text("Small bog is here."),
    generator_method = "update_mapgen",
    generator_id = "mx_pond_swamp",
    z_levels = { 0, 0 },
}
definition:flag("CLASSIC")
definition:flag("WATER")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_pond_swamp_2",
    name = ccb.content.text("bog"),
    description = ccb.content.text("Small bog is here."),
    generator_method = "update_mapgen",
    generator_id = "mx_pond_swamp_2",
    z_levels = { 0, 0 },
}
definition:flag("CLASSIC")
definition:flag("WATER")
content.add(definition)
end
