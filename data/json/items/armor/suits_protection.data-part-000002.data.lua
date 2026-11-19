local ccb = require("ccb")

ccb.content.define_item {
    id = "armor_samurai",
    category = "armor",
    name = ccb.content.plural_text("ō-yoroi", "ō-yoroi"),
    description = ccb.content.text("An ornamental suit of Japanese samurai armor."),
    mass = "9220 g",
    volume = "11500 ml",
    price = "900 USD",
    survival_price = "80 USD",
    materials = { "iron", "leather" },
    symbol = "[",
    looks_like = "armor_lightplate",
    color = "dark_gray",
    length = "60 cm",
    flags = { "VARSIZE", "STURDY", "OUTER", "BLOCK_WHILE_WORN" },
    melee_damage = { bash = 8 },
    armor = {
        warmth = 25,
        thickness = 4,
        portions = {
            {
                encumbrance = 15,
                coverage = 85,
                covers = { "torso", "leg_l", "leg_r", "arm_l", "arm_r", "hand_l", "hand_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "armor_scrapsuit",
    category = "armor",
    name = ccb.content.text("scrap suit"),
    description = ccb.content.text("A suit of armor made from scraps of metal secured by simple strings to cloth wraps; the loose collection of plates provides decent but uncomfortable protection."),
    mass = "9534 g",
    volume = "15500 ml",
    price = "600 USD",
    survival_price = "2 USD 50 cent",
    accuracy = { grip = "bad", length = "hand", surface = "any", balance = "uneven" },
    materials = { "budget_steel", "cotton" },
    symbol = "[",
    looks_like = "armor_lightplate",
    color = "light_gray",
    length = "40 cm",
    flags = { "OUTER", "BLOCK_WHILE_WORN" },
    melee_damage = { bash = 6, cut = 3 },
    armor = {
        warmth = 10,
        portions = {
            {
                materials = {
                    { id = "budget_steel", coverage = 75, thickness = 2 },
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                },
                covers = { "torso" },
                coverage = 95,
                encumbrance = 18,
            },
            {
                materials = {
                    { id = "budget_steel", coverage = 75, thickness = 1.5 },
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                },
                covers = { "arm_l", "arm_r" },
                coverage = 95,
                encumbrance = 15,
            },
            {
                materials = {
                    { id = "budget_steel", coverage = 75, thickness = 1.5 },
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 95,
                encumbrance = 15,
            },
        },
    },
}

ccb.content.define_item {
    id = "armor_xl_scrapsuit",
    copy_from = "armor_scrapsuit",
    name = ccb.content.text("scrap suit"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "armor_xs_scrapsuit",
    copy_from = "armor_scrapsuit",
    name = ccb.content.text("scrap suit"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "armor_tiresuit",
    category = "armor",
    name = ccb.content.text("tire suit"),
    description = ccb.content.text("A suit of armor made from thick chunks of rubber tire secured by simple strings; the loose collection of rubber plates provides decent but not the most convenient protection."),
    mass = "14400 g",
    volume = "15500 ml",
    price = "500 USD",
    survival_price = "2 USD",
    materials = { "rubber" },
    symbol = "[",
    looks_like = "armor_scrapsuit",
    color = "light_gray",
    length = "40 cm",
    flags = { "OUTER", "NONCONDUCTIVE", "BLOCK_WHILE_WORN" },
    armor = {
        warmth = 10,
        thickness = 4,
        portions = {
            {
                encumbrance = 18,
                coverage = 80,
                covers = { "torso", "leg_l", "leg_r", "arm_l", "arm_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "beekeeping_suit",
    name = ccb.content.text("beekeeping suit"),
    description = ccb.content.text("A white suit commonly worn by professional beekeepers with straps on your ankles and wrists to prevent bees from flying in.  It's not a very tough fabric, but it's lightweight and has plenty of storage thanks to a chest pocket."),
    mass = "1587 g",
    volume = "3500 ml",
    price = "120 USD",
    survival_price = "1 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "hazmat_suit",
    color = "white",
    length = "12 cm",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1600 ml",
            mass_limit = "3 kg",
            max_item_length = "18 cm",
            moves = 120,
        },
    },
    flags = { "VARSIZE", "OUTER" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 100, encumbrance = { 10, 15 } },
            { covers = { "leg_l", "leg_r" }, coverage = 100, encumbrance = { 10, 12 } },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 10, 10 } },
        },
        warmth = 25,
        thickness = 2,
        environmental_protection = 1,
    },
}
