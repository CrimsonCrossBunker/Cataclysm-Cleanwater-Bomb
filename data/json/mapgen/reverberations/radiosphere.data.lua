local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "radiosphere_radio_tower_top" },
    vision_levels = "isolated_tower",
    name = ccb.content.text("radio tower"),
    symbol = ".",
    color = "light_gray",
    see_cost = "all_clear",
}

ccb.content.define_overmap_terrain {
    id = { "radiosphere_deletion_plane" },
    name = ccb.content.text("vanishing plane"),
    symbol = "~",
    color = "cyan",
    see_cost = "all_clear",
}
