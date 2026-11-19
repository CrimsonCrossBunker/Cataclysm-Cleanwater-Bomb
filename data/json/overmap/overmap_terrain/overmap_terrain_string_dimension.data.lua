local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "string_dimension_crossroads" },
    flags = { "NO_ROTATE" },
    vision_levels = "open_land",
    land_use_code = "open_land",
    name = ccb.content.text("bridges"),
    symbol = ".",
    color = "light_gray",
    see_cost = "all_clear",
}

ccb.content.define_overmap_terrain {
    id = { "string_dimension_void" },
    flags = { "NO_ROTATE" },
    vision_levels = "open_land",
    name = ccb.content.text("empty space"),
    symbol = " ",
    color = "black",
    see_cost = "all_clear",
}

ccb.content.define_overmap_terrain {
    id = { "string_dimension_true_void" },
    flags = { "NO_ROTATE" },
    vision_levels = "open_land",
    name = ccb.content.text("empty space"),
    symbol = " ",
    color = "black",
    see_cost = "opaque",
}

ccb.content.define_overmap_terrain {
    id = {
        "string_dimension_small_ziggurat_1", "string_dimension_small_ziggurat_0",
        "string_dimension_small_ziggurat_-1", "string_dimension_small_ziggurat_-2",
        "string_dimension_small_ziggurat_-3",
    },
    vision_levels = "isolated_tower",
    name = ccb.content.text("floating inverted ziggurat"),
    symbol = "Z",
    color = "yellow",
    see_cost = "low",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_string_dimension_plane",
    copy_from = "generic_open_land",
    name = ccb.content.text("planes"),
    symbol = "+",
    color = "light_blue",
    flags = { "REQUIRES_PREDECESSOR" },
}

ccb.content.define_overmap_terrain {
    id = "string_dimension_plane_core",
    copy_from = "generic_string_dimension_plane",
    extend = { flags = { "NO_ROTATE" } },
}

ccb.content.define_overmap_terrain {
    id = "string_dimension_plane_end",
    copy_from = "generic_string_dimension_plane",
}

ccb.content.define_overmap_terrain {
    id = {
        "string_dimension_plane_z_stack_0", "string_dimension_plane_z_stack_1",
        "string_dimension_plane_z_stack_-1",
    },
    vision_levels = "isolated_tower",
    name = ccb.content.text("z-stack"),
    symbol = "+",
    color = "yellow",
    see_cost = "low",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_string_dimension_field",
    copy_from = "generic_open_land",
    name = ccb.content.text("fields"),
    symbol = ",",
    color = "white",
    flags = { "REQUIRES_PREDECESSOR" },
}

ccb.content.define_overmap_terrain {
    id = "string_dimension_field_core",
    copy_from = "generic_string_dimension_field",
    extend = { flags = { "NO_ROTATE" } },
}

ccb.content.define_overmap_terrain {
    id = "string_dimension_field_end",
    copy_from = "generic_string_dimension_field",
}

ccb.content.define_overmap_terrain {
    id = { "string_dimension_field_vent_a", "string_dimension_field_vent_b" },
    vision_levels = "open_land",
    name = ccb.content.text("grassy field"),
    symbol = ",",
    color = "red",
    see_cost = "all_clear",
}

ccb.content.define_overmap_terrain {
    id = {
        "string_dimension_field_vent_a_-1", "string_dimension_field_vent_b_-1",
        "string_dimension_field_vent_a_-2", "string_dimension_field_vent_a_-3",
    },
    vision_levels = "underground_stone",
    name = ccb.content.text("underground cistern"),
    symbol = "O",
    color = "dark_gray",
    see_cost = "full_high",
    flags = { "KNOWN_UP" },
}

ccb.content.define_overmap_terrain {
    id = {
        "string_dimension_dome_x2y0z-2", "string_dimension_dome_x1y1z-2",
        "string_dimension_dome_x0y2z-2", "string_dimension_dome_z-2", "string_dimension_dome_x0y0z-1",
        "string_dimension_dome_x1y0z-1", "string_dimension_dome_x2y0z-1",
        "string_dimension_dome_x0y1z-1", "string_dimension_dome_x1y1z-1",
        "string_dimension_dome_x2y1z-1", "string_dimension_dome_x0y2z-1",
        "string_dimension_dome_x1y2z-1", "string_dimension_dome_x2y2z-1",
        "string_dimension_dome_x0y0z0", "string_dimension_dome_x1y0z0", "string_dimension_dome_x2y0z0",
        "string_dimension_dome_x0y1z0", "string_dimension_dome_x1y1z0", "string_dimension_dome_x2y1z0",
        "string_dimension_dome_x0y2z0", "string_dimension_dome_x1y2z0", "string_dimension_dome_x2y2z0",
        "string_dimension_dome_x0y0z1", "string_dimension_dome_x1y0z1", "string_dimension_dome_x2y0z1",
        "string_dimension_dome_x0y1z1", "string_dimension_dome_x1y1z1", "string_dimension_dome_x2y1z1",
        "string_dimension_dome_x0y2z1", "string_dimension_dome_x1y2z1", "string_dimension_dome_x2y2z1",
        "string_dimension_dome_x0y0z2", "string_dimension_dome_x1y0z2", "string_dimension_dome_x2y0z2",
        "string_dimension_dome_x0y1z2", "string_dimension_dome_x1y1z2", "string_dimension_dome_x2y1z2",
        "string_dimension_dome_x0y2z2", "string_dimension_dome_x1y2z2", "string_dimension_dome_x2y2z2",
    },
    vision_levels = "industrial_building",
    name = ccb.content.text("domed fortress"),
    symbol = "o",
    color = "light_gray",
    see_cost = "full_high",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = { "string_dimension_dome_distress_beacon", "string_dimension_dome_distress_beacon_1" },
    vision_levels = "isolated_tower",
    name = ccb.content.text("big electronic thing"),
    symbol = "E",
    color = "light_green",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = { "string_dimension_utility_tunnel_entrance" },
    vision_levels = "open_land",
    land_use_code = "open_land",
    name = ccb.content.text("islet"),
    symbol = "o",
    color = "light_gray",
    see_cost = "all_clear",
    flags = { "REQUIRES_PREDECESSOR" },
}

ccb.content.define_overmap_terrain {
    id = {
        "string_dimension_utility_tunnel_four_way", "string_dimension_utility_tunnel_T",
        "string_dimension_utility_tunnel_straight", "string_dimension_utility_tunnel_corner",
        "string_dimension_utility_tunnel_end",
    },
    name = ccb.content.text("utility tunnel"),
    symbol = "#",
    color = "red",
    see_cost = "high",
    vision_levels = "underground_dirt",
    travel_cost = "basement",
    flags = { "REQUIRES_PREDECESSOR" },
}

ccb.content.define_overmap_terrain {
    id = {
        "string_dimension_ka_facility_x0y0z0", "string_dimension_ka_facility_x1y0z0",
        "string_dimension_ka_facility_x2y0z0", "string_dimension_ka_facility_x3y0z0",
        "string_dimension_ka_facility_x4y0z0", "string_dimension_ka_facility_x0y1z0",
        "string_dimension_ka_facility_x1y1z0", "string_dimension_ka_facility_x2y1z0",
        "string_dimension_ka_facility_x3y1z0", "string_dimension_ka_facility_x4y1z0",
    },
    vision_levels = "industrial_building",
    name = ccb.content.text("strange facility"),
    symbol = "K",
    color = "red",
    see_cost = "full_high",
}
