local ccb = require("ccb")

-- Builds a concrete floor from a pit.
ccb.content.define_construction {
    id = "constr_concrete",
    group = "build_concrete_floor",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 3 } },
    duration = "60 m",
    tools = { { { "concrete_mix_tool", 50 } } },
    qualities = { { { id = "SMOOTH", level = 2 } } },
    components = { { { "concrete", 2 } }, { { "water", 2 }, { "water_clean", 2 } } },
    pre_terrain = "t_pit_shallow",
    post_terrain = "t_concrete",
}

-- Makes an outside wooden paving, similar to what would be used in patios.
ccb.content.define_construction {
    id = "constr_floor_noroof",
    group = "build_wooden_floor",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 1 } },
    duration = "100 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 14 } }, { { "nails", 28, "LIST" } } },
    pre_checks = "check_empty",
    post_terrain = "t_floor_noroof",
}

ccb.content.define_construction {
    id = "constr_grave",
    group = "dig_grave_and_bury_sealed_coffin",
    category = "DIG",
    required_skills = { { "fabrication", 0 } },
    duration = "60 m",
    qualities = { { { id = "HAMMER", level = 1 } }, { { id = "DIG", level = 2 } } },
    components = { { { "rock", 20 }, { "2x4", 2 } } },
    pre_flags = { flag = "DIGGABLE", force_terrain = true },
    pre_terrain = "f_coffin_c",
    post_flags = { "keep_items" },
    post_terrain = "t_grave_new",
    completion_actions = "done_grave",
}

-- Makes a metal gangway between two adjacent points, typically roofs.
ccb.content.define_construction {
    id = "constr_metal_gangway",
    group = "build_metal_gangway",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 5 } },
    duration = "90 m",
    qualities = { { id = "GLARE", level = 1 } },
    tools = {
        {
            { "oxy_torch", 10 },
            { "welder", 50 },
            { "welding_kit", 50 },
            { "welder_crude", 75 },
            { "toolset", 75 },
        },
    },
    components = { { { "steel_plate", 2 } } },
    pre_note = ccb.content.text("Must be supported on at least two sides."),
    pre_checks = "check_support_below",
    post_terrain = "t_floor_metal_gangway",
}

ccb.content.define_construction {
    id = "constr_pavement_y",
    group = "paint_pavement_yellow",
    category = "DECORATE",
    required_skills = { { "fabrication", 0 } },
    duration = "4 m",
    tools = { { "paint_brush" } },
    components = { { { "paint_yellow", 3 } } },
    pre_terrain = "t_pavement",
    post_terrain = "t_pavement_y",
}

ccb.content.define_construction {
    id = "constr_pavement_y_bg_dp",
    group = "paint_pavement_yellow",
    category = "DECORATE",
    required_skills = { { "fabrication", 0 } },
    duration = "4 m",
    tools = { { "paint_brush" } },
    components = { { { "paint_yellow", 3 } } },
    pre_terrain = "t_pavement_bg_dp",
    post_terrain = "t_pavement_y_bg_dp",
}

ccb.content.define_construction {
    id = "constr_platform_resin",
    group = "extrude_resin_floor_no_roof",
    category = "CONSTRUCT",
    skill = "fabrication",
    difficulty = 1,
    duration = "30 m",
    qualities = { { id = "SMOOTH", level = 1 } },
    components = { { { "alien_pod_resin", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "t_platform_resin",
}

ccb.content.define_construction {
    id = "constr_remove_rubber_mulch",
    group = "remove_rubber_mulch",
    category = "OTHER",
    required_skills = { { "survival", 0 } },
    duration = "60 m",
    qualities = { { { id = "DIG", level = 1 } } },
    byproducts = { { item = "shredded_rubber", count = { 150, 200 } } },
    pre_terrain = "t_rubber_mulch",
    post_terrain = "t_dirt",
}

ccb.content.define_construction {
    id = "constr_revert_pavement_y",
    group = "take_paint_off_pavement",
    category = "DECORATE",
    required_skills = { { "fabrication", 0 } },
    duration = "10 m",
    tools = { { "chipper" } },
    pre_terrain = "t_pavement_y",
    post_terrain = "t_pavement",
}

ccb.content.define_construction {
    id = "constr_revert_pavement_y_bg_dp",
    group = "take_paint_off_pavement",
    category = "DECORATE",
    required_skills = { { "fabrication", 0 } },
    duration = "10 m",
    tools = { { "chipper" } },
    pre_terrain = "t_pavement_y_bg_dp",
    post_terrain = "t_pavement_bg_dp",
}

-- Covers the floor with rubber mulch. Used for constructing exercise spaces.
ccb.content.define_construction {
    id = "constr_rubber_mulch",
    group = "make_rubber_mulch",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 1 } },
    duration = "40 m",
    components = { { { "shredded_rubber", 200 } } },
    pre_checks = "check_empty",
    post_terrain = "t_rubber_mulch",
}

-- Adds wood chippings to a shallow pit to prevent plants growing, or for looks.
ccb.content.define_construction {
    id = "constr_woodchips",
    group = "make_woodchip_floor",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 0 } },
    duration = "40 m",
    components = { { { "splinter", 50 } } },
    pre_terrain = "t_pit_shallow",
    post_terrain = "t_woodchips",
}

-- Makes a wooden gangway between two adjacent points, typically roofs.
ccb.content.define_construction {
    id = "constr_wooden_gangway",
    group = "build_wooden_gangway",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 1 } },
    duration = "100 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 14 } }, { { "nails", 28, "LIST" } } },
    pre_note = ccb.content.text("Must be supported on at least two sides."),
    pre_checks = "check_support_below",
    post_terrain = "t_floor_wooden_gangway",
}
