local ccb = require("ccb")

ccb.content.define_item {
    id = "2lcanteen",
    category = "clothing",
    name = ccb.content.text("2.5 L canteen"),
    looks_like = "bottle_plastic",
    description = ccb.content.text("A large plastic water canteen, with a 2.5 liter capacity and carrying strap."),
    ascii_picture = "2lcanteen",
    mass = "155 g",
    volume = "2625 ml",
    price = "10 USD",
    survival_price = "50 cent",
    materials = { "plastic" },
    symbol = ")",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            watertight = true,
            rigid = true,
            capacity = "2500 ml",
            max_item_volume = "32 ml",
            mass_limit = "5 kg",
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "COLLAPSE_CONTENTS" },
    armor = {
        portions = {
            {
                materials = { { id = "plastic", coverage = 100, thickness = 2.0 } },
                encumbrance = 4,
                coverage = 10,
                covers = { "torso" },
                subparts = { "torso_hanging_front" },
            },
        },
    },
}

ccb.content.define_item {
    id = "camelbak",
    category = "container",
    name = ccb.content.text("hydration pack"),
    looks_like = "runner_bag",
    description = ccb.content.text("A slim and lightweight insulated plastic bladder worn on the back or within a hydration pouch in a backpack.  It has a large pocket and a capped mouth for filling with liquid, with a hose that allows the wearer to drink hands-free."),
    ascii_picture = "camelbak",
    mass = "185 g",
    volume = "250 ml",
    price = "100 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton", "plastic" },
    symbol = ")",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            watertight = true,
            transparent = true,
            capacity = "3000 ml",
            max_item_volume = "32 ml",
            mass_limit = "20 kg",
        },
    },
    flags = { "BELTED", "COLLAPSE_CONTENTS" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "cotton", coverage = 100, thickness = 1.0 },
                    { id = "plastic", coverage = 100, thickness = 1.0 },
                },
                coverage = 30,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}
