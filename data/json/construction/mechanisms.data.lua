local ccb = require("ccb")

ccb.content.define_construction {
    id = "constr_mechanical_winch",
    group = "build_mechanical_winch",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 5 }, { "mechanics", 6 } },
    duration = "60 m",
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
    components = { { { "chain", 16 } }, { { "wheel_metal", 2 } }, { { "pipe", 4 } } },
    pre_note = ccb.content.text("Must be adjacent to ordinary, concrete, brick, or rock wall that is itself adjacent to a metal gate in order to open said gate."),
    pre_checks = "check_empty",
    post_terrain = "t_gates_mech_control_lab",
}

ccb.content.define_construction {
    id = "constr_palisade_pulley",
    group = "build_rope_pulley_system",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 5 }, { "mechanics", 2 } },
    duration = "60 m",
    components = {
        { { "rope_natural", 1, "LIST" } },
        { { "stick", 8 }, { "stick_long", 4 }, { "2x4", 8 } },
        { { "block_and_tackle", 1 } },
    },
    pre_note = ccb.content.text("Can be deconstructed without tools.  Must be adjacent to a palisade wall that is itself adjacent to a palisade gate in order to open said gate."),
    pre_checks = "check_empty",
    post_terrain = "t_palisade_pulley",
}

ccb.content.define_construction {
    id = "constr_palisade_pulley_wood",
    group = "build_rope_pulley_system",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 5 }, { "mechanics", 2 } },
    duration = "60 m",
    components = {
        { { "rope_natural", 1, "LIST" } },
        { { "stick", 8 }, { "stick_long", 4 }, { "2x4", 8 } },
        { { "block_and_tackle_wood", 1 } },
    },
    pre_note = ccb.content.text("Can be deconstructed without tools.  Must be adjacent to a palisade wall that is itself adjacent to a palisade gate in order to open said gate."),
    pre_checks = "check_empty",
    post_terrain = "t_palisade_pulley_wood",
}
