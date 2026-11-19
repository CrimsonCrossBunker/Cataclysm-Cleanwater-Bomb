local ccb = require("ccb")

ccb.content.define_item {
    id = "helmet_xlblack_dragon_hide",
    copy_from = "helmet_black_dragon_hide",
    name = ccb.content.text("black dragonhide helmet"),
    description = ccb.content.text("A massive helmet made from very durable black dragonhide.  It protects your head well, and doesn't cover your face, but is large enough to fit even the strangest of heads."),
    mass = "815 g",
    volume = "4500 ml",
    armor = {
        thickness = 3,
        environmental_protection = 1,
        portions = { { encumbrance = 26, coverage = 100, covers = { "head" } } },
    },
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "suit_xlblack_dragon_scale",
    copy_from = "suit_black_dragon_scale",
    name = ccb.content.text("black dragonscale armor"),
    description = ccb.content.text("A massive full suit of incredibly durable black dragon scale mail.  It comes with all the accoutrements that cover your torso, legs, and arms; sized to fit even the strangest of bodies."),
    mass = "6250 g",
    volume = "18 L",
    armor = {
        thickness = 5,
        environmental_protection = 3,
        portions = {
            {
                encumbrance = 35,
                coverage = 100,
                covers = { "leg_l", "leg_r", "torso", "arm_l", "arm_r" },
            },
        },
    },
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "suit_xlblack_dragon_hide",
    copy_from = "suit_black_dragon_hide",
    name = ccb.content.text("black dragonhide armor"),
    description = ccb.content.text("A massive full suit of very durable black dragonhide armor.  It comes with all the accoutrements that cover your torso, legs, and arms; sized to fit even the strangest of bodies."),
    mass = "5500 g",
    volume = "18 L",
    armor = {
        thickness = 3,
        environmental_protection = 2,
        portions = {
            {
                encumbrance = 26,
                coverage = 100,
                covers = { "leg_l", "leg_r", "torso", "arm_l", "arm_r" },
            },
        },
    },
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

-- After adding more dragons, maybe make it more generic
ccb.content.define_item {
    id = "backpack_black_dragon_hide",
    name = ccb.content.text("dragonhide backpack"),
    description = ccb.content.text("A custom-built backpack.  Made of very durable dragon leather and carefully crafted to hold as much stuff as possible."),
    mass = "900 g",
    volume = "5250 ml",
    price = "2 kUSD 400 USD",
    survival_price = "32 USD 50 cent",
    materials = { "black_dragon_hide" },
    symbol = "[",
    looks_like = "backpack",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "29 L",
            mass_limit = "45 kg",
            max_item_length = "48 cm",
            magazine_well = "5 L",
            moves = 300,
        },
    },
    flags = { "WATER_FRIENDLY", "STURDY", "BELTED", "WATERPROOF" },
    armor = {
        warmth = 8,
        thickness = 3,
        environmental_protection = 3,
        portions = { { encumbrance = { 5, 30 }, coverage = 40, covers = { "torso" } } },
    },
}

ccb.content.define_item {
    id = "backpack_xl_black_dragon_hide",
    copy_from = "backpack_black_dragon_hide",
    name = ccb.content.text("dragonhide backpack"),
    mass = "1200 g",
    volume = "6250 ml",
    price = "2 kUSD 800 USD",
    survival_price = "34 USD 50 cent",
    symbol = "[",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "38 L",
            mass_limit = "52 kg",
            max_item_length = "58 cm",
            magazine_well = "5 L",
            moves = 330,
        },
    },
    armor = {
        warmth = 9,
        thickness = 4,
        environmental_protection = 3,
        portions = { { encumbrance = { 8, 40 }, coverage = 40, covers = { "torso" } } },
    },
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}
