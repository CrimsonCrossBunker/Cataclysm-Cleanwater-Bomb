local ccb = require("ccb")

ccb.content.define_item {
    id = "trenchcoat_aramid",
    name = ccb.content.text("trenchcoat, aramid"),
    description = ccb.content.text("A trenchoat made of aramid fibers to provide level 1 stab/cut protection up to 24 joules.  Lots of pockets and low profile."),
    mass = "1750 g",
    volume = "7250 ml",
    price = "979 USD",
    survival_price = "7 USD 50 cent",
    materials = { "kevlar" },
    symbol = "[",
    looks_like = "trenchcoat",
    color = "brown",
    pockets = {
        { kind = "CONTAINER", capacity = "1500 ml", mass_limit = "4 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "1500 ml", mass_limit = "4 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "1 L", mass_limit = "2 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "1 L", mass_limit = "2 kg", moves = 80 },
        { kind = "CONTAINER", capacity = "500 ml", mass_limit = "1 kg", moves = 120 },
        { kind = "CONTAINER", capacity = "500 ml", mass_limit = "1 kg", moves = 120 },
    },
    flags = { "VARSIZE", "POCKETS", "OUTER" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_lower" },
                coverage = 100,
                encumbrance = { 9, 19 },
            },
            {
                covers = { "torso" },
                subparts = { "torso_upper" },
                coverage = 95,
                encumbrance = { 0, 0 },
            },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 9, 9 } },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 90,
                encumbrance = { 4, 5 },
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
                coverage = 80,
                encumbrance = { 0, 0 },
            },
        },
        warmth = 50,
        thickness = 3,
        environmental_protection = 1,
    },
}

-- inherit name and description from item
ccb.content.define_item {
    id = "blazer_aramid",
    name = ccb.content.text("blazer, aramid"),
    description = ccb.content.text("A professional-looking wool blazer.  It's made of aramid fibers to provide Level 1 cut/stab resistance up to 24 joules."),
    mass = "680 g",
    volume = "3500 ml",
    price = "120 USD",
    survival_price = "50 cent",
    materials = { "kevlar" },
    symbol = "[",
    looks_like = "jacket_light",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "3 kg",
            max_item_length = "11 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "750 ml",
            mass_limit = "3 kg",
            max_item_length = "11 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "350 ml",
            mass_limit = "2 kg",
            max_item_length = "9 cm",
            moves = 100,
        },
    },
    flags = { "VARSIZE", "OUTER" },
    variant_kind = "generic",
    variants = {
        { id = "generic" },
        {
            id = "bostonchan",
            name = ccb.content.text("Boston-Chan blazer"),
            append = true,
            description = ccb.content.text("This one is bright blue and styled to cosplay Boston-Chan."),
            color = "blue",
            weight = 0,
        },
    },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 85, encumbrance = { 16, 20 } },
            { covers = { "arm_l", "arm_r" }, coverage = 85, encumbrance = { 16, 16 } },
        },
        warmth = 25,
        thickness = 1.5,
        valid_mods = { "steel_padded" },
    },
}
