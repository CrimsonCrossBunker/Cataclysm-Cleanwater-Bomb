local ccb = require("ccb")

ccb.content.define_construction {
    id = "constr_fvat_empty_no_faucet",
    group = "build_fermenting_vat",
    category = "FURN",
    required_skills = { { "fabrication", 2 }, { "cooking", 3 } },
    duration = "90 m",
    qualities = { { { id = "HAMMER", level = 2 } }, { { id = "SAW_W", level = 1 } } },
    components = { { { "2x4", 14 } }, { { "nail", 12 } }, { { "sheet_metal_small", 13 } } },
    pre_checks = "check_empty",
    post_terrain = "f_fvat_empty",
}

ccb.content.define_construction {
    id = "app_battery_car_clay",
    group = "place_clay_car_battery",
    category = "APPLIANCE",
    required_skills = { { "electronics", 1 } },
    duration = "6 m",
    components = { { { "battery_car_clay", 1 } } },
    pre_checks = "check_empty",
    completion_actions = "done_appliance",
    activity_level = "LIGHT_EXERCISE",
}

ccb.content.define_construction {
    id = "app_battery_clay_array",
    group = "place_clay_battery_array",
    category = "APPLIANCE",
    required_skills = { { "electronics", 1 } },
    duration = "6 m",
    components = { { { "battery_clay_array", 1 } } },
    pre_checks = "check_empty",
    completion_actions = "done_appliance",
    activity_level = "LIGHT_EXERCISE",
}
