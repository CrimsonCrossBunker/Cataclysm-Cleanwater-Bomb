local ccb = require("ccb")

ccb.content.define_item {
    id = "helmet_full_carbide",
    category = "armor",
    name = ccb.content.text("raider's breaching helmet"),
    description = ccb.content.text("This helmet is designed for the individual that is worried about catching heavy weapons fire to the face.  It is unwieldy and heavy, and lacks basic environmental protection features, but it just might stop even the largest of ballistic rounds."),
    mass = "3175 g",
    volume = "2750 ml",
    price = "400 USD",
    survival_price = "2 kUSD 850 USD",
    materials = { "vacuum_carbide_hard" },
    faults = { { group = "carbide_armor" } },
    symbol = "[",
    looks_like = "helmet_barbute",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY", "PADDED" },
    melee_damage = { bash = 10 },
    armor = {
        portions = {
            { covers = { "head" }, coverage = 100, encumbrance = 40 },
            { covers = { "mouth" }, coverage = 100, encumbrance = 30 },
            { covers = { "eyes" }, coverage = 80, encumbrance = 20 },
        },
        warmth = 10,
        thickness = 1,
        environmental_protection = 1,
    },
}
