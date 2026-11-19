local ccb = require("ccb")

ccb.content.define_construction {
    id = "constr_armchair",
    group = "build_armchair",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    activity_level = "LIGHT_EXERCISE",
    duration = "15 s",
    components = { { { "armchair", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_armchair",
}

ccb.content.define_construction {
    id = "constr_bench_wooden",
    group = "build_bench_wooden",
    category = "FURN",
    required_skills = { { "fabrication", 1 } },
    duration = "45 m",
    qualities = { { { id = "SAW_W", level = 2 } }, { { id = "HAMMER", level = 2 } } },
    components = { { { "log", 1 }, { "wood_beam", 1 } }, { { "nails", 4, "LIST" } }, { { "2x4", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_bench_wooden",
}

ccb.content.define_construction {
    id = "constr_chair",
    group = "build_chair",
    category = "FURN",
    duration = "15 s",
    components = { { { "chair_wood", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_chair",
    activity_level = "LIGHT_EXERCISE",
    required_skills = { { "fabrication", 0 } },
}

ccb.content.define_construction {
    id = "constr_logstool",
    group = "build_log_stool",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "15 s",
    components = { { { "stool_log", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_logstool",
    activity_level = "LIGHT_EXERCISE",
}

ccb.content.define_construction {
    id = "constr_place_chair_plywood",
    group = "place_chair_plywood",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "15 s",
    components = { { { "chair_plywood", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_chair_plywood",
    activity_level = "LIGHT_EXERCISE",
}

ccb.content.define_construction {
    id = "constr_place_chair_wood_black",
    group = "place_chair_wood_black",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "15 s",
    components = { { { "chair_wood_black", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_chair_black",
    activity_level = "LIGHT_EXERCISE",
}

ccb.content.define_construction {
    id = "constr_place_chair_wood_white",
    group = "place_chair_wood_white",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "15 s",
    components = { { { "chair_wood_white", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_chair_white",
    activity_level = "LIGHT_EXERCISE",
}

ccb.content.define_construction {
    id = "constr_place_barstool",
    group = "place_barstool",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "15 s",
    components = { { { "barstool", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_barstool",
    activity_level = "LIGHT_EXERCISE",
}

ccb.content.define_construction {
    id = "constr_place_travel_toilet",
    group = "place_travel_toilet",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "1 m",
    components = { { { "toilet_travel", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_bullettrailer_toilet",
    activity_level = "LIGHT_EXERCISE",
}

ccb.content.define_construction {
    id = "constr_place_folded_travel_toilet",
    group = "place_travel_toilet",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "1 m",
    components = { { { "toilet_travel_folded", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_bullettrailer_toilet",
    activity_level = "LIGHT_EXERCISE",
}

ccb.content.define_construction {
    id = "constr_stool",
    group = "build_stool",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "15 s",
    components = { { { "stool_wood", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_stool",
    activity_level = "LIGHT_EXERCISE",
}

ccb.content.define_construction {
    id = "constr_beanbag",
    group = "build_beanbag",
    category = "FURN",
    duration = "15 s",
    components = { { { "beanbag", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_beanbag",
    activity_level = "LIGHT_EXERCISE",
    required_skills = { { "fabrication", 0 } },
}
