local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "earth_scrap_metal_spire" },
    flags = { "NO_ROTATE" },
    vision_levels = "isolated_tower",
    name = ccb.content.text("alien scrap metal spire"),
    symbol = "¡",
    color = "light_gray",
    see_cost = "all_clear",
}
