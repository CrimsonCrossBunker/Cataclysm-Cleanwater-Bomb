local ccb = require("ccb")

ccb.content.define_item {
    id = "marloss_scarf",
    copy_from = "keffiyeh",
    looks_like = "scarf",
    name = ccb.content.text("cyan scarf"),
    description = ccb.content.text("A simple cloth scarf worn by Marloss Voices.  Wherever the Voices go, long-sought peace soon follows, for better or for worse."),
    color = "cyan",
    armor = {},
}

ccb.content.define_item {
    id = "grass_keffiyeh",
    name = ccb.content.text("grass keffiyeh"),
    description = ccb.content.text("A grass sheet with cords to wear it like a Middle Eastern headdress.  It's a bit itchy, but can keep your head and mouth a bit warmer if there's nothing in the way."),
    mass = "152 g",
    volume = "1250 ml",
    price = "10 cent",
    survival_price = "5 cent",
    materials = { "dry_plant" },
    symbol = "[",
    looks_like = "scarf",
    color = "green",
    flags = { "OVERSIZE", "COLLAR", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 10,
        thickness = 1,
        environmental_protection = 0,
        portions = { { encumbrance = 10, coverage = 85, covers = { "head" } } },
    },
}

ccb.content.define_item {
    id = "nun_wimple",
    name = ccb.content.text("wimple"),
    description = ccb.content.text("A loose cloth headwrap and veil.  Typically worn by Christian nuns."),
    mass = "70 g",
    volume = "250 ml",
    price = "6 USD",
    survival_price = "60 cent",
    materials = { "cotton" },
    symbol = "[",
    color = "white",
    flags = { "OVERSIZE" },
    armor = {
        warmth = 5,
        thickness = 0.1,
        environmental_protection = 1,
        portions = { { encumbrance = 4, coverage = 80, covers = { "head" } } },
    },
}
