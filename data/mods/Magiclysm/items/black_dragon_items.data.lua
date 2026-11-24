local ccb = require("ccb")

-- Tanning 1 raw hide can get 20 scales as byproduct, those scales should be on the hide before tanning
ccb.content.define_item {
    id = "black_dragon_hide_raw",
    category = "spare_parts",
    name = ccb.content.plural_text("raw black dragon hide", "raw black dragon hide"),
    mass = "10100 g",
    color = "black_white",
    symbol = ",",
    description = ccb.content.text("A carefully folded raw hide harvested from a black dragon.  It is a large enough piece that it is workable to make armor, and with enough scales you could make scale mail."),
    price = "500 USD",
    materials = {
        { id = "black_dragon_hide", portions = 25 },
        { id = "black_dragon_scales", portions = 50 },
        { id = "flesh", portions = 25 },
    },
    flags = { "NO_SALVAGE", "TRADER_AVOID" },
    volume = "4 L",
    comestible = { shelf_life = "3 day", kind = "FOOD", vitamins = { { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "boots_black_dragon_scale",
    category = "armor",
    name = ccb.content.plural_text("pair of black dragonscale boots", "pairs of black dragonscale boots"),
    description = ccb.content.text("Boots made of black incredibly durable dragonscale.  Very protective, and surprisingly light."),
    mass = "945 g",
    volume = "3250 ml",
    price = "750 USD",
    materials = { "black_dragon_hide", "black_dragon_scales" },
    symbol = "[",
    color = "black_white",
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    melee_damage = { bash = 7 },
    armor = {
        warmth = 25,
        thickness = 5,
        environmental_protection = 3,
        portions = { { encumbrance = 30, coverage = 100, covers = { "foot_l", "foot_r" } } },
    },
}

ccb.content.define_item {
    id = "boots_black_dragon_hide",
    category = "armor",
    name = ccb.content.plural_text("pair of black dragonhide boots", "pairs of black dragonhide boots"),
    description = ccb.content.text("Boots made of very durable black dragonhide.  Very protective, and surprisingly light."),
    mass = "655 g",
    volume = "3250 ml",
    price = "500 USD",
    materials = { "black_dragon_hide" },
    symbol = "[",
    color = "black_white",
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    melee_damage = { bash = 7 },
    armor = {
        warmth = 20,
        thickness = 3,
        environmental_protection = 3,
        portions = { { encumbrance = 20, coverage = 100, covers = { "foot_l", "foot_r" } } },
    },
}

ccb.content.define_item {
    id = "helmet_black_dragon_scale",
    category = "armor",
    name = ccb.content.plural_text("black dragonscale helmet", "black dragonscale helmets"),
    description = ccb.content.text("A helmet made from black incredibly durable dragonscale, held together with black dragonhide.  It comes equipped with a full face visor with only a thin slit to see out of.  Activate to raise the visor."),
    mass = "856 g",
    volume = "2500 ml",
    price = "580 USD",
    accuracy = -1,
    materials = { "black_dragon_hide", "black_dragon_scales" },
    symbol = "[",
    color = "black_white",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "WATERPROOF", "STURDY", "SUN_GLASSES" },
    melee_damage = { bash = 10 },
    armor = {
        portions = {
            { covers = { "head" }, coverage = 100, encumbrance = 32 },
            { covers = { "eyes", "mouth" }, coverage = 100, encumbrance = 20 },
        },
        warmth = 25,
        thickness = 5,
        environmental_protection = 3,
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Raise visor"),
            target = "helmet_black_dragon_scale_raised",
            message = ccb.content.text("You raise the helm's visor."),
        },
    },
}

ccb.content.define_item {
    id = "helmet_black_dragon_scale_raised",
    category = "armor",
    copy_from = "helmet_black_dragon_scale",
    name = ccb.content.plural_text("black dragonscale helmet (raised visor)", "black dragonscale helmets (raised visor)"),
    description = ccb.content.text("A helmet made from incredibly durable black dragonscale, held together with black dragonhide.  The visor is raised."),
    symbol = "[",
    inheritance = { remove = { flags = { "SUN_GLASSES" } } },
    armor = {
        portions = { { covers = { "head" }, coverage = 100, encumbrance = 32 } },
        thickness = 5,
        environmental_protection = 3,
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Lower visor"),
            target = "helmet_black_dragon_scale",
            message = ccb.content.text("You lower the helm's visor."),
        },
    },
}

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

ccb.content.define_item {
    id = "helmet_xlblack_dragon_scale",
    copy_from = "helmet_black_dragon_scale",
    name = ccb.content.plural_text("black dragonscale helmet", "black dragonscale helmets"),
    description = ccb.content.text("A massive helmet made from incredibly durable black dragonscale, held together with black dragonhide.  It comes equipped with a full face visor you can raise and is large enough to fit even the strangest of heads."),
    mass = "1256 g",
    volume = "4500 ml",
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
    armor = {
        thickness = 5,
        environmental_protection = 3,
        portions = {
            { covers = { "head" }, coverage = 100, encumbrance = 42 },
            { covers = { "eyes", "mouth" }, coverage = 100, encumbrance = 20 },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Raise visor"),
            target = "helmet_xlblack_dragon_scale_raised",
            message = ccb.content.text("You raise the helm's visor."),
        },
    },
}

ccb.content.define_item {
    id = "helmet_xlblack_dragon_scale_raised",
    copy_from = "helmet_black_dragon_scale_raised",
    name = ccb.content.plural_text("black dragonscale helmet (raised visor)", "black dragonscale helmets (raised visor)"),
    description = ccb.content.text("A massive helmet made from incredibly durable black dragonscale, held together with black dragonhide.  It is large enough to fit even the strangest of heads.  The visor is raised"),
    mass = "1256 g",
    volume = "4500 ml",
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
    armor = {
        thickness = 5,
        environmental_protection = 3,
        portions = { { covers = { "head" }, coverage = 100, encumbrance = 42 } },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Lower visor"),
            target = "helmet_xlblack_dragon_scale",
            message = ccb.content.text("You lower the helm's visor."),
        },
    },
}

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
