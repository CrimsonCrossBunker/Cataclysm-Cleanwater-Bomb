local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "LIXA_surface_1a", "LIXA_surface_2a", "LIXA_surface_1b", "LIXA_surface_2b" },
    name = ccb.content.text("research facility"),
    vision_levels = "large_building",
    symbol = "l",
    color = "light_gray",
    see_cost = "full_high",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = { "LIXA_roof_1a", "LIXA_roof_2a", "LIXA_roof_1b", "LIXA_roof_2b" },
    vision_levels = "roof_or_air",
    name = ccb.content.text("research facility roof"),
    symbol = "l",
    color = "light_gray",
    see_cost = "full_high",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = { "LIXA_entry_1", "LIXA_entry_2" },
    name = ccb.content.text("research facility gate"),
    vision_levels = "large_building",
    symbol = "l",
    color = "light_gray",
    see_cost = "full_high",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = { "LIXA_road" },
    copy_from = "road_abstract",
    name = ccb.content.text("research facility access road"),
    symbol = "l",
    color = "light_gray",
    see_cost = "none",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = { "LIXA_road_guard", "LIXA_road_guard_roof" },
    name = ccb.content.text("research facility checkpoint"),
    vision_levels = "large_building",
    symbol = "l",
    color = "light_gray",
    see_cost = "full_high",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = {
        "LIXA_stairshaft_1a", "LIXA_stairshaft_1b", "LIXA_stairshaft_1c", "LIXA_stairshaft_1d",
        "LIXA_stairshaft_2a", "LIXA_stairshaft_2b", "LIXA_stairshaft_2c", "LIXA_stairshaft_2d",
    },
    name = ccb.content.text("LIXA experiment floor access"),
    vision_levels = "underground_stone",
    symbol = "l",
    color = "light_gray",
    see_cost = "full_high",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = { "LIXA_workfloor_1a", "LIXA_workfloor_2a", "LIXA_workfloor_1b", "LIXA_workfloor_2b" },
    vision_levels = "underground_stone",
    name = ccb.content.text("LIXA research floor"),
    symbol = "L",
    color = "light_blue",
    see_cost = "full_high",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = { "LIXA_device_1", "LIXA_device_2", "LIXA_device_3", "LIXA_device_2_roof", "LIXA_device_3_roof" },
    name = ccb.content.text("LIXA device floor"),
    vision_levels = "underground_stone",
    symbol = "L",
    color = "light_blue",
    see_cost = "full_high",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = { "LIXA_device_unfolded_A", "LIXA_device_unfolded_B", "LIXA_device_unfolded_noaccess" },
    vision_levels = "underground_stone",
    name = ccb.content.text("unfolded space"),
    symbol = "!",
    color = "white",
    see_cost = "full_high",
    flags = { "NO_ROTATE" },
}
