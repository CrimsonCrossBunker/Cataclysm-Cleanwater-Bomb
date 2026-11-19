local ccb = require("ccb")

ccb.content.define_item {
    id = "conc_venom",
    category = "chems",
    name = ccb.content.plural_text("concentrated venom", "concentrated venom"),
    description = ccb.content.text("A transparent, lightly greenish liquid, refined from the venom of bees and wasps.  Active ingredients include (nor-)adrenaline, dopamine, histamine, and protein toxins.  It is now relatively stable, but will require further separation to be useful for anything other than killing you."),
    phase = "liquid",
    mass = "5 g",
    volume = "5 ml",
    stack_size = 1,
    default_container = "test_tube",
    symbol = ";",
    color = "light_green",
    display_type = "BY_VOLUME",
    stackable = true,
    ammunition = { count = 10, type = "components" },
}

ccb.content.define_item {
    id = "conc_paralytic",
    name = ccb.content.plural_text("concentrated paralytic", "concentrated paralytic"),
    description = ccb.content.text("A concentrated paralytic agent, originally from a triffid.  Given your experience with its effects (chiefly gathered while sourcing this batch) and their striking similarity to earthly flora, you figure it's related to curarines.  Might come in handy in crafting more useful things."),
    copy_from = "conc_venom",
    color = "light_gray",
    ammunition = {},
}

ccb.content.define_item {
    id = "rocuronium",
    category = "chems",
    name = ccb.content.plural_text("rocuronium", "rocuronium"),
    description = ccb.content.text("Rocuronium bromide, a fast-acting muscle relaxant.  Used primarily in emergency medicine because of its relative stability, it can serve as a component of a balanced anesthesia in a pinch."),
    mass = "10 g",
    volume = "10 ml",
    phase = "liquid",
    default_container = "test_tube",
    symbol = ";",
    color = "light_gray",
    price = "20 USD",
    survival_price = "2 USD",
    stack_size = 1,
    display_type = "BY_VOLUME",
    ammunition = { type = "components", count = 1 },
}
