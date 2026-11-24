local ccb = require("ccb")

-- Thinking this is a single ear here.
ccb.content.define_item {
    id = "corn",
    name = ccb.content.text("corn cob"),
    mass = "140 g",
    color = "light_green",
    symbol = "%",
    description = ccb.content.text("A corn cob full of delicious golden kernels.  You can eat them on the cob or shell it for cooking."),
    price = "1 USD 70 cent",
    survival_price = "50 cent",
    materials = { "veggy" },
    volume = "195 ml",
    flags = { "EATEN_HOT", "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "5 days",
        kind = "FOOD",
        calories = 132,
        vitamins = {
            { id = "vitC", amount = 12 },
            { id = "iron", amount = 4 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "corn_kernels",
    name = ccb.content.plural_text("corn kernels", "handfuls of corn kernels"),
    mass = "60 g",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("Delicious golden kernels of corn."),
    display_type = "BY_WEIGHT",
    price = "2 USD",
    survival_price = "60 cent",
    materials = { "veggy" },
    volume = "83 ml",
    flags = {
        "EDIBLE_FROZEN",
        "EATEN_HOT",
        "RAW",
        "INEDIBLE",
        "CATTLE",
        "PLANTABLE_SEED",
        "BIRD",
        "RAT",
        "MOUSE",
    },
    stackable = true,
    subtype_order = { "seed", "comestible" },
    seed = {
        plant_name = ccb.content.text("corn"),
        fruit = "corn",
        drop_seeds = false,
        byproducts = { "withered" },
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "20 days" },
            { stage = "GROWTH_SEEDLING", duration = "20 days" },
            { stage = "GROWTH_MATURE", duration = "20 days" },
            { stage = "GROWTH_HARVEST", duration = "20 days" },
            { stage = "GROWTH_OVERGROWN", duration = "1 hour" },
        },
        climate = {
            base_c = 10,
            optimum_c = 27,
            min_c = 0,
            max_c = 38,
            degree_days = 860,
            water_mm = 520,
            growing_days = 87,
            water_peak = 0.62,
        },
    },
    comestible = {
        shelf_life = "5 days",
        kind = "FOOD",
        calories = 132,
        smoking_result = "dry_corn",
        vitamins = {
            { id = "vitC", amount = 12 },
            { id = "iron", amount = 4 },
            { id = "veggy_allergen", amount = 1 },
        },
        pet_food = { "CATTLEFOOD" },
    },
}

ccb.content.define_item {
    id = "empty_corn_cob",
    name = ccb.content.text("empty corn cob"),
    mass = "80 g",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("An empty corn cob.  No longer contains any edible kernels, but it can be used to make stock or as fuel."),
    price = "1 cent",
    survival_price = "1 cent",
    materials = { "veggy", "wood" },
    volume = "111 ml",
    flags = { "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "5 days",
        kind = "FOOD",
        fun = -8,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "popcorn_cob",
    name = ccb.content.plural_text("popcorn cob", "popcorn cobs"),
    copy_from = "corn",
    description = ccb.content.text("A popcorn cob full of popcorn kernels.  You can eat them on the cob or shell it for cooking."),
    comestible = { kind = "FOOD", fun = -2 },
    use_actions = { { kind = "consume_drug", used_up_item = "empty_corn_cob", moves = 500 } },
}

ccb.content.define_item {
    id = "popcorn_raw",
    name = ccb.content.plural_text("raw popcorn", "raw popcorn"),
    copy_from = "corn_kernels",
    color = "light_green",
    description = ccb.content.text("A special variety of corn which could be used for making popcorn, after it's dried.  Unlike normal corn, it's not sweet and is more dry."),
    price = "1 USD 70 cent",
    flags = { "NUTRIENT_OVERRIDE", "EATEN_HOT", "RAW", "PLANTABLE_SEED", "CATTLE", "BIRD", "RAT", "MOUSE" },
    subtype_order = { "seed", "comestible" },
    seed = {
        plant_name = ccb.content.text("popcorn"),
        fruit = "popcorn_cob",
        drop_seeds = false,
        byproducts = { "withered" },
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "23 days" },
            { stage = "GROWTH_SEEDLING", duration = "23 days" },
            { stage = "GROWTH_MATURE", duration = "23 days" },
            { stage = "GROWTH_HARVEST", duration = "22 days" },
            { stage = "GROWTH_OVERGROWN", duration = "1 hour" },
        },
        climate = {
            base_c = 10,
            optimum_c = 27,
            min_c = 0,
            max_c = 38,
            degree_days = 1120,
            water_mm = 520,
            growing_days = 111,
            water_peak = 0.66,
        },
    },
    comestible = {
        kind = "FOOD",
        calories = 120,
        fun = -2,
        smoking_result = "kernels",
        pet_food = { "CATTLEFOOD", "BIRDFOOD" },
    },
}

