local ccb = require("ccb")

ccb.content.define_item {
    id = "egg_proxy_bigfrog",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of giant frog's eggs", "clusters of giant frog's eggs"),
    mass = "160 g",
    volume = "1 L",
    symbol = "O",
    description = ccb.content.text("A large clump of very large frog eggs.  They're gelatinous, transparent and larger than even chicken's eggs."),
    price = "50 cent",
    survival_price = "1 USD",
    comestible = {
        quench = 8,
        calories = 200,
        fun = -30,
        vitamins = {
            { id = "iron", amount = 29 },
            { id = "mutant_toxin", amount = 20 },
            { id = "egg_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "egg_pattern_bigfrog",
    copy_from = "egg_proxy_bigfrog",
    name = ccb.content.plural_text("cluster of giant frog's eggs", "clusters of giant frog's eggs"),
    description = ccb.content.text("From a distance you could mistake it for a cluster of gigantic caviar.  It is only on close inspection that you can make out the faint translucence of these softball-sized frog eggs."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_pattern_bigtad", chance = 45 } } },
}

ccb.content.define_item {
    id = "egg_strange_bigfrog",
    copy_from = "egg_proxy_bigfrog",
    name = ccb.content.plural_text("cluster of giant frog's eggs", "clusters of giant frog's eggs"),
    description = ccb.content.text("A thick flotilla of enormous frog eggs floats together atop the water in a roughly circular mass."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_strange_bigtad", chance = 45 } } },
}
