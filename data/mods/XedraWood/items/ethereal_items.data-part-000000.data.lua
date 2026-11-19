local ccb = require("ccb")

ccb.content.define_item {
    id = "item_mountain_tattoo_six",
    name = ccb.content.plural_text("The Crown of the Mountain", "The Crown of the Mountain"),
    description = ccb.content.text("The spirits have infused you with the resilience of the mountains."),
    mass = "400 g",
    volume = "400 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "stone" },
    symbol = "x",
    color = "light_gray",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "PERSONAL", "WATER_FRIENDLY" },
    armor = {
        warmth = 1,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "stone", coverage = 100, thickness = 1.5 } },
                covers = { "head" },
                coverage = 100,
                encumbrance = 4,
                breathability = "AVERAGE",
            },
            {
                materials = { { id = "stone", coverage = 100, thickness = 2.5 } },
                covers = { "torso", "arm_l", "arm_r", "leg_l", "leg_r", "tail" },
                coverage = 100,
                encumbrance = 4,
                breathability = "AVERAGE",
            },
            {
                materials = { { id = "stone", coverage = 100, thickness = 1.75 } },
                covers = { "hand_l", "hand_r", "foot_l", "foot_r" },
                coverage = 100,
                encumbrance = 4,
                breathability = "AVERAGE",
            },
        },
    },
}
