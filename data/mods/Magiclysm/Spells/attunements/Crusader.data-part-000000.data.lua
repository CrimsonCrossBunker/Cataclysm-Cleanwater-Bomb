local ccb = require("ccb")

ccb.content.define_item {
    id = "holy_shield",
    name = ccb.content.plural_text("Holy Shield", "Holy Shields"),
    description = ccb.content.text("A Crusader's magical shield, enhanced to protect the Crusader from all that stands in their way."),
    mass = "1905 g",
    volume = "4 L",
    length = "100 cm",
    price = "0 cent",
    survival_price = "0 cent",
    accuracy = 3,
    materials = { "concentrated_mana" },
    symbol = "[",
    color = "light_gray",
    techniques = { "WBLOCK_3" },
    flags = {
        "OVERSIZE", "BELTED", "RESTRICT_HANDS", "BLOCK_WHILE_WORN", "UNBREAKABLE_MELEE", "NONCONDUCTIVE",
        "NO_REPAIR", "NO_SALVAGE", "TRADER_AVOID",
    },
    max_worn = 1,
    melee_damage = { bash = 14 },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {
        sided = true,
        portions = {
            { covers = { "arm_l", "arm_r" }, coverage = 70, encumbrance = { 12, 12 } },
            { covers = { "hand_l", "hand_r" }, coverage = 100, encumbrance = { 12, 12 } },
        },
        thickness = 6,
    },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_holy_shield_0" } },
}
