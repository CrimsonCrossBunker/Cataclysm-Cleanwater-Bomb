local ccb = require("ccb")

ccb.content.define_item {
    id = "tac_helmet_uicas",
    repair_like = "xlkevlar",
    category = "armor",
    name = ccb.content.text("UICAS Point of Impact helmet"),
    description = ccb.content.text("A lightweight black helmet that provides excellent protection from all sorts of damage, unless it's airborne.  UICAS makes the point of designing all headgear whenever possible with clear faceplates, in order to provide a human touch to all interactions."),
    mass = "980 g",
    volume = "2 L",
    price = "370 USD",
    survival_price = "750 USD",
    accuracy = -1,
    materials = { "vacuum_carbide" },
    symbol = "[",
    looks_like = "tac_fullhelmet",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    flags = { "WATER_FRIENDLY", "STURDY", "PADDED" },
    melee_damage = { bash = 10 },
    armor = {
        portions = { { covers = { "head" }, coverage = 95, encumbrance = 15 } },
        warmth = 10,
        thickness = 4,
    },
}
