local ccb = require("ccb")

ccb.content.define_item {
    id = "tallit_gadol",
    category = "clothing",
    symbol = "[",
    color = "blue",
    name = ccb.content.plural_text("tallit gadol", "tallit gadol"),
    description = ccb.content.text("A large prayer shawl worn by observant Jews during morning prayers and certain other occasions."),
    price = "250 USD",
    survival_price = "50 cent",
    materials = { "wool" },
    mass = "500 g",
    volume = "1 L",
    flags = { "OUTER", "OVERSIZE", "ALLOWS_NATURAL_ATTACKS" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 45,
        environmental_protection = 2,
        thickness = 1,
        portions = {
            { encumbrance = 5, coverage = 50, covers = { "torso" }, subparts = { "torso_upper" } },
            {
                encumbrance = 5,
                coverage = 10,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
            },
        },
    },
}
