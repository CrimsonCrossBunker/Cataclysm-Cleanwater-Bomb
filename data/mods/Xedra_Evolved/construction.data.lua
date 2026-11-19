local ccb = require("ccb")

ccb.content.define_construction {
    id = "place_dreamforged_bed_of_restful_repose",
    group = "bed_upgrades",
    category = "OTHER",
    required_skills = { { "fabrication", 1 } },
    duration = "120 m",
    components = { { { "dreamforged_bed_of_restful_repose", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_dreamforged_bed_of_restful_repose",
    activity_level = "LIGHT_EXERCISE",
}
