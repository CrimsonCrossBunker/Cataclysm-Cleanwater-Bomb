local ccb = require("ccb")

ccb.content.define_item {
    id = "ankle_wallet_pouch",
    name = ccb.content.plural_text("ankle wallet pouch", "ankle wallet pouches"),
    description = ccb.content.text("A small concealed wallet pouch worn on the ankle.  If you strap it under your clothes, it can help you keep your wallet hidden and safe."),
    mass = "60 g",
    volume = "150 ml",
    price = "10 cent",
    survival_price = "10 cent",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "legpouch",
    color = "light_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "600 g",
            max_item_length = "9 cm",
            moves = 150,
        },
    },
    flags = { "BELTED", "OVERSIZE", "ALLOWS_NATURAL_ATTACKS", "WATER_FRIENDLY" },
    armor = {
        sided = true,
        thickness = 0.1,
        portions = {
            {
                encumbrance = 1,
                coverage = 25,
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
            },
        },
    },
}

-- tucked against back
ccb.content.define_item {
    id = "makeshift_knapsack",
    name = ccb.content.text("makeshift knapsack"),
    description = ccb.content.text("A pair of pants with the bottom ends tied with string, and then passed through the belt loops so the knapsack can be carried on the back."),
    mass = "560 g",
    volume = "2 L",
    price = "10 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "light_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "5 L",
            mass_limit = "10 kg",
            max_item_length = "70 cm",
            moves = 300,
        },
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "5 L",
            mass_limit = "4 kg",
            max_item_length = "150 cm",
            min_item_length = "60 cm",
            moves = 200,
            extra_encumbrance = 10,
            description = ccb.content.text("Tucked between your back and the backpack."),
            ripoff = 3,
            transparent = true,
        },
    },
    flags = { "BELTED", "WATER_FRIENDLY" },
    armor = {
        warmth = 5,
        thickness = 0.2,
        portions = {
            {
                encumbrance = { 2, 9 },
                coverage = 60,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

ccb.content.define_item {
    id = "makeshift_sling",
    name = ccb.content.text("makeshift sling"),
    description = ccb.content.text("A large sheet tied into a crude, over-the-shoulder sling."),
    mass = "771 g",
    volume = "5 L",
    price = "1 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "ragpouch",
    color = "light_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "10 L",
            mass_limit = "15 kg",
            max_item_length = "50 cm",
            magazine_well = "2 L",
            moves = 300,
        },
    },
    flags = { "OVERSIZE", "BELTED", "WATER_FRIENDLY" },
    armor = {
        warmth = 10,
        thickness = 1,
        portions = {
            {
                encumbrance = 4,
                volume_encumbrance = 0.4,
                coverage = 80,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}
