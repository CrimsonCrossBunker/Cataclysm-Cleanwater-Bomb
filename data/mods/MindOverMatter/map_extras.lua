local ccb = require("ccb")
local content = ccb.content

-- Native map-extra definitions
do
local definition = content.MapExtra {
    id = "mx_alien_grass",
    name = ccb.content.text("alien flora"),
    description = ccb.content.text("A cluster of alien flora."),
    generator_method = "update_mapgen",
    generator_id = "mx_alien_grass",
    symbol = "A",
    color = "red",
    autonote_visibility = "details",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_alien_grass_2",
    name = ccb.content.text("alien flora"),
    description = ccb.content.text("A cluster of alien flora."),
    generator_method = "update_mapgen",
    generator_id = "mx_alien_grass_2",
    symbol = "A",
    color = "magenta",
    autonote_visibility = "outlines",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_alien_grass_3",
    name = ccb.content.text("alien flora"),
    description = ccb.content.text("A cluster of alien flora."),
    generator_method = "update_mapgen",
    generator_id = "mx_alien_grass_3",
    symbol = "A",
    color = "cyan",
    autonote_visibility = "details",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_alien_grass_4",
    name = ccb.content.text("alien flora"),
    description = ccb.content.text("A cluster of alien flora."),
    generator_method = "update_mapgen",
    generator_id = "mx_alien_grass_4",
    symbol = "A",
    color = "yellow",
    autonote_visibility = "outlines",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_alien_grass_5",
    name = ccb.content.text("alien flora"),
    description = ccb.content.text("A cluster of alien flora."),
    generator_method = "update_mapgen",
    generator_id = "mx_alien_grass_5",
    symbol = "A",
    color = "light_red",
    autonote_visibility = "outlines",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_alien_grove",
    name = ccb.content.text("alien grove"),
    description = ccb.content.text("A large cluster of alien flora."),
    generator_method = "update_mapgen",
    generator_id = "mx_alien_grove",
    symbol = "F",
    color = "magenta",
    autonote_visibility = "vague",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nether_pond",
    name = ccb.content.text("pool of dark water"),
    description = ccb.content.text("A pool of some unearthly liquid."),
    generator_method = "update_mapgen",
    generator_id = "mx_nether_pond",
    symbol = "O",
    color = "dark_gray",
    autonote_visibility = "vague",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_fear_hawk_copse",
    name = ccb.content.text("Suspicious stand of trees"),
    description = ccb.content.text("A suspicious copse of trees."),
    generator_method = "update_mapgen",
    generator_id = "mx_fear_hawk_copse",
    z_levels = { 0, 0 },
    autonote_visibility = "outlines",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_glass_and_crystal",
    name = ccb.content.text("crystal cluster"),
    description = ccb.content.text("A patch of crystals and black stone."),
    generator_method = "update_mapgen",
    generator_id = "mx_glass_and_crystal",
    symbol = "C",
    color = "dark_gray",
    autonote_visibility = "vague",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_phavian_science",
    name = ccb.content.text("Scientists"),
    description = ccb.content.text("Several corpses of scientists are here."),
    generator_method = "update_mapgen",
    generator_id = "mx_phavian_science",
    z_levels = { -5, 0 },
    symbol = "s",
    color = "light_blue",
    autonote_visibility = "same_tile",
}
definition:flag("MAN_MADE")
content.add(definition)
end
