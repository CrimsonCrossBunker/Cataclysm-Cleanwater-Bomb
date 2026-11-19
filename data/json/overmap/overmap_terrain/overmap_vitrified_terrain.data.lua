local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "unvitrified_farm_1", "unvitrified_farm_2", "unvitrified_farm_neg_1", "unvitrified_farm_0" },
    name = ccb.content.text("quiet farmstead"),
    vision_levels = "isolated_building",
    symbol = "G",
    color = "i_light_gray",
    flags = { "NO_ROTATE" },
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = { "unvitrified_orchard" },
    vision_levels = "first_glance_forest",
    name = ccb.content.text("quiet orchard"),
    symbol = "G",
    color = "i_light_gray",
    flags = { "NO_ROTATE" },
    see_cost = "spaced_high",
}
