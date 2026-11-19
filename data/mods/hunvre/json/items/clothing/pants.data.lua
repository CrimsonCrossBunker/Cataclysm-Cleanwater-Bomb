local ccb = require("ccb")

ccb.content.define_item {
    id = "leggings",
    color = "blue",
    symbol = "[",
    looks_like = "leg_warmers",
    name = ccb.content.plural_text("leggings", "leggings"),
    description = ccb.content.text("Stretchy, close-fitting pants, thin and breathable."),
    materials = { "lycra" },
    mass = "500 g",
    volume = "500 ml",
    survival_price = "1 USD",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 10,
        thickness = 0.2,
        portions = { { covers = { "leg_l", "leg_r" }, coverage = 100 } },
    },
}

ccb.content.define_item {
    id = "short_shorts",
    color = "blue",
    symbol = "[",
    looks_like = "jeans",
    name = ccb.content.plural_text("short shorts", "short shorts"),
    description = ccb.content.text("Short shorts barely covering the thighs."),
    materials = { "nylon" },
    mass = "100 g",
    volume = "100 ml",
    survival_price = "1 USD",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "NORMAL" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "950 ml",
            mass_limit = "3500 g",
            max_item_length = "15 cm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "950 ml",
            mass_limit = "3500 g",
            max_item_length = "15 cm",
            moves = 100,
        },
    },
    armor = {
        warmth = 15,
        thickness = 1,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 100,
                encumbrance = 3,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
                coverage = 20,
                encumbrance = 3,
            },
        },
    },
}

ccb.content.define_item {
    id = "shorts",
    copy_from = "short_shorts",
    name = ccb.content.plural_text("shorts", "shorts"),
    description = ccb.content.text("Shorts going down to mid thighs."),
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "950 ml",
            mass_limit = "3500 g",
            max_item_length = "15 cm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "950 ml",
            mass_limit = "3500 g",
            max_item_length = "15 cm",
            moves = 100,
        },
    },
    armor = {
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 100,
                encumbrance = 3,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
                coverage = 40,
                encumbrance = 3,
            },
        },
    },
    inheritance = { scale = { mass = 2, volume = 2 } },
}

ccb.content.define_item {
    id = "cargo_shorts",
    copy_from = "shorts",
    name = ccb.content.plural_text("cargo shorts", "cargo shorts"),
    description = ccb.content.text("Shorts going down to mid thighs with additional pockets on the sides."),
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "950 ml",
            mass_limit = "3500 g",
            max_item_length = "15 cm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "950 ml",
            mass_limit = "3500 g",
            max_item_length = "15 cm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "bermuda_shorts",
    copy_from = "short_shorts",
    name = ccb.content.plural_text("bermuda shorts", "bermuda shorts"),
    description = ccb.content.text("Shorts reaching just above the knees."),
    armor = {
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r", "leg_upper_l", "leg_upper_r" },
                coverage = 100,
                encumbrance = 3,
            },
        },
    },
    inheritance = { scale = { mass = 4, volume = 4 } },
}

ccb.content.define_item {
    id = "cargo_bermuda_shorts",
    copy_from = "bermuda_shorts",
    name = ccb.content.plural_text("cargo bermuda shorts", "cargo bermuda shorts"),
    description = ccb.content.text("Shorts reaching just above the knees with additional pockets on the sides."),
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "950 ml",
            mass_limit = "3500 g",
            max_item_length = "15 cm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "950 ml",
            mass_limit = "3500 g",
            max_item_length = "15 cm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "capris",
    copy_from = "short_shorts",
    name = ccb.content.plural_text("capris", "capris"),
    description = ccb.content.text("Pants going up to mid calf."),
    armor = {
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                subparts = {
                    "leg_hip_l",
                    "leg_hip_r",
                    "leg_upper_l",
                    "leg_upper_r",
                    "leg_knee_l",
                    "leg_knee_r",
                },
                coverage = 100,
                encumbrance = 3,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r" },
                coverage = 40,
                encumbrance = 3,
            },
        },
    },
    inheritance = { scale = { mass = 6, volume = 6 } },
}

ccb.content.define_item {
    id = "cargo_capris",
    copy_from = "capris",
    name = ccb.content.plural_text("cargo capris", "cargo capris"),
    description = ccb.content.text("Pants going up to mid calf with additional pockets on the sides."),
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "950 ml",
            mass_limit = "3500 g",
            max_item_length = "15 cm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "950 ml",
            mass_limit = "3500 g",
            max_item_length = "15 cm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "pants",
    copy_from = "short_shorts",
    name = ccb.content.plural_text("pants", "pants"),
    description = ccb.content.text("A pair of pants."),
    armor = { portions = { { covers = { "leg_l", "leg_r" }, coverage = 100 } } },
    inheritance = { scale = { mass = 8, volume = 8 } },
}

ccb.content.define_item {
    id = "cargo_pants",
    copy_from = "pants",
    name = ccb.content.plural_text("cargo pants", "cargo pants"),
    description = ccb.content.text("A pair of pants with additional pockets on the sides."),
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "950 ml",
            mass_limit = "3500 g",
            max_item_length = "15 cm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "950 ml",
            mass_limit = "3500 g",
            max_item_length = "15 cm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "20 cm",
            moves = 80,
        },
    },
    armor = {},
}
