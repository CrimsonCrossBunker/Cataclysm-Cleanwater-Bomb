local ccb = require("ccb")

ccb.content.define_item {
    id = "itzcuauhtli_pants_army",
    copy_from = "pants_army",
    name = ccb.content.plural_text("Itzcuāuhtli Corps combat uniform pants", "Itzcuāuhtli Corps combat uniform pants"),
    description = ccb.content.text("The standard combat uniform of the Itzcuāuhtli Corps, in shades of dark green and grey.  These are pants, with several pockets."),
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}

ccb.content.define_item {
    id = "itzcuauhtli_combat_shirt",
    copy_from = "combat_shirt",
    name = ccb.content.plural_text("Itzcuāuhtli Corps combat uniform shirt", "Itzcuāuhtli Corps combat uniform shirt"),
    description = ccb.content.text("The standard combat uniform of the Itzcuāuhtli Corps, in shades of dark green and grey.  This is a shirt."),
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}

ccb.content.define_item {
    id = "itzcuauhtli_jacket_army_modern",
    copy_from = "jacket_army_modern",
    name = ccb.content.plural_text("Itzcuāuhtli Corps combat uniform jacket", "Itzcuāuhtli Corps combat uniform jacket"),
    description = ccb.content.text("The standard combat uniform of the Itzcuāuhtli Corps, in shades of dark green and grey.  This is a jacket.  It has the eagle over a field of stars symbol of the Itzcuāuhtli Corps on both shoulders."),
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}

ccb.content.define_item {
    id = "holy_symbol_fifth_sun",
    copy_from = "holy_symbol",
    name = ccb.content.text("Imperial Church holy symbol"),
    description = ccb.content.text("A necklace made of fine gold chain, bearing an image of Jesucristo as the Ultimate Sacrifice as a pendant, his heart clearly visible through his chest.  Under his left hand is a raindrop, representing the Aeon Tláloc, and under his right hand is a sun disc, representing the Aeon Huītzilōpōchtli."),
    variants = {},
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}
