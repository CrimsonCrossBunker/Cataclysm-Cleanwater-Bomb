local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "scarlet_sea_reverberation" },
    flags = { "NO_ROTATE" },
    vision_levels = "water_body",
    name = ccb.content.text("scarlet sea"),
    symbol = "#",
    travel_cost = "field",
    color = "red",
    see_cost = "all_clear",
}

ccb.content.define_overmap_terrain {
    id = { "scarlet_scrap_metal_spire" },
    flags = { "NO_ROTATE" },
    vision_levels = "isolated_tower",
    name = ccb.content.text("scrap metal spire"),
    symbol = "¡",
    color = "light_gray",
    see_cost = "all_clear",
}

ccb.content.define_overmap_terrain {
    id = { "scarlet_sea_xedra_hew" },
    vision_levels = "island",
    name = ccb.content.text("exposed sandbar"),
    symbol = "i",
    color = "light_gray",
    see_cost = "all_clear",
}
