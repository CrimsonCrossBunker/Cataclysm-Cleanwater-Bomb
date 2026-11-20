local ccb = require("ccb")

ccb.content.define_item {
    id = "cthonic_poultice",
    name = ccb.content.plural_text("cthonic poultice", "cthonic poultices"),
    description = ccb.content.text("A poultice made from the elements of the earth.  You could use it to heal your wounds, if you were made of stone."),
    mass = "175 g",
    volume = "250 ml",
    price = "6 USD",
    materials = { "dreamstuff" },
    symbol = "~",
    color = "brown",
    flags = { "NO_INGEST", "CANT_HEAL_EVERYONE" },
    comestible = { kind = "MED" },
    use_actions = { { kind = "heal", bandages_power = 15, limb_power = 5, bleed = 5, moves = 300 } },
}

ccb.content.define_item {
    id = "verdant_poultice",
    name = ccb.content.plural_text("verdant poultice", "verdant poultices"),
    description = ccb.content.text("A poultice made from plant life.  You could use it to heal your wounds, if you were grown from plants."),
    mass = "175 g",
    volume = "250 ml",
    price = "6 USD",
    materials = { "dreamstuff" },
    symbol = "~",
    color = "brown",
    flags = { "NO_INGEST", "CANT_HEAL_EVERYONE" },
    comestible = { kind = "MED" },
    use_actions = { { kind = "heal", bandages_power = 15, limb_power = 5, bleed = 5, moves = 300 } },
}

ccb.content.define_item {
    id = "cerulean_poultice",
    name = ccb.content.plural_text("cerulean poultice", "cerulean poultices"),
    description = ccb.content.text("A poultice made from the elements of the sea.  You could use it to heal your wounds, if you were liquid as well."),
    mass = "175 g",
    volume = "250 ml",
    price = "6 USD",
    materials = { "dreamstuff" },
    symbol = "~",
    color = "brown",
    flags = { "NO_INGEST", "CANT_HEAL_EVERYONE" },
    comestible = { kind = "MED" },
    use_actions = { { kind = "heal", bandages_power = 15, limb_power = 5, bleed = 5, moves = 300 } },
}

ccb.content.define_item {
    id = "charred_sacrifice",
    name = ccb.content.plural_text("charred sacrifice", "charred sacrifice"),
    description = ccb.content.text("A devotion to the powers of fire.  You could use it to heal your wounds, if you were born of the flames."),
    mass = "175 g",
    volume = "250 ml",
    price = "6 USD",
    materials = { "dreamstuff" },
    symbol = "~",
    color = "brown",
    flags = { "NO_INGEST", "CANT_HEAL_EVERYONE" },
    comestible = { kind = "MED" },
    use_actions = { { kind = "heal", bandages_power = 15, limb_power = 5, bleed = 5, moves = 300 } },
}

ccb.content.define_item {
    id = "doll_repair_paste",
    name = ccb.content.plural_text("doll repair paste", "doll repair paste"),
    description = ccb.content.text("A paste made from paint and glue.  You could use it to heal your wounds, if you were made in man's image."),
    mass = "175 g",
    volume = "250 ml",
    price = "6 USD",
    materials = { "dreamstuff" },
    symbol = "~",
    color = "brown",
    flags = { "NO_INGEST", "CANT_HEAL_EVERYONE" },
    comestible = { kind = "MED" },
    use_actions = { { kind = "heal", bandages_power = 15, limb_power = 5, bleed = 5, moves = 300 } },
}

ccb.content.define_item {
    id = "ethereal_draught",
    name = ccb.content.plural_text("ethereal draught", "ethereal draughts"),
    description = ccb.content.text("A concoction made from honey and bread.  You could use it to heal your wounds, if you were born of air and darkness."),
    mass = "175 g",
    volume = "250 ml",
    price = "6 USD",
    materials = { "dreamstuff" },
    symbol = "~",
    color = "brown",
    flags = { "NO_INGEST", "CANT_HEAL_EVERYONE" },
    comestible = { kind = "MED" },
    use_actions = { { kind = "heal", bandages_power = 15, limb_power = 5, bleed = 5, moves = 300 } },
}
