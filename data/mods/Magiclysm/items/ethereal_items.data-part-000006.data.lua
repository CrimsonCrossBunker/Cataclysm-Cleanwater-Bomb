local ccb = require("ccb")

ccb.content.define_item {
    id = "aura_stoneskin",
    category = "armor",
    name = ccb.content.plural_text("stoneskin coating", "stoneskin coating"),
    description = ccb.content.text("A thin layer of shifting, almost fluid living rock, covering the entire body."),
    mass = "100 g",
    volume = "25 L",
    materials = { "stone" },
    symbol = "[",
    color = "light_gray",
    flags = { "OVERSIZE", "PERSONAL", "STURDY", "PADDED" },
    max_worn = 1,
    armor = {
        warmth = 5,
        thickness = 2.6,
        environmental_protection = 2,
        portions = {
            {
                encumbrance = 16,
                coverage = 100,
                covers = {
                    "head", "mouth", "eyes", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l",
                    "leg_r", "foot_l", "foot_r",
                },
            },
        },
    },
}
