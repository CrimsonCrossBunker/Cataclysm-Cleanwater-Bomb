local ccb = require("ccb")

ccb.content.define_construction {
    id = "constr_chair_treesung",
    group = "build_chair_treesung",
    category = "FURN",
    duration = "15 s",
    components = { { { "chair_treesung", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_chair_treesung",
    activity_level = "LIGHT_EXERCISE",
    required_skills = { { "fabrication", 0 } },
}

ccb.content.define_construction {
    id = "constr_wardrobe_treesung",
    group = "build_wardrobe_treesung",
    category = "FURN",
    duration = "15 s",
    components = { { { "wardrobe_treesung", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_wardrobe_treesung",
    activity_level = "LIGHT_EXERCISE",
    required_skills = { { "fabrication", 0 } },
}

ccb.content.define_construction {
    id = "constr_place_treesung_table",
    group = "place_treesung_table",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "1 m",
    components = { { { "table_treesung", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_table_treesung",
    activity_level = "LIGHT_EXERCISE",
}

ccb.content.define_construction {
    id = "constr_bed_frame_treesung",
    group = "build_bed_treesung",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "1 m",
    components = { { { "bedframe_treesung", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_bedframe_treesung",
}

ccb.content.define_construction {
    id = "constr_down_bed_frame_treesung",
    group = "build_down_bed_treesung",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "1 m",
    components = { { { "bedframe_treesung", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_bedframe_treesung",
}

ccb.content.define_construction {
    id = "constr_finish_bed_treesung",
    group = "build_bed_treesung",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "5 m",
    components = { { { "mattress", 1 } } },
    pre_terrain = "f_bedframe_treesung",
    post_terrain = "f_bed_treesung",
}

ccb.content.define_construction {
    id = "constr_finish_down_bed_treesung",
    group = "build_down_bed_treesung",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "5 m",
    components = { { { "down_mattress", 1 } } },
    pre_terrain = "f_bedframe_treesung",
    post_terrain = "f_bed_down_treesung",
}
