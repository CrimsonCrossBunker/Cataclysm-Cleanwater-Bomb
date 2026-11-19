local ccb = require("ccb")

ccb.content.define_item {
    id = "armor_riot_torso",
    category = "armor",
    name = ccb.content.plural_text("riot chest guard", "riot chest guards"),
    description = ccb.content.text("A hard chest protector, attached to thigh and upper arm guards.  Used by riot police officers.  MOLLE webbing is attached to the torso and the word POLICE is emblazoned across the front."),
    mass = "2 kg",
    volume = "10 L",
    price = "400 USD",
    survival_price = "25 USD",
    materials = { "thermo_resin", "plastic_pad" },
    symbol = "[",
    looks_like = "chestguard_hard",
    color = "dark_gray",
    length = "60 cm",
    flags = {
        "STURDY",
        "OUTER",
        "WATER_FRIENDLY",
        "PADDED",
        "ALLOWS_GASTROPOD_FOOT",
        "ALLOWS_LEG_TENTACLES",
    },
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
                encumbrance = 2,
                coverage = 65,
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 6 },
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
                covers = { "leg_l", "leg_r" },
                volume_encumbrance = 0,
                coverage = 30,
                materials = { { id = "plastic_pad", coverage = 100, thickness = 7 } },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
            {
                volume_encumbrance = 0,
                coverage = 30,
                materials = { { id = "plastic_pad", coverage = 100, thickness = 7 } },
                covers = { "gastropod_foot" },
                subparts = { "leg_hip_gastropod_l", "leg_hip_gastropod_r" },
            },
            {
                volume_encumbrance = 0,
                coverage = 30,
                materials = { { id = "plastic_pad", coverage = 100, thickness = 7 } },
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                subparts = {
                    "tentacle_lower_front_base_l", "tentacle_lower_middle_base_l",
                    "tentacle_lower_rear_base_l", "tentacle_lower_middle_base_r",
                    "tentacle_lower_middle_base_r", "tentacle_lower_rear_base_r",
                },
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 6 }, { kind = "detach_molle" } },
}
