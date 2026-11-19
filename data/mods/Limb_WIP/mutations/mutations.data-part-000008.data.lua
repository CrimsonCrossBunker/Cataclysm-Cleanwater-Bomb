local ccb = require("ccb")

ccb.content.define_mutation {
    id = "WINGS_STUB",
    name = ccb.content.text("Wing Stubs"),
    points = 0,
    visibility = 2,
    ugliness = 2,
    description = ccb.content.text("You have a pair of stubby little wings projecting from your shoulderblades.  They can be wiggled at will, but are useless."),
    types = { "WINGS" },
    replacements = { "WINGS_INSECT", "WINGS_BUTTERFLY" },
    categories = { "INSECT" },
}

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

ccb.content.define_mutation {
    id = "NO_RIGHT_LEG",
    name = ccb.content.text("No Right Leg"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("Whether by a serious accident, birth defect, or other means, you have lost your right leg.  You can hobble around, but will likely need a wheelchair or other means of locomotion to get somewhere far."),
    bionic_exclusions = { "leg_knee_r", "leg_lower_r", "leg_draped_r", "foot_r" },
    restricts_gear = { "foot_r" },
    prerequisites = { "HAS_RIGHT_LEG" },
    allowed_item_flags = { "LEG_PROSTHETIC" },
    enchantments = { "ENCH_NO_RIGHT_LEG" },
    cancels = {
        "BADKNEES", "LIGHTSTEP", "STRONGKNEES", "STRONG_LEGS", "PADDED_FEET", "ANIMAL_FEET",
        "FELINE_LEAP", "LEAPING_LEGS", "LEAPING_LEGS2", "BIRD_LEGS", "FLEET2", "FLEET", "HOOVES",
        "RABBIT_FEET", "TOUGH_FEET", "RAP_TALONS", "WEBBED_FEET",
    },
}

ccb.content.define_mutation {
    id = "NO_LEFT_LEG",
    name = ccb.content.text("No Left Leg"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("Whether by a serious accident, birth defect, or other means, you have lost your left leg.  You can hobble around, but will likely need a wheelchair or other means of locomotion to get somewhere far."),
    bionic_exclusions = { "leg_knee_l", "leg_lower_l", "leg_draped_l", "foot_l" },
    restricts_gear = { "foot_l" },
    prerequisites = { "HAS_LEFT_LEG" },
    allowed_item_flags = { "LEG_PROSTHETIC" },
    enchantments = { "ENCH_NO_LEFT_LEG" },
    cancels = {
        "BADKNEES", "LIGHTSTEP", "STRONGKNEES", "STRONG_LEGS", "PADDED_FEET", "ANIMAL_FEET",
        "FELINE_LEAP", "LEAPING_LEGS", "LEAPING_LEGS2", "BIRD_LEGS", "FLEET2", "FLEET", "HOOVES",
        "RABBIT_FEET", "TOUGH_FEET", "RAP_TALONS", "WEBBED_FEET",
    },
}

ccb.content.define_mutation {
    id = "NO_LEFT_ARM",
    name = ccb.content.text("No Left Arm"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("Whether by a serious accident, birth defect, or other means, you have lost your left arm.  As such, you cannot use anything you normally could with it, like lifting with two hands."),
    bionic_exclusions = { "arm_upper_l", "arm_elbow_l", "arm_lower_l", "hand_l" },
    restricts_gear = { "hand_l" },
    prerequisites = { "HAS_LEFT_ARM" },
    allowed_item_flags = { "ARM_PROSTHETIC" },
    enchantments = { "ENCH_NO_LEFT_ARM" },
    cancels = {
        "BARBS", "NAILS", "CLAWS", "CLAWS_RAT", "CLAWS_ST", "CLAWS_RETRACT", "CLAWS_TENTACLE",
        "ARM_FEATHERS", "TALONS", "BENDY1", "PAWS", "PAWS_LARGE", "BURROW", "BURROWLARGE", "PAWS_LITTLE",
        "SLIME_HANDS", "WEBBED",
    },
}

ccb.content.define_mutation {
    id = "NO_RIGHT_ARM",
    name = ccb.content.text("No Right Arm"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("Whether by a serious accident, birth defect, or other means, you have lost your right arm.  As such, you cannot use anything you normally could with it, like lifting with two hands."),
    bionic_exclusions = { "arm_upper_r", "arm_elbow_r", "arm_lower_r", "hand_r" },
    restricts_gear = { "hand_r" },
    prerequisites = { "HAS_RIGHT_ARM" },
    allowed_item_flags = { "ARM_PROSTHETIC" },
    enchantments = { "ENCH_NO_RIGHT_ARM" },
    cancels = {
        "CRUSTACEAN_CLAW", "BARBS", "NAILS", "CLAWS", "CLAWS_RAT", "CLAWS_ST", "CLAWS_RETRACT",
        "CLAWS_TENTACLE", "TALONS", "ARM_FEATHERS", "BENDY1", "PAWS", "PAWS_LARGE", "BURROW",
        "BURROWLARGE", "PAWS_LITTLE", "SLIME_HANDS", "WEBBED",
    },
}
