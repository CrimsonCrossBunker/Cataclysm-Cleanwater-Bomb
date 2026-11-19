local ccb = require("ccb")

ccb.content.define_item {
    id = "biokin_hammerhand_item",
    name = ccb.content.plural_text("[Ψ]hammerhand", "[Ψ]hammerhand"),
    description = ccb.content.text("You can perform many common handy tasks with your bare hands."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    symbol = "$",
    color = "pink",
    flags = {
        "UNBREAKABLE", "ZERO_WEIGHT", "ALLOWS_NATURAL_ATTACKS", "INTEGRATED", "PADDED", "OUTER",
        "SEMITANGIBLE", "WATER_FRIENDLY", "NO_DROP",
    },
    max_worn = 1,
    qualities = {
        { id = "WRENCH", level = 1 },
        { id = "SCREW", level = 1 },
        { id = "HAMMER", level = 3 },
        { id = "HAMMER_FINE", level = 1 },
        { id = "HAMMER_SOFT", level = 1 },
        { id = "CHISEL_WOOD", level = 1 },
        { id = "PRYING_NAIL", level = 1 },
        { id = "PRY", level = 2 },
    },
    melee_damage = { bash = 6 },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { portions = { { encumbrance = 0, coverage = 0, covers = { "hand_l", "hand_r" } } } },
}
