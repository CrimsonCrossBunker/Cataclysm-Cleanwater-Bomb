local ccb = require("ccb")

ccb.content.define_construction {
    id = "constr_xedra_standing_alembic",
    group = "build_standing_alembic",
    category = "FURN",
    required_skills = { { "chemistry", 2 } },
    duration = "15 m",
    qualities = {},
    components = {
        { { "pot_copper", 1 } },
        { { "pipe_glass", 4 } },
        { { "glass_tube_small", 10 } },
        { { "stopcock", 5 } },
        { { "flask_glass", 3 } },
    },
    pre_checks = "check_empty",
    post_terrain = "f_alembic",
    activity_level = "LIGHT_EXERCISE",
}
