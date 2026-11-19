local ccb = require("ccb")

ccb.content.define_item {
    id = "shield_ice",
    name = ccb.content.plural_text("large shield of magical ice", "large shields of magical ice"),
    category = "armor",
    description = ccb.content.text("A lightweight but tough shield crafted entirely of magical ice."),
    mass = "1 kg",
    volume = "5 L",
    length = "50 cm",
    price = "1 cent",
    accuracy = 1,
    materials = { "concentrated_mana" },
    symbol = "[",
    color = "light_gray",
    looks_like = "gauntlets_chitin",
    techniques = { "WBLOCK_3" },
    flags = { "OVERSIZE", "BELTED", "RESTRICT_HANDS", "BLOCK_WHILE_WORN", "UNRESTRICTED" },
    melee_damage = { bash = 14 },
    armor = {
        sided = true,
        thickness = 4,
        portions = { { encumbrance = 10, coverage = 70, covers = { "arm_l", "arm_r", "hand_l", "hand_r" } } },
    },
}
