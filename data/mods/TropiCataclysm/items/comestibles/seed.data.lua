local ccb = require("ccb")

ccb.content.define_item {
    id = "seed_melon",
    copy_from = "seed",
    name = ccb.content.plural_text("melon seeds", "melon seeds"),
    mass = "2 g",
    color = "white",
    description = ccb.content.text("Some raw melon seeds."),
    price = "1 cent",
    volume = "2 ml",
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
    use_actions = { "SEED" },
}

ccb.content.define_item {
    id = "seed_banana",
    copy_from = "seed",
    name = ccb.content.plural_text("banana seeds", "banana seeds"),
    mass = "2 g",
    color = "dark_gray",
    description = ccb.content.text("Some raw banana seeds."),
    price = "1 cent",
    volume = "2 ml",
    subtype_order = { "seed", "comestible" },
    seed = {
        plant_name = ccb.content.text("banana"),
        fruit = "banana",
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "23 days" },
            { stage = "GROWTH_SEEDLING", duration = "23 days" },
            { stage = "GROWTH_MATURE", duration = "23 days" },
            { stage = "GROWTH_HARVEST", duration = "22 days" },
            { stage = "GROWTH_OVERGROWN", duration = "1 hour" },
        },
    },
    comestible = {},
    use_actions = { "SEED" },
}

ccb.content.define_item {
    id = "seed_kiwi",
    copy_from = "seed",
    name = ccb.content.plural_text("kiwi seeds", "kiwi seeds"),
    mass = "2 g",
    color = "dark_gray",
    description = ccb.content.text("Some raw kiwi seeds."),
    price = "1 cent",
    volume = "2 ml",
    subtype_order = { "seed", "comestible" },
    seed = {
        plant_name = ccb.content.text("kiwi"),
        fruit = "kiwi",
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
    use_actions = { "SEED" },
}
