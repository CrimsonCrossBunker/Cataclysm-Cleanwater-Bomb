local ccb = require("ccb")

ccb.content.define_item {
    id = "yum_lichen_extra",
    name = ccb.content.plural_text("clump of processed lichen", "clumps of processed lichen"),
    mass = "115 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("A clump of squishy lichen, while it isn't as wet as it used to be, your hands no longer tingle holding it."),
    price = "6 cent",
    volume = "25 ml",
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = {
        kind = "FOOD",
        calories = 300,
        healthy = 3,
        quench = 10,
        fun = -3,
        vitamins = {
            { id = "calcium", amount = 5 },
            { id = "iron", amount = 12 },
            { id = "vitC", amount = 56 },
        },
    },
}

ccb.content.define_item {
    id = "frost_human_flesh",
    copy_from = "flesh",
    name = ccb.content.plural_text("chunk of frostbitten human meat", "chunks of frostbitten human meat"),
    description = ccb.content.text("Freshly butchered meat from a frozen human carcass, not the most appetizing."),
    mass = "296 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "50 cent",
    flags = { "RAW" },
    comestible = {
        shelf_life = "1 day",
        calories = 402,
        healthy = -1,
        fun = -10,
        cooks_like = "meat_cooked",
        vitamins = {
            { id = "vitC", amount = 13 },
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 53 },
            { id = "mutant_toxin", amount = 25 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
        smoking_result = "meat_smoked",
    },
}

ccb.content.define_item {
    id = "frost_human_cooked",
    copy_from = "frost_human_flesh",
    name = ccb.content.plural_text("cooked freezerburned human meat", "cooked freezerburned human meat"),
    description = ccb.content.text("A freshly cooked slice of human meat, it has severe frostburn."),
    flags = { "EATEN_HOT" },
    comestible = { parasites = 0, healthy = 0, fun = 0 },
    inheritance = { scale = { price = 1.5 } },
}

ccb.content.define_item {
    id = "frost_hstomach",
    copy_from = "flesh",
    name = ccb.content.text("frostbitten human stomach"),
    description = ccb.content.text("A shriveled gray stomach, it hasn't seen use in a very long time."),
    mass = "72 g",
    volume = "250 ml",
    survival_price = "25 cent",
    price = "2 USD",
    comestible = {
        vitamins = { { id = "mutant_toxin", amount = 25 }, { id = "human_flesh_vitamin", amount = 1 } },
        shelf_life = "8 hours",
        calories = 60,
        quench = 1,
        healthy = -1,
        fun = -15,
    },
}
