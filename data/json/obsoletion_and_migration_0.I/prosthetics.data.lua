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

local leg_cancels = {
    "BADKNEES",
    "LIGHTSTEP",
    "STRONGKNEES",
    "STRONG_LEGS",
    "PADDED_FEET",
    "ANIMAL_FEET",
    "FELINE_LEAP",
    "LEAPING_LEGS",
    "LEAPING_LEGS2",
    "BIRD_LEGS",
    "FLEET2",
    "FLEET",
    "HOOVES",
    "RABBIT_FEET",
    "TOUGH_FEET",
    "RAP_TALONS",
    "WEBBED_FEET",
}

local left_arm_cancels = {
    "BARBS",
    "NAILS",
    "CLAWS",
    "CLAWS_RAT",
    "CLAWS_ST",
    "CLAWS_RETRACT",
    "CLAWS_TENTACLE",
    "ARM_FEATHERS",
    "TALONS",
    "BENDY1",
    "PAWS",
    "PAWS_LARGE",
    "BURROW",
    "BURROWLARGE",
    "PAWS_LITTLE",
    "SLIME_HANDS",
    "WEBBED",
}

local right_arm_cancels = { "CRUSTACEAN_CLAW" }
for _, trait_id in ipairs(left_arm_cancels) do
    right_arm_cancels[#right_arm_cancels + 1] = trait_id
end

local function define_amputee_reset_trait(spec)
    ccb.content.define_mutation {
        id = spec.id,
        name = ccb.content.text(spec.name),
        points = 0,
        valid = false,
        purifiable = false,
        description = ccb.content.text(spec.description),
        bionic_exclusions = spec.bionic_exclusions,
        restricts_gear = spec.restricts_gear,
        prerequisites = spec.prerequisites,
        allowed_item_flags = spec.allowed_item_flags,
        on_process = "amputee_reset",
        cancels = spec.cancels,
    }
end

local missing_leg_desc = "Whether by a serious accident, birth defect, or other means, you have lost your %s leg.  You can hobble around, but will likely need a wheelchair or other means of locomotion to get somewhere far."
local missing_arm_desc = "Whether by a serious accident, birth defect, or other means, you have lost your %s arm.  As such, you cannot use anything you normally could with it, like lifting with two hands."

define_amputee_reset_trait {
    id = "NO_RIGHT_LEG",
    name = "No Right Leg",
    description = string.format(missing_leg_desc, "right"),
    bionic_exclusions = { "leg_knee_r", "leg_lower_r", "leg_draped_r", "foot_r" },
    restricts_gear = { "foot_r" },
    prerequisites = { "HAS_RIGHT_LEG" },
    allowed_item_flags = { "LEG_PROSTHETIC" },
    cancels = leg_cancels,
}

define_amputee_reset_trait {
    id = "NO_LEFT_LEG",
    name = "No Left Leg",
    description = string.format(missing_leg_desc, "left"),
    bionic_exclusions = { "leg_knee_l", "leg_lower_l", "leg_draped_l", "foot_l" },
    restricts_gear = { "foot_l" },
    prerequisites = { "HAS_LEFT_LEG" },
    allowed_item_flags = { "LEG_PROSTHETIC" },
    cancels = leg_cancels,
}

define_amputee_reset_trait {
    id = "NO_LEFT_ARM",
    name = "No Left Arm",
    description = string.format(missing_arm_desc, "left"),
    bionic_exclusions = { "arm_upper_l", "arm_elbow_l", "arm_lower_l", "hand_l" },
    restricts_gear = { "hand_l" },
    prerequisites = { "HAS_LEFT_ARM" },
    allowed_item_flags = { "ARM_PROSTHETIC" },
    cancels = left_arm_cancels,
}

define_amputee_reset_trait {
    id = "NO_RIGHT_ARM",
    name = "No Right Arm",
    description = string.format(missing_arm_desc, "right"),
    bionic_exclusions = { "arm_upper_r", "arm_elbow_r", "arm_lower_r", "hand_r" },
    restricts_gear = { "hand_r" },
    prerequisites = { "HAS_RIGHT_ARM" },
    allowed_item_flags = { "ARM_PROSTHETIC" },
    cancels = right_arm_cancels,
}

local prosthetics = {
    { "RIGHT_PROSTHETIC_LEG", "Right Prosthetic Leg", "right leg", { "leg_knee_r", "leg_lower_r", "leg_draped_r", "foot_prosthetic_r" } },
    { "LEFT_PROSTHETIC_LEG", "Left Prosthetic Leg", "left leg", { "leg_knee_l", "leg_lower_l", "leg_draped_l", "foot_prosthetic_l" } },
    { "RIGHT_PEG_LEG", "Right Peg Leg", "right leg", { "leg_knee_r", "leg_lower_r", "leg_draped_r", "foot_r" } },
    { "LEFT_PEG_LEG", "Left Peg Leg", "left leg", { "leg_knee_l", "leg_lower_l", "leg_draped_l", "foot_l" } },
    { "LEFT_PROSTHETIC_ARM", "Left Prosthetic Arm", "left arm", { "arm_upper_l", "arm_elbow_l", "arm_lower_l", "hand_prosthetic_l" } },
    { "RIGHT_PROSTHETIC_ARM", "Right Prosthetic Arm", "right arm", { "arm_upper_r", "arm_elbow_r", "arm_lower_r", "hand_prosthetic_r" } },
    { "LEFT_NEUROPROSTHETIC_ARM", "Left Neuroprosthetic Arm", "left arm", { "arm_upper_l", "arm_elbow_l", "arm_lower_l", "hand_neuroprosthetic_l" } },
    { "RIGHT_NEUROPROSTHETIC_ARM", "Right Neuroprosthetic Arm", "right arm", { "arm_upper_r", "arm_elbow_r", "arm_lower_r", "hand_neuroprosthetic_r" } },
    { "LEFT_COSMETIC_PROSTHETIC_ARM", "Left Cosmetic Prosthetic Arm", "left arm", { "arm_upper_l", "arm_elbow_l", "arm_lower_l", "hand_prosthetic_l" } },
    { "RIGHT_COSMETIC_PROSTHETIC_ARM", "Right Cosmetic Prosthetic Arm", "right arm", { "arm_upper_r", "arm_elbow_r", "arm_lower_r", "hand_prosthetic_r" } },
}

for _, entry in ipairs(prosthetics) do
    define_amputee_reset_trait {
        id = entry[1],
        name = entry[2],
        description = "You have a prosthetic on your " .. entry[3] .. ".",
        bionic_exclusions = entry[4],
    }
end
