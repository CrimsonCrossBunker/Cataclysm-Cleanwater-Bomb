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
