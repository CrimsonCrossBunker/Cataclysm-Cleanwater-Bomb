local ccb = require("ccb")

ccb.content.define_item {
    id = "chainmail_junk_feet",
    category = "armor",
    name = ccb.content.plural_text("chainmail chausses (pair)", "chainmail chausses (pair)"),
    description = ccb.content.text("Customized chainmail chausses that cover the feet, like booties made of chainmail.  The metal shows signs of rust and corrosion."),
    mass = "1801 g",
    volume = "500 ml",
    price = "50 USD 12 cent",
    survival_price = "20 USD",
    materials = { "budget_steel_chain", "leather" },
    symbol = "[",
    color = "light_red",
    flags = { "VARSIZE", "STURDY", "OUTER" },
    armor = {
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.0 },
                    { id = "budget_steel_chain", coverage = 100, thickness = 1.2 },
                },
                encumbrance = 14,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "leather", coverage = 100, thickness = 4.0 } },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "lc_chainmail_feet",
    category = "armor",
    name = ccb.content.plural_text("mild steel chainmail chausses (pair)", "mild steel chainmail chausses (pair)"),
    description = ccb.content.text("Customized chainmail chausses that cover the feet, like booties made of chainmail."),
    mass = "1801 g",
    volume = "500 ml",
    price = "50 USD 12 cent",
    survival_price = "20 USD",
    materials = { "lc_steel_chain" },
    symbol = "[",
    color = "light_red",
    flags = { "VARSIZE", "STURDY", "OUTER" },
    armor = {
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.0 },
                    { id = "lc_steel_chain", coverage = 100, thickness = 1.2 },
                },
                encumbrance = 14,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "leather", coverage = 100, thickness = 4.0 } },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_chainmail_feet",
    copy_from = "lc_chainmail_feet",
    name = ccb.content.plural_text("mild steel chainmail chausses (pair)", "mild steel chainmail chausses (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 2, volume = 2 } },
}

