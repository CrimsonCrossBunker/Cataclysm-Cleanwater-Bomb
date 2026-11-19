local ccb = require("ccb")

ccb.content.define_item {
    id = "beekeeping_hood",
    name = ccb.content.text("beekeeping hood"),
    description = ccb.content.text("A beekeeping hood.  Keeps the bees out, but lets fresh air in."),
    mass = "260 g",
    volume = "1500 ml",
    price = "45 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton", "plastic" },
    symbol = "[",
    looks_like = "cowboy_hat",
    color = "white",
    flags = { "VARSIZE", "OUTER" },
    armor = {
        portions = {
            { covers = { "head" }, coverage = 100, encumbrance_modifiers = { "NONE" } },
            {
                covers = { "eyes", "mouth" },
                coverage = 100,
                encumbrance = 5,
                breathability = "GOOD",
            },
        },
        warmth = 10,
        thickness = 1,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "chainmail_junk_hood",
    category = "armor",
    name = ccb.content.text("chainmail coif"),
    description = ccb.content.text("A customized chainmail hood.  Can be worn comfortably under helmets."),
    mass = "1315 g",
    volume = "500 ml",
    price = "50 USD 12 cent",
    survival_price = "25 USD",
    materials = { "budget_steel_chain" },
    symbol = "[",
    looks_like = "balclava",
    color = "light_red",
    flags = { "VARSIZE", "STURDY", "OUTER" },
    armor = {
        thickness = 4,
        warmth = 5,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "budget_steel_chain", coverage = 100, thickness = 1.2 } },
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
        },
    },
}

ccb.content.define_item {
    id = "lc_chainmail_hood",
    category = "armor",
    name = ccb.content.text("mild steel chainmail coif"),
    description = ccb.content.text("A customized chainmail hood.  Can be worn comfortably under helmets."),
    mass = "1315 g",
    volume = "500 ml",
    price = "50 USD 12 cent",
    survival_price = "25 USD",
    materials = { "lc_steel_chain" },
    symbol = "[",
    looks_like = "balclava",
    color = "light_red",
    flags = { "VARSIZE", "STURDY", "OUTER" },
    armor = {
        warmth = 5,
        environmental_protection = 1,
        portions = {
            {
                materials = { { id = "lc_steel_chain", coverage = 100, thickness = 1.2 } },
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_lc_chainmail_hood",
    copy_from = "lc_chainmail_hood",
    name = ccb.content.text("mild steel chainmail coif"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_lc_chainmail_hood",
    copy_from = "lc_chainmail_hood",
    name = ccb.content.text("mild steel chainmail coif"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "mc_chainmail_hood",
    copy_from = "lc_chainmail_hood",
    name = ccb.content.text("medium steel chainmail coif"),
    replace_materials = { lc_steel_chain = "mc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_chainmail_hood",
    copy_from = "mc_chainmail_hood",
    name = ccb.content.text("medium steel chainmail coif"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_mc_chainmail_hood",
    copy_from = "mc_chainmail_hood",
    name = ccb.content.text("medium steel chainmail coif"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "hc_chainmail_hood",
    copy_from = "lc_chainmail_hood",
    name = ccb.content.text("high steel chainmail coif"),
    replace_materials = { lc_steel_chain = "hc_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_chainmail_hood",
    copy_from = "hc_chainmail_hood",
    name = ccb.content.text("high steel chainmail coif"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_hc_chainmail_hood",
    copy_from = "hc_chainmail_hood",
    name = ccb.content.text("high steel chainmail coif"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "ch_chainmail_hood",
    copy_from = "lc_chainmail_hood",
    name = ccb.content.text("hardened steel chainmail coif"),
    replace_materials = { lc_steel_chain = "ch_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_chainmail_hood",
    copy_from = "ch_chainmail_hood",
    name = ccb.content.text("hardened steel chainmail coif"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_ch_chainmail_hood",
    copy_from = "ch_chainmail_hood",
    name = ccb.content.text("hardened steel chainmail coif"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "qt_chainmail_hood",
    copy_from = "lc_chainmail_hood",
    name = ccb.content.text("tempered steel chainmail coif"),
    replace_materials = { lc_steel_chain = "qt_steel_chain" },
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_chainmail_hood",
    copy_from = "qt_chainmail_hood",
    name = ccb.content.text("tempered steel chainmail coif"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_qt_chainmail_hood",
    copy_from = "qt_chainmail_hood",
    name = ccb.content.text("tempered steel chainmail coif"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "hood_rain",
    name = ccb.content.text("rain hood"),
    description = ccb.content.text("A waterproof hood made to be worn in bad weather."),
    mass = "160 g",
    volume = "750 ml",
    price = "20 USD",
    survival_price = "2 USD 50 cent",
    materials = { "vinyl" },
    symbol = "[",
    looks_like = "hat_cotton",
    color = "yellow",
    flags = { "RAINPROOF", "OUTER" },
    armor = {
        warmth = 8,
        thickness = 0.3,
        environmental_protection = 2,
        portions = { { encumbrance_modifiers = { "NONE" }, coverage = 100, covers = { "head" } } },
    },
}

ccb.content.define_item {
    id = "nomex_hood",
    name = ccb.content.text("flame-resistant hood"),
    description = ccb.content.text("A snug fitting garment that protects your head and neck, made from lightweight Nomex fire-resistant fabric.  Tough yet breathable, it is light and comfortable to wear under clothing."),
    mass = "210 g",
    volume = "500 ml",
    price = "50 USD",
    survival_price = "5 USD",
    materials = { "nomex" },
    symbol = "[",
    looks_like = "hood_rain",
    color = "light_gray",
    flags = { "VARSIZE", "WATER_FRIENDLY", "SKINTIGHT", "STURDY" },
    armor = {
        warmth = 5,
        thickness = 3,
        environmental_protection = 2,
        portions = { { encumbrance_modifiers = { "NONE" }, coverage = 100, covers = { "head" } } },
    },
}

ccb.content.define_item {
    id = "hood_gut",
    name = ccb.content.text("gutskin hood"),
    description = ccb.content.text("A hood sewn from treated and split intestines, the perfect companion for a gutskin parka."),
    mass = "40 g",
    volume = "250 ml",
    price = "26 USD",
    survival_price = "1 USD 50 cent",
    materials = { "gutskin" },
    symbol = "[",
    looks_like = "hood_rain",
    color = "light_gray",
    flags = { "RAINPROOF", "OUTER" },
    armor = {
        warmth = 10,
        thickness = 0.1,
        environmental_protection = 1,
        portions = { { encumbrance_modifiers = { "NONE" }, coverage = 95, covers = { "head" } } },
    },
}

ccb.content.define_item {
    id = "hood_ninja",
    name = ccb.content.text("ninja hood"),
    description = ccb.content.text("A black hood commonly used by ninja."),
    mass = "80 g",
    volume = "1000 ml",
    price = "35 USD",
    survival_price = "20 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "balclava",
    color = "dark_gray",
    flags = { "VARSIZE" },
    armor = {
        portions = {
            { covers = { "head" }, coverage = 100, encumbrance_modifiers = { "NONE" } },
            { covers = { "mouth" }, coverage = 100, encumbrance = 5 },
        },
        warmth = 8,
        thickness = 0.2,
        environmental_protection = 1,
    },
}
