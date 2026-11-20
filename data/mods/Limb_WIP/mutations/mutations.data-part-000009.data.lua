local ccb = require("ccb")

ccb.content.define_mutation {
    id = "RIGHT_PROSTHETIC_LEG",
    name = ccb.content.text("Right Prosthetic Leg"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("You have a prosthetic on your right leg."),
    bionic_exclusions = { "leg_knee_r", "leg_lower_r", "leg_draped_r", "foot_prosthetic_r" },
    on_process = "wear_right_leg_prosthetic",
    enchantments = { "ENCH_RIGHT_PROSTHETIC" },
}

ccb.content.define_mutation {
    id = "LEFT_PROSTHETIC_LEG",
    name = ccb.content.text("Left Prosthetic Leg"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("You have a prosthetic on your left leg."),
    bionic_exclusions = { "leg_knee_l", "leg_lower_l", "leg_draped_l", "foot_prosthetic_l" },
    on_process = "wear_left_leg_prosthetic",
    enchantments = { "ENCH_LEFT_PROSTHETIC" },
}

ccb.content.define_mutation {
    id = "RIGHT_PEG_LEG",
    name = ccb.content.text("Right Peg Leg"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("You have a prosthetic on your right leg."),
    bionic_exclusions = { "leg_knee_r", "leg_lower_r", "leg_draped_r", "foot_r" },
    on_process = "wear_right_leg_prosthetic",
    enchantments = { "ENCH_RIGHT_PEGLEG" },
}

ccb.content.define_mutation {
    id = "LEFT_PEG_LEG",
    name = ccb.content.text("Left Peg Leg"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("You have a prosthetic on your left leg."),
    bionic_exclusions = { "leg_knee_l", "leg_lower_l", "leg_draped_l", "foot_l" },
    on_process = "wear_left_leg_prosthetic",
    enchantments = { "ENCH_LEFT_PEGLEG" },
}

ccb.content.define_mutation {
    id = "LEFT_PROSTHETIC_ARM",
    name = ccb.content.text("Left Prosthetic Arm"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("You have a prosthetic on your left arm."),
    bionic_exclusions = { "arm_upper_l", "arm_elbow_l", "arm_lower_l", "hand_prosthetic_l" },
    on_process = "wear_left_arm_prosthetic",
    enchantments = { "ENCH_LEFT_ARM_PROSTHETIC" },
}

ccb.content.define_mutation {
    id = "RIGHT_PROSTHETIC_ARM",
    name = ccb.content.text("Right Prosthetic Arm"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("You have a prosthetic on your right arm."),
    bionic_exclusions = { "arm_upper_r", "arm_elbow_r", "arm_lower_r", "hand_prosthetic_r" },
    on_process = "wear_right_arm_prosthetic",
    enchantments = { "ENCH_RIGHT_ARM_PROSTHETIC" },
}

ccb.content.define_mutation {
    id = "LEFT_NEUROPROSTHETIC_ARM",
    name = ccb.content.text("Left Neuroprosthetic Arm"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("You have a prosthetic on your left arm."),
    bionic_exclusions = { "arm_upper_l", "arm_elbow_l", "arm_lower_l", "hand_neuroprosthetic_l" },
    on_process = "wear_left_arm_prosthetic",
    enchantments = { "ENCH_LEFT_ARM_NEUROPROSTHETIC" },
}

ccb.content.define_mutation {
    id = "RIGHT_NEUROPROSTHETIC_ARM",
    name = ccb.content.text("Right Neuroprosthetic Arm"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("You have a prosthetic on your right arm."),
    bionic_exclusions = { "arm_upper_r", "arm_elbow_r", "arm_lower_r", "hand_neuroprosthetic_r" },
    on_process = "wear_right_arm_prosthetic",
    enchantments = { "ENCH_RIGHT_ARM_NEUROPROSTHETIC" },
}

ccb.content.define_mutation {
    id = "LEFT_COSMETIC_PROSTHETIC_ARM",
    name = ccb.content.text("Left Cosmetic Prosthetic Arm"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("You have a prosthetic on your left arm."),
    bionic_exclusions = { "arm_upper_l", "arm_elbow_l", "arm_lower_l", "hand_prosthetic_l" },
    on_process = "wear_left_arm_prosthetic",
    enchantments = { "ENCH_LEFT_ARM_COSMETIC_PROSTHETIC" },
}

ccb.content.define_mutation {
    id = "RIGHT_COSMETIC_PROSTHETIC_ARM",
    name = ccb.content.text("Right Cosmetic Prosthetic Arm"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("You have a prosthetic on your right arm."),
    bionic_exclusions = { "arm_upper_r", "arm_elbow_r", "arm_lower_r", "hand_prosthetic_r" },
    on_process = "wear_right_arm_prosthetic",
    enchantments = { "ENCH_RIGHT_ARM_COSMETIC_PROSTHETIC" },
}
