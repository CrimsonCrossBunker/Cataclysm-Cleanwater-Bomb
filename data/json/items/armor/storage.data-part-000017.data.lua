local ccb = require("ccb")

ccb.content.define_item {
    id = "plastic_shopping_bag",
    name = ccb.content.text("plastic shopping bag"),
    description = ccb.content.text("A bag used to carry groceries home."),
    ascii_picture = "bag_plastic",
    category = "container",
    mass = "2 g",
    volume = "30 ml",
    price = "1 cent",
    survival_price = "10 cent",
    materials = { "plastic" },
    symbol = "[",
    color = "white",
    pockets = { { kind = "CONTAINER", capacity = "5 L", mass_limit = "3 kg", moves = 150 } },
    flags = { "OVERSIZE", "BELTED", "RESTRICT_HANDS", "WATER_FRIENDLY" },
    armor = {
        sided = true,
        portions = {
            {
                covers = { "arm_l", "arm_r" },
                coverage = 4,
                encumbrance = 1,
                volume_encumbrance = 0.7,
            },
            {
                covers = { "hand_l", "hand_r" },
                coverage = 4,
                encumbrance = 1,
                volume_encumbrance = 0.7,
            },
        },
        thickness = 0.01,
    },
}

ccb.content.define_item {
    id = "purse",
    name = ccb.content.text("purse"),
    description = ccb.content.text("A fancy leather purse from a well-known designer.  A bit cumbersome to wear, but provides some storage."),
    mass = "297 g",
    volume = "1 L",
    price = "75 USD",
    survival_price = "1 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "5 L",
            mass_limit = "10 kg",
            max_item_length = "30 cm",
            moves = 150,
        },
    },
    flags = { "BELTED", "WATER_FRIENDLY", "OVERSIZE" },
    armor = {
        thickness = 1,
        portions = {
            {
                encumbrance = 2,
                volume_encumbrance = 0.25,
                coverage = 25,
                covers = { "torso" },
                subparts = { "torso_hanging_front" },
            },
        },
    },
}

ccb.content.define_item {
    id = "ragpouch",
    name = ccb.content.plural_text("pouch", "pouches"),
    description = ccb.content.text("A makeshift bag, cobbled together from rags.  Really gets in the way, but provides a decent amount of storage."),
    mass = "35 g",
    volume = "500 ml",
    price = "10 USD",
    survival_price = "1 USD",
    materials = { "cotton" },
    symbol = "[",
    color = "light_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "2250 ml",
            mass_limit = "2 kg",
            max_item_length = "30 cm",
            moves = 200,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = {
        thickness = 0.2,
        portions = {
            {
                encumbrance = 5,
                volume_encumbrance = 0.3,
                coverage = 100,
                covers = { "torso" },
                subparts = { "torso_waist" },
            },
        },
    },
}