ccb.content.define_item {
    id = "xs_lc_chainmail_feet",
    copy_from = "lc_chainmail_feet",
    name = ccb.content.plural_text("mild steel chainmail chausses (pair)", "mild steel chainmail chausses (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "mc_chainmail_feet",
    copy_from = "lc_chainmail_feet",
    name = ccb.content.plural_text("medium steel chainmail chausses (pair)", "medium steel chainmail chausses (pair)"),
    description = ccb.content.text("Customized chainmail chausses that cover the feet, like booties made of chainmail."),
    replace_materials = { lc_steel_chain = "mc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_chainmail_feet",
    copy_from = "mc_chainmail_feet",
    name = ccb.content.plural_text("medium steel chainmail chausses (pair)", "medium steel chainmail chausses (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 2, volume = 2 } },
}

ccb.content.define_item {
    id = "xs_mc_chainmail_feet",
    copy_from = "mc_chainmail_feet",
    looks_like = "chainmail_feet",
    name = ccb.content.plural_text("medium steel chainmail chausses (pair)", "medium steel chainmail chausses (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "hc_chainmail_feet",
    copy_from = "lc_chainmail_feet",
    name = ccb.content.plural_text("high steel chainmail chausses (pair)", "high steel chainmail chausses (pair)"),
    description = ccb.content.text("Customized chainmail chausses that cover the feet, like booties made of chainmail."),
    replace_materials = { lc_steel_chain = "hc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_chainmail_feet",
    copy_from = "hc_chainmail_feet",
    name = ccb.content.plural_text("high steel chainmail chausses (pair)", "high steel chainmail chausses (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 2, volume = 2 } },
}

ccb.content.define_item {
    id = "xs_hc_chainmail_feet",
    copy_from = "hc_chainmail_feet",
    name = ccb.content.plural_text("high steel chainmail chausses (pair)", "high steel chainmail chausses (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "ch_chainmail_feet",
    copy_from = "lc_chainmail_feet",
    name = ccb.content.plural_text("hardened steel chainmail chausses (pair)", "hardened steel chainmail chausses (pair)"),
    description = ccb.content.text("Customized chainmail chausses that cover the feet, like booties made of chainmail."),
    replace_materials = { lc_steel_chain = "ch_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_chainmail_feet",
    copy_from = "ch_chainmail_feet",
    name = ccb.content.plural_text("hardened steel chainmail chausses (pair)", "hardened steel chainmail chausses (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 2, volume = 2 } },
}

ccb.content.define_item {
    id = "xs_ch_chainmail_feet",
    copy_from = "ch_chainmail_feet",
    name = ccb.content.plural_text("hardened steel chainmail chausses (pair)", "hardened steel chainmail chausses (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "qt_chainmail_feet",
    copy_from = "lc_chainmail_feet",
    name = ccb.content.plural_text("tempered steel chainmail chausses (pair)", "tempered steel chainmail chausses (pair)"),
    description = ccb.content.text("Customized chainmail chausses that cover the feet, like booties made of chainmail."),
    replace_materials = { lc_steel_chain = "qt_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_chainmail_feet",
    copy_from = "qt_chainmail_feet",
    name = ccb.content.plural_text("tempered steel chainmail chausses (pair)", "tempered steel chainmail chausses (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 2, volume = 2 } },
}

ccb.content.define_item {
    id = "xs_qt_chainmail_feet",
    copy_from = "qt_chainmail_feet",
    name = ccb.content.plural_text("tempered steel chainmail chausses (pair)", "tempered steel chainmail chausses (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "nomex_socks",
    name = ccb.content.plural_text("flame-resistant socks (pair)", "flame-resistant socks (pair)"),
    description = ccb.content.text("A snug-fitting pair of stockings made from thin and lightweight Nomex fabric."),
    mass = "200 g",
    volume = "750 ml",
    price = "20 USD",
    survival_price = "1 USD",
    materials = { "nomex" },
    symbol = "[",
    looks_like = "socks",
    color = "light_gray",
    flags = { "VARSIZE", "WATER_FRIENDLY", "SKINTIGHT", "STURDY" },
    armor = {
        warmth = 5,
        thickness = 1,
        environmental_protection = 2,
        portions = { { encumbrance = 6, coverage = 100, covers = { "foot_l", "foot_r" } } },
    },
}

ccb.content.define_item {
    id = "xlnomex_socks",
    name = ccb.content.plural_text("flame-resistant socks (pair)", "flame-resistant socks (pair)"),
    mass = "300 g",
    volume = "1000 ml",
    copy_from = "nomex_socks",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "xsnomex_socks",
    copy_from = "nomex_socks",
    name = ccb.content.plural_text("flame-resistant socks (pair)", "flame-resistant socks (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "socks",
    name = ccb.content.plural_text("socks (pair)", "socks (pair)"),
    description = ccb.content.text("Socks.  Put 'em on your feet."),
    mass = "32 g",
    volume = "250 ml",
    price = "2 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "socks_wool",
    color = "white",
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 5,
        thickness = 0.2,
        portions = { { coverage = 100, covers = { "foot_l", "foot_r" } } },
    },
}

ccb.content.define_item {
    id = "xlsocks",
    name = ccb.content.plural_text("socks (pair)", "socks (pair)"),
    mass = "58 g",
    volume = "250 ml",
    copy_from = "socks",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "xssocks",
    copy_from = "socks",
    name = ccb.content.plural_text("socks (pair)", "socks (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "socks_ankle",
    name = ccb.content.plural_text("ankle socks (pair)", "ankle socks (pair)"),
    description = ccb.content.text("Short socks, commonly used for sports.  These are designed to protect your feet from friction, not temperature."),
    mass = "25 g",
    volume = "200 ml",
    price = "1 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "socks",
    color = "light_gray",
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        thickness = 0.3,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l", "foot_toes_r",
                    "foot_toes_l", "foot_sole_r", "foot_sole_l",
                },
                materials = { { id = "cotton", coverage = 100, thickness = 0.3 } },
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = { { id = "cotton", coverage = 100, thickness = 0.3 } },
                coverage = 60,
            },
        },
    },
}

ccb.content.define_item {
    id = "socks_bag",
    name = ccb.content.plural_text("bag socks (pair)", "bag socks (pair)"),
    description = ccb.content.text("A pair of disposable plastic bags, adapted to be used as socks."),
    mass = "6 g",
    volume = "250 ml",
    price = "50 cent",
    survival_price = "10 cent",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "socks",
    color = "light_blue",
    flags = { "WATERPROOF", "OVERSIZE", "SOFT" },
    armor = {
        thickness = 0.01,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l", "foot_toes_r",
                    "foot_toes_l", "foot_sole_r", "foot_sole_l",
                },
                materials = { { id = "plastic", coverage = 100, thickness = 0.01 } },
                encumbrance = 3,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = { { id = "cotton", coverage = 100, thickness = 0.01 } },
                coverage = 20,
            },
        },
    },
}

ccb.content.define_item {
    id = "socks_bowling",
    name = ccb.content.plural_text("disposable bowling socks (pair)", "disposable bowling socks (pair)"),
    description = ccb.content.text("Cheap socks designed to be worn once and then thrown away.  They keep your feet clean, but are too thin to give any protection."),
    mass = "20 g",
    volume = "250 ml",
    price = "50 cent",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "socks",
    color = "white",
    flags = { "SKINTIGHT" },
    armor = { warmth = 2, portions = { { coverage = 80, covers = { "foot_l", "foot_r" } } } },
}

-- NO_SALVAGE is to prevent an infinite yarn/wool exploit because the salvage system sucks.
ccb.content.define_item {
    id = "socks_wool",
    name = ccb.content.plural_text("wool socks (pair)", "wool socks (pair)"),
    description = ccb.content.text("Warm socks made of wool."),
    mass = "44 g",
    volume = "250 ml",
    price = "12 USD",
    survival_price = "1 USD 50 cent",
    materials = { "wool" },
    symbol = "[",
    looks_like = "socks",
    color = "blue",
    flags = { "VARSIZE", "SKINTIGHT", "NO_SALVAGE" },
    armor = {
        warmth = 30,
        thickness = 0.3,
        portions = { { encumbrance = 5, coverage = 100, covers = { "foot_l", "foot_r" } } },
    },
}

ccb.content.define_item {
    id = "xlsocks_wool",
    name = ccb.content.plural_text("wool socks (pair)", "wool socks (pair)"),
    mass = "77 g",
    volume = "500 ml",
    copy_from = "socks_wool",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } } },
}

ccb.content.define_item {
    id = "xssocks_wool",
    copy_from = "socks_wool",
    name = ccb.content.plural_text("wool socks (pair)", "wool socks (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Variants ordered by color, and then pattern of striped, polka dot, floral, checkered
ccb.content.define_item {
    id = "stockings",
    name = ccb.content.plural_text("stockings (pair)", "stockings (pair)"),
    description = ccb.content.text("Long cotton socks that reach above the knees to help protect from the cold."),
    mass = "90 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "leg_warmers",
    color = "dark_gray",
    flags = { "VARSIZE", "SKINTIGHT" },
    variant_kind = "generic",
    variants = {
        {
            id = "stockings_black",
            name = ccb.content.plural_text("black stockings (pair)", "black stockings (pair)"),
            description = ccb.content.text("This one is colored black."),
            color = "dark_gray",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_white",
            name = ccb.content.plural_text("white stockings (pair)", "white stockings (pair)"),
            description = ccb.content.text("This one is colored white."),
            color = "light_gray",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_white_striped",
            name = ccb.content.plural_text("striped stockings (pair)", "striped stockings (pair)"),
            description = ccb.content.text("This one is black, with white stripes.  Or is it white with black stripes?"),
            color = "light_gray",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_red",
            name = ccb.content.plural_text("red stockings (pair)", "red stockings (pair)"),
            description = ccb.content.text("This one is colored red."),
            color = "red",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_red_polka_dot",
            name = ccb.content.plural_text("red polka dot stockings (pair)", "red polka dot stockings (pair)"),
            description = ccb.content.text("This one is colored red with a polka dot pattern."),
            color = "light_red",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_red_floral",
            name = ccb.content.plural_text("red floral stockings (pair)", "red floral stockings (pair)"),
            description = ccb.content.text("This one is colored in various shades of red with a floral pattern."),
            color = "red",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_yellow",
            name = ccb.content.plural_text("yellow stockings (pair)", "yellow stockings (pair)"),
            description = ccb.content.text("This one is colored yellow."),
            color = "yellow",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_green",
            name = ccb.content.plural_text("green stockings (pair)", "green stockings (pair)"),
            description = ccb.content.text("This one is colored green."),
            color = "green",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_orange_striped",
            name = ccb.content.plural_text("orange striped stockings (pair)", "orange striped stockings (pair)"),
            description = ccb.content.text("This one is colored orange with a striped pattern."),
            color = "light_red",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_blue",
            name = ccb.content.plural_text("blue stockings (pair)", "blue stockings (pair)"),
            description = ccb.content.text("This one is colored blue."),
            color = "blue",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_blue_striped",
            name = ccb.content.plural_text("blue striped stockings (pair)", "blue striped stockings (pair)"),
            description = ccb.content.text("This one is colored blue and white with a striped pattern."),
            color = "blue",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_blue_floral",
            name = ccb.content.plural_text("blue floral stockings (pair)", "blue floral stockings (pair)"),
            description = ccb.content.text("This one is colored in various shades of blue with a floral pattern."),
            color = "blue",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_blue_checkered",
            name = ccb.content.plural_text("blue checkered stockings (pair)", "blue checkered stockings (pair)"),
            description = ccb.content.text("This one is colored blue and black with a checkered pattern."),
            color = "blue",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_purple",
            name = ccb.content.plural_text("purple stockings (pair)", "purple stockings (pair)"),
            description = ccb.content.text("This one is colored purple."),
            color = "magenta",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_purple_striped",
            name = ccb.content.plural_text("purple striped stockings (pair)", "purple striped stockings (pair)"),
            description = ccb.content.text("This one is colored purple and white with a striped pattern."),
            color = "light_red",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_purple_polka_dot",
            name = ccb.content.plural_text("purple polka dot stockings (pair)", "purple polka dot stockings (pair)"),
            description = ccb.content.text("This one is colored purple with a polka dot pattern."),
            color = "magenta",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_purple_floral",
            name = ccb.content.plural_text("purple floral stockings (pair)", "purple floral stockings (pair)"),
            description = ccb.content.text("This one is colored in various shades of purple with a floral pattern."),
            color = "magenta",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_pink",
            name = ccb.content.plural_text("pink stockings (pair)", "pink stockings (pair)"),
            description = ccb.content.text("This one is colored pink."),
            color = "magenta",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_pink_striped",
            name = ccb.content.plural_text("pink striped stockings (pair)", "pink striped stockings (pair)"),
            description = ccb.content.text("This one is colored pink and white with a striped pattern."),
            color = "light_red",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_pink_polka_dot",
            name = ccb.content.plural_text("pink polka dot stockings (pair)", "pink polka dot stockings (pair)"),
            description = ccb.content.text("This one is colored pink with a polka dot pattern."),
            color = "light_red",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_green_striped",
            name = ccb.content.plural_text("green striped stockings (pair)", "green striped stockings (pair)"),
            description = ccb.content.text("This one is colored green and white with a striped pattern."),
            color = "green",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_gray_striped",
            name = ccb.content.plural_text("gray striped stockings (pair)", "gray striped stockings (pair)"),
            description = ccb.content.text("This one is colored gray and white with a striped pattern."),
            color = "light_gray",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_brown",
            name = ccb.content.plural_text("brown stockings (pair)", "brown stockings (pair)"),
            description = ccb.content.text("This one is colored brown."),
            color = "brown",
            append = true,
            weight = 3,
        },
        {
            id = "stockings_brown_polka_dot",
            name = ccb.content.plural_text("brown polka dot stockings (pair)", "brown polka dot stockings (pair)"),
            description = ccb.content.text("This one is colored brown with a polka dot pattern."),
            color = "brown",
            append = true,
            weight = 3,
        },
    },
    armor = {
        warmth = 10,
        thickness = 0.1,
        portions = {
            { encumbrance = 5, coverage = 100, covers = { "foot_l", "foot_r" } },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r", "leg_knee_l", "leg_knee_r" },
                coverage = 100,
                encumbrance = 4,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
                coverage = 60,
            },
        },
    },
}

ccb.content.define_item {
    id = "stockings_tent_legs",
    name = ccb.content.plural_text("tentacle stockings (pair)", "tentacle stockings (pair)"),
    description = ccb.content.text("Six long cotton tubes sized to fit over tentacles and help protect them from the cold."),
    mass = "300 g",
    volume = "1500 ml",
    price = "12 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "leg_warmers",
    color = "dark_gray",
    flags = { "VARSIZE", "SKINTIGHT", "OVERSIZE", "MUTATED_ANATOMY_ONLY" },
    armor = {
        warmth = 10,
        thickness = 0.1,
        portions = {
            {
                encumbrance = 8,
                coverage = 100,
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "tabi_dress",
    name = ccb.content.plural_text("tabi (pair)", "tabi (pair)"),
    description = ccb.content.text("A pair of split toe black tabi socks.  Usually worn as a part of traditional Japanese clothing.  The big toe is separated from the others by the fabric to be comfortably worn with thonged footwear."),
    mass = "50 g",
    volume = "250 ml",
    price = "25 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "socks",
    color = "dark_gray",
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 5,
        thickness = 0.2,
        portions = { { coverage = 100, covers = { "foot_l", "foot_r" } } },
    },
}

ccb.content.define_item {
    id = "tabi_gi",
    name = ccb.content.plural_text("gi tabi (pair)", "gi tabi (pair)"),
    description = ccb.content.text("A pair of split toe white tabi socks, as used by martial arts practitioners.  Usually worn as a part of traditional Japanese clothing.  The big toe is separated from the others by the fabric to be comfortably worn with thonged footwear."),
    mass = "50 g",
    volume = "250 ml",
    price = "25 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "socks",
    color = "white",
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 5,
        thickness = 0.2,
        portions = { { coverage = 100, covers = { "foot_l", "foot_r" } } },
    },
}

ccb.content.define_item {
    id = "lc_sabaton",
    name = ccb.content.text("mild steel sabaton"),
    description = ccb.content.text("A flexible set of jointed lames that can be worn over footwear for additional protection, traditionally worn by mounted knights."),
    mass = "750 g",
    volume = "750 ml",
    price = "400 USD",
    survival_price = "30 USD",
    symbol = "[",
    looks_like = "boots_steel",
    materials = { "lc_steel" },
    color = "light_gray",
    flags = { "STURDY", "OUTER" },
    melee_damage = { bash = 7 },
    armor = {
        warmth = 0,
        sided = true,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "lc_steel", coverage = 100, thickness = 1.25 } },
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r",
                    "foot_toes_l",
                    "foot_heel_r",
                    "foot_heel_l",
                    "foot_arch_r",
                    "foot_arch_l",
                },
                coverage = 100,
                encumbrance = 10,
                layers = { "OUTER" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_sabaton",
    copy_from = "lc_sabaton",
    name = ccb.content.text("mild steel sabaton"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.25, volume = 1.25 } },
}

ccb.content.define_item {
    id = "mc_sabaton",
    copy_from = "lc_sabaton",
    name = ccb.content.text("medium steel sabaton"),
    replace_materials = { lc_steel = "mc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_sabaton",
    copy_from = "mc_sabaton",
    name = ccb.content.text("medium steel sabaton"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.25, volume = 1.25 } },
}

ccb.content.define_item {
    id = "hc_sabaton",
    copy_from = "lc_sabaton",
    name = ccb.content.text("high steel sabaton"),
    replace_materials = { lc_steel = "hc_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_sabaton",
    copy_from = "hc_sabaton",
    name = ccb.content.text("high steel sabaton"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.25, volume = 1.25 } },
}

ccb.content.define_item {
    id = "ch_sabaton",
    copy_from = "lc_sabaton",
    name = ccb.content.text("hardened steel sabaton"),
    replace_materials = { lc_steel = "ch_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_sabaton",
    copy_from = "ch_sabaton",
    name = ccb.content.text("hardened steel sabaton"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.25, volume = 1.25 } },
}

ccb.content.define_item {
    id = "qt_sabaton",
    copy_from = "lc_sabaton",
    name = ccb.content.text("tempered steel sabaton"),
    replace_materials = { lc_steel = "qt_steel" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_sabaton",
    copy_from = "qt_sabaton",
    name = ccb.content.text("tempered steel sabaton"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.25, volume = 1.25 } },
}

ccb.content.define_item {
    id = "espadrilles",
    name = ccb.content.plural_text("espadrilles", "espadrilles"),
    description = ccb.content.text("Originating from the Pyrenees and made from a rope sole and cloth, these shoes are perfect for the hot weather, sipping Sangria and dodging tourists."),
    looks_like = "leathersandals",
    price = "20 USD",
    survival_price = "10 USD",
    symbol = "[",
    materials = { "cotton" },
    volume = "600 ml",
    mass = "300 g",
    flags = { "VARSIZE" },
    armor = {
        warmth = 2,
        portions = {
            {
                layers = { "NORMAL" },
                encumbrance = 4,
                coverage = 100,
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l", "foot_heel_r", "foot_heel_l" },
                materials = { { id = "cotton", thickness = 1 } },
            },
            {
                layers = { "NORMAL" },
                encumbrance = 0,
                coverage = 100,
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_arch_r", "foot_arch_l", "foot_sole_r", "foot_sole_l" },
                materials = { { id = "dry_plant", thickness = 6 } },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_espadrilles",
    copy_from = "espadrilles",
    name = ccb.content.plural_text("espadrilles", "espadrilles"),
    armor = {},
    inheritance = { add = { flags = { "PREFIX_XL", "OVERSIZE" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_espadrilles",
    copy_from = "espadrilles",
    name = ccb.content.plural_text("espadrilles", "espadrilles"),
    armor = {},
    inheritance = { add = { flags = { "PREFIX_XS", "UNDERSIZE" } }, scale = { mass = 0.5, volume = 0.5 } },
}

ccb.content.define_item {
    id = "jikatabi",
    name = ccb.content.plural_text("jika-tabi (pair)", "jika-tabi (pair)"),
    description = ccb.content.text("A pair of thin traditional Japanese split toed boots sewn out of leather."),
    mass = "230 g",
    volume = "500 ml",
    price = "30 USD",
    survival_price = "3 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "boots",
    color = "brown",
    flags = { "VARSIZE", "WATERPROOF" },
    armor = {
        warmth = 20,
        thickness = 1.0,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l" },
                materials = { { id = "leather", coverage = 100, thickness = 0.4 } },
                encumbrance = 4,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = { { id = "leather", coverage = 100, thickness = 1.0 } },
                coverage = 80,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l" },
                materials = { { id = "leather", coverage = 100, thickness = 1.0 } },
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "leather", coverage = 100, thickness = 4.0 } },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "jikatabi_sneakers",
    name = ccb.content.plural_text("jika-tabi sneakers (pair)", "jika-tabi sneakers (pair)"),
    description = ccb.content.text("A pair of comfortable modern split toed jika-tabi shoes with a rubber base.  Also known as ninja shoes.  Though originally developed for laborers in Japan, in the west they are usually found being used in outdoor martial arts practice."),
    mass = "300 g",
    volume = "500 ml",
    price = "40 USD",
    survival_price = "4 USD",
    materials = { "canvas", "rubber" },
    symbol = "[",
    looks_like = "sneakers",
    color = "dark_gray",
    flags = { "VARSIZE", "STURDY" },
    armor = {
        warmth = 20,
        thickness = 1,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_heel_r", "foot_heel_l", "foot_arch_r", "foot_arch_l" },
                materials = { { id = "canvas", coverage = 100, thickness = 1 } },
                encumbrance = 2,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l" },
                materials = { { id = "canvas", coverage = 100, thickness = 0.4 } },
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = { { id = "canvas", coverage = 100, thickness = 1.0 } },
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "canvas", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
}
