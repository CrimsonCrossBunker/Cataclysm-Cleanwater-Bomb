local ccb = require("ccb")

ccb.content.define_item {
    id = "marshmallow_flesh",
    name = ccb.content.plural_text("chunk of marshmallow flesh", "chunks of marshmallow flesh"),
    description = ccb.content.text("A big chunk of squishy, fluffy, puffy, delicious marshmallow flesh."),
    mass = "53 g",
    volume = "250 ml",
    color = "white",
    symbol = "%",
    survival_price = "1 USD",
    looks_like = "marshmallow",
    materials = { "junk" },
    flags = { "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = "90 days",
        kind = "FOOD",
        calories = 168,
        fun = 10,
        vitamins = { { id = "junk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "smores_flesh",
    name = ccb.content.plural_text("piece of s'mores' flesh", "pieces of s'mores' flesh"),
    looks_like = "smores",
    mass = "180 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("A shell of graham crackers and chocolate filled with delicious marshmallow flesh."),
    survival_price = "2 USD 50 cent",
    materials = { "wheat", "junk" },
    volume = "250 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = "90 days",
        kind = "FOOD",
        calories = 418,
        vitamins = {
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 6 },
            { id = "wheat_allergen", amount = 1 },
            { id = "junk_allergen", amount = 1 },
        },
        fun = 20,
    },
}

ccb.content.define_item {
    id = "candy3_flesh",
    name = ccb.content.plural_text("chunk of chewy candy flesh", "chunks of chewy candy flesh"),
    mass = "127 g",
    color = "yellow",
    looks_like = "candy3",
    symbol = "%",
    description = ccb.content.text("A chunk of colorful fruit-flavored chewy candy meat."),
    survival_price = "5 USD 54 cent",
    materials = { "junk" },
    volume = "250 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        calories = 235,
        fun = 3,
        vitamins = { { id = "junk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "candy3gator_flesh",
    name = ccb.content.plural_text("chunk of reptilian candy flesh", "chunks of reptilian candy flesh"),
    copy_from = "candy3_flesh",
    looks_like = "candy3gator",
    color = "green",
    description = ccb.content.text("A chunk of colorful fruit-flavored candy meat, this one is extra chewy."),
    comestible = {},
}

ccb.content.define_item {
    id = "grahmcrackers_shell",
    name = ccb.content.text("graham cracker shell"),
    looks_like = "grahmcrackers",
    mass = "82 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("A dry, sugary piece of shell of a graham cracker."),
    survival_price = "3 USD",
    materials = { "wheat", "junk" },
    volume = "250 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = "90 days",
        kind = "FOOD",
        quench = -4,
        calories = 293,
        vitamins = {
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 6 },
            { id = "wheat_allergen", amount = 1 },
            { id = "junk_allergen", amount = 1 },
        },
        fun = 2,
    },
}

ccb.content.define_item {
    id = "cookie_flesh",
    name = ccb.content.plural_text("chunk of cookie flesh", "chunks of cookie flesh"),
    looks_like = "cookies",
    mass = "132 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("A sweet, delicious chunk of cookie flesh."),
    survival_price = "1 USD 50 cent",
    materials = { "wheat", "junk" },
    volume = "250 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = "60 days",
        kind = "FOOD",
        quench = -1,
        calories = 160,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 6 },
            { id = "wheat_allergen", amount = 1 },
            { id = "junk_allergen", amount = 1 },
        },
        fun = 7,
    },
}
