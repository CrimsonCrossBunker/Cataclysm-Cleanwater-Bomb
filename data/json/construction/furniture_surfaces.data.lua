local ccb = require("ccb")

ccb.content.define_construction {
    id = "constr_coffee_table",
    group = "build_coffee_table",
    category = "FURN",
    required_skills = { { "fabrication", 1 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 1 } } },
    components = { { { "2x4", 2 } }, { { "wood_sheet", 1 }, { "wood_panel", 1 } }, { { "nails", 8, "LIST" } } },
    pre_checks = "check_empty",
    post_terrain = "f_coffee_table",
}

ccb.content.define_construction {
    id = "constr_counter",
    group = "build_counter",
    category = "FURN",
    required_skills = { { "fabrication", 1 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 1 } } },
    components = { { { "2x4", 2 } }, { { "wood_sheet", 1 }, { "wood_panel", 2 } }, { { "nails", 8, "LIST" } } },
    pre_checks = "check_empty",
    post_terrain = "f_counter",
}

ccb.content.define_construction {
    id = "constr_counter_gate",
    group = "build_counter_gate",
    category = "FURN",
    required_skills = { { "fabrication", 1 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 6 } }, { { "nails", 10, "LIST" } }, { { "hinge", 2 } } },
    pre_checks = "check_empty",
    post_terrain = "f_counter_gate_c",
}

ccb.content.define_construction {
    id = "constr_desk",
    group = "build_desk",
    category = "FURN",
    required_skills = { { "fabrication", 4 } },
    duration = "90 m",
    qualities = {
        { { id = "HAMMER", level = 2 } },
        { { id = "SAW_W", level = 1 } },
        { { id = "CUT", level = 2 } },
    },
    components = {
        { { "2x4", 8 } },
        { { "wood_sheet", 1 }, { "wood_panel", 2 } },
        { { "nails", 24, "LIST" } },
    },
    pre_checks = "check_empty",
    post_terrain = "f_desk",
}

ccb.content.define_construction {
    id = "constr_place_table",
    group = "place_table",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "1 m",
    components = { { { "w_table", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_table",
    activity_level = "LIGHT_EXERCISE",
}

ccb.content.define_construction {
    id = "constr_place_table_fancy",
    group = "place_table",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "1 m",
    components = { { { "v_table", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_table_fancy",
    activity_level = "LIGHT_EXERCISE",
}

ccb.content.define_construction {
    id = "constr_place_workbench",
    group = "place_workbench",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "1 m",
    components = { { { "workbench", 1 } } },
    pre_note = ccb.content.text("Can be deconstructed without tools."),
    pre_checks = "check_empty",
    post_terrain = "f_workbench",
    activity_level = "LIGHT_EXERCISE",
}

ccb.content.define_construction {
    id = "constr_metal_table",
    group = "build_scrap_metal_table",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 2 } },
    duration = "90 m",
    qualities = {
        { { id = "SAW_M", level = 1 } },
        { { id = "WRENCH", level = 2 } },
        { { id = "DRILL", level = 1 } },
    },
    components = {
        { { "pipe_fittings", 2 }, { "steel_chunk_any", 3, "LIST" } },
        { { "sheet_metal_small", 4 }, { "scrap", 4 } },
        { { "sheet_metal", 1 } },
        { { "pipe", 1 } },
    },
    pre_checks = "check_empty",
    post_terrain = "f_metal_table",
}

ccb.content.define_construction {
    id = "constr_table",
    group = "build_table",
    category = "FURN",
    required_skills = { { "fabrication", 1 } },
    duration = "30 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 1 } } },
    components = { { { "2x4", 4 } }, { { "wood_sheet", 1 }, { "wood_panel", 1 } }, { { "nails", 8, "LIST" } } },
    pre_checks = "check_empty",
    post_terrain = "f_table",
}

ccb.content.define_construction {
    id = "constr_solar_cooker",
    group = "build_solar_cooker",
    category = "FURN",
    required_skills = { { "fabrication", 2 } },
    duration = "20 m",
    components = { { { "solar_cooker", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_solar_cooker",
    activity_level = "MODERATE_EXERCISE",
}
