local ccb = require("ccb")

ccb.content.define_item {
    id = "entry_suit",
    category = "armor",
    name = ccb.content.text("entry suit"),
    description = ccb.content.text("A flame-resistant whole-body garment worn by firefighters as protection against extreme heat.  It requires a separate gas mask for full protection against smoke."),
    mass = "2900 g",
    volume = "6 L",
    price = "2 kUSD 405 USD",
    survival_price = "25 USD",
    materials = { "nomex", "kevlar" },
    symbol = "[",
    looks_like = "jumpsuit",
    color = "light_gray",
    length = "30 cm",
    flags = { "VARSIZE", "WATERPROOF", "RAINPROOF", "GAS_PROOF", "STURDY", "OUTER" },
    armor = {
        warmth = 30,
        thickness = 5,
        environmental_protection = 20,
        portions = {
            {
                encumbrance = 50,
                coverage = 100,
                covers = {
                    "head",
                    "torso",
                    "arm_l",
                    "arm_r",
                    "hand_l",
                    "hand_r",
                    "leg_l",
                    "leg_r",
                    "foot_l",
                    "foot_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_entry_suit",
    name = ccb.content.text("entry suit"),
    copy_from = "entry_suit",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "entry_suit_xs",
    copy_from = "entry_suit",
    looks_like = "entry_suit",
    name = ccb.content.text("entry suit"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- real bite suits are made with linen, but we don't have linen, so denim is the closest approx. (canvas is always waterproofed and these suits are not)
-- skip second entry for arm encumbrance
ccb.content.define_item {
    id = "bite_suit",
    category = "armor",
    name = ccb.content.text("canine bite suit"),
    description = ccb.content.text("Designed to stop the injuries of dog bites, this thick, one piece suit is often used in the rehabilitation of abused animals and in training dogs by the police and military.  A base layer of aramid fabric has had strips of soft body armor sewn into it to mimic quilting, and to soften the blunt of animals jumping, slashing, or pouncing on the wearer."),
    mass = "11556 g",
    volume = "8255 ml",
    price = "200 USD",
    survival_price = "100 USD",
    materials = { "kevlar", "denim" },
    symbol = "[",
    looks_like = "coat_winter",
    color = "light_gray",
    flags = { "VARSIZE", "STURDY", "NONCONDUCTIVE" },
    armor = {
        warmth = 50,
        thickness = 4,
        valid_mods = { "steel_padded" },
        portions = {
            {
                materials = {
                    { id = "kevlar", coverage = 95, thickness = 4 },
                    { id = "denim", coverage = 100, thickness = 3 },
                },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 30,
            },
            {
                materials = {
                    { id = "kevlar", coverage = 100, thickness = 4 },
                    { id = "denim", coverage = 100, thickness = 3 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_lower_l", "arm_upper_r", "arm_lower_r" },
                coverage = 100,
                encumbrance = 30,
            },
            {
                materials = {
                    { id = "kevlar", coverage = 70, thickness = 4 },
                    { id = "denim", coverage = 100, thickness = 3 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_elbow_l", "arm_shoulder_l", "arm_elbow_r", "arm_shoulder_r" },
                coverage = 100,
                encumbrance = 0,
            },
            {
                materials = {
                    { id = "kevlar", coverage = 95, thickness = 4 },
                    { id = "kevlar", coverage = 100, thickness = 3 },
                },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 30,
            },
        },
    },
}

-- Should be substantially more difficult to repair than ordinary plastic - ch_steel is difficulty 7
ccb.content.define_item {
    id = "hazmat_suit",
    repair_like = "ch_steel_lump",
    category = "armor",
    name = ccb.content.text("hazmat suit"),
    description = ccb.content.text("An impermeable whole-body garment worn as protection against hazardous materials.  Restrictive and fragile, wearing it will provide complete protection against ambient radiation.  It requires a separate gas mask for full protection."),
    mass = "5000 g",
    volume = "17 L",
    price = "1 kUSD 175 USD",
    survival_price = "15 USD",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "beekeeping_suit",
    color = "yellow",
    flags = {
        "VARSIZE",
        "WATERPROOF",
        "RAINPROOF",
        "GAS_PROOF",
        "RAD_PROOF",
        "ELECTRIC_IMMUNE",
        "OUTER",
        "SOFT",
    },
    armor = {
        warmth = 40,
        thickness = 2,
        environmental_protection = 20,
        portions = {
            {
                encumbrance = 37,
                coverage = 100,
                covers = {
                    "head",
                    "torso",
                    "arm_l",
                    "arm_r",
                    "hand_l",
                    "hand_r",
                    "leg_l",
                    "leg_r",
                    "foot_l",
                    "foot_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "nomex_suit",
    name = ccb.content.text("flame-resistant suit"),
    description = ccb.content.text("A snug body suit made from thin and lightweight Nomex fire-resistant fabric.  Tough yet breathable, it is light and comfortable to wear under clothing."),
    mass = "688 g",
    volume = "1500 ml",
    price = "130 USD",
    survival_price = "7 USD 50 cent",
    materials = { "nomex" },
    symbol = "[",
    looks_like = "jumpsuit",
    color = "light_gray",
    flags = { "VARSIZE", "WATER_FRIENDLY", "SKINTIGHT", "STURDY" },
    armor = {
        warmth = 5,
        thickness = 2,
        environmental_protection = 2,
        portions = {
            {
                encumbrance = 6,
                coverage = 100,
                covers = { "leg_l", "leg_r", "torso", "arm_l", "arm_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_nomex_suit",
    name = ccb.content.text("flame-resistant suit"),
    copy_from = "nomex_suit",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "nomex_suit_xs",
    copy_from = "nomex_suit",
    looks_like = "nomex_suit",
    name = ccb.content.text("flame-resistant suit"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}
