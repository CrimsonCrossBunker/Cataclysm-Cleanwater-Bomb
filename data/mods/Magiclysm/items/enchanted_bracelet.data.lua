local ccb = require("ccb")

ccb.content.define_item {
    id = "mana_leech_shackle",
    copy_from = "mana_leech_shackle_unlocked",
    name = ccb.content.plural_text("mana-leech shackle", "mana-leech shackles"),
    description = ccb.content.text("A platinum bracelet covered in runes.  It cannot be removed without the appropriate spell and it constantly drains the wearer's mana, preventing them from casting any spell until they get rid of it."),
    mass = "50 g",
    volume = "25 ml",
    materials = { "platinum" },
    symbol = "[",
    color = "white",
    flags = {
        "MORPHIC", "NO_TAKEOFF", "STURDY", "ONE_PER_LAYER", "WATER_FRIENDLY", "TRADER_AVOID",
        "ALLOWS_NATURAL_ATTACKS",
    },
    subtype_order = { "tool", "armor", "artifact" },
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
    artifact = {
        enchantments = { "ITEM_ENCH_Magiclysm_mana_leech_shackle_0", "ITEM_ENCH_Magiclysm_mana_leech_shackle_1" },
    },
}
