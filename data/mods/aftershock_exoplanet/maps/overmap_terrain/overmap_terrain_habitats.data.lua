local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = {
        "afs_modular_habitat_center_small_ground_level_above",
        "afs_modular_habitat_center_small_ground_level",
    },
    name = ccb.content.text("habitat entrance"),
    symbol = "H",
    color = "light_blue",
    see_cost = "high",
    flags = { "SIDEWALK" },
}

ccb.content.define_overmap_terrain {
    id = {
        "afs_modular_habitat_pillars_ground", "afs_modular_habitat_pillars_ground_walkway",
        "afs_modular_habitat_end_pillars_above_walkway", "afs_modular_habitat_pillars",
    },
    name = ccb.content.text("habitat superstructure"),
    symbol = "+",
    color = "light_gray",
    see_cost = "medium",
}

ccb.content.define_overmap_terrain {
    id = { "afs_modular_habitat_center_maintenance_tiny" },
    name = ccb.content.text("habitat maintenance level"),
    symbol = "+",
    color = "yellow",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = {
        "afs_modular_habitat_center_farm", "afs_modular_habitat_greenhouse",
        "afs_modular_habitat_greenhouse_ramp_up",
    },
    name = ccb.content.text("urban farm"),
    symbol = "f",
    color = "light_green",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = { "afs_modular_habitat_center_industry", "afs_modular_habitat_industry" },
    name = ccb.content.text("industrial habitat"),
    symbol = "i",
    color = "yellow",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = { "afs_modular_habitat_biodiesel_end", "afs_modular_habitat_biodiesel_straight" },
    name = ccb.content.text("refinery wing"),
    symbol = "i",
    color = "yellow",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = { "afs_modular_habitat_roof" },
    name = ccb.content.text("habitat roof"),
    symbol = "r",
    color = "light_gray",
    see_cost = "none",
    flags = { "PP_GENERATE_RUINED" },
}

ccb.content.define_overmap_terrain {
    id = { "afs_modular_habitat_greenhouse_control_ramp" },
    name = ccb.content.text("farm control room"),
    symbol = "o",
    color = "light_green",
    see_cost = "high",
    flags = { "PP_GENERATE_RUINED" },
}
