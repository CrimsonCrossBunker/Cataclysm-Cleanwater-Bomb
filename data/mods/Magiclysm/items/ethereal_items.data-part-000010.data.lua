local ccb = require("ccb")

ccb.content.define_item {
    id = "aura_auroral_guard",
    category = "armor",
    name = ccb.content.plural_text("auroral shell", "auroral shell"),
    description = ccb.content.text("A sturdy shell that wraps your body, granting a sturdy defense."),
    mass = "400 g",
    volume = "25 L",
    materials = { "concentrated_mana" },
    symbol = "[",
    color = "light_gray",
    flags = { "OVERSIZE", "PERSONAL", "STURDY", "PADDED" },
    max_worn = 1,
    armor = {
        portions = {
            {
                encumbrance = 5,
                coverage = 100,
                covers = {
                    "head", "mouth", "eyes", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l",
                    "leg_r", "foot_l", "foot_r",
                },
            },
        },
        thickness = 3.3,
        environmental_protection = 8,
    },
}

ccb.content.define_item {
    id = "alchemist_pocket",
    category = "armor",
    name = ccb.content.text("ethereal pocket"),
    description = ccb.content.text("A small ethereal pocket located under your left arm.  You can store your potions here, but it seems it has no real limitations."),
    mass = "1 g",
    volume = "1 ml",
    materials = { "concentrated_mana" },
    symbol = "x",
    color = "magenta",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "10 L",
            mass_limit = "20 kg",
            max_item_length = "50 cm",
            moves = 60,
            weight_multiplier = 0,
        },
    },
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "BELTED",
        "WATERPROOF",
        "PADDED",
        "TARDIS",
    },
    armor = { portions = { { covers = { "arm_l" }, coverage = 0, encumbrance = 0 } } },
}
