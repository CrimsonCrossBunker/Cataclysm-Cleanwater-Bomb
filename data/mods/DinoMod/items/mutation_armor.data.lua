local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_stegoskin",
    category = "armor",
    name = ccb.content.plural_text("stego skin", "stego skin"),
    description = ccb.content.text("Thick, bulky and heavy.  This skin withstands punishment from even the biggest beasts."),
    mass = "10 kg",
    volume = "3600 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "leather", "flesh", "bone", "chitin" },
    symbol = "x",
    color = "light_red",
    flags = {
        "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "SKINTIGHT", "NORMAL", "WATER_FRIENDLY",
        "PADDED", "SOFT",
    },
    armor = {
        warmth = 10,
        environmental_protection = 3,
        portions = {
            {
                materials = {
                    { id = "leather", coverage = 100, thickness = 3.5 },
                    { id = "flesh", coverage = 100, thickness = 1 },
                    { id = "bone", coverage = 95, thickness = 5 },
                    { id = "chitin", coverage = 95, thickness = 5 },
                },
                covers = {
                    "hand_l",
                    "hand_r",
                    "foot_l",
                    "foot_r",
                    "leg_l",
                    "leg_r",
                    "arm_l",
                    "arm_r",
                    "torso",
                    "head",
                },
                coverage = 100,
                encumbrance = 20,
                breathability = "POOR",
            },
            {
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.5 },
                    { id = "flesh", coverage = 100, thickness = 1 },
                    { id = "bone", coverage = 60, thickness = 4.5 },
                    { id = "chitin", coverage = 60, thickness = 4.5 },
                },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 5,
                breathability = "POOR",
                layers = { "SKINTIGHT" },
            },
        },
    },
}
