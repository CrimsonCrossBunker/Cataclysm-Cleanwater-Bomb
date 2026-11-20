local ccb = require("ccb")
local content = ccb.content

-- Native map-extra definitions
do
local definition = content.MapExtra {
    id = "mx_wraitheon_droneswarm",
    name = ccb.content.text("Wraitheon Droneswarm"),
    description = ccb.content.text("A group of combat drones."),
    generator_method = "update_mapgen",
    generator_id = "mx_wraitheon_droneswarm",
    symbol = "w",
    color = "pink",
    autonote_visibility = "same_tile",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_reaver_bandits",
    name = ccb.content.text("Scavenger Party"),
    description = ccb.content.text("A group of scavengers who double as bandits."),
    generator_method = "update_mapgen",
    generator_id = "mx_reaver_bandits",
    symbol = "b",
    color = "pink",
    autonote_visibility = "same_tile",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_gunship",
    name = ccb.content.text("Gunship Crash"),
    description = ccb.content.text("Gunship crashed here."),
    generator_method = "update_mapgen",
    generator_id = "mx_gunship",
    z_levels = { 0, 0 },
    symbol = "X",
    color = "light_blue",
    autonote_visibility = "same_tile",
}
content.add(definition)
end