ccb.content.define_item {
    id = "kernels",
    name = ccb.content.plural_text("popcorn kernels", "handfuls of popcorn kernels"),
    mass = "45 g",
    color = "brown",
    default_container = "bag_plastic_small",
    symbol = "%",
    description = ccb.content.text("Dried kernels from a particular type of corn.  Inedible raw, they can be cooked to make a tasty snack."),
    display_type = "BY_WEIGHT",
    price = "1 USD",
    survival_price = "4 USD",
    materials = { "junk" },
    volume = "83 ml",
    flags = {
        "NUTRIENT_OVERRIDE",
        "EDIBLE_FROZEN",
        "PLANTABLE_SEED",
        "INEDIBLE",
        "CATTLE",
        "BIRD",
        "RAT",
        "MOUSE",
    },
    subtype_order = { "seed", "comestible" },
    seed = {
        plant_name = ccb.content.text("popcorn"),
        fruit = "popcorn_cob",
        drop_seeds = false,
        byproducts = { "withered" },
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "23 days" },
            { stage = "GROWTH_SEEDLING", duration = "23 days" },
            { stage = "GROWTH_MATURE", duration = "23 days" },
            { stage = "GROWTH_HARVEST", duration = "22 days" },
            { stage = "GROWTH_OVERGROWN", duration = "1 hour" },
        },
        climate = {
            base_c = 10,
            optimum_c = 27,
            min_c = 0,
            max_c = 38,
            degree_days = 1120,
            water_mm = 520,
            growing_days = 111,
            water_peak = 0.66,
        },
    },
    comestible = {
        kind = "FOOD",
        calories = 120,
        fun = -6,
        pet_food = { "CATTLEFOOD", "BIRDFOOD" },
        vitamins = { { id = "junk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "popcorn",
    name = ccb.content.plural_text("popcorn", "popcorn"),
    mass = "11 g",
    color = "white",
    default_container = "bag_plastic_small",
    symbol = "%",
    description = ccb.content.text("Plain, unseasoned popcorn.  Not as tasty as other kinds, but healthier as a result."),
    price = "28 cent",
    survival_price = "6 cent",
    materials = { "veggy" },
    volume = "62 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        quench = -1,
        calories = 30,
        fun = 4,
        vitamins = { { id = "iron", amount = 2 }, { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "popcorn2",
    name = ccb.content.plural_text("salted popcorn", "salted popcorn"),
    copy_from = "popcorn",
    description = ccb.content.text("Popcorn with salt added for extra flavor."),
    materials = { "junk" },
    comestible = { quench = -3, healthy = -1, fun = 8, vitamins = { { id = "junk_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "popcorn3",
    name = ccb.content.plural_text("buttered popcorn", "buttered popcorn"),
    copy_from = "popcorn",
    description = ccb.content.text("Popcorn with a light covering of butter for extra flavor."),
    materials = { "junk" },
    comestible = { healthy = -1, calories = 50, fun = 10, vitamins = { { id = "junk_allergen", amount = 1 } } },
}

-- Wheatstraw has about 4410 kcal/kg, about 30 kcal will be lost when the wheat is threshed, and another 10 when it's winnowed. Humans can't digest wheatstraw, but many herbivores can.
ccb.content.define_item {
    id = "wheat_stalks",
    name = ccb.content.plural_text("wheat stalks", "sheaves of wheat stalks"),
    mass = "302 g",
    color = "brown",
    symbol = ",",
    description = ccb.content.text("A sheaf of freshly-cut wheat, now ready for drying in a stook or smoker."),
    price = "25 cent",
    display_type = "BY_WEIGHT",
    survival_price = "20 cent",
    materials = { "veggy" },
    flags = { "FRESH_GRAIN", "INEDIBLE", "CATTLE" },
    volume = "1 L",
    stackable = true,
    comestible = {
        kind = "FOOD",
        shelf_life = "22 days",
        calories = 707,
        pet_food = { "CATTLEFOOD" },
        smoking_result = "dry_wheat_stalks",
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

-- This value is completely made up(by me) on the broad assumption that hardier winter crops are also less nutritious. ~10% less calories than regular wheat.
ccb.content.define_item {
    id = "red_winter_wheat_stalks",
    name = ccb.content.plural_text("red winter wheat stalks", "sheaves of red winter wheat stalks"),
    copy_from = "wheat_stalks",
    description = ccb.content.text("A sheaf of freshly-cut winter wheat, now ready for drying in a stook or smoker."),
    comestible = { calories = 640, vitamins = { { id = "veggy_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "dry_wheat_stalks",
    name = ccb.content.plural_text("dried wheat stalks", "sheaves of dried wheat stalks"),
    materials = { { id = "dry_plant", portions = 10 }, { id = "veggy", portions = 1 } },
    mass = "273 g",
    color = "brown",
    symbol = ",",
    description = ccb.content.text("A sheaf of dried wheat stalks.  These will require threshing before anything can be done with them."),
    display_type = "BY_WEIGHT",
    flags = { "INEDIBLE", "CATTLE", "SMOKED", "NUTRIENT_OVERRIDE" },
    price = "25 cent",
    survival_price = "20 cent",
    volume = "900 ml",
    stackable = true,
    comestible = {
        kind = "FOOD",
        quench = -10,
        calories = 707,
        pet_food = { "CATTLEFOOD" },
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "dry_winter_wheat_stalks",
    name = ccb.content.plural_text("dried winter wheat stalks", "sheaves of dried winter wheat stalks"),
    copy_from = "dry_wheat_stalks",
    description = ccb.content.text("A sheaf of dried winter wheat stalks.  These will require threshing before anything can be done with them."),
    comestible = { kind = "FOOD", calories = 640, vitamins = { { id = "veggy_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "threshed_wheat",
    name = ccb.content.plural_text("threshed wheat", "handfuls of threshed wheat"),
    materials = { "wheat" },
    mass = "205 g",
    color = "brown",
    symbol = ",",
    flags = { "INEDIBLE", "CATTLE", "BIRD", "RAT", "MOUSE", "NUTRIENT_OVERRIDE" },
    description = ccb.content.text("Wheat with the chaff still mixed in.  It will have to be winnowed before it's usable."),
    display_type = "BY_WEIGHT",
    price = "25 cent",
    survival_price = "20 cent",
    volume = "252 ml",
    stackable = true,
    comestible = {
        kind = "FOOD",
        quench = -10,
        calories = 677,
        pet_food = { "CATTLEFOOD" },
        vitamins = { { id = "wheat_allergen", amount = 1 } },
    },
}

-- Continuing the trend of hardier winter wheat having ~10% less calories.
ccb.content.define_item {
    id = "threshed_winter_wheat",
    name = ccb.content.plural_text("threshed winter wheat", "handfuls of threshed winter wheat"),
    copy_from = "threshed_wheat",
    comestible = {
        kind = "FOOD",
        quench = -10,
        calories = 610,
        vitamins = { { id = "wheat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "chaff",
    name = ccb.content.plural_text("chaff", "handfuls of chaff"),
    category = "other",
    materials = { { id = "dry_plant", portions = 10 }, { id = "veggy", portions = 1 } },
    mass = "2 g",
    color = "brown",
    symbol = ",",
    flags = { "INEDIBLE", "CATTLE", "BIRD" },
    description = ccb.content.text("Loose bits of dried straw and seed casings from winnowed grain.  There are a few fragments of seeds still mixed in, a big enough pile of this stuff could be made into bird food or cattle fodder."),
    display_type = "BY_WEIGHT",
    price = "0 cent",
    survival_price = "0 cent",
    volume = "2 ml",
    stackable = true,
    comestible = {
        kind = "FOOD",
        quench = -1,
        calories = 10,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

-- These things are rock-hard and not digestible by humans, but birds and cattle can eat them just fine.
ccb.content.define_item {
    id = "wheat",
    name = ccb.content.plural_text("wheat", "handfuls of wheat"),
    mass = "203 g",
    color = "brown",
    symbol = ",",
    description = ccb.content.text("A heap of dried wheatberries, ready for planting.  They're hard as gravel, but could be boiled for food or ground into flour."),
    display_type = "BY_WEIGHT",
    price = "1 USD 20 cent",
    survival_price = "1 USD",
    materials = { "wheat" },
    volume = "250 ml",
    flags = {
        "EDIBLE_FROZEN", "RAW", "INEDIBLE", "CATTLE", "PLANTABLE_SEED", "CUT_HARVEST", "BIRD", "RAT",
        "MOUSE", "NUTRIENT_OVERRIDE",
    },
    stackable = true,
    subtype_order = { "seed", "milling", "comestible" },
    seed = {
        plant_name = ccb.content.text("wheat"),
        fruit = "wheat_stalks",
        drop_seeds = false,
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "30 days" },
            { stage = "GROWTH_SEEDLING", duration = "30 days" },
            { stage = "GROWTH_MATURE", duration = "30 days" },
            { stage = "GROWTH_HARVEST", duration = "30 days" },
            { stage = "GROWTH_OVERGROWN", duration = "1 hour" },
        },
        climate = {
            base_c = 4.4,
            optimum_c = 23,
            min_c = -6,
            max_c = 36,
            degree_days = 1060,
            water_mm = 480,
            growing_days = 109,
            water_peak = 0.7,
        },
    },
    milling = { result = "flour", recipe = "flour_mill_1_15" },
    comestible = {
        kind = "FOOD",
        quench = -10,
        calories = 667,
        vitamins = {
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 40 },
            { id = "wheat_allergen", amount = 1 },
        },
        pet_food = { "CATTLEFOOD", "BIRDFOOD" },
    },
}

-- This avoids copy-from on the base wheat item because that item is coded as a seed despite 'proper' wheat seeds existing. To keep things simple I've not mixed the roles like that.
-- Continuing the trend of hardier winter wheat having ~10% less calories.
ccb.content.define_item {
    id = "winter_wheat",
    name = ccb.content.plural_text("winter wheat", "handfuls of winter wheat"),
    mass = "203 g",
    color = "brown",
    symbol = ",",
    description = ccb.content.text("A heap of dried wheatberries.  They're hard as gravel, but could be boiled for food or ground into flour."),
    display_type = "BY_WEIGHT",
    price = "1 USD 20 cent",
    survival_price = "1 USD",
    materials = { "wheat" },
    volume = "250 ml",
    flags = {
        "EDIBLE_FROZEN", "RAW", "INEDIBLE", "CATTLE", "PLANTABLE_SEED", "CUT_HARVEST", "BIRD", "RAT",
        "MOUSE", "NUTRIENT_OVERRIDE",
    },
    stackable = true,
    subtype_order = { "milling", "comestible" },
    milling = { result = "flour", recipe = "flour_mill_1_15" },
    comestible = {
        kind = "FOOD",
        quench = -10,
        calories = 610,
        vitamins = {
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 40 },
            { id = "wheat_allergen", amount = 1 },
        },
        pet_food = { "CATTLEFOOD", "BIRDFOOD" },
    },
}

ccb.content.define_item {
    id = "barley_stalks",
    name = ccb.content.plural_text("barley stalks", "sheaves of barley stalks"),
    copy_from = "wheat_stalks",
    description = ccb.content.text("A sheaf of freshly-cut barley, now ready for drying in a stook or smoker."),
    comestible = { calories = 775, smoking_result = "dry_barley_stalks" },
}

ccb.content.define_item {
    id = "dry_barley_stalks",
    name = ccb.content.plural_text("dried barley stalks", "sheaves of dried barley stalks"),
    copy_from = "dry_wheat_stalks",
    description = ccb.content.text("A sheaf of dried barley stalks.  These will require threshing before anything can be done with them."),
    comestible = { calories = 775 },
}

ccb.content.define_item {
    id = "threshed_barley",
    name = ccb.content.plural_text("threshed barley", "handfuls of threshed barley"),
    copy_from = "threshed_wheat",
    description = ccb.content.text("Barley with the chaff still mixed in.  It will have to be winnowed before it's usable."),
    comestible = { calories = 745 },
}

ccb.content.define_item {
    id = "barley",
    name = ccb.content.plural_text("barley", "handfuls of barley"),
    mass = "211 g",
    color = "brown",
    symbol = ",",
    description = ccb.content.text("A pile of dried barleycorn, a staple of brewing everywhere.  It can be planted, boiled, or ground into flour."),
    price = "5 cent",
    survival_price = "62 cent",
    materials = { "veggy" },
    volume = "250 ml",
    flags = {
        "EDIBLE_FROZEN", "RAW", "INEDIBLE", "CATTLE", "PLANTABLE_SEED", "CUT_HARVEST", "BIRD", "RAT",
        "MOUSE", "NUTRIENT_OVERRIDE",
    },
    subtype_order = { "seed", "milling", "comestible" },
    seed = {
        plant_name = ccb.content.text("barley"),
        fruit = "barley_stalks",
        drop_seeds = false,
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "18 days" },
            { stage = "GROWTH_SEEDLING", duration = "18 days" },
            { stage = "GROWTH_MATURE", duration = "17 days" },
            { stage = "GROWTH_HARVEST", duration = "17 days" },
            { stage = "GROWTH_OVERGROWN", duration = "1 hour" },
        },
        climate = {
            base_c = 4,
            optimum_c = 21,
            min_c = -5,
            max_c = 32,
            degree_days = 870,
            water_mm = 460,
            growing_days = 90,
            water_peak = 0.65,
        },
    },
    milling = { result = "flour", recipe = "flour_mill_1_15" },
    comestible = {
        kind = "FOOD",
        quench = -10,
        calories = 743,
        vitamins = {
            { id = "calcium", amount = 6 },
            { id = "iron", amount = 29 },
            { id = "veggy_allergen", amount = 1 },
        },
        pet_food = { "CATTLEFOOD", "BIRDFOOD" },
    },
}

ccb.content.define_item {
    id = "oat_stalks",
    name = ccb.content.plural_text("oat stalks", "sheaves of oat stalks"),
    copy_from = "wheat_stalks",
    description = ccb.content.text("A sheaf of freshly-cut oats, now ready for drying in a stook or smoker."),
    price = "12 cent",
    survival_price = "10 cent",
    comestible = { calories = 524, smoking_result = "dry_oat_stalks" },
}

ccb.content.define_item {
    id = "dry_oat_stalks",
    name = ccb.content.plural_text("dried oat stalks", "sheaves of dried oat stalks"),
    copy_from = "dry_wheat_stalks",
    description = ccb.content.text("A sheaf of dried oat stalks.  These will require threshing before anything can be done with them."),
    price = "12 cent",
    survival_price = "10 cent",
    comestible = { quench = -5, calories = 355 },
}

ccb.content.define_item {
    id = "threshed_oats",
    name = ccb.content.plural_text("threshed oats", "handfuls of threshed oats"),
    copy_from = "threshed_wheat",
    description = ccb.content.text("Oats with the chaff still mixed in.  They will have to be winnowed before they're usable."),
    price = "12 cent",
    survival_price = "10 cent",
    comestible = { quench = -5, calories = 524 },
}

-- the calories of 4 units (140 g) of oatmeal
ccb.content.define_item {
    id = "oats",
    name = ccb.content.plural_text("oats", "handfuls of oats"),
    display_type = "BY_WEIGHT",
    mass = "203 g",
    color = "brown",
    symbol = ",",
    description = ccb.content.text("A pile of raw oats."),
    price = "1 USD 20 cent",
    survival_price = "1 USD",
    materials = { "wheat" },
    volume = "250 ml",
    flags = {
        "EDIBLE_FROZEN", "RAW", "INEDIBLE", "CATTLE", "NUTRIENT_OVERRIDE", "PLANTABLE_SEED",
        "CUT_HARVEST", "BIRD", "RAT", "MOUSE",
    },
    subtype_order = { "seed", "milling", "comestible" },
    seed = {
        plant_name = ccb.content.text("oats"),
        fruit = "oat_stalks",
        drop_seeds = false,
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "17 days" },
            { stage = "GROWTH_SEEDLING", duration = "16 days" },
            { stage = "GROWTH_MATURE", duration = "16 days" },
            { stage = "GROWTH_HARVEST", duration = "16 days" },
            { stage = "GROWTH_OVERGROWN", duration = "1 hour" },
        },
        climate = {
            base_c = 4.4,
            optimum_c = 21,
            min_c = -4,
            max_c = 32,
            degree_days = 840,
            water_mm = 480,
            growing_days = 91,
            water_peak = 0.62,
        },
    },
    milling = { result = "flour_wheat_free", recipe = "flour_wheat_free_mill_4_15" },
    comestible = {
        kind = "FOOD",
        quench = -5,
        calories = 524,
        vitamins = {
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 20 },
            { id = "wheat_allergen", amount = 1 },
        },
        pet_food = { "CATTLEFOOD", "BIRDFOOD" },
    },
}

ccb.content.define_item {
    id = "wild_rice_stalks",
    name = ccb.content.plural_text("wild rice stalks", "sheaves of wild rice stalks"),
    copy_from = "buckwheat_stalks",
    description = ccb.content.text("A sheaf of wild rice stalks, ready for drying."),
    price = "12 cent",
    survival_price = "10 cent",
    comestible = { quench = -5, calories = 135, smoking_result = "dry_wild_rice_stalks" },
}

ccb.content.define_item {
    id = "dry_wild_rice_stalks",
    name = ccb.content.plural_text("dried wild rice stalks", "sheaves of dried wild rice stalks"),
    copy_from = "dry_buckwheat_stalks",
    description = ccb.content.text("A bunch of dry wild rice stalks.  Threshing these would knock the grains loose."),
    price = "12 cent",
    survival_price = "10 cent",
    comestible = { quench = -5, calories = 135 },
}

ccb.content.define_item {
    id = "wild_rice",
    name = ccb.content.plural_text("wild rice", "handfuls of wild rice"),
    copy_from = "oats",
    materials = { "veggy" },
    description = ccb.content.text("Raw wild rice, still in its fibrous shell.  It'll need to be milled before it's edible for humans."),
    flags = {
        "EDIBLE_FROZEN",
        "RAW",
        "INEDIBLE",
        "CATTLE",
        "PLANTABLE_SEED",
        "CUT_HARVEST",
        "BIRD",
        "RAT",
        "MOUSE",
    },
    subtype_order = { "seed", "milling", "comestible" },
    seed = {
        plant_name = ccb.content.text("wild rice"),
        fruit = "wild_rice_stalks",
        drop_seeds = false,
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "23 days" },
            { stage = "GROWTH_SEEDLING", duration = "23 days" },
            { stage = "GROWTH_MATURE", duration = "23 days" },
            { stage = "GROWTH_HARVEST", duration = "22 days" },
            { stage = "GROWTH_OVERGROWN", duration = "1 hour" },
        },
        climate = {
            base_c = 10,
            optimum_c = 26,
            min_c = 0,
            max_c = 37,
            degree_days = 1000,
            water_mm = 880,
            growing_days = 110,
            water_peak = 0.6,
        },
    },
    milling = { result = "dry_wild_rice", recipe = "dry_wild_rice_mill_1_5" },
    comestible = { calories = 120, fun = -20, pet_food = { "CATTLEFOOD", "BIRDFOOD" } },
}

ccb.content.define_item {
    id = "buckwheat",
    name = ccb.content.plural_text("buckwheat", "handfuls of buckwheat"),
    mass = "180 g",
    color = "brown",
    symbol = ",",
    description = ccb.content.text("Dry seeds from a wild buckwheat plant.  Inedible in their present state, they are commonly cooked or ground into flour."),
    price = "45 cent",
    survival_price = "2 USD",
    materials = { "veggy" },
    volume = "250 ml",
    flags = {
        "EDIBLE_FROZEN", "RAW", "INEDIBLE", "CATTLE", "PLANTABLE_SEED", "CUT_HARVEST", "BIRD", "RAT",
        "MOUSE", "NUTRIENT_OVERRIDE",
    },
    subtype_order = { "seed", "milling", "comestible" },
    seed = {
        plant_name = ccb.content.text("buckwheat"),
        fruit = "buckwheat_stalks",
        drop_seeds = false,
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "23 days" },
            { stage = "GROWTH_SEEDLING", duration = "23 days" },
            { stage = "GROWTH_MATURE", duration = "23 days" },
            { stage = "GROWTH_HARVEST", duration = "22 days" },
            { stage = "GROWTH_OVERGROWN", duration = "1 hour" },
        },
        climate = {
            base_c = 7,
            optimum_c = 24,
            min_c = -1,
            max_c = 36,
            degree_days = 635,
            water_mm = 300,
            growing_days = 75,
            water_peak = 0.63,
        },
    },
    milling = { result = "flour_wheat_free", recipe = "flour_wheat_free_mill_1_15" },
    comestible = {
        kind = "FOOD",
        quench = -8,
        calories = 616,
        vitamins = {
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 22 },
            { id = "veggy_allergen", amount = 1 },
        },
        pet_food = { "CATTLEFOOD", "BIRDFOOD" },
    },
}

ccb.content.define_item {
    id = "canola_stalks",
    name = ccb.content.plural_text("canola stalks", "sheaves of canola stalks"),
    copy_from = "wheat_stalks",
    mass = "171 g",
    description = ccb.content.text("A sheaf of tall grass with slender little seed pods, now ready for drying."),
    price = "12 cent",
    survival_price = "10 cent",
    volume = "315 ml",
    comestible = { quench = -5, calories = 247, smoking_result = "dry_canola_stalks" },
}

ccb.content.define_item {
    id = "dry_canola_stalks",
    name = ccb.content.plural_text("dried canola stalks", "sheaves of dried canola stalks"),
    copy_from = "dry_wheat_stalks",
    mass = "149 g",
    description = ccb.content.text("A sheaf of dry grass, it must be threshed to separate out the seeds."),
    price = "12 cent",
    survival_price = "10 cent",
    volume = "315 ml",
    comestible = { quench = -5, calories = 247 },
}

ccb.content.define_item {
    id = "threshed_canola",
    name = ccb.content.plural_text("threshed canola", "handfuls of threshed canola"),
    copy_from = "threshed_wheat",
    mass = "134 g",
    description = ccb.content.text("Round black seeds mixed in with dry chaff."),
    price = "12 cent",
    survival_price = "10 cent",
    volume = "252 ml",
    comestible = { quench = -5, calories = 235 },
}

ccb.content.define_item {
    id = "seed_canola",
    name = ccb.content.plural_text("canola seeds", "handfuls of canola seeds"),
    mass = "132 g",
    color = "light_gray",
    symbol = ",",
    category = "seeds",
    description = ccb.content.text("A heap of round black seeds, typically milled and pressed for their oil."),
    price = "20 cent",
    survival_price = "1 USD 50 cent",
    materials = { "veggy" },
    volume = "250 ml",
    flags = {
        "EDIBLE_FROZEN", "RAW", "INEDIBLE", "NUTRIENT_OVERRIDE", "CATTLE", "PLANTABLE_SEED",
        "CUT_HARVEST", "BIRD", "RAT", "MOUSE",
    },
    stackable = true,
    subtype_order = { "seed", "milling", "comestible" },
    seed = {
        plant_name = ccb.content.text("canola"),
        fruit = "canola_stalks",
        drop_seeds = false,
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "23 days" },
            { stage = "GROWTH_SEEDLING", duration = "23 days" },
            { stage = "GROWTH_MATURE", duration = "23 days" },
            { stage = "GROWTH_HARVEST", duration = "22 days" },
            { stage = "GROWTH_OVERGROWN", duration = "1 hour" },
        },
        climate = {
            base_c = 5,
            optimum_c = 22,
            min_c = -5,
            max_c = 34,
            degree_days = 1200,
            water_mm = 420,
            growing_days = 102,
            water_peak = 0.68,
        },
    },
    milling = { result = "paste_seed", recipe = "paste_seed_mill_1_1" },
    comestible = {
        kind = "FOOD",
        quench = -10,
        calories = 230,
        vitamins = {
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 47 },
            { id = "vitC", amount = 7 },
            { id = "veggy_allergen", amount = 1 },
        },
        pet_food = { "CATTLEFOOD", "BIRDFOOD" },
    },
}

ccb.content.define_item {
    id = "dry_lentil_stalks",
    name = ccb.content.plural_text("dried lentil stalks", "sheaves of dried lentil stalks"),
    copy_from = "dry_wheat_stalks",
    mass = "149 g",
    description = ccb.content.text("A pile of short stalks with lentils rattling in their pods.  These plants dried in the field and didn't need a tool to harvest, but they'll still need to be threshed and winnowed."),
    price = "12 cent",
    survival_price = "10 cent",
    volume = "315 ml",
    comestible = { quench = -5, calories = 247 },
}

ccb.content.define_item {
    id = "threshed_lentils",
    name = ccb.content.plural_text("threshed lentils", "handfuls of threshed lentils"),
    copy_from = "threshed_wheat",
    mass = "134 g",
    description = ccb.content.text("Lentils with chaff mixed in.  These will have to be winnowed before they're usable."),
    price = "12 cent",
    survival_price = "10 cent",
    volume = "252 ml",
    comestible = { quench = -5, calories = 235 },
}

ccb.content.define_item {
    id = "dry_lentils",
    name = ccb.content.plural_text("dried lentils", "handfuls of dried lentils"),
    mass = "132 g",
    color = "light_gray",
    default_container = "bag_plastic_small",
    symbol = ",",
    description = ccb.content.text("A humble but nutrient-rich legume.  They should be cooked prior to consumption, unless you're planning to plant them."),
    display_type = "BY_WEIGHT",
    price = "10 cent",
    survival_price = "75 cent",
    materials = { "veggy" },
    volume = "125 ml",
    flags = {
        "EDIBLE_FROZEN", "RAW", "INEDIBLE", "NUTRIENT_OVERRIDE", "CATTLE", "PLANTABLE_SEED", "BIRD",
        "RAT", "MOUSE",
    },
    stackable = true,
    subtype_order = { "seed", "comestible" },
    seed = {
        plant_name = ccb.content.text("lentils"),
        fruit = "dry_lentil_stalks",
        drop_seeds = false,
        growth_stages = {
            { stage = "GROWTH_SEED", duration = "23 days" },
            { stage = "GROWTH_SEEDLING", duration = "23 days" },
            { stage = "GROWTH_MATURE", duration = "23 days" },
            { stage = "GROWTH_HARVEST", duration = "22 days" },
            { stage = "GROWTH_OVERGROWN", duration = "1 hour" },
        },
        climate = {
            base_c = 5,
            optimum_c = 23,
            min_c = -3,
            max_c = 33,
            degree_days = 930,
            water_mm = 365,
            growing_days = 104,
            water_peak = 0.68,
        },
    },
    comestible = {
        kind = "FOOD",
        quench = -10,
        calories = 230,
        vitamins = {
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 47 },
            { id = "vitC", amount = 7 },
            { id = "veggy_allergen", amount = 1 },
        },
        pet_food = { "CATTLEFOOD", "BIRDFOOD" },
    },
}

ccb.content.define_item {
    id = "buckwheat_stalks",
    name = ccb.content.plural_text("buckwheat stalks", "sheaves of buckwheat stalks"),
    mass = "287 g",
    color = "brown",
    symbol = ",",
    description = ccb.content.text("These leafy stalks only get about waist-high and technically aren't a grass, but thanks to their long stems and nutritious seeds, they can still be farmed like any other cereal crop."),
    display_type = "BY_WEIGHT",
    price = "25 cent",
    survival_price = "20 cent",
    materials = { "veggy" },
    flags = { "FRESH_GRAIN", "INEDIBLE", "CATTLE" },
    volume = "315 ml",
    stackable = true,
    comestible = {
        kind = "FOOD",
        shelf_life = "22 days",
        calories = 679,
        pet_food = { "CATTLEFOOD" },
        smoking_result = "dry_buckwheat_stalks",
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "dry_buckwheat_stalks",
    name = ccb.content.plural_text("dried buckwheat stalks", "sheaves of dried buckwheat stalks"),
    materials = { { id = "dry_plant", portions = 10 }, { id = "veggy", portions = 1 } },
    mass = "258 g",
    color = "brown",
    symbol = ",",
    description = ccb.content.text("A heap of dried buckwheat.  It'll need to be threshed before eating, unless you're a cow."),
    display_type = "BY_WEIGHT",
    flags = { "INEDIBLE", "CATTLE", "SMOKED", "NUTRIENT_OVERRIDE" },
    price = "25 cent",
    survival_price = "20 cent",
    volume = "315 ml",
    stackable = true,
    comestible = {
        kind = "FOOD",
        quench = -10,
        calories = 679,
        pet_food = { "CATTLEFOOD" },
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "threshed_buckwheat",
    name = ccb.content.plural_text("threshed buckwheat", "handfuls of threshed buckwheat"),
    materials = { "wheat" },
    mass = "190 g",
    color = "brown",
    symbol = ",",
    flags = { "INEDIBLE", "CATTLE", "BIRD", "RAT", "MOUSE", "NUTRIENT_OVERRIDE" },
    description = ccb.content.text("A pile of buckwheat seeds with some chaff still mixed in.  Once it's winnowed, it'll be ready for use."),
    display_type = "BY_WEIGHT",
    price = "25 cent",
    survival_price = "20 cent",
    volume = "290 ml",
    stackable = true,
    comestible = {
        kind = "FOOD",
        quench = -10,
        calories = 677,
        pet_food = { "CATTLEFOOD" },
        vitamins = { { id = "wheat_allergen", amount = 1 } },
    },
}
