local ccb = require("ccb")

ccb.content.define_item {
    id = "nomad_bodyglove_1",
    name = ccb.content.text("nomad bodyglove"),
    description = ccb.content.text("A simple, thin, skintight layer of breathable fabric that protects your skin.  It has integrated feet and precisely placed rubberized pads to protect critical points from impact and abrasion."),
    mass = "125 g",
    volume = "1 L",
    price = "25 USD",
    survival_price = "4 USD",
    materials = { "lycra", "rubber" },
    symbol = "[",
    looks_like = "union_suit",
    color = "white",
    flags = { "VARSIZE", "SKINTIGHT", "HOOD", "STURDY", "SOFT" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "lycra", coverage = 100, thickness = 0.2 },
                    { id = "rubber", coverage = 80, thickness = 0.8 },
                },
                covers = { "torso", "arm_l", "arm_r", "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 1,
                breathability = "GOOD",
            },
            {
                materials = { { id = "lycra", coverage = 100, thickness = 0.2 } },
                covers = { "foot_l", "foot_r" },
                coverage = 100,
                encumbrance = 1,
                breathability = "GOOD",
            },
        },
        warmth = 1,
        thickness = 1,
        environmental_protection = 1,
    },
}
