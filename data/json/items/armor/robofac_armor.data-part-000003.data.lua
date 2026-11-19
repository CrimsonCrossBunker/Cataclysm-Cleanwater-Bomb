local ccb = require("ccb")

-- NO_I18N
-- skip encumbrance for additional parts of same body part
-- skip encumbrance for additional parts of same body part
ccb.content.define_item {
    id = "robofac_mantle",
    abstract = true,
    category = "armor",
    name = ccb.content.text_without_extraction("abstract mantle"),
    mass = "6853 g",
    volume = "6600 ml",
    price = "600 USD",
    survival_price = "50 USD",
    materials = { "ceramic" },
    symbol = ",",
    color = "dark_gray",
    flags = { "ABLATIVE_MANTLE", "CANT_WEAR", "OUTER" },
    armor = {
        thickness = 7,
        environmental_protection = 5,
        warmth = 15,
        portions = {
            { encumbrance = 5, coverage = 95, covers = { "torso" }, subparts = { "torso_upper" } },
            {
                encumbrance = 0,
                coverage = 60,
                vitals_coverage = 90,
                covers = { "torso" },
                subparts = { "torso_lower" },
            },
            {
                encumbrance = 2,
                coverage = 95,
                vitals_coverage = 90,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
            },
            {
                encumbrance = 0,
                coverage = 85,
                vitals_coverage = 90,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r" },
            },
        },
    },
}

-- NO_I18N
-- skip encumbrance for additional parts of same body part
ccb.content.define_item {
    id = "robofac_skirt",
    abstract = true,
    category = "armor",
    name = ccb.content.text_without_extraction("abstract armored skirt"),
    mass = "2454 g",
    volume = "3500 ml",
    price = "600 USD",
    survival_price = "50 USD",
    materials = { "ceramic" },
    symbol = ",",
    color = "dark_gray",
    flags = { "ABLATIVE_SKIRT", "CANT_WEAR", "OUTER" },
    armor = {
        thickness = 7,
        environmental_protection = 5,
        warmth = 15,
        portions = {
            {
                encumbrance = 2,
                coverage = 100,
                vitals_coverage = 90,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
            {
                encumbrance = 0,
                coverage = 85,
                vitals_coverage = 90,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}
