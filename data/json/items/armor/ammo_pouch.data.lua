local ccb = require("ccb")

ccb.content.define_item {
    id = "belt_loop_small",
    name = ccb.content.text("small belt loop"),
    description = ccb.content.text("A MOLLE-compatible loop for attaching small tools to a load-bearing vest."),
    mass = "25 g",
    volume = "25 ml",
    price = "10 USD",
    survival_price = "1 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "leather_pouch",
    color = "brown",
    pockets = {
        {
            holster = true,
            capacity = "500 ml",
            mass_limit = "500 g",
            max_item_length = "30 cm",
            moves = 50,
            allowed_flags = { "BELT_CLIP" },
            volume_encumbrance = 0.3,
            transparent = true,
        },
    },
    flags = { "CANT_WEAR", "WATER_FRIENDLY", "PALS_SMALL" },
    armor = { thickness = 1, portions = { { encumbrance = 0, coverage = 0, covers = { "torso" } } } },
}

ccb.content.define_item {
    id = "belt_loop_medium",
    name = ccb.content.text("medium belt loop"),
    description = ccb.content.text("A MOLLE-compatible loop for attaching tools and some weapons to a load-bearing vest."),
    mass = "50 g",
    volume = "50 ml",
    price = "10 USD",
    survival_price = "1 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "leather_pouch",
    color = "brown",
    pockets = {
        {
            holster = true,
            capacity = "1500 ml",
            mass_limit = "1500 g",
            max_item_length = "60 cm",
            moves = 50,
            allowed_flags = { "BELT_CLIP" },
            volume_encumbrance = 0.3,
            transparent = true,
        },
    },
    flags = { "CANT_WEAR", "WATER_FRIENDLY", "PALS_MEDIUM" },
    armor = { thickness = 1, portions = { { encumbrance = 0, coverage = 0, covers = { "torso" } } } },
}

ccb.content.define_item {
    id = "belt_loop_large",
    name = ccb.content.text("large belt loop"),
    description = ccb.content.text("A MOLLE-compatible loop for attaching large tools and weapons to a load-bearing vest."),
    mass = "100 g",
    volume = "100 ml",
    price = "10 USD",
    survival_price = "1 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "leather_pouch",
    color = "brown",
    pockets = {
        {
            holster = true,
            capacity = "2000 ml",
            mass_limit = "6000 g",
            max_item_length = "100 cm",
            moves = 50,
            allowed_flags = { "BELT_CLIP" },
            volume_encumbrance = 0.3,
            transparent = true,
        },
    },
    flags = { "CANT_WEAR", "WATER_FRIENDLY", "PALS_LARGE" },
    armor = { thickness = 1, portions = { { encumbrance = 0, coverage = 0, covers = { "torso" } } } },
}

--  stats taken from: https://www.varusteleka.com/en/product/us-molle-ii-sustainment-pouch-surplus/63566
ccb.content.define_item {
    id = "sustainment_pouch",
    name = ccb.content.plural_text("sustainment pouch", "sustainment pouches"),
    description = ccb.content.text("A large, drawstring & buckle pouch originally designed to hold 3 MREs, and part of the official MOLLE II rucksack system.  Has MOLLE straps for attaching to a belt, vest, or rucksack."),
    mass = "230 g",
    volume = "300 ml",
    price = "30 USD",
    survival_price = "2 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "holster",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "7000 ml",
            mass_limit = "10000 g",
            max_item_length = "30 cm",
            moves = 80,
            volume_encumbrance = 0.3,
        },
    },
    flags = { "BELTED", "WATER_FRIENDLY", "OVERSIZE", "PALS_MEDIUM" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 1, coverage = 20, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}
