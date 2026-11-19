local ccb = require("ccb")

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
