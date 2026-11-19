local ccb = require("ccb")

ccb.content.define_item {
    id = "canteen_wood",
    category = "clothing",
    name = ccb.content.text("wooden canteen"),
    looks_like = "canteen",
    description = ccb.content.text("A water canteen made from wood, secured by metal bands and sealed with wax or pitch.  Holds 1.5 liters and has a simple carry strap."),
    ascii_picture = "canteen_wood",
    mass = "232 g",
    volume = "1750 ml",
    price = "8 USD",
    survival_price = "10 cent",
    materials = { "wood" },
    symbol = ")",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            rigid = true,
            watertight = true,
            capacity = "1500 ml",
            max_item_volume = "17 ml",
            mass_limit = "3 kg",
        },
    },
    flags = { "BELTED", "WATER_FRIENDLY" },
    armor = {
        portions = {
            {
                materials = { { id = "wood", coverage = 100, thickness = 2.0 } },
                encumbrance = 5,
                coverage = 5,
                covers = { "torso" },
                subparts = { "torso_hanging_front" },
            },
        },
    },
}

ccb.content.define_item {
    id = "waterskin",
    category = "clothing",
    name = ccb.content.text("small waterskin"),
    looks_like = "canvas_bag",
    description = ccb.content.text("A small watertight leather bag with a carrying strap, can hold 1.5 liters of water."),
    ascii_picture = "waterskin",
    mass = "453 g",
    volume = "250 ml",
    price = "20 USD",
    survival_price = "50 cent",
    materials = { "leather" },
    symbol = ")",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            watertight = true,
            capacity = "1500 ml",
            max_item_volume = "17 ml",
            mass_limit = "3 kg",
        },
    },
    flags = { "BELTED", "WATER_FRIENDLY" },
    armor = {
        sided = true,
        portions = {
            {
                materials = { { id = "leather", coverage = 100, thickness = 2.0 } },
                coverage = 5,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_r", "leg_hip_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "waterskin2",
    category = "clothing",
    name = ccb.content.text("waterskin"),
    looks_like = "waterskin",
    description = ccb.content.text("A watertight leather bag with a carrying strap, can hold 3 liters of water."),
    ascii_picture = "waterskin2",
    mass = "783 g",
    volume = "500 ml",
    price = "40 USD",
    survival_price = "50 cent",
    materials = { "leather" },
    symbol = ")",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            watertight = true,
            capacity = "3 L",
            max_item_volume = "17 ml",
            mass_limit = "6 kg",
        },
    },
    flags = { "BELTED", "WATER_FRIENDLY" },
    armor = {
        portions = {
            {
                materials = { { id = "leather", coverage = 100, thickness = 2.0 } },
                coverage = 10,
                covers = { "torso" },
                subparts = { "torso_hanging_front" },
            },
        },
    },
}

ccb.content.define_item {
    id = "waterskin3",
    category = "clothing",
    name = ccb.content.text("large waterskin"),
    looks_like = "waterskin2",
    description = ccb.content.text("A large watertight leather bag with a carrying strap, can hold 5 liters of water."),
    ascii_picture = "waterskin3",
    mass = "990 g",
    volume = "750 ml",
    price = "60 USD",
    survival_price = "1 USD",
    materials = { "leather" },
    symbol = ")",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            watertight = true,
            capacity = "5 L",
            max_item_volume = "17 ml",
            mass_limit = "10 kg",
        },
    },
    flags = { "BELTED", "WATER_FRIENDLY" },
    armor = {
        portions = {
            {
                materials = { { id = "leather", coverage = 100, thickness = 2.0 } },
                coverage = 40,
                covers = { "torso" },
                subparts = { "torso_hanging_front" },
            },
        },
    },
}
