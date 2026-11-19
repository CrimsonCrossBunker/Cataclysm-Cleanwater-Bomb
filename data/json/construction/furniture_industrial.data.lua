local ccb = require("ccb")

ccb.content.define_construction {
    id = "constr_ground_cable",
    group = "lay_down_decorative_ground_cable",
    category = "CONSTRUCT",
    required_skills = { { "fabrication", 0 } },
    duration = "1 m",
    components = { { { "cable", 2 } } },
    pre_checks = "check_empty",
    post_terrain = "f_ground_cable",
}
