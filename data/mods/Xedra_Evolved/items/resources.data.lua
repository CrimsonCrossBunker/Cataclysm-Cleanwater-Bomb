local ccb = require("ccb")

-- Density 2g/ml.
ccb.content.define_item {
    id = "scrap_moon_tears",
    category = "spare_parts",
    name = ccb.content.plural_text("scrap moon tears", "scraps of moon tears"),
    description = ccb.content.text("A bulky assortment of small bits of scrap moon tears, useful for forging into ingots and wire."),
    mass = "5 g",
    volume = "25 ml",
    price = "5 USD",
    survival_price = "10 cent",
    stack_size = 10,
    materials = { "moon_tears" },
    symbol = ",",
    color = "light_gray",
    ammunition = { count = 2, type = "components" },
}

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

ccb.content.define_item {
    id = "concentrated_underhill_essence",
    name = ccb.content.plural_text("concentrated underhill essence", "concentrated underhill essence"),
    description = ccb.content.text("The distilled essence of the Fae.  Can be used as part of rituals."),
    mass = "9 g",
    volume = "5 ml",
    price = "8 USD",
    survival_price = "10 cent",
    symbol = "~",
    color = "light_blue",
    phase = "liquid",
    looks_like = "fae_blood",
    flags = { "WATER_DISSOLVE" },
    comestible = { kind = "MED", servings = 1 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink some concentrated underhill essence."),
            vitamins = { { id = "underhill_essence", minimum = 100 } },
        },
    },
}

ccb.content.define_item {
    id = "water",
    copy_from = "water",
    name = ccb.content.plural_text("water", "water"),
    comestible = { kind = "DRINK", calories = 0 },
    inheritance = {
        add = {
            flags = { "NUTRIENT_OVERRIDE" },
            contamination = {
                { disease = "xe_hydrating_gout_incubation", probability = 0.1 },
            },
        },
    },
}

ccb.content.define_item {
    id = "water_murky",
    copy_from = "water_murky",
    name = ccb.content.plural_text("murky water", "murky water"),
    comestible = { kind = "DRINK", calories = 0 },
    inheritance = {
        add = {
            flags = { "NUTRIENT_OVERRIDE" },
            contamination = {
                { disease = "xe_hydrating_gout_incubation", probability = 10 },
            },
        },
    },
}
