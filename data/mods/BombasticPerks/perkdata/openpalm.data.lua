local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_hand_openpalm",
    category = "armor",
    name = ccb.content.plural_text("callused hands", "callused hands"),
    description = ccb.content.text("You've dealt so many blows your hands are rough with calluses.  The edge of your hand is sharp enough to cut paper."),
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "flesh" },
    symbol = "x",
    color = "magenta",
    flags = { "INTEGRATED", "UNBREAKABLE", "PERSONAL", "ZERO_WEIGHT" },
    qualities = { { id = "BUTCHER", level = 5 }, { id = "CUT", level = 1 } },
    melee_damage = { cut = 4 },
    armor = {
        thickness = 2,
        portions = { { encumbrance = 1, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}
