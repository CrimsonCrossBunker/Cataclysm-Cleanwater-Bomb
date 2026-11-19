local ccb = require("ccb")

ccb.content.define_construction {
    id = "constr_hay",
    group = "place_hay_bale",
    category = "FURN",
    required_skills = { { "survival", 0 } },
    duration = "10 m",
    components = { { { "straw_pile", 40 }, { "withered", 40 } }, { { "rope_natural", 1, "LIST" } } },
    pre_checks = "check_empty",
    post_terrain = "f_hay",
    activity_level = "LIGHT_EXERCISE",
}
