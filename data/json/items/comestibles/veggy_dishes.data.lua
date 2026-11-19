local ccb = require("ccb")

ccb.content.define_item {
    id = "sauerkraut",
    name = ccb.content.plural_text("sauerkraut", "sauerkraut"),
    mass = "255 g",
    color = "green",
    default_container = "jar_glass_sealed",
    symbol = "%",
    description = ccb.content.text("This crunchy, sour topping made from lettuce or cabbage is perfect for your hot dogs and hamburgers, or, if you're desperate, straight to your stomach."),
    display_type = "BY_WEIGHT",
    price = "4 USD 50 cent",
    survival_price = "50 cent",
    materials = { "veggy" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "30 days",
        kind = "FOOD",
        quench = 2,
        calories = 43,
        vitamins = {
            { id = "vitC", amount = 85 },
            { id = "calcium", amount = 17 },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = -2,
    },
}

ccb.content.define_item {
    id = "nopalitos",
    name = ccb.content.text("nopalito"),
    mass = "100 g",
    color = "green",
    symbol = "%",
    description = ccb.content.text("A less prickly version of cactus pads."),
    price = "33 cent",
    survival_price = "16 cent",
    materials = { "veggy" },
    volume = "166 ml",
    stackable = true,
    comestible = {
        shelf_life = "10 days",
        kind = "FOOD",
        quench = 10,
        calories = 15,
        vitamins = {
            { id = "vitC", amount = 9 },
            { id = "calcium", amount = 16 },
            { id = "iron", amount = 3 },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = 3,
    },
}

ccb.content.define_item {
    id = "fiddlehead_boiled",
    name = ccb.content.plural_text("boiled fiddleheads", "boiled fiddleheads"),
    mass = "50 g",
    flags = { "FREEZERBURN", "EATEN_HOT" },
    color = "light_green",
    symbol = "%",
    description = ccb.content.text("Boiled fiddleheads.  Not bad, but would be better sauteed in butter."),
    price = "80 cent",
    survival_price = "25 cent",
    materials = { "veggy" },
    volume = "120 ml",
    stackable = true,
    comestible = {
        shelf_life = "2 days 12 hours",
        kind = "FOOD",
        calories = 18,
        fun = 1,
        vitamins = {
            { id = "vitC", amount = 6 },
            { id = "calcium", amount = 4 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "fiddlehead_sauteed",
    name = ccb.content.plural_text("sauteed fiddleheads", "sauteed fiddleheads"),
    mass = "100 g",
    flags = { "FREEZERBURN", "EATEN_HOT" },
    color = "light_green",
    symbol = "%",
    description = ccb.content.text("Fiddleheads sauteed in fat.  Tender and delicious."),
    price = "4 USD",
    survival_price = "50 cent",
    materials = { "veggy" },
    volume = "240 ml",
    stackable = true,
    comestible = {
        shelf_life = "2 days 12 hours",
        kind = "FOOD",
        calories = 160,
        fun = 5,
        vitamins = {
            { id = "vitC", amount = 32 },
            { id = "calcium", amount = 4 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "jerusalem_artichoke_sauteed",
    name = ccb.content.text("sauteed Jerusalem artichoke"),
    copy_from = "jerusalem_artichoke",
    color = "brown",
    description = ccb.content.text("Most of this artichoke's inulin has been converted into fructose after cooking, and it now tastes pleasantly sweet."),
    price = "0 cent",
    comestible = {
        kind = "FOOD",
        shelf_life = "2 days",
        healthy = 0,
        calories = 150,
        fun = 3,
        vitamins = {
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 11 },
            { id = "vitC", amount = 2 },
        },
    },
    inheritance = { add = { flags = { "EATEN_HOT", "FREEZERBURN" } }, remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "jerusalem_artichoke_boiled",
    name = ccb.content.text("boiled Jerusalem artichoke"),
    copy_from = "jerusalem_artichoke_sauteed",
    description = ccb.content.text("Still crunchy but much more palatable than raw, with a slight nutty taste."),
    comestible = { fun = 2, calories = 120 },
    inheritance = { add = { flags = { "NUTRIENT_OVERRIDE" } } },
}

ccb.content.define_item {
    id = "cooked_bell_pepper",
    name = ccb.content.text("cooked bell pepper"),
    copy_from = "bell_pepper",
    color = "green",
    description = ccb.content.text("A cored and cooked bell pepper.  It is far more enjoyable now that the seeds are removed."),
    price = "0 cent",
    comestible = {
        shelf_life = "2 days",
        fun = 1,
        vitamins = { { id = "vitC", amount = 32 }, { id = "calcium", amount = 4 } },
    },
    inheritance = { remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "groundnut_prepared",
    name = ccb.content.plural_text("prepared ground nuts", "prepared ground nuts"),
    copy_from = "groundnut",
    description = ccb.content.text("Ground nuts that have been peeled and then boiled, to destroy the harmful protease inhibitors.  Safe to eat, but need further cooking to become palatable.  Can be used much like potatoes."),
    comestible = { shelf_life = "2 days", smoking_result = "dry_veggy", healthy = 0, fun = -2 },
    inheritance = { add = { flags = { "EATEN_HOT" } }, remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "groundnut_boiled",
    name = ccb.content.plural_text("boiled ground nuts", "boiled ground nuts"),
    copy_from = "groundnut_prepared",
    description = ccb.content.text("Boiled ground nuts.  They look and taste a little like potatoes, but with a slight nutty taste."),
    display_type = "BY_WEIGHT",
    comestible = { fun = 2 },
}

ccb.content.define_item {
    id = "salsa",
    name = ccb.content.plural_text("salsa", "salsa"),
    mass = "67 g",
    color = "red",
    default_container = "jar_glass_sealed",
    sealed_container = false,
    symbol = "%",
    description = ccb.content.text("Chopped tomatoes, spices, and any number of other vegetables, used as a condiment in Mexican food.  Not so good on its own, but great in a dish."),
    display_type = "BY_WEIGHT",
    price = "50 cent",
    survival_price = "25 cent",
    materials = { { id = "tomato", portions = 10 }, { id = "veggy", portions = 1 } },
    volume = "62 ml",
    flags = { "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "4 days",
        kind = "FOOD",
        quench = 3,
        calories = 42,
        vitamins = { { id = "iron", amount = 2 }, { id = "veggy_allergen", amount = 1 } },
        fun = 2,
    },
}

ccb.content.define_item {
    id = "melitzanosalata",
    name = ccb.content.plural_text("Melitzanosalata", "Melitzanosalata"),
    mass = "260 g",
    color = "brown",
    symbol = "m",
    description = ccb.content.text("A Greek eggplant dip.  The eggplants are baked until almost falling apart and seasoned with a big help of garlic, then mixed with some oil and acid."),
    display_type = "BY_WEIGHT",
    price = "75 cent",
    survival_price = "1 USD 25 cent",
    materials = { { id = "veggy" } },
    volume = "250 ml",
    flags = { "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "6 days",
        kind = "FOOD",
        calories = 155,
        fun = 3,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "onion_sauteed",
    name = ccb.content.plural_text("sauteed onions", "sauteed onions"),
    mass = "129 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Onions cooked up in oil and spices, often used as a topping or side in dishes."),
    display_type = "BY_WEIGHT",
    price = "4 USD",
    survival_price = "2 USD 50 cent",
    materials = { "veggy", "oil" },
    volume = "200 ml",
    flags = { "EATEN_HOT", "EDIBLE_FROZEN", "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "3 days",
        kind = "FOOD",
        calories = 334,
        fun = 6,
        vitamins = {
            { id = "vitC", amount = 12 },
            { id = "calcium", amount = 4 },
            { id = "iron", amount = 2 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "kombu",
    name = ccb.content.plural_text("kombu", "kombu"),
    mass = "10 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("An essential component of Japanese cuisine, this dried sheet of seaweed has hardened to the point of inedibility.  Boiled in water, it should make an excellent broth."),
    price = "10 cent",
    survival_price = "10 cent",
    materials = { "veggy" },
    volume = "25 ml",
    flags = { "INEDIBLE" },
    stackable = true,
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        calories = 17,
        smoking_result = "kombu",
        vitamins = {
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 3 },
            { id = "vitC", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "mashed_potato",
    name = ccb.content.plural_text("mashed potato", "mashed potato"),
    copy_from = "potato_baked",
    color = "white",
    description = ccb.content.text("Boiled potatoes mashed together with salt & oil."),
    display_type = "BY_WEIGHT",
    price = "50 cent",
    survival_price = "30 cent",
    sealed_container = true,
    comestible = { shelf_life = "1 day 12 hours", quench = 3, calories = 136 },
}

ccb.content.define_item {
    id = "vegetarian_dolmas",
    name = ccb.content.plural_text("vegetarian dolmas", "vegetarian dolmas"),
    symbol = "%",
    looks_like = "homemade_burrito",
    description = ccb.content.text("Grape leaves stuffed with rice, vegetables, and spices.  A popular dish in Mediterranean and Middle Eastern cuisines."),
    survival_price = "40 cent",
    materials = { { id = "veggy" } },
    color = "green",
    mass = "110 g",
    volume = "104 ml",
    flags = { "FREEZERBURN" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        shelf_life = "6 days",
        calories = 140,
        fun = 5,
        quench = -2,
        vitamins = {
            { id = "vitC", amount = 10 },
            { id = "iron", amount = 10 },
            { id = "veggy_allergen", amount = 1 },
            { id = "calcium", amount = 4 },
        },
    },
}
