local ccb = require("ccb")

ccb.content.define_construction {
    id = "constr_chimney",
    group = "build_chimney",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 3 } },
    duration = "2 h",
    qualities = { { { id = "SMOOTH", level = 1 } } },
    components = {
        { { "brick", 30 } },
        { { "mortar_build", 1 }, { "mortar_lime", 1 } },
        { { "water", 1 }, { "water_clean", 1 } },
        { { "sheet_metal", 2 } },
    },
    pre_checks = "check_empty",
    post_terrain = "f_chimney",
}

ccb.content.define_construction {
    id = "constr_vent_pipe",
    group = "build_vent_pipe",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 3 } },
    duration = "30 m",
    tools = {
        {
            { "oxy_torch", 4 },
            { "welder", 20 },
            { "welding_kit", 20 },
            { "welder_crude", 30 },
            { "toolset", 30 },
        },
    },
    qualities = { { { id = "SAW_M", level = 1 } }, { { id = "GLARE", level = 1 } } },
    components = { { { "pipe", 3 } } },
    pre_checks = "check_empty",
    post_terrain = "f_vent_pipe",
}
