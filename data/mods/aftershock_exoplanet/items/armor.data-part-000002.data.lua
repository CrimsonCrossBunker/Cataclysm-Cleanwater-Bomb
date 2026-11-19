local ccb = require("ccb")

ccb.content.define_item {
    id = "q_solarpack",
    name = ccb.content.plural_text("quantum solar backpack (folded)", "quantum solar backpacks (folded)"),
    description = ccb.content.text("Personal portable charging system consisting of an array of quantum solar panels neatly folded in the form of a large backpack.  It can be worn as one, and has an integrated cable to plug it into a cable charger system.  Cutting edge technology."),
    mass = "7500 g",
    volume = "5 L",
    price = "15 kUSD",
    accuracy = -1,
    materials = { "glass", "steel" },
    symbol = "[",
    color = "light_gray",
    flags = { "FRAGILE", "BELTED", "OVERSIZE", "SOLARPACK" },
    max_worn = 1,
    melee_damage = { bash = 10 },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { thickness = 3, portions = { { encumbrance = 12, coverage = 40, covers = { "torso" } } } },
    use_actions = { "SOLARPACK" },
}
