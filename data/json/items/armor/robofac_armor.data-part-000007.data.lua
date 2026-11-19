local ccb = require("ccb")

ccb.content.define_item {
    id = "robofac_vambraces",
    abstract = true,
    category = "armor",
    name = ccb.content.plural_text("abstract armored vambraces (pair)", "abstract armored vambraces (pair)"),
    looks_like = "armguard_hard",
    mass = "845 g",
    volume = "4000 ml",
    price = "600 USD",
    survival_price = "50 USD",
    materials = { "ceramic" },
    symbol = ",",
    color = "dark_gray",
    flags = { "BLOCK_WHILE_WORN", "OUTER", "PADDED" },
    armor = {
        thickness = 5.25,
        environmental_protection = 5,
        warmth = 20,
        portions = {
            {
                encumbrance = 3,
                coverage = 95,
                vitals_coverage = 90,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_elbow_l", "arm_elbow_r", "arm_lower_l", "arm_lower_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "robofac_greaves",
    abstract = true,
    category = "armor",
    name = ccb.content.plural_text("abstract armored greaves (pair)", "abstract armored greaves (pair)"),
    looks_like = "legguard_hard",
    mass = "1295 g",
    volume = "5000 ml",
    price = "600 USD",
    survival_price = "50 USD",
    materials = { "ceramic" },
    symbol = ",",
    color = "dark_gray",
    flags = { "OUTER", "PADDED" },
    armor = {
        thickness = 5.25,
        environmental_protection = 5,
        warmth = 20,
        portions = {
            {
                encumbrance = 3,
                coverage = 95,
                vitals_coverage = 90,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_knee_l", "leg_knee_r", "leg_lower_l", "leg_lower_r" },
            },
        },
    },
}
