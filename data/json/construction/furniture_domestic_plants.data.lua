local ccb = require("ccb")

ccb.content.define_construction {
    id = "constr_planter",
    group = "build_planter",
    category = "FURN",
    required_skills = { { "fabrication", 3 } },
    duration = "25 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 2 } } },
    components = {
        { { "2x4", 12 } },
        { { "nails", 36, "LIST" } },
        { { "pebble", 200 } },
        { { "material_soil", 75 } },
    },
    pre_checks = "check_empty",
    post_terrain = "f_planter",
}

ccb.content.define_construction {
    id = "constr_stooking_spot",
    group = "make_stooking_spot",
    category = "OTHER",
    required_skills = { { "survival", 2 } },
    duration = "0 m",
    pre_note = ccb.content.text("Mark a spot to stack cut grain for drying outdoors.  Once placed, put unrotten undried grain stalks on the stooking spot and examine it to get started."),
    pre_checks = "check_empty",
    post_flags = { "keep_items" },
    dark_craftable = true,
    post_terrain = "f_stook_empty",
}
