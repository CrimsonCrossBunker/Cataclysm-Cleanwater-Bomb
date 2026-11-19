local ccb = require("ccb")

ccb.content.define_construction {
    id = "constr_bulletin",
    group = "build_bulletin_board",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "20 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 1 } } },
    components = { { { "2x4", 4 }, { "wood_panel", 1 } }, { { "nails", 8, "LIST" } } },
    pre_checks = "check_empty",
    post_terrain = "f_bulletin",
}

ccb.content.define_construction {
    id = "constr_sign",
    group = "build_sign",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 0 } },
    duration = "20 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = { { { "2x4", 1 }, { "wood_panel", 1 } }, { { "2x4", 2 } }, { { "nails", 6, "LIST" } } },
    pre_checks = "check_empty",
    post_terrain = "f_sign",
}
