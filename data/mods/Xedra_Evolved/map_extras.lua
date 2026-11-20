local ccb = require("ccb")
local content = ccb.content

-- Native map-extra definitions
do
local definition = content.MapExtra {
    id = "mx_hunger_track",
    name = ccb.content.text("Half-eaten corpses"),
    description = ccb.content.text("Piles of gore surround a trail of bloody footsteps."),
    generator_method = "update_mapgen",
    generator_id = "mx_hunger_track",
    z_levels = { 0, 0 },
    symbol = "l",
    color = "magenta_yellow",
    autonote_visibility = "same_tile",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_sevenoclock_track",
    name = ccb.content.text("Half-eaten corpses"),
    description = ccb.content.text("Piles of gore surround a trail of bloody footsteps."),
    generator_method = "update_mapgen",
    generator_id = "mx_sevenoclock_track",
    z_levels = { 0, 0 },
    symbol = "l",
    color = "magenta_yellow",
    autonote_visibility = "same_tile",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_deathworm_track",
    name = ccb.content.text("Bloodsoaked acid streaks"),
    description = ccb.content.text("A hole in the ground surrounds piles of acid-burned gore."),
    generator_method = "update_mapgen",
    generator_id = "mx_deathworm_track",
    z_levels = { 0, 0 },
    symbol = "l",
    color = "magenta_yellow",
    autonote_visibility = "same_tile",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_golden_monolith",
    name = ccb.content.text("Golden Monolith"),
    description = ccb.content.text("A golden monolith sitting serenely overlooking the nearby terrain."),
    generator_method = "update_mapgen",
    generator_id = "mx_golden_monolith",
    z_levels = { 0, 0 },
    symbol = "I",
    color = "magenta_yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_spider_shimmering",
    name = ccb.content.text("Spiders"),
    description = ccb.content.text("This area is covered with webs.  There probably are spiders nearby."),
    generator_method = "update_mapgen",
    generator_id = "mx_spider_shimmering",
    z_levels = { -2, 0 },
    symbol = "S",
    color = "yellow",
    autonote_visibility = "same_tile",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_goblin_spider",
    name = ccb.content.text("Spiders"),
    description = ccb.content.text("This area is covered with webs.  There probably are spiders nearby."),
    generator_method = "update_mapgen",
    generator_id = "mx_goblin_spider",
    z_levels = { -2, 0 },
    symbol = "S",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_trees_map_salamander",
    name = ccb.content.text("Stand of trees"),
    description = ccb.content.text("A copse of trees."),
    generator_method = "update_mapgen",
    generator_id = "mx_trees_map_salamander",
    z_levels = { 0, 0 },
    symbol = "E",
    color = "green",
    autonote_visibility = "same_tile",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_trees_map_sylph",
    name = ccb.content.text("Stand of trees"),
    description = ccb.content.text("A copse of trees."),
    generator_method = "update_mapgen",
    generator_id = "mx_trees_map_sylph",
    z_levels = { 0, 0 },
    symbol = "E",
    color = "green",
    autonote_visibility = "same_tile",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_trees_map_ierde",
    name = ccb.content.text("Stand of trees"),
    description = ccb.content.text("A copse of trees."),
    generator_method = "update_mapgen",
    generator_id = "mx_trees_map_ierde",
    z_levels = { 0, 0 },
    symbol = "E",
    color = "green",
    autonote_visibility = "same_tile",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_homelesscamp_homullus",
    name = ccb.content.text("Homeless camp"),
    description = ccb.content.text("A camp of the homeless."),
    generator_method = "update_mapgen",
    generator_id = "mx_homelesscamp_homullus",
    z_levels = { 0, 0 },
    symbol = "E",
    color = "green",
    autonote_visibility = "same_tile",
}
definition:flag("MAN_MADE")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_forest_pond_avore",
    name = ccb.content.text("basin"),
    description = ccb.content.text("Small basin is here."),
    generator_method = "update_mapgen",
    generator_id = "mx_forest_pond_avore",
    z_levels = { 0, 0 },
    symbol = "E",
    color = "light_green",
    autonote_visibility = "details",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_forest_pond_salamander_avore",
    name = ccb.content.text("basin"),
    description = ccb.content.text("Small basin is here."),
    generator_method = "update_mapgen",
    generator_id = "mx_forest_pond_salamander_avore",
    z_levels = { 0, 0 },
    symbol = "E",
    color = "light_green",
    autonote_visibility = "same_tile",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_pond_forest_undine",
    name = ccb.content.text("basin"),
    description = ccb.content.text("Small basin is here."),
    generator_method = "update_mapgen",
    generator_id = "mx_pond_forest_undine",
    z_levels = { 0, 0 },
    symbol = "E",
    color = "blue",
    autonote_visibility = "same_tile",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_pond_forest_undine_ierde",
    name = ccb.content.text("basin"),
    description = ccb.content.text("Small basin is here."),
    generator_method = "update_mapgen",
    generator_id = "mx_pond_forest_undine_ierde",
    z_levels = { 0, 0 },
    symbol = "E",
    color = "blue",
    autonote_visibility = "same_tile",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_goblin_fruits",
    name = ccb.content.text("strange plants"),
    description = ccb.content.text("A group of strange plants are growing here."),
    generator_method = "update_mapgen",
    generator_id = "mx_goblin_fruits",
    z_levels = { 0, 0 },
    symbol = "G",
    color = "magenta",
    autonote_visibility = "details",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_ring_of_mushrooms",
    name = ccb.content.text("a ring of mushrooms"),
    description = ccb.content.text("A group of mushrooms growing in a ring."),
    generator_method = "update_mapgen",
    generator_id = "mx_ring_of_mushrooms",
    z_levels = { 0, 0 },
    symbol = "m",
    color = "light_gray",
    autonote_visibility = "none",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_dreamwound_shadow",
    name = ccb.content.text("a shadowy wound in reality"),
    description = ccb.content.text("What you can only describe as a wound in reality appears to be leaking shadows."),
    generator_method = "update_mapgen",
    generator_id = "mx_dreamwound_shadow",
    z_levels = { 0, 0 },
    symbol = "w",
    color = "dark_gray_red",
    autonote_visibility = "same_tile",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_ozma_statue",
    name = ccb.content.text("a statue surrounded by emerald poppies"),
    description = ccb.content.text("A ruined statue surrounded by emerald poppies."),
    generator_method = "update_mapgen",
    generator_id = "mx_ozma_statue",
    z_levels = { 0, 0 },
    symbol = "m",
    color = "light_green",
    autonote_visibility = "none",
}
definition:flag("CLASSIC")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_XE_XEDRA_mutagen_transport",
    name = ccb.content.text("TCL Truck"),
    description = ccb.content.text("A crashed Trans-Coast Logistics truck."),
    generator_method = "update_mapgen",
    generator_id = "mx_XE_XEDRA_mutagen_transport",
    z_levels = { 0, 0 },
    symbol = "T",
    color = "yellow",
}
definition:flag("CLASSIC")
content.add(definition)
end
