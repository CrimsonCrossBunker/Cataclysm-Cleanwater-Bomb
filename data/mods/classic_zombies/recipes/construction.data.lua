local ccb = require("ccb")

ccb.content.define_construction {
    id = "app_battery_car_assembly",
    group = "place_car_battery_assembly",
    category = "APPLIANCE",
    required_skills = { { "electronics", 3 } },
    duration = "25 m",
    components = { { { "battery_car_assembly", 1 } } },
    pre_checks = "check_empty",
    completion_actions = "done_appliance",
    activity_level = "LIGHT_EXERCISE",
}
