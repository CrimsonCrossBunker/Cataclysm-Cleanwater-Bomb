local ccb = require("ccb")

ccb.content.define_item {
    id = "cured_roe",
    copy_from = "egg_fish",
    name = ccb.content.plural_text("post apocalyptic 'caviar'", "post apocalyptic 'caviar'"),
    description = ccb.content.text("Fish eggs that have been cured in a salty brine.  Can be vacuum sealed to preserve freshness.  Technically caviar only came from a specific type of Sturgeon roe but the FDA allows all cured fish to be referred to as caviar."),
    mass = "48 g",
    volume = "62 ml",
    price = "125 cent",
    survival_price = "62 cent",
    flags = {},
    comestible = { calories = 68, fun = 5 },
}

ccb.content.define_item {
    id = "egg_goose",
    name = ccb.content.text("domestic goose egg"),
    copy_from = "egg_chicken",
    comestible = {
        calories = 266,
        vitamins = {
            { id = "iron", amount = "5 mg" },
            { id = "calcium", amount = "86 mg" },
            { id = "egg_allergen", amount = 1 },
        },
    },
    inheritance = {
        add = { rot_spawn = { monster = "mon_goose_chick" } },
        scale = { volume = 2.88, mass = 2.88 },
    },
}

-- Volume and calories defined manually because proportional rounded them down to 0
ccb.content.define_item {
    id = "egg_hummingbird",
    name = ccb.content.text("ruby-throated hummingbird egg"),
    copy_from = "egg_chicken",
    volume = "1 ml",
    comestible = { shelf_life = "7 days", calories = 1 },
    inheritance = { add = { rot_spawn = { monster = "mon_hummingbird_chick" } }, scale = { mass = 0.01 } },
}

ccb.content.define_item {
    id = "egg_woodpecker",
    name = ccb.content.text("downy woodpecker egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "6 days" },
    inheritance = {
        add = { rot_spawn = { monster = "mon_woodpecker_chick" } },
        scale = { volume = 0.06, mass = 0.06, calories = 0.06 },
    },
}

ccb.content.define_item {
    id = "egg_coot",
    name = ccb.content.text("American coot egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "13 days" },
    inheritance = {
        add = { rot_spawn = { monster = "mon_coot_chick" } },
        scale = { volume = 0.73, mass = 0.73, calories = 0.73 },
    },
}

ccb.content.define_item {
    id = "egg_cormorant",
    name = ccb.content.text("double-crested cormorant egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "14 days" },
    inheritance = { add = { rot_spawn = { monster = "mon_cormorant_chick" } } },
}

ccb.content.define_item {
    id = "egg_moorhen",
    name = ccb.content.text("common gallinule egg"),
    copy_from = "egg_chicken",
    comestible = {},
    inheritance = {
        add = { rot_spawn = { monster = "mon_moorhen_chick" } },
        scale = { volume = 0.73, mass = 0.73, calories = 0.73 },
    },
}

ccb.content.define_item {
    id = "egg_grebe",
    name = ccb.content.text("horned grebe egg"),
    copy_from = "egg_chicken",
    comestible = { shelf_life = "12 days" },
    inheritance = { add = { rot_spawn = { monster = "mon_grebe_chick" } } },
}

ccb.content.define_item {
    id = "egg_water_beetle",
    name = ccb.content.text("water beetle egg"),
    description = ccb.content.text("The egg of a water beetle, usually found near aquatic grass."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_diving_larva", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_water_bug",
    name = ccb.content.text("water scorpion egg"),
    copy_from = "egg_insect",
    description = ccb.content.text("The egg of a water scorpion, usually found near aquatic grass."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_water_scorpion_larva", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_butterfly",
    name = ccb.content.text("butterfly egg"),
    description = ccb.content.text("The egg of a butterfly.  They are usually found clustered on leaves."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_caterpillar_butterfly", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_moth",
    name = ccb.content.text("moth egg"),
    description = ccb.content.text("The egg of a moth.  They are usually found clustered on leaves."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_caterpillar_moth", chance = 50 } } },
}

ccb.content.define_item {
    id = "egg_cicada",
    name = ccb.content.text("cicada egg"),
    description = ccb.content.text("The egg of a cicada.  They are usually found near trees."),
    copy_from = "egg_insect",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_cicada_nymph", chance = 50 } } },
}

ccb.content.define_item {
    id = "menemen",
    name = ccb.content.plural_text("menemen", "menemen"),
    copy_from = "scrambled_eggs",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("A popular traditional Turkish dish which includes eggs, tomato, green peppers, and spices such as ground black and red pepper cooked in olive oil."),
    price = "5 USD",
    survival_price = "2 USD 50 cent",
    materials = { "egg", "veggy" },
    flags = { "EATEN_HOT", "FREEZERBURN" },
    comestible = {
        quench = -1,
        calories = 450,
        fun = 5,
        vitamins = { { id = "veggy_allergen", amount = 1 }, { id = "egg_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "egg_proxy_frog",
    abstract = true,
    copy_from = "egg_fish",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    color = "brown",
    description = ccb.content.text("A large clump of frog eggs.  They're gelatinous and transparent."),
    price = "25 cent",
    survival_price = "50 cent",
    comestible = { fun = -16, vitamins = { { id = "iron", amount = 4 }, { id = "egg_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "egg_leo_frog",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("This is a dense cluster of dark frog's eggs, not dissimilar in appearance to caviar."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_leo_tadpole", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_bullfrog_frog",
    copy_from = "egg_proxy_frog",
    name = ccb.content.plural_text("cluster of frog's eggs", "clusters of frog's eggs"),
    description = ccb.content.text("A thin film of frog eggs floats together atop the water in a roughly circular mass."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_bullfrog_tadpole", chance = 20 } } },
}
