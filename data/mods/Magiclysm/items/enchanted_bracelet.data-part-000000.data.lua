local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "platinum_bracelet_magic",
    abstract = true,
    name = ccb.content.text_without_extraction("platinum bracelet"),
    description = ccb.content.text_without_extraction("A bracelet, completely covered with a large amount of runes from both sides."),
    mass = "50 g",
    volume = "25 ml",
    materials = { "platinum", "crystallized_mana" },
    symbol = "[",
    color = "white",
    flags = {
        "BELTED", "NO_WEAR_EFFECT", "STURDY", "ONE_PER_LAYER", "WATER_FRIENDLY",
        "ALLOWS_NATURAL_ATTACKS", "OVERSIZE",
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        sided = true,
        portions = {
            {
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}
