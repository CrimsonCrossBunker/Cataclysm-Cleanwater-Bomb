local ccb = require("ccb")

ccb.content.define_item {
    id = "art_robe",
    copy_from = "robe",
    name = ccb.content.text("royal robe"),
    description = ccb.content.text("An once-ornately decorated robe with an unfamiliar royal symbol on it, now made threadbare by time.  The humanoid figure on the seal has two pairs of eyes.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    armor = {},
}

ccb.content.define_item {
    id = "art_gloves",
    copy_from = "gloves_leather",
    name = ccb.content.plural_text("ornate leather gloves (pair)", "ornate leather gloves (pair)"),
    description = ccb.content.text("A set of worn leather gloves embossed with silver.  The unidentifiable leather it is made from is oddly soft.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    armor = {},
}

ccb.content.define_item {
    id = "art_boots",
    copy_from = "boots",
    name = ccb.content.plural_text("ancient leather boots (pair)", "ancient leather boots (pair)"),
    description = ccb.content.text("A pair of ancient leather boots.  Though the flaps of leather are crudely sewn together, the red hue it is dyed with is striking.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    armor = {},
}

ccb.content.define_item {
    id = "art_sword",
    copy_from = "sword_xiphos",
    name = ccb.content.plural_text("ancient sword", "ancient swords"),
    description = ccb.content.text("A sword made out of a striking black metal.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    tool = {},
}

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
    materials = { "wood", "bronze" },
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
    copy_from = "spear_bronze",
    name = ccb.content.plural_text("ancient spear", "ancient spears"),
    description = ccb.content.text("A sturdy wooden pole with a sharp bronze spike on the end.  The handle has the symbol of a blue sun on it.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    tool = {},
}
