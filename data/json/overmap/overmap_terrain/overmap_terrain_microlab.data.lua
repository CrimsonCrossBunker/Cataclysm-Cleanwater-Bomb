local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "microlab_generic", "microlab_generic_special_room" },
    vision_levels = "underground_stone",
    name = ccb.content.text("science lab"),
    symbol = "L",
    color = "light_blue",
    see_cost = "full_high",
    flags = { "NO_ROTATE", "RISK_EXTREME", "SOURCE_CHEMISTRY", "SOURCE_MEDICINE" },
}

ccb.content.define_overmap_terrain {
    id = "microlab_generic_edge",
    copy_from = "microlab_generic",
}

ccb.content.define_overmap_terrain {
    id = "microlab_generic_surface_connector",
    copy_from = "microlab_generic",
}

ccb.content.define_overmap_terrain {
    id = "microlab_generic_vent_shaft_connector",
    copy_from = "microlab_generic",
}

ccb.content.define_overmap_terrain {
    id = "microlab_sub_station",
    vision_levels = "underground_stone",
    name = ccb.content.text("subway station?"),
    symbol = "S",
    color = "light_blue",
    see_cost = "full_high",
    flags = { "RISK_EXTREME", "SOURCE_CHEMISTRY", "SOURCE_MEDICINE" },
}

ccb.content.define_overmap_terrain {
    id = "microlab_sub_connector",
    copy_from = "microlab_sub_station",
}

ccb.content.define_overmap_terrain {
    id = "microlab_generic_sub_entry",
    name = ccb.content.text("science lab"),
    symbol = "L",
    copy_from = "microlab_sub_connector",
}

ccb.content.define_overmap_terrain {
    id = {
        "microlab_generic_firebreak", "microlab_portal_dressroom", "microlab_generic_stairs_down",
        "microlab_generic_edge_room_connector", "microlab_generic_hallway_blind_end",
        "microlab_generic_isolated_stairs_odd", "microlab_generic_isolated_stairs_up",
        "microlab_generic_isolated_elevator_pit",
    },
    vision_levels = "underground_stone",
    name = ccb.content.text("science lab"),
    symbol = "L",
    color = "cyan",
    see_cost = "full_high",
    flags = { "RISK_EXTREME", "SOURCE_CHEMISTRY", "SOURCE_MEDICINE" },
}

ccb.content.define_overmap_terrain {
    id = {
        "microlab_portal_security1", "microlab_portal_security2", "microlab_portal_security3",
        "microlab_portal_security4", "microlab_portal_security5", "microlab_portal_security6",
        "microlab_portal_security7", "microlab_portal_security8", "microlab_portal_security_hallway1",
        "microlab_portal_security_hallway2",
    },
    vision_levels = "underground_stone",
    name = ccb.content.text("physics lab"),
    symbol = "L",
    color = "red",
    see_cost = "full_high",
    flags = { "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = { "microlab_generic_hallway" },
    vision_levels = "underground_stone",
    name = ccb.content.text("lab hallway"),
    color = "light_red",
    see_cost = "full_high",
    flags = { "LINEAR" },
}

ccb.content.define_overmap_terrain {
    id = { "microlab_reactor", "microlab_reactor_b" },
    vision_levels = "underground_stone",
    name = ccb.content.text("science lab reactor"),
    symbol = "L",
    color = "light_red",
    see_cost = "full_high",
    flags = { "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = { "microlab_distorted", "microlab_distorted_edge", "microlab_distorted_special_room" },
    name = ccb.content.text("distorted science lab"),
    color = "pink",
    copy_from = "microlab_generic",
}

ccb.content.define_overmap_terrain {
    id = "microlab_distorted_hallway",
    vision_levels = "underground_stone",
    name = ccb.content.text("distorted hallway"),
    color = "light_red",
    see_cost = "full_high",
    flags = { "LINEAR" },
}

ccb.content.define_overmap_terrain {
    id = { "microlab_portal_elevator", "microlab_portal_elevator_physics_glass" },
    vision_levels = "underground_stone",
    name = ccb.content.text("physics department elevator"),
    color = "light_red",
    symbol = "L",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = { "microlab_portal_MSU14_elevator" },
    vision_levels = "underground_stone",
    name = ccb.content.text("Hub 14 elevator"),
    color = "cyan",
    symbol = "L",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = { "microlab_portal_MSU14" },
    vision_levels = "underground_stone",
    name = ccb.content.text("Hub 14"),
    symbol = "L",
    color = "cyan",
    see_cost = "full_high",
    flags = { "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = "microlab_portal_elevator_nether_glass",
    vision_levels = "underground_stone",
    name = ccb.content.text("lost level"),
    color = "black",
    symbol = " ",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = "microlab_generic_surface",
    vision_levels = "underground_stone",
    name = ccb.content.text("lab"),
    symbol = "L",
    color = "blue",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = "microlab_generic_surface_roof",
    copy_from = "microlab_generic_surface",
}

ccb.content.define_overmap_terrain {
    id = "microlab_ratkin",
    vision_levels = "underground_stone",
    name = ccb.content.text("science lab"),
    symbol = "L",
    color = "green",
    spawns = { group = "GROUP_RATKIN_LAB", population = { 12, 25 }, chance = 80 },
    see_cost = "full_high",
    flags = { "NO_ROTATE", "RISK_EXTREME", "SOURCE_CHEMISTRY", "SOURCE_MEDICINE" },
}

ccb.content.define_overmap_terrain {
    id = "microlab_ratkin_edge",
    copy_from = "microlab_ratkin",
}

ccb.content.define_overmap_terrain {
    id = "microlab_ratkin_surface_connector",
    copy_from = "microlab_ratkin",
    flags = { "SHOULD_NOT_SPAWN" },
}

ccb.content.define_overmap_terrain {
    id = "microlab_ratkin_vent_shaft_connector",
    copy_from = "microlab_ratkin",
    flags = { "SHOULD_NOT_SPAWN" },
}

ccb.content.define_overmap_terrain {
    id = "microlab_sub_station_ratkin",
    vision_levels = "underground_stone",
    name = ccb.content.text("pump station?"),
    symbol = "P",
    color = "green",
    spawns = { group = "GROUP_RATKIN_LAB", population = { 12, 25 }, chance = 80 },
    see_cost = "full_high",
    flags = { "RISK_EXTREME", "SOURCE_CHEMISTRY", "SOURCE_MEDICINE" },
}

ccb.content.define_overmap_terrain {
    id = "microlab_ratkin_sub_entry",
    vision_levels = "underground_stone",
    name = ccb.content.text("science lab"),
    symbol = "L",
    color = "green",
    spawns = { group = "GROUP_RATKIN_LAB", population = { 12, 25 }, chance = 80 },
    see_cost = "full_high",
    flags = { "RISK_EXTREME", "SOURCE_CHEMISTRY", "SOURCE_MEDICINE" },
}

ccb.content.define_overmap_terrain {
    id = "microlab_sub_connector_ratkin",
    copy_from = "microlab_sub_station",
    flags = { "SHOULD_NOT_SPAWN" },
}
