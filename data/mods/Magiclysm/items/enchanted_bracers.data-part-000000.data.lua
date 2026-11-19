local ccb = require("ccb")

ccb.content.define_item {
    id = "mbracer_steel_pair",
    category = "armor",
    name = ccb.content.plural_text("pair of steel bracers", "pairs of steel bracers"),
    description = ccb.content.text("A full assembly of medieval arm protection."),
    mass = "1520 g",
    volume = "2500 ml",
    price = "200 USD",
    accuracy = -1,
    materials = { "steel", "leather" },
    symbol = "[",
    color = "light_gray",
    flags = { "OUTER", "STURDY", "BLOCK_WHILE_WORN", "WATER_FRIENDLY" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 10,
        thickness = 5,
        portions = {
            {
                covers = { "arm_l", "arm_r" },
                encumbrance = 3,
                coverage = 95,
                melee_coverage = 95,
                ranged_coverage = 90,
                vitals_coverage = 70,
                subparts = { "arm_lower_r", "arm_lower_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "mbracer_steel_single",
    copy_from = "mbracer_steel_pair",
    name = ccb.content.plural_text("steel bracer", "steel bracers"),
    mass = "770 g",
    volume = "1250 ml",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { sided = true },
}
