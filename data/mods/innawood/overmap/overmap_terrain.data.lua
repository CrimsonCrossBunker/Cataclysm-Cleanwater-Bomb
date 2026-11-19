local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "innawood_ore_vein_surface_indicator",
    name = ccb.content.text("rocky patch"),
    looks_like = "field",
    symbol = ".",
    color = "brown",
    see_cost = "none",
    vision_levels = "blends_till_details",
}

ccb.content.define_overmap_terrain {
    id = "innawood_ore_vein_subsurface",
    vision_levels = "always_full",
    name = ccb.content.text("subsurface rock"),
    symbol = "%",
    color = "dark_gray",
    looks_like = "empty_rock",
    see_cost = "opaque",
    travel_cost = "basement",
}

ccb.content.define_overmap_terrain {
    id = {
        "innawood_ore_vein_surface_z2_left_side", "innawood_ore_vein_surface_z2_center",
        "innawood_ore_vein_surface_z2_right_side", "innawood_ore_vein_surface_z3_left_side",
        "innawood_ore_vein_surface_z3_center", "innawood_ore_vein_surface_z3_right_side",
    },
    vision_levels = "always_full",
    name = ccb.content.text("ore vein"),
    symbol = "%",
    color = "dark_gray",
    looks_like = "empty_rock",
    see_cost = "opaque",
    travel_cost = "basement",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_ravine",
    name = ccb.content.text("ravine"),
    symbol = "V",
    color = "light_gray",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = {
        "ravine_2way", "ravine_3way", "ravine_straight", "ravine_corner", "ravine_2way_bottom",
        "ravine_3way_bottom", "ravine_straight_bottom", "ravine_corner_bottom",
    },
    copy_from = "generic_ravine",
}

ccb.content.define_overmap_terrain {
    id = { "ravine_2way_ground", "ravine_3way_ground", "ravine_straight_ground", "ravine_corner_ground" },
    copy_from = "generic_ravine",
    see_cost = "all_clear",
    flags = { "REQUIRES_PREDECESSOR" },
}

ccb.content.define_overmap_terrain {
    id = "ravine_bottom_forest",
    name = ccb.content.text("ravine floor"),
    extras = "ravine_bottom",
    copy_from = "forest",
}
