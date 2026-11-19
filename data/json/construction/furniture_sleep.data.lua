local ccb = require("ccb")

ccb.content.define_construction {
    id = "constr_bed_frame",
    group = "build_bed",
    category = "FURN",
    required_skills = { { "fabrication", 4 } },
    duration = "55 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 1 } } },
    components = { { { "2x4", 12 } }, { { "nails", 10, "LIST" } } },
    pre_checks = "check_empty",
    post_terrain = "f_bed_frame",
}

ccb.content.define_construction {
    id = "constr_bunkbed",
    group = "build_bed",
    category = "FURN",
    required_skills = { { "fabrication", 4 } },
    duration = "70 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 1 } } },
    components = {
        { { "2x4", 16 }, { "wood_panel", 4 } },
        { { "2x4", 2 } },
        { { "nails", 20, "LIST" } },
        { { "mattress", 1 } },
    },
    pre_terrain = "f_bed",
    post_terrain = "f_bunkbed",
}

ccb.content.define_construction {
    id = "constr_down_bed_frame",
    group = "build_down_bed",
    category = "FURN",
    required_skills = { { "fabrication", 4 } },
    duration = "55 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 1 } } },
    components = { { { "2x4", 12 } }, { { "nails", 10, "LIST" } } },
    pre_checks = "check_empty",
    post_terrain = "f_bed_frame",
}

ccb.content.define_construction {
    id = "constr_down_bunkbed",
    group = "build_down_bed",
    category = "FURN",
    required_skills = { { "fabrication", 4 } },
    duration = "70 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 1 } } },
    components = {
        { { "2x4", 16 }, { "wood_panel", 4 } },
        { { "2x4", 2 } },
        { { "nails", 20, "LIST" } },
        { { "down_mattress", 1 } },
    },
    pre_terrain = "f_bed_down",
    post_terrain = "f_bunkbed_down",
}

ccb.content.define_construction {
    id = "constr_finish_bed",
    group = "build_bed",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "5 m",
    components = { { { "mattress", 1 } } },
    pre_terrain = "f_bed_frame",
    post_terrain = "f_bed",
}

ccb.content.define_construction {
    id = "constr_finish_down_bed",
    group = "build_down_bed",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "5 m",
    components = { { { "down_mattress", 1 } } },
    pre_terrain = "f_bed_frame",
    post_terrain = "f_bed_down",
}

ccb.content.define_construction {
    id = "constr_hammock",
    group = "place_hammock",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "5 m",
    components = { { { "hammock", 1 } } },
    pre_note = ccb.content.text("Can be deconstructed without tools.  Must be supported on at least two sides."),
    pre_checks = "check_support",
    post_terrain = "f_hammock",
    activity_level = "LIGHT_EXERCISE",
}

ccb.content.define_construction {
    id = "constr_hammock_net",
    group = "place_net_hammock",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "5 m",
    components = { { { "hammock_net", 1 } } },
    pre_note = ccb.content.text("Can be deconstructed without tools.  Must be supported on at least two sides."),
    pre_checks = "check_support",
    post_terrain = "f_hammock_net",
    activity_level = "LIGHT_EXERCISE",
}

-- 12,5 liters
ccb.content.define_construction {
    id = "constr_leaves_pile",
    group = "build_pile_of_leaves",
    category = "FURN",
    required_skills = { { "survival", 0 } },
    duration = "1 m",
    components = { { { "leaves", 125 } } },
    pre_note = ccb.content.text("Can be deconstructed without tools."),
    pre_checks = "check_empty",
    post_terrain = "f_leaves_pile",
}

ccb.content.define_construction {
    id = "constr_makeshift_bed",
    group = "build_makeshift_bed",
    category = "FURN",
    required_skills = { { "fabrication", 2 } },
    duration = "45 m",
    qualities = { { { id = "HAMMER", level = 2 } } },
    components = {
        { { "2x4", 4 } },
        { { "nails", 6, "LIST" } },
        {
            { "sheet", 2 },
            { "blanket", 1 },
            { "down_blanket", 1 },
            { "fur_blanket", 1 },
            { "quilt", 1 },
            { "quilt_patchwork", 1 },
            { "sleeping_bag", 1 },
            { "sleeping_bag_fur", 1 },
        },
    },
    pre_checks = "check_empty",
    post_terrain = "f_makeshift_bed",
}

ccb.content.define_construction {
    id = "constr_straw_bed",
    group = "build_straw_bed",
    category = "FURN",
    required_skills = { { "fabrication", 1 } },
    duration = "30 m",
    components = {
        { { "2x4", 4 }, { "stick", 4 }, { "stick_long", 2 } },
        { { "straw_pile", 160 }, { "withered", 160 } },
    },
    pre_note = ccb.content.text("Can be deconstructed without tools."),
    pre_checks = "check_empty",
    post_terrain = "f_straw_bed",
}
