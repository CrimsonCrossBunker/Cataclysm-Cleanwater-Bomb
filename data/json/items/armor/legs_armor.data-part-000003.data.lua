local ccb = require("ccb")

ccb.content.define_item {
    id = "trousers_eod",
    category = "armor",
    name = ccb.content.plural_text("EOD trousers", "EOD trousers"),
    description = ccb.content.text("This is a heavy pair of trousers armored in Kevlar, Nomex, and foam padding, for use by explosive ordnance disposal technicians.  While it offers near complete coverage in fragmentation resistant materials, it still offers insufficient protection from ballistic threats."),
    mass = "6400 g",
    volume = "7 L",
    price = "10 kUSD 60 USD",
    survival_price = "120 USD",
    materials = { "kevlar", "nomex" },
    symbol = "[",
    color = "light_green",
    flags = { "STURDY", "OUTER", "RAINPROOF" },
    max_worn = 1,
    armor = {
        warmth = 65,
        environmental_protection = 2,
        thickness = 15,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar", coverage = 100, thickness = 7.4 },
                    { id = "plastic_pad", coverage = 100, thickness = 2.0 },
                },
                coverage = 100,
                vitals_coverage = 100,
                covers = { "leg_l", "leg_r" },
                encumbrance = 80,
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 4 }, { kind = "detach_molle" } },
}

ccb.content.define_item {
    id = "trousers_eod_light",
    category = "armor",
    name = ccb.content.plural_text("tactical EOD trousers", "tactical EOD trousers"),
    description = ccb.content.text("This is a heavy pair of trousers armored in Kevlar, Nomex, and foam padding, for use by explosive ordnance disposal technicians in 'non-permissive environments'.  While it offers near complete coverage in fragmentation resistant materials, it still offers insufficient protection from ballistic threats.  These trousers are lighter than normal EOD armor to provide more maneuverability."),
    mass = "3000 g",
    volume = "7 L",
    price = "2 kUSD 734 USD 40 cent",
    survival_price = "33 USD",
    materials = { "kevlar", "nomex" },
    symbol = "[",
    color = "light_gray",
    flags = { "STURDY", "OUTER", "RAINPROOF" },
    max_worn = 1,
    armor = {
        warmth = 40,
        environmental_protection = 2,
        thickness = 7,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar", coverage = 100, thickness = 4.4 },
                    { id = "plastic_pad", coverage = 100, thickness = 2 },
                },
                encumbrance = 40,
                coverage = 100,
                vitals_coverage = 100,
                covers = { "leg_l", "leg_r" },
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 6 }, { kind = "detach_molle" } },
}
