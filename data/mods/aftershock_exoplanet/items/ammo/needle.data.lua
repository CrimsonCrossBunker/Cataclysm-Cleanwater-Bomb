local ccb = require("ccb")

ccb.content.define_item {
    id = "3x35dart",
    name = ccb.content.text("GG Stinger 3x35mm flechette"),
    description = ccb.content.text("The Gibson Gear Stinger flechette is a magnetically propelled dart roughly half the length of the average human thumb."),
    mass = "7 g",
    volume = "105 ml",
    price = "200 USD",
    materials = { "steel" },
    symbol = "=",
    color = "green",
    stack_size = 75,
    ammunition = {
        count = 100,
        type = "3x35",
        range = 10,
        damage = { type = "bullet", amount = 8, penetration = 30 },
        dispersion = 60,
        recoil = 40,
    },
}

ccb.content.define_item {
    id = "3x35frangible",
    copy_from = "3x35dart",
    name = ccb.content.text("GG Splinter 3x35mm flechette"),
    description = ccb.content.text("Gibson Gear Splinter flechettes are made with magnetic ceramics that shatter upon impact and dig deeply into flesh, as a consequence of this change these rounds lose almost all of their armor piercing."),
    mass = "6 g",
    price = "250 USD",
    materials = { "ceramic" },
    inheritance = {
        scale = { recoil = 0.9 },
        offset = {
            range = -1,
            dispersion = 20,
            damage = { type = "bullet", amount = 20, penetration = -30 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "3x35toxic",
    copy_from = "3x35dart",
    name = ccb.content.text("GG Fang 3x35mm NTX flechette"),
    description = ccb.content.text("Gibson Gear Fang flechettes loading a small ampoule of neurotoxic poison within a hollow cobalt dart.  Although principally designed to neutralize the heavily augmented, they are effective against most organic targets."),
    mass = "6 g",
    price = "1600 USD",
    inheritance = { scale = { recoil = 0.9 }, offset = { range = -1, dispersion = 20 } },
    ammunition = { damage = { type = "afs_toxin_bullet", amount = 8, penetration = 15 } },
}
