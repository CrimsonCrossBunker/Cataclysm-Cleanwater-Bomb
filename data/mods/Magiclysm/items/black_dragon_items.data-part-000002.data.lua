local ccb = require("ccb")

ccb.content.define_item {
    id = "helmet_black_dragon_hide",
    category = "armor",
    name = ccb.content.text("black dragonhide helmet"),
    description = ccb.content.text("A helmet made from very durable black dragonhide.  It protects your head well, but doesn't cover your face."),
    mass = "585 g",
    volume = "2 L",
    price = "580 USD",
    accuracy = -1,
    materials = { "black_dragon_hide" },
    symbol = "[",
    color = "black_white",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    melee_damage = { bash = 10 },
    armor = {
        warmth = 15,
        thickness = 3,
        environmental_protection = 1,
        portions = { { encumbrance = 20, coverage = 100, covers = { "head" } } },
    },
}

ccb.content.define_item {
    id = "suit_black_dragon_scale",
    category = "armor",
    name = ccb.content.text("black dragonscale armor"),
    description = ccb.content.text("A full suit of incredibly durable black dragon scale mail.  It comes with all the accoutrements that cover your torso, legs, and arms, with the benefit of being very light and flexible."),
    mass = "4250 g",
    volume = "12 L",
    price = "20 kUSD",
    accuracy = -3,
    materials = { "black_dragon_hide", "black_dragon_scales" },
    symbol = "[",
    color = "black_white",
    flags = { "VARSIZE", "WATERPROOF", "RAINPROOF", "STURDY", "OUTER" },
    melee_damage = { bash = 6 },
    armor = {
        warmth = 25,
        thickness = 5,
        environmental_protection = 3,
        portions = {
            {
                encumbrance = 25,
                coverage = 100,
                covers = { "leg_l", "leg_r", "torso", "arm_l", "arm_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "suit_black_dragon_hide",
    category = "armor",
    name = ccb.content.text("black dragonhide armor"),
    description = ccb.content.text("A full suit of very durable black dragonhide armor.  It comes with all the accoutrements that cover your torso, legs, and arms, with the benefit of being very light and flexible."),
    mass = "3 kg",
    volume = "11 L",
    price = "20 kUSD",
    accuracy = -3,
    materials = { "black_dragon_hide" },
    symbol = "[",
    color = "black_white",
    flags = { "VARSIZE", "WATERPROOF", "RAINPROOF", "STURDY", "OUTER" },
    melee_damage = { bash = 6 },
    armor = {
        warmth = 15,
        thickness = 3,
        environmental_protection = 2,
        portions = {
            {
                encumbrance = 18,
                coverage = 100,
                covers = { "leg_l", "leg_r", "torso", "arm_l", "arm_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "gauntlets_black_dragon_scale",
    category = "armor",
    name = ccb.content.plural_text("pair of black dragonscale gauntlets", "pairs of black dragonscale gauntlets"),
    description = ccb.content.text("A pair of heavy-duty gauntlets made of incredibly durable black dragonscale that covers your hands."),
    mass = "380 g",
    volume = "1 L",
    price = "1 kUSD 800 USD",
    materials = { "black_dragon_hide", "black_dragon_scales" },
    symbol = "[",
    color = "black_white",
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    armor = {
        warmth = 20,
        thickness = 4,
        environmental_protection = 3,
        portions = { { encumbrance = 20, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "gloves_black_dragon_hide",
    category = "armor",
    name = ccb.content.plural_text("pair of black dragonhide gloves", "pairs of black dragonhide gloves"),
    description = ccb.content.text("A pair of gloves made of very durable black dragonhide, modified to be easy to wear while providing maximum protection under extreme conditions."),
    mass = "230 g",
    volume = "750 ml",
    price = "1 kUSD 800 USD",
    materials = { "black_dragon_hide" },
    symbol = "[",
    color = "black_white",
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    armor = {
        warmth = 13,
        thickness = 2,
        environmental_protection = 1,
        portions = { { encumbrance = 8, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "boots_xlblack_dragon_scale",
    copy_from = "boots_black_dragon_scale",
    name = ccb.content.plural_text("pair of black dragonscale boots", "pairs of black dragonscale boots"),
    description = ccb.content.text("Massive boots made of incredibly durable black dragonscale, modified to fit even the strangest of bodies.  Very protective, and surprisingly light."),
    mass = "1545 g",
    volume = "6250 ml",
    armor = {
        thickness = 5,
        environmental_protection = 3,
        portions = { { encumbrance = 40, coverage = 100, covers = { "foot_l", "foot_r" } } },
    },
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "boots_xlblack_dragon_hide",
    copy_from = "boots_black_dragon_hide",
    name = ccb.content.plural_text("pair of black dragonhide boots", "pairs of black dragonhide boots"),
    description = ccb.content.text("Massive boots made of very durable black dragonhide, modified to fit even the strangest of bodies.  Very protective, and surprisingly light."),
    mass = "955 g",
    volume = "6250 ml",
    armor = {
        thickness = 3,
        environmental_protection = 3,
        portions = { { encumbrance = 25, coverage = 100, covers = { "foot_l", "foot_r" } } },
    },
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "gauntlets_xlblack_dragon_scale",
    copy_from = "gauntlets_black_dragon_scale",
    name = ccb.content.plural_text("pair of black dragonscale gauntlets", "pairs of black dragonscale gauntlets"),
    description = ccb.content.text("A pair of heavy-duty gauntlets made of incredibly durable black dragonscale that covers your hands, or whatever you use as hands."),
    mass = "680 g",
    volume = "2 L",
    armor = {
        thickness = 4,
        environmental_protection = 3,
        portions = { { encumbrance = 30, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "gloves_xlblack_dragon_hide",
    copy_from = "gloves_black_dragon_hide",
    name = ccb.content.plural_text("pair of black dragonhide gloves", "pairs of black dragonhide gloves"),
    description = ccb.content.text("A pair of gloves made of very durable black dragonhide, modified to be easy to wear while providing maximum protection under extreme conditions.  Sized to fit even the strangest of anatomy."),
    mass = "430 g",
    volume = "1500 ml",
    armor = {
        thickness = 2,
        environmental_protection = 1,
        portions = { { encumbrance = 18, coverage = 100, covers = { "hand_l", "hand_r" } } },
    },
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}
