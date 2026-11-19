local ccb = require("ccb")

ccb.content.define_item {
    id = "throat_guard_nylon",
    category = "armor",
    name = ccb.content.text("nylon throat guard"),
    description = ccb.content.text("A common nylon throat guard commonly used for neck protection when playing sports."),
    mass = "60 g",
    volume = "510 ml",
    price = "15 USD",
    survival_price = "50 cent",
    symbol = "[",
    materials = { "nylon" },
    color = "light_blue",
    looks_like = "iotv_neck_plate",
    armor = {
        warmth = 8,
        thickness = 2,
        portions = {
            {
                covers = { "head" },
                subparts = { "head_throat", "head_nape" },
                coverage = 100,
                encumbrance_modifiers = { "NONE" },
            },
        },
    },
}

ccb.content.define_item {
    id = "throat_guard_canvas",
    name = ccb.content.text("canvas throat guard"),
    description = ccb.content.text("A common canvas throat guard commonly used for neck protection when playing sports like hockey."),
    copy_from = "throat_guard_nylon",
    materials = { "canvas" },
    color = "light_gray",
    armor = {},
}

ccb.content.define_item {
    id = "throat_guard_plastic",
    category = "armor",
    name = ccb.content.text("plastic throat guard"),
    description = ccb.content.text("A rare variety of throat guard originally known as a gorget and used for neck protection in HEMA.  It's made from thick rubber covered by nylon.  It offers good protection for the throat, but it only covers a small portion of the nape."),
    mass = "160 g",
    volume = "4408 ml",
    price = "55 USD",
    survival_price = "1 USD",
    symbol = "[",
    materials = { "thermo_resin", "nylon" },
    color = "dark_gray",
    looks_like = "iotv_neck_plate",
    flags = { "WATERPROOF", "STURDY", "OUTER" },
    armor = {
        warmth = 10,
        thickness = 4,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.5 },
                    { id = "thermo_resin", coverage = 95, thickness = 4 },
                },
                covers = { "head" },
                subparts = { "head_throat" },
                rigid_only = true,
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK" },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.5 },
                    { id = "thermo_resin", coverage = 75, thickness = 4 },
                },
                covers = { "head" },
                subparts = { "head_nape" },
                rigid_only = true,
                coverage = 20,
                encumbrance_modifiers = { "NONE" },
            },
        },
    },
}

ccb.content.define_item {
    id = "throat_guard_cut_resistant",
    name = ccb.content.text("cut-resistant throat guard"),
    description = ccb.content.text("A cut-resistant Kevlar throat guard, commonly used by welders, security forces and in some sports."),
    copy_from = "throat_guard_nylon",
    mass = "136 g",
    price = "130 USD",
    survival_price = "4 USD",
    materials = { "kevlar" },
    color = "dark_gray",
    flags = { "WATER_FRIENDLY" },
    armor = { environmental_protection = 1 },
}

ccb.content.define_item {
    id = "throat_guard_mercenary",
    category = "armor",
    name = ccb.content.text("mercenary throat guard"),
    description = ccb.content.text("A ballistic collar modified to wear it as a standalone armor, carefully combined with a regular nylon throat guard for extra protection."),
    mass = "680 g",
    volume = "1000 ml",
    survival_price = "1 USD",
    symbol = "[",
    materials = { "kevlar_layered", "nylon" },
    color = "dark_gray",
    looks_like = "iotv_neck_plate",
    flags = { "STURDY", "OUTER", "NORMAL", "WATER_FRIENDLY" },
    armor = {
        warmth = 10,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 3 },
                    { id = "kevlar_layered", coverage = 90, thickness = 4.4 },
                },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_throat", "head_nape" },
                encumbrance_modifiers = { "RESTRICTS_NECK" },
            },
        },
    },
}
