local ccb = require("ccb")

ccb.content.define_construction {
    id = "constr_innawood_bulletin",
    group = "build_innawood_bulletin_board",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "20 m",
    components = {
        { { "stick", 6 }, { "stick_long", 3 } },
        { { "string_36", 1 }, { "cordage_36", 1 } },
        { { "birchbark", 6 }, { "willowbark", 6 }, { "tanbark", 6 }, { "alder_bark", 6 } },
    },
    pre_checks = "check_empty",
    post_terrain = "f_bulletin",
}
