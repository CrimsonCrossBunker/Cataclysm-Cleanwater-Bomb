local ccb = require("ccb")

ccb.content.define_construction {
    id = "place_transport_beacon",
    group = "place_transporter_beacon",
    category = "OTHER",
    required_skills = { { "electronics", 2 } },
    duration = "15 m",
    components = { { { "psionic_transporter_beacon", 1 } } },
    pre_checks = "check_empty",
    post_terrain = "f_transporter_beacon",
    activity_level = "NO_EXERCISE",
}

ccb.content.define_construction {
    id = "ap_standing_pyrokinetic_lamp",
    group = "place_standing_pyrokinetic_lamp",
    category = "APPLIANCE",
    required_skills = { { "fabrication", 0 } },
    duration = "5 s",
    components = { { { "standing_pyrokinetic_lamp", 1 } } },
    pre_checks = "check_empty",
    completion_actions = "done_appliance",
    activity_level = "NO_EXERCISE",
}

ccb.content.define_construction {
    id = "ap_psi_noetic_resonance_detector",
    group = "place_psi_noetic_resonance_detector",
    category = "APPLIANCE",
    required_skills = { { "fabrication", 0 } },
    duration = "5 m",
    components = { { { "psi_noetic_resonance_detector", 1 } } },
    pre_checks = "check_empty",
    completion_actions = "done_appliance",
    activity_level = "NO_EXERCISE",
}
