local ccb = require("ccb")

ccb.content.define_item {
    id = "armor_riot",
    category = "armor",
    name = ccb.content.plural_text("riot armor suit", "riot armor suits"),
    description = ccb.content.text("A full suit of black plastic body armor plates used by riot police.  Cleverly placed velcro straps secure each piece, resulting in slightly less encumbrance than its constituent parts.  MOLLE webbing is attached to the torso and the word POLICE is emblazoned across the front."),
    mass = "3 kg",
    volume = "12500 ml",
    price = "600 USD",
    survival_price = "40 USD",
    materials = { "thermo_resin", "plastic_pad" },
    symbol = "[",
    looks_like = "kevlar",
    color = "dark_gray",
    length = "60 cm",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY", "PADDED", "BLOCK_WHILE_WORN" },
    armor = {
        warmth = 20,
        portions = {
            {
                encumbrance = 6,
                coverage = 75,
                covers = { "torso" },
                volume_encumbrance = 0.3,
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 7 },
                    { id = "thermo_resin", coverage = 90, thickness = 2 },
                },
            },
            {
                covers = { "arm_l", "arm_r", "leg_l", "leg_r" },
                volume_encumbrance = 0,
                encumbrance = 4,
                coverage = 90,
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 5 },
                    { id = "thermo_resin", coverage = 90, thickness = 1.75 },
                },
                subparts = {
                    "arm_lower_l", "arm_lower_r", "arm_elbow_l", "arm_elbow_r", "leg_knee_l",
                    "leg_knee_r", "leg_lower_l", "leg_lower_r",
                },
            },
            {
                covers = { "arm_l", "arm_r", "leg_l", "leg_r", "foot_l", "foot_r" },
                volume_encumbrance = 0,
                coverage = 65,
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 5 },
                    { id = "thermo_resin", coverage = 90, thickness = 1.5 },
                },
                subparts = {
                    "arm_shoulder_l",
                    "arm_shoulder_r",
                    "arm_upper_l",
                    "arm_upper_r",
                    "leg_upper_l",
                    "leg_upper_r",
                },
            },
            {
                covers = { "foot_l", "foot_r" },
                volume_encumbrance = 0,
                encumbrance = 2,
                coverage = 75,
                materials = { { id = "thermo_resin", coverage = 100, thickness = 1.5 } },
                subparts = { "foot_arch_l", "foot_arch_r", "foot_ankle_r", "foot_ankle_l" },
            },
            {
                covers = { "leg_l", "leg_r" },
                volume_encumbrance = 0,
                coverage = 30,
                materials = { { id = "plastic_pad", coverage = 100, thickness = 7 } },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 6 }, { kind = "detach_molle" } },
}
