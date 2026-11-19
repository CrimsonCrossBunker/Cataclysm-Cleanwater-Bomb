local ccb = require("ccb")

ccb.content.define_item {
    id = "stomach_boiled",
    copy_from = "small_stomach_boiled",
    name = ccb.content.text("large boiled stomach"),
    description = ccb.content.text("A boiled stomach from an animal, nothing else.  It looks all but appetizing."),
    comestible = { fun = -5 },
    inheritance = { scale = { price = 2.0, calories = 2.0, volume = 2.0, mass = 2.0 } },
}

ccb.content.define_item {
    id = "hstomach_boiled",
    copy_from = "stomach_boiled",
    name = ccb.content.text("boiled large human stomach"),
    description = ccb.content.text("A boiled stomach from a large humanoid creature, nothing else.  It looks all but appetizing."),
    materials = { "hflesh" },
    comestible = {
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "human_flesh_vitamin", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "small_stomach_boiled",
    name = ccb.content.text("boiled stomach"),
    mass = "72 g",
    color = "red",
    symbol = ",",
    description = ccb.content.text("A small boiled stomach from an animal, nothing else.  It looks all but appetizing."),
    price = "3 USD 75 cent",
    survival_price = "10 cent",
    materials = { "flesh" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        calories = 60,
        fun = -3,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "small_hstomach_boiled",
    copy_from = "small_stomach_boiled",
    name = ccb.content.text("boiled human stomach"),
    description = ccb.content.text("A small boiled stomach from a human, nothing else.  It looks all but appetizing."),
    materials = { "hflesh" },
    comestible = {
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "human_flesh_vitamin", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "raw_leather",
    category = "spare_parts",
    name = ccb.content.plural_text("raw hide", "raw hide"),
    mass = "100 g",
    volume = "125 ml",
    color = "pink",
    symbol = ",",
    description = ccb.content.text("A carefully folded raw skin harvested from an animal.  You can cure it for storage and tanning, or eat it if you're desperate enough."),
    price = "3 USD 30 cent",
    survival_price = "20 cent",
    materials = { "flesh" },
    flags = { "TRADER_AVOID" },
    stackable = true,
    comestible = {
        shelf_life = "1 day 12 hours",
        kind = "FOOD",
        quench = -2,
        calories = 350,
        fun = -12,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}
