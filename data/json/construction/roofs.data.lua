local ccb = require("ccb")

ccb.content.define_construction {
    id = "constr_brick_roof",
    group = "build_brick_roof",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 3 } },
    duration = "120 m",
    qualities = { { { id = "SMOOTH", level = 1 } } },
    components = {
        { { "brick", 15 } },
        { { "mortar_build", 1 }, { "mortar_lime", 1 } },
        { { "water", 1 }, { "water_clean", 1 } },
    },
    pre_note = ccb.content.text("Must be supported directly from below or on at least two sides.  May need a 'room' supporting a roof directly below."),
    pre_checks = { "check_support", "check_unblocked" },
    post_terrain = "t_brick_roof",
}

ccb.content.define_construction {
    id = "constr_concrete_roof",
    group = "build_concrete_roof",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 5 } },
    duration = "60 m",
    tools = { { { "concrete_mix_tool", 25 } } },
    qualities = { { { id = "SMOOTH", level = 2 } } },
    components = { { { "concrete", 2 } }, { { "water", 2 }, { "water_clean", 2 } } },
    pre_note = ccb.content.text("Must be supported directly from below or on at least two sides.  May need a 'room' supporting a roof directly below."),
    pre_checks = { "check_support", "check_unblocked" },
    post_terrain = "t_concrete_roof",
}

ccb.content.define_construction {
    id = "constr_flat_roof",
    group = "build_flat_roof",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 3 } },
    duration = "60 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 2 } } },
    components = {
        { { "wood_sheet", 1 }, { "wood_panel", 2 } },
        { { "2x4", 6 } },
        { { "nails", 40, "LIST" } },
    },
    pre_note = ccb.content.text("Must be supported directly from below or on at least two sides.  May need a 'room' supporting a roof directly below."),
    pre_checks = { "check_support", "check_unblocked" },
    post_terrain = "t_flat_roof",
}

-- Step 1: Build skylight
ccb.content.define_construction {
    id = "constr_glass_roof",
    group = "build_sky_light",
    category = "WINDOWS",
    required_skills = { { "fabrication", 4 } },
    duration = "90 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_M", level = 1 } } },
    components = { { { "glass_sheet", 2 } } },
    pre_terrain = "t_skylight_frame",
    post_terrain = "t_glass_roof",
}

ccb.content.define_construction {
    id = "constr_log_sod_roof",
    group = "build_log_sod_roof",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 4 } },
    duration = "120 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = {
        { { "log", 2 } },
        { { "stick", 4 }, { "2x4", 8 }, { "stick_long", 2 } },
        { { "material_soil", 40 } },
        { { "birchbark", 12 }, { "pine_bough", 12 } },
    },
    pre_note = ccb.content.text("Must be supported directly from below or on at least two sides.  May need a 'room' supporting a roof directly below."),
    pre_checks = { "check_support", "check_unblocked" },
    post_terrain = "t_log_sod_roof",
}

ccb.content.define_construction {
    id = "constr_metal_roof",
    group = "build_metal_roof",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 4 }, { "mechanics", 4 } },
    duration = "60 m",
    tools = {
        {
            { "oxy_torch", 5 },
            { "welder", 25 },
            { "welding_kit", 25 },
            { "welder_crude", 40 },
            { "toolset", 40 },
        },
    },
    qualities = { { { id = "SAW_M", level = 2 } }, { { id = "GLARE", level = 1 } } },
    components = {
        { { "steel_lump_any", 4, "LIST" }, { "steel_chunk_any", 12, "LIST" }, { "scrap", 36 } },
        { { "sheet_metal", 10 } },
    },
    pre_note = ccb.content.text("Must be supported directly from below or on at least two sides.  May need a 'room' supporting a roof directly below."),
    pre_checks = { "check_support", "check_unblocked" },
    post_terrain = "t_metal_roof",
}

ccb.content.define_construction {
    id = "constr_metal_flat_roof",
    group = "build_metal_flat_roof",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 5 } },
    duration = "45 m",
    qualities = { { id = "GLARE", level = 1 } },
    tools = {
        {
            { "oxy_torch", 5 },
            { "welder", 25 },
            { "welding_kit", 25 },
            { "welder_crude", 40 },
            { "toolset", 40 },
        },
    },
    components = { { { "steel_plate", 2 } } },
    pre_note = ccb.content.text("Must be supported directly from below or on at least two sides.  May need a 'room' supporting a roof directly below."),
    pre_checks = { "check_support", "check_unblocked" },
    post_terrain = "t_metal_flat_roof",
}

-- Fairly time consuming as you have to extrude the resin slowly and wait for it to dry, then layer it on itself
ccb.content.define_construction {
    id = "constr_resin_roof",
    group = "extrude_resin_roof",
    category = "CONSTRUCT",
    skill = "fabrication",
    difficulty = 1,
    duration = "60 m",
    components = { { { "alien_pod_resin", 1 } } },
    pre_note = ccb.content.text("Must be supported directly from below or on at least two sides.  May need a 'room' supporting a roof directly below."),
    pre_checks = { "check_support", "check_unblocked" },
    post_terrain = "t_resin_roof",
}

ccb.content.define_construction {
    id = "constr_shingle_flat_roof",
    group = "build_shingle_flat_roof",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 3 } },
    duration = "60 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 2 } } },
    components = { { { "wood_panel", 1 } }, { { "2x4", 8 } }, { { "nails", 20, "LIST" } } },
    pre_note = ccb.content.text("Must be supported directly from below or on at least two sides.  May need a 'room' supporting a roof directly below."),
    pre_checks = { "check_support", "check_unblocked" },
    post_terrain = "t_shingle_flat_roof",
}

ccb.content.define_construction {
    id = "constr_thatched_roof",
    group = "build_thatched_roof",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 3 }, { "survival", 7 } },
    duration = "300 m",
    qualities = { { id = "CUT", level = 2 } },
    components = {
        { { "2x4", 5 }, { "stick", 10 }, { "stick_long", 5 } },
        { { "straw_pile", 60 }, { "withered", 60 } },
        { { "cordage", 8, "LIST" } },
    },
    pre_note = ccb.content.text("Must be supported directly from below or on at least two sides.  May need a 'room' supporting a roof directly below."),
    pre_checks = { "check_support", "check_unblocked" },
    post_terrain = "t_thatch_roof",
}

ccb.content.define_construction {
    id = "constr_treated_wood_roof",
    group = "build_treated_wood_roof",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 3 } },
    duration = "60 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 2 } } },
    components = {
        { { "wood_sheet", 1 }, { "wood_panel", 2 } },
        { { "2x4", 6 } },
        { { "nails", 40, "LIST" } },
    },
    pre_note = ccb.content.text("Must be supported directly from below or on at least two sides.  May need a 'room' supporting a roof directly below."),
    pre_checks = { "check_support", "check_unblocked" },
    post_terrain = "t_wood_treated_roof",
}

ccb.content.define_construction {
    id = "constr_wood_roof",
    group = "build_wood_roof",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 3 } },
    duration = "60 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 2 } } },
    components = {
        { { "wood_sheet", 1 }, { "wood_panel", 2 } },
        { { "2x4", 6 } },
        { { "nails", 40, "LIST" } },
    },
    pre_note = ccb.content.text("Must be supported directly from below or on at least two sides.  May need a 'room' supporting a roof directly below."),
    pre_checks = { "check_support", "check_unblocked" },
    post_terrain = "t_wood_roof",
}
