local ccb = require("ccb")

ccb.content.define_item {
    id = "acid_res_aura",
    name = ccb.content.text("acid resistance aura"),
    description = ccb.content.text("An all-encompassing, invisible layer of protection against acid."),
    mass = "500 mg",
    volume = "1ml",
    price = "36 USD 46 cent",
    symbol = "o",
    color = "green",
    materials = { "magical_material" },
    flags = {
        "AURA", "SEMITANGIBLE", "OVERSIZE", "TRADER_AVOID", "NO_TAKEOFF", "NONCONDUCTIVE", "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
    armor = {
        portions = {
            {
                encumbrance = 0,
                coverage = 100,
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l",
                    "foot_r", "mouth", "eyes",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "acid_res_aura_greater",
    name = ccb.content.text("greater acid resistance aura"),
    description = ccb.content.text("An all-encompassing, invisible layer of protection against acid."),
    mass = "500 mg",
    volume = "1ml",
    price = "36 USD 46 cent",
    symbol = "o",
    color = "green",
    materials = { "magical_material" },
    flags = {
        "AURA", "SEMITANGIBLE", "OVERSIZE", "TRADER_AVOID", "NO_TAKEOFF", "NONCONDUCTIVE", "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
    armor = {
        portions = {
            {
                encumbrance = 0,
                coverage = 100,
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l",
                    "foot_r", "mouth", "eyes",
                },
            },
        },
    },
}
