local ccb = require("ccb")

ccb.content.define_item {
    id = "mana_leech_shackle_unlocked",
    name = ccb.content.plural_text("inert mana-leech shackle", "inert mana-leech shackles"),
    description = ccb.content.text("A platinum bracelet covered in runes.  If it was active, it would keep its wearer from casting spells.  Now it's just another useless trinket as you do not know the spells it requires to be activated again."),
    mass = "50 g",
    volume = "25 ml",
    materials = { "platinum" },
    symbol = "[",
    color = "white",
    flags = { "STURDY", "ONE_PER_LAYER", "WATER_FRIENDLY", "TRADER_AVOID", "ALLOWS_NATURAL_ATTACKS" },
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
