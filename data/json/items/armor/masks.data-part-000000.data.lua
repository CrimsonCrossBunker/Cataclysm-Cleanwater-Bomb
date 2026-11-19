local ccb = require("ccb")

ccb.content.define_item {
    id = "balclava",
    name = ccb.content.text("balaclava"),
    description = ccb.content.text("A warm covering that protects the head and face from the cold."),
    mass = "70 g",
    volume = "250 ml",
    price = "35 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "hat_cotton",
    color = "dark_gray",
    flags = { "VARSIZE", "SKINTIGHT" },
    variants = {
        {
            id = "black",
            name = ccb.content.text("black balaclava"),
            append = true,
            description = ccb.content.text("This one is black."),
            weight = 99,
        },
        {
            id = "skull",
            name = ccb.content.text("skull print balaclava"),
            description = ccb.content.text("A skull-print balaclava covering the head and face, commonly used by motorcycle riders and as part of a costume."),
            weight = 1,
        },
    },
    armor = {
        warmth = 15,
        thickness = 0.5,
        environmental_protection = 1,
        portions = { { encumbrance = 5, coverage = 95, covers = { "head", "mouth" } } },
    },
}

-- delete balclava :) variants
ccb.content.define_item {
    id = "balaclava_cut_resistant",
    category = "armor",
    name = ccb.content.text("cut-resistant balaclava"),
    description = ccb.content.text("A face covering that helps protect from slashes and cuts, in addition to the cold."),
    variants = {},
    copy_from = "balclava",
    price = "76 USD",
    materials = { "kevlar" },
    armor = {},
}
