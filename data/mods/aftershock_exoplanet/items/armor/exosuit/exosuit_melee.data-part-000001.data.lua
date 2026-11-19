local ccb = require("ccb")

ccb.content.define_item {
    id = "exosuit_claw",
    name = ccb.content.plural_text("exosuit claws", "exosuit claws"),
    description = ccb.content.text("A pair of oversized and articulated hydraulic gauntlets with fingertips ending in cruel talons."),
    mass = "3 kg",
    volume = "300 ml",
    length = "50 cm",
    price = "11 USD",
    survival_price = "2 USD 50 cent",
    accuracy = { grip = "weapon", length = "hand", surface = "any", balance = "neutral" },
    materials = { "qt_steel" },
    symbol = "[",
    color = "light_gray",
    flags = { "WATER_FRIENDLY", "DURABLE_MELEE", "OVERSIZE", "OUTER", "EXO_MEDIUM_GADGET", "SPAWN_ACTIVE" },
    melee_damage = { bash = 50, cut = 10 },
    armor = {
        power_armor = true,
        portions = {
            {
                materials = {
                    { id = "qt_steel", coverage = 100, thickness = 2 },
                    { id = "superalloy", coverage = 25, thickness = 1.5 },
                },
                covers = { "hand_l", "hand_r" },
                coverage = 100,
                encumbrance = 5,
            },
        },
    },
}
