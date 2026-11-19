local ccb = require("ccb")

ccb.content.define_construction {
    id = "constr_extract_bog_iron",
    group = "extract_bog_iron",
    category = "OTHER",
    required_skills = { { "survival", 0 } },
    duration = "5 h",
    qualities = { { { id = "DIG", level = 1 } } },
    byproducts = { { item = "iron_ore", count = { 40, 60 } } },
    pre_terrain = "t_bog_iron",
    completion_actions = "done_extract_maybe_revert_to_dirt",
}

ccb.content.define_construction {
    id = "constr_bloomery",
    group = "build_bloomery",
    category = "FURN",
    required_skills = { { "fabrication", 5 } },
    duration = "120 m",
    qualities = { { { id = "DIG", level = 1 } }, { { id = "HAMMER", level = 2 } } },
    components = { { { "rock", 30 } }, { { "clay_lump", 10 } } },
    pre_note = ccb.content.text("Can be deconstructed without tools."),
    pre_checks = "check_empty",
    post_terrain = "f_bloomery",
}
