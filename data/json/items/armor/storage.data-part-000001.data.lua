local ccb = require("ccb")

ccb.content.define_item {
    id = "backpack_giant",
    name = ccb.content.text("giant novelty backpack"),
    description = ccb.content.text("A huge fabric backpack made mostly as a joke before the Cataclysm.  Now, it's still rather silly, but it can store a lot of stuff."),
    mass = "1200 g",
    volume = "9186 ml",
    price = "45 USD",
    survival_price = "7 USD 50 cent",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "backpack",
    color = "green",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "80 L",
            mass_limit = "40 kg",
            max_item_length = "96 cm",
            magazine_well = "8750 ml",
            moves = 300,
        },
    },
    flags = { "BELTED" },
    armor = {
        warmth = 5,
        thickness = 2,
        portions = {
            {
                encumbrance = 20,
                volume_encumbrance = 0.22,
                coverage = 100,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
            {
                encumbrance = { 10, 10 },
                coverage = 60,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_r", "leg_upper_l" },
            },
        },
    },
}

-- tucked against back
ccb.content.define_item {
    id = "backpack_leather",
    name = ccb.content.text("leather backpack"),
    description = ccb.content.text("A small leather backpack.  Good storage for a little encumbrance."),
    mass = "818 g",
    volume = "2 L",
    price = "119 USD",
    survival_price = "5 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "backpack",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "25 L",
            mass_limit = "30 kg",
            max_item_length = "40 cm",
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
        warmth = 9,
        thickness = 3,
        portions = {
            {
                encumbrance = 4,
                volume_encumbrance = 0.2,
                coverage = 60,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

-- It's modeled as our normal backpack but made of 16.5 oz denim.
-- water bottle pocket
-- tucked against back
ccb.content.define_item {
    id = "backpack_denim",
    name = ccb.content.text("denim backpack"),
    description = ccb.content.text("A denim backpack.  Solid storage for few encumbrance.  The texture feels nice."),
    mass = "560 g",
    volume = "2 L",
    price = "50 USD",
    survival_price = "3 USD",
    materials = { "denim" },
    symbol = "[",
    looks_like = "backpack",
    color = "light_blue",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "25 L",
            mass_limit = "30 kg",
            max_item_length = "40 cm",
            moves = 300,
        },
        {
            kind = "CONTAINER",
            holster = true,
            capacity = "510 ml",
            mass_limit = "1 kg",
            max_item_length = "24 cm",
            min_item_length = "18 cm",
            moves = 80,
            description = ccb.content.text("Small pocket for a water bottle."),
            ripoff = 2,
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
    flags = { "BELTED" },
    armor = {
        warmth = 6,
        thickness = 1.1,
        portions = {
            {
                encumbrance = { 3, 25 },
                coverage = 60,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}
