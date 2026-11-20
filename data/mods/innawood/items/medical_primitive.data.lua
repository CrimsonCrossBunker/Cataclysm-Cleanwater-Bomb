local ccb = require("ccb")

ccb.content.define_item {
    id = "bandages_birchbark",
    name = ccb.content.plural_text("birchbark bandage", "birchbark bandages"),
    description = ccb.content.text("A small roll of birchbark with cord, to tie around wounds to help stop bleeding and protect from dirt.  It's better than nothing."),
    mass = "70 g",
    volume = "41 ml",
    price = "4 cent",
    survival_price = "4 cent",
    materials = { "wood" },
    symbol = "!",
    color = "white",
    flags = { "NO_INGEST", "EDIBLE_FROZEN" },
    comestible = { kind = "MED" },
    use_actions = { { kind = "heal", bandages_power = 2, bleed = 8, moves = 6000 } },
}

ccb.content.define_item {
    id = "bandages_birchbark_adv",
    name = ccb.content.plural_text("salved birchbark bandage", "salved birchbark bandages"),
    description = ccb.content.text("Birchbark bandages with added garlic salve.  They're better for wounds but not as good as real bandages."),
    mass = "70 g",
    volume = "250 ml",
    price = "25 cent",
    survival_price = "1 USD",
    materials = { "wood" },
    symbol = "!",
    color = "white",
    flags = { "NO_INGEST", "EDIBLE_FROZEN" },
    comestible = { kind = "MED" },
    use_actions = { { kind = "heal", bandages_power = 3, bleed = 10, moves = 6000 } },
}
