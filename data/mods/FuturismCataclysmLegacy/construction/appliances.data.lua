local ccb = require("ccb")

ccb.content.define_construction {
    id = "app_solar_v3",
    group = "place_solar_panel_v3",
    category = "APPLIANCE",
    required_skills = { { "fabrication", 1 } },
    duration = "6 m",
    qualities = { { { id = "WRENCH", level = 1 } } },
    components = { { { "solar_panel_v3", 1 } } },
    pre_checks = "check_empty",
    completion_actions = "done_appliance",
    activity_level = "LIGHT_EXERCISE",
}

ccb.content.define_construction {
    id = "app_reinforced_solar_v3",
    group = "place_reinforced_solar_panel_v3",
    category = "APPLIANCE",
    required_skills = { { "fabrication", 1 } },
    duration = "6 m",
    qualities = { { { id = "WRENCH", level = 1 } } },
    components = { { { "reinforced_solar_panel_v3", 1 } } },
    pre_checks = "check_empty",
    completion_actions = "done_appliance",
    activity_level = "LIGHT_EXERCISE",
}

ccb.content.define_construction {
    id = "app_ground_solar_v3",
    group = "place_ground_solar_panel_v3",
    category = "APPLIANCE",
    required_skills = { { "fabrication", 1 } },
    duration = "6 m",
    qualities = { { { id = "WRENCH", level = 1 } } },
    components = { { { "ground_solar_panel_v3", 1 } } },
    pre_checks = "check_empty",
    completion_actions = "done_appliance",
    activity_level = "LIGHT_EXERCISE",
}

ccb.content.define_construction {
    id = "app_reinforced_ground_solar_v3",
    group = "place_reinforced_ground_solar_panel_v3",
    category = "APPLIANCE",
    required_skills = { { "fabrication", 1 } },
    duration = "6 m",
    qualities = { { { id = "WRENCH", level = 1 } } },
    components = { { { "reinforced_ground_solar_panel_v3", 1 } } },
    pre_checks = "check_empty",
    completion_actions = "done_appliance",
    activity_level = "LIGHT_EXERCISE",
}
