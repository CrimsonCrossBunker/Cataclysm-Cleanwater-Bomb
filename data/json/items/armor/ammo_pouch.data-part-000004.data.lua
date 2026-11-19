local ccb = require("ccb")

ccb.content.define_item {
    id = "quiver",
    name = ccb.content.text("quiver"),
    description = ccb.content.text("A leather quiver worn at the waist that can hold 20 arrows or bolts.  Use insert to store arrows or bolts."),
    mass = "320 g",
    volume = "500 ml",
    price = "65 USD",
    survival_price = "10 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "bscabbard",
    color = "brown",
    pockets = { { ammunition = { arrow = 20, bolt = 20 }, moves = 20 } },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    melee_damage = { bash = 2 },
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                encumbrance = 3,
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "nylon_quiver",
    name = ccb.content.text("nylon quiver"),
    description = ccb.content.text("A lighter and more durable quiver made of nylon, with straps to attach to a MOLLE system."),
    mass = "230 g",
    volume = "500 ml",
    price = "65 USD",
    survival_price = "12 USD",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "bscabbard",
    color = "light_gray",
    pockets = { { ammunition = { arrow = 20, bolt = 20 }, moves = 20 } },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "PALS_LARGE" },
    melee_damage = { bash = 2 },
    armor = {
        sided = true,
        thickness = 0.5,
        portions = {
            {
                encumbrance = 2,
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "quiver_birchbark",
    name = ccb.content.text("birchbark quiver"),
    description = ccb.content.text("A quiver woven from strips of birch bark, worn at the waist, that can hold 20 arrows or bolts.  Use insert to store arrows or bolts."),
    mass = "490 g",
    volume = "500 ml",
    price = "65 USD",
    survival_price = "7 USD 50 cent",
    materials = { "wood" },
    symbol = "[",
    looks_like = "quiver",
    color = "light_gray",
    pockets = { { ammunition = { arrow = 20, bolt = 20 }, moves = 20 } },
    flags = { "BELTED", "VARSIZE", "OVERSIZE", "WATER_FRIENDLY" },
    melee_damage = { bash = 2 },
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                encumbrance = 10,
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "pipe_quiver",
    name = ccb.content.text("pipe quiver"),
    description = ccb.content.text("A makeshift quiver fashioned from a pipe, worn at the waist.  Heavier and thinner than a typical quiver, it can only hold 10 arrows or bolts.  Use insert to store arrows or bolts."),
    mass = "800 g",
    volume = "370 ml",
    price = "65 USD",
    survival_price = "5 USD",
    materials = { "steel" },
    symbol = "[",
    looks_like = "quiver",
    color = "dark_gray",
    pockets = { { ammunition = { arrow = 10, bolt = 10 }, moves = 20 } },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    melee_damage = { bash = 10 },
    armor = {
        sided = true,
        thickness = 1.5,
        portions = {
            {
                encumbrance = 10,
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "quiver_large",
    name = ccb.content.text("large quiver"),
    description = ccb.content.text("A large leather quiver, worn on the back, that can hold 60 arrows or bolts.  Historically used by horse archers, rather than foot archers, but neither of THEM had to fight zombies.  Use insert to store arrows or bolts."),
    mass = "920 g",
    volume = "1500 ml",
    price = "88 USD",
    survival_price = "15 USD",
    materials = { "leather", "steel" },
    symbol = "[",
    looks_like = "quiver",
    color = "brown",
    pockets = { { ammunition = { arrow = 60, bolt = 60 }, moves = 20 } },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    melee_damage = { bash = 4 },
    armor = {
        thickness = 1,
        portions = {
            {
                encumbrance = 3,
                coverage = 30,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

ccb.content.define_item {
    id = "quiver_large_birchbark",
    name = ccb.content.text("large birchbark quiver"),
    description = ccb.content.text("A large quiver woven from strips of birchbark, worn on the back, that can hold 60 arrows or bolts.  Use insert to store arrows or bolts."),
    mass = "1380 g",
    volume = "1500 ml",
    price = "88 USD",
    survival_price = "12 USD 50 cent",
    materials = { "wood" },
    symbol = "[",
    looks_like = "quiver_birchbark",
    color = "light_gray",
    pockets = { { ammunition = { arrow = 60, bolt = 60 }, moves = 20 } },
    flags = { "BELTED", "VARSIZE", "OVERSIZE", "WATER_FRIENDLY" },
    melee_damage = { bash = 4 },
    armor = {
        thickness = 1,
        portions = {
            {
                encumbrance = 14,
                coverage = 30,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

ccb.content.define_item {
    id = "pipe_quiver_large",
    name = ccb.content.text("large pipe quiver"),
    description = ccb.content.text("A large makeshift quiver fashioned from 3 pipes, worn on the back.  Heavier and thinner than a typical large quiver, it can only hold 30 arrows or bolts.  Use insert to store arrows or bolts."),
    mass = "2000 g",
    volume = "810 ml",
    price = "88 USD",
    survival_price = "10 USD",
    materials = { "steel" },
    symbol = "[",
    looks_like = "quiver",
    color = "dark_gray",
    pockets = { { ammunition = { arrow = 30, bolt = 30 }, moves = 30 } },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    melee_damage = { bash = 12 },
    armor = {
        sided = true,
        thickness = 1.5,
        portions = {
            {
                encumbrance = 14,
                coverage = 30,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

ccb.content.define_item {
    id = "quiver_simple_cloth",
    name = ccb.content.text("simple cloth quiver"),
    description = ccb.content.text("A simple quiver made out of cloth that can be adjusted to hold various types of arrows, bolts, and spears of different lengths.  Takes slightly longer to pull ammunition from than a regular quiver.  Use insert to store arrows, bolts, fishing spears, or atlatl spears."),
    mass = "200 g",
    volume = "500 ml",
    price = "5 USD",
    survival_price = "1 USD",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "quiver",
    color = "white",
    pockets = { { ammunition = { arrow = 30, bolt = 30, atlatl = 5, fishspear = 5 }, moves = 30 } },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                encumbrance = 6,
                coverage = 30,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}
