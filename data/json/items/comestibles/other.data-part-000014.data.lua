local ccb = require("ccb")

ccb.content.define_item {
    id = "camp_meal_medium",
    name = ccb.content.plural_text("prepared meal (medium)", "prepared meals (medium)"),
    mass = "600 g",
    volume = "600 ml",
    copy_from = "camp_meal_small",
    comestible = { kind = "FOOD" },
}

ccb.content.define_item {
    id = "camp_meal_large",
    name = ccb.content.plural_text("prepared meal (large)", "prepared meals (large)"),
    mass = "1200 g",
    volume = "1200 ml",
    copy_from = "camp_meal_small",
    comestible = { kind = "FOOD" },
}

ccb.content.define_item {
    id = "press_cake",
    name = ccb.content.text("press cake"),
    description = ccb.content.text("Dry leftovers that remain after extracting the oil from nuts or seeds."),
    mass = "250 g",
    volume = "250 ml",
    price = "1 USD",
    survival_price = "25 cent",
    materials = { "veggy" },
    symbol = "%",
    color = "yellow",
    comestible = {
        kind = "FOOD",
        shelf_life = "300 days",
        calories = 200,
        quench = -15,
        fun = -15,
        freezing_point = -274,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

-- DW 0.2g protein 0.04 fat 0.04 carb... 0.2*4+0.04*4+0.04*9 = 1.326kcal
-- 1 earthworm has such a small amount of vitamins, i'm not sure it's possible to model them.
ccb.content.define_item {
    id = "earthworm",
    name = ccb.content.text("earthworm"),
    description = ccb.content.text("A common earthworm."),
    mass = "2 g",
    volume = "5 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "flesh" },
    symbol = "c",
    color = "brown",
    flags = { "FREEZERBURN", "RAW", "NO_AUTO_CONSUME", "BIRD", "NUTRIENT_OVERRIDE" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        shelf_life = "2 days",
        quench = 1,
        fun = -10,
        calories = 1,
        parasites = 20,
        vitamins = {
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 1 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "earthworm_handful",
    copy_from = "earthworm",
    name = ccb.content.plural_text("handful of earthworms", "handfuls of earthworms"),
    description = ccb.content.text("A handful of earthworms."),
    mass = "20 g",
    volume = "20 ml",
    stackable = true,
    comestible = {
        quench = 10,
        fun = -20,
        calories = 13,
        parasites = 10,
        vitamins = { { id = "calcium", amount = 3 }, { id = "iron", amount = 8 } },
    },
}

-- Dried weight is about 15% of normal
ccb.content.define_item {
    id = "earthworm_dried",
    copy_from = "earthworm_boiled",
    name = ccb.content.plural_text("dried earthworms", "dried earthworms"),
    description = ccb.content.text("Dried, cooked and ground earthworms."),
    symbol = "%",
    flags = { "SMOKED", "NUTRIENT_OVERRIDE" },
    mass = "3 g",
    volume = "3 ml",
    stackable = true,
    comestible = { shelf_life = "100 days", quench = -1, fun = -1 },
}

ccb.content.define_item {
    id = "earthworm_fried",
    copy_from = "earthworm_boiled",
    name = ccb.content.plural_text("fried earthworms", "fried earthworms"),
    description = ccb.content.text("A handful of fried earthworms, cooked in salt."),
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = { fun = 0 },
}

-- 10 earthworms triple-boiled
ccb.content.define_item {
    id = "earthworm_boiled",
    copy_from = "earthworm_handful",
    name = ccb.content.plural_text("boiled earthworms", "boiled earthworms"),
    description = ccb.content.text("A handful of common earthworms, boiled to remove impurities."),
    flags = { "FREEZERBURN", "NUTRIENT_OVERRIDE" },
    comestible = { shelf_life = "5 days", fun = -5, parasites = 0, smoking_result = "earthworm_dried" },
}
