local ccb = require("ccb")

ccb.content.define_item {
    id = "seed_pineapple",
    copy_from = "seed",
    name = ccb.content.plural_text("pineapple roots", "pineapple roots"),
    description = ccb.content.text("Roots of a pineapple plant, for growing your own."),
    mass = "152 g",
    price = "20 cent",
    volume = "31 ml",
    subtype_order = { "seed", "comestible" },
    seed = {
        plant_name = ccb.content.text("pineapple"),
        fruit = "pineapple",
        byproducts = { "straw_pile" },
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "70 days" },
            { stage = "GROWTH_SEEDLING", duration = "70 days" },
            { stage = "GROWTH_MATURE", duration = "70 days" },
            { stage = "GROWTH_HARVEST", duration = "70 days" },
            { stage = "GROWTH_OVERGROWN", duration = "1 hour" },
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "seed_melon",
    copy_from = "seed_fruit",
    name = ccb.content.plural_text("melon seeds", "melon seeds"),
    description = ccb.content.text("Some melon seeds."),
    subtype_order = { "seed", "comestible" },
    seed = {
        plant_name = ccb.content.text("melon"),
        fruit = "melon",
        byproducts = { "withered" },
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "23 days" },
            { stage = "GROWTH_SEEDLING", duration = "23 days" },
            { stage = "GROWTH_MATURE", duration = "23 days" },
            { stage = "GROWTH_HARVEST", duration = "22 days" },
            { stage = "GROWTH_OVERGROWN", duration = "1 hour" },
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "seed_bananas",
    copy_from = "seed_fruit",
    name = ccb.content.plural_text("banana saplings", "banana saplings"),
    description = ccb.content.text("Some banana saplings."),
    subtype_order = { "seed", "comestible" },
    seed = {
        plant_name = ccb.content.text("banana"),
        fruit = "banana",
        byproducts = { "withered" },
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "30 days" },
            { stage = "GROWTH_SEEDLING", duration = "30 days" },
            { stage = "GROWTH_MATURE", duration = "30 days" },
            { stage = "GROWTH_HARVEST", duration = "30 days" },
            { stage = "GROWTH_OVERGROWN", duration = "1 hour" },
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "seed_orange",
    copy_from = "seed_fruit",
    name = ccb.content.plural_text("orange vines", "orange vines"),
    description = ccb.content.text("Some orange vines.  Definitely GMO."),
    subtype_order = { "seed", "comestible" },
    seed = {
        plant_name = ccb.content.text("orange"),
        fruit = "orange",
        byproducts = { "withered" },
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "23 days" },
            { stage = "GROWTH_SEEDLING", duration = "23 days" },
            { stage = "GROWTH_MATURE", duration = "23 days" },
            { stage = "GROWTH_HARVEST", duration = "22 days" },
            { stage = "GROWTH_OVERGROWN", duration = "1 hour" },
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "seed_lemon",
    copy_from = "seed_fruit",
    name = ccb.content.plural_text("lemon vines", "lemon vines"),
    description = ccb.content.text("Some lemon vines.  Definitely GMO."),
    subtype_order = { "seed", "comestible" },
    seed = {
        plant_name = ccb.content.text("lemon"),
        fruit = "lemon",
        byproducts = { "withered" },
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "23 days" },
            { stage = "GROWTH_SEEDLING", duration = "23 days" },
            { stage = "GROWTH_MATURE", duration = "23 days" },
            { stage = "GROWTH_HARVEST", duration = "22 days" },
            { stage = "GROWTH_OVERGROWN", duration = "1 hour" },
        },
    },
    comestible = {},
}

ccb.content.define_item {
    id = "seed_coconut",
    copy_from = "seed_fruit",
    name = ccb.content.plural_text("subterranean coconut", "subterranean coconuts"),
    description = ccb.content.text("Proof that man went too far before the Cataclysm."),
    subtype_order = { "seed", "comestible" },
    seed = {
        plant_name = ccb.content.text("coconut"),
        fruit = "coconut",
        byproducts = { "withered" },
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "30 days" },
            { stage = "GROWTH_SEEDLING", duration = "30 days" },
            { stage = "GROWTH_MATURE", duration = "30 days" },
            { stage = "GROWTH_HARVEST", duration = "30 days" },
            { stage = "GROWTH_OVERGROWN", duration = "1 hour" },
        },
    },
    comestible = {},
}
