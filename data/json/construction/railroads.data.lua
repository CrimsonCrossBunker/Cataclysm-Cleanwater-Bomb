local ccb = require("ccb")

-- Covers the floor with gravel. Used for constructing railroads.
ccb.content.define_construction {
    id = "constr_railroad_rubble",
    group = "make_gravel_floor",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 1 } },
    duration = "40 m",
    components = { { { "material_gravel", 500 } } },
    pre_checks = "check_empty",
    post_terrain = "t_railroad_rubble",
}

ccb.content.define_construction {
    id = "constr_railroad_track_small",
    group = "build_straight_small_railroad_track",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 4 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = {
        { { "railroad_track_small", 1 } },
        { { "2x4", 4 } },
        { { "nails", 20, "LIST" } },
        { { "sheet_metal_small", 2 } },
    },
    pre_terrain = "t_railroad_rubble",
    post_terrain = "t_railroad_track_small",
}

ccb.content.define_construction {
    id = "constr_railroad_track_small_d",
    group = "build_diagonal_small_railroad_track",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 4 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = {
        { { "railroad_track_small", 1 } },
        { { "2x4", 4 } },
        { { "nails", 20, "LIST" } },
        { { "sheet_metal_small", 2 } },
    },
    pre_terrain = "t_railroad_rubble",
    post_terrain = "t_railroad_track_small_d",
}

ccb.content.define_construction {
    id = "constr_remove_gravel",
    group = "remove_gravel",
    category = "OTHER",
    required_skills = { { "survival", 0 } },
    duration = "60 m",
    qualities = { { { id = "DIG", level = 1 } } },
    byproducts = { { item = "material_gravel", count = { 7, 10 } } },
    pre_terrain = "t_railroad_rubble",
    post_terrain = "t_dirt",
    strict = true,
}
