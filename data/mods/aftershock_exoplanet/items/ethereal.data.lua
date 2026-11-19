local ccb = require("ccb")

ccb.content.define_item {
    id = "cold_res_cream",
    name = ccb.content.plural_text("cold resistance cream", "cold resistance creams"),
    description = ccb.content.text("A thick layer of something that smells worse than walrus fat.  But it keeps you warm."),
    mass = "1g",
    volume = "1ml",
    price = "36 USD 46 cent",
    symbol = "o",
    color = "green",
    materials = { "oil" },
    flags = {
        "AURA", "SEMITANGIBLE", "OVERSIZE", "WATER_FRIENDLY", "TRADER_AVOID", "NO_TAKEOFF",
        "NONCONDUCTIVE", "UNBREAKABLE", "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 150,
        portions = {
            {
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l",
                    "foot_r", "mouth", "eyes",
                },
            },
        },
    },
    artifact = { enchantments = { "afs_ench_climate_control_warm" } },
}

ccb.content.define_item {
    id = "cold_res_cream_greater",
    name = ccb.content.plural_text("heat retention xtreme cream", "heat retention xtreme creams"),
    description = ccb.content.text("The last word in cold snap protection designed to give short term protection in the event of a suit breach in vacuum."),
    mass = "1g",
    volume = "1ml",
    price = "36 USD 46 cent",
    symbol = "o",
    color = "green",
    materials = { "oil" },
    flags = {
        "AURA", "SEMITANGIBLE", "OVERSIZE", "WATER_FRIENDLY", "TRADER_AVOID", "NO_TAKEOFF",
        "NONCONDUCTIVE", "UNBREAKABLE", "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 150,
        portions = {
            {
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l",
                    "foot_r", "mouth", "eyes",
                },
            },
        },
    },
    artifact = { enchantments = { "afs_ench_climate_control_warm", "ench_cold_armor" } },
}
