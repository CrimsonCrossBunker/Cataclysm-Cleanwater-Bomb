local ccb = require("ccb")

ccb.content.define_item {
    id = "scrap_shadowstuff",
    category = "spare_parts",
    name = ccb.content.plural_text("scrap shadowstuff", "scraps of shadowstuff"),
    description = ccb.content.text("A bulky assortment of small bits of scrap shadowstuff, possibly useful in ephemeral crafting."),
    mass = "10 mg",
    volume = "25 ml",
    price = "5 USD",
    survival_price = "10 cent",
    stack_size = 10,
    materials = { "shadowstuff" },
    symbol = ",",
    color = "light_gray",
    ammunition = { count = 2, type = "scrap_shadowstuff" },
}

ccb.content.define_item {
    id = "chunk_shadowstuff",
    category = "spare_parts",
    name = ccb.content.plural_text("chunk shadowstuff", "scraps of shadowstuff"),
    description = ccb.content.text("A bulky assortment of larger bits of scrap shadowstuff, possibly useful in ephemeral crafting."),
    mass = "2000 mg",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "10 cent",
    stack_size = 10,
    materials = { "shadowstuff" },
    symbol = ",",
    color = "light_gray",
    ammunition = { count = 2, type = "components" },
}

-- Density 2g/ml.
ccb.content.define_item {
    id = "scrap_dreamdross",
    category = "spare_parts",
    name = ccb.content.plural_text("scrap dreamdross", "scraps of dreamdross"),
    description = ccb.content.text("A bulky assortment of small bits of scrap dreamdross, useful in all kinds of ephemeral crafting."),
    mass = "5 g",
    volume = "25 ml",
    price = "5 USD",
    survival_price = "10 cent",
    stack_size = 10,
    materials = { "dreamstuff" },
    symbol = ",",
    color = "light_gray",
    ammunition = { count = 2, type = "scrap_dreamdross" },
}

ccb.content.define_item {
    id = "dreamdross_lump",
    category = "spare_parts",
    name = ccb.content.plural_text("lump of dreamdross", "lumps of dreamdross"),
    description = ccb.content.text("A heavy formed piece of dreamdross.  Useful for some crafting recipes."),
    mass = "50 g",
    volume = "25 ml",
    price = "20 USD",
    survival_price = "5 USD",
    materials = { "dreamstuff" },
    symbol = ",",
    color = "light_gray",
    melee_damage = { bash = 12 },
    ammunition = { type = "components" },
}

ccb.content.define_item {
    id = "obsidian_rock",
    copy_from = "rock",
    name = ccb.content.plural_text("chunk of obsidian", "chunks of obsidian"),
    color = "black_red",
    description = ccb.content.text("A chunk of obsidian, smashed from a larger rock vein.  It has several wickedly sharp edges and could probably be formed into a weapon with some work."),
    symbol = "*",
    category = "spare_parts",
    materials = { "obsidian" },
    flags = { "TRADER_AVOID", "NPC_THROWN", "SLING_PROJECTILE" },
    mass = "637 g",
    volume = "250 ml",
    length = "8 cm",
    melee_damage = { stab = 3 },
    ammunition = {
        type = "rock",
        damage = { type = "stab", amount = 5 },
        range = 10,
        dispersion = 14,
        loudness = 0,
        effects = { "NON_FOULING", "RECOVER_60" },
    },
}
