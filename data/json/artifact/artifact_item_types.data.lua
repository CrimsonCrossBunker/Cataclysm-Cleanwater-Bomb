local ccb = require("ccb")

-- Tool qualities equivalent to steak knife, combat equiv.  to copper knife + 1 w/ RAPID and BLOCK1, size/weight off combat knife +1
ccb.content.define_item {
    id = "art_dagger",
    name = ccb.content.plural_text("ancient athame", "ancient athames"),
    description = ccb.content.text("A ritual knife used by some ancient civilization.  Unreadable runes are carved into the handle.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    mass = "504 g",
    volume = "500 ml",
    length = "25 cm",
    price = "30 USD",
    accuracy = { grip = "solid", length = "hand", surface = "line", balance = "neutral" },
    materials = { "wood", "steel" },
    symbol = ";",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    qualities = { { id = "CUT", level = 1 }, { id = "CUT_FINE", level = 1 }, { id = "BUTCHER", level = 11 } },
    weapon_categories = { "KNIVES" },
    flags = { "SHEATH_KNIFE", "TRADER_AVOID" },
    melee_damage = { bash = 2, stab = 13 },
    tool = {},
}

ccb.content.define_item {
    id = "art_spear",
    copy_from = "spear_steel",
    name = ccb.content.plural_text("ancient spear", "ancient spears"),
    description = ccb.content.text("A sturdy wooden pole with a sharp metal spike on the end.  The handle has the symbol of a blue sun on it.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    tool = {},
}

ccb.content.define_item {
    id = "art_club",
    copy_from = "club_wooden",
    name = ccb.content.plural_text("ancient club", "ancient clubs"),
    description = ccb.content.text("A misshapen rod of gnarled, knotted wood.  The knots in the wood exhibit a strange fractal pattern.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    tool = {},
}
