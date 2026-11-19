local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "xedra_rural_church", "xedra_rural_church_parking" },
    vision_levels = "isolated_building",
    name = ccb.content.text("barricaded rural church"),
    symbol = "C",
    color = "light_red",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = { "xedra_rural_church_steeple" },
    vision_levels = "isolated_building",
    name = ccb.content.text("rural church steeple"),
    symbol = "C",
    color = "light_red",
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = { "xedra_rural_church_steeple_roof" },
    vision_levels = "roof_or_air",
    name = ccb.content.text("rural church steeple roof"),
    symbol = "C",
    color = "light_red",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = { "xedra_rural_church_basement" },
    vision_levels = "underground_dirt",
    see_cost = "full_high",
    name = ccb.content.text("church basement"),
    symbol = "B",
    color = "light_red",
}

ccb.content.define_overmap_terrain {
    id = {
        "morgantown_1a", "morgantown_2a", "morgantown_3a", "morgantown_1b", "morgantown_2b",
        "morgantown_3b", "morgantown_1c", "morgantown_2c", "morgantown_3c",
    },
    vision_levels = "isolated_building",
    name = ccb.content.text("forested ruins"),
    symbol = "f",
    color = "dark_gray",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = {
        "morgantown_forest_fence_s", "morgantown_forest", "morgantown_forest_fence_corner",
        "morgantown_forest_fence_entry", "morgantown_forest_fence_entry_2",
    },
    vision_levels = "forested",
    name = ccb.content.text("fenced-off forest"),
    symbol = "f",
    color = "green",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = { "xedra_fishing_shack_0", "xedra_fishing_shack_1", "xedra_fishing_shack_2" },
    name = ccb.content.text("lakeside shack"),
    vision_levels = "isolated_building",
    symbol = "C",
    color = "green",
    see_cost = "high",
}
