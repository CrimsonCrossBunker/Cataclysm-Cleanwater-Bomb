local ccb = require("ccb")

ccb.content.define_map_extra {
    id = "mx_wraitheon_droneswarm",
    name = ccb.content.text("Wraitheon Droneswarm"),
    description = ccb.content.text("A group of combat drones."),
    generator = { method = "update_mapgen", id = "mx_wraitheon_droneswarm" },
    symbol = "w",
    color = "pink",
    visibility = "same_tile",
}

ccb.content.define_map_extra {
    id = "mx_reaver_bandits",
    name = ccb.content.text("Scavenger Party"),
    description = ccb.content.text("A group of scavengers who double as bandits."),
    generator = { method = "update_mapgen", id = "mx_reaver_bandits" },
    symbol = "b",
    color = "pink",
    visibility = "same_tile",
}

ccb.content.define_map_extra {
    id = "mx_gunship",
    name = ccb.content.text("Gunship Crash"),
    description = ccb.content.text("Gunship crashed here."),
    generator = { method = "update_mapgen", id = "mx_gunship" },
    z_levels = { 0, 0 },
    symbol = "X",
    color = "light_blue",
    visibility = "same_tile",
}
