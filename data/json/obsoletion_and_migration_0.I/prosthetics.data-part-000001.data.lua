local ccb = require("ccb")

ccb.content.define_mutation {
    id = "HAS_LEFT_LEG",
    name = ccb.content.text_without_extraction("left leg"),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = false,
    description = ccb.content.text_without_extraction("Dummy mutation that keeps you from wearing prosthetics."),
    replacements = { "NO_LEFT_LEG" },
    restricts_gear = { "leg_stub_l" },
}

ccb.content.define_mutation {
    id = "HAS_RIGHT_LEG",
    name = ccb.content.text_without_extraction("right leg"),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = false,
    description = ccb.content.text_without_extraction("Dummy mutation that keeps you from wearing prosthetics."),
    replacements = { "NO_RIGHT_LEG" },
    restricts_gear = { "leg_stub_r" },
}

ccb.content.define_mutation {
    id = "HAS_LEFT_ARM",
    name = ccb.content.text_without_extraction("left arm"),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = false,
    description = ccb.content.text_without_extraction("Dummy mutation that keeps you from wearing prosthetics."),
    replacements = { "NO_LEFT_ARM" },
    restricts_gear = { "arm_stub_l" },
}

ccb.content.define_mutation {
    id = "HAS_RIGHT_ARM",
    name = ccb.content.text_without_extraction("right arm"),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = false,
    description = ccb.content.text_without_extraction("Dummy mutation that keeps you from wearing prosthetics."),
    replacements = { "NO_RIGHT_ARM" },
    restricts_gear = { "arm_stub_r" },
}
