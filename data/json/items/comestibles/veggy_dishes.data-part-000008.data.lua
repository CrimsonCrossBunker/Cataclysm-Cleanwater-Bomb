local ccb = require("ccb")

ccb.content.define_item {
    id = "rehydrated_veggy",
    name = ccb.content.plural_text("rehydrated vegetable", "rehydrated vegetable"),
    conditional_names = {
        {
            kind = "COMPONENT_ID",
            key = "bamboo_cooked",
            name = ccb.content.plural_text("%s, cooked bamboo shoots", "%s, cooked bamboo shoots"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "bell_pepper",
            name = ccb.content.plural_text("%s, bell pepper", "%s, bell pepper"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "broccoli",
            name = ccb.content.plural_text("%s, broccoli", "%s, broccoli"),
        },
        {
            kind = "COMPONENT_ID",
            key = "burdock_cooked",
            name = ccb.content.plural_text("%s, cooked burdock greens", "%s, cooked burdock greens"),
        },
        {
            kind = "COMPONENT_ID",
            key = "plant_stalk",
            name = ccb.content.plural_text("%s, plant stalk", "%s, plant stalk"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "cabbage",
            name = ccb.content.plural_text("%s, cabbage", "%s, cabbage"),
        },
        {
            kind = "COMPONENT_ID",
            key = "carrot",
            name = ccb.content.plural_text("%s, carrot", "%s, carrot"),
        },
        {
            kind = "COMPONENT_ID",
            key = "carrot_wild",
            name = ccb.content.plural_text("%s, wild root", "%s, wild root"),
        },
        {
            kind = "COMPONENT_ID",
            key = "raw_asparagus",
            name = ccb.content.plural_text("%s, raw asparagus", "%s, raw asparagus"),
        },
        {
            kind = "COMPONENT_ID",
            key = "cattail_stalk",
            name = ccb.content.plural_text("%s, cattail stalk", "%s, cattail stalk"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "celery",
            name = ccb.content.plural_text("%s, celery", "%s, celery"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "corn_kernels",
            name = ccb.content.plural_text("%s, corn kernels", "%s, corn kernels"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "cucumber",
            name = ccb.content.plural_text("%s, cucumber", "%s, cucumber"),
        },
        {
            kind = "COMPONENT_ID",
            key = "dandelion_cooked",
            name = ccb.content.plural_text("%s, cooked dandelion greens", "%s, cooked dandelion greens"),
        },
        {
            kind = "COMPONENT_ID",
            key = "grape_leaves",
            name = ccb.content.plural_text("%s, grape leaves", "%s, grape leaves"),
        },
        {
            kind = "COMPONENT_ID",
            key = "groundnut_prepared",
            name = ccb.content.plural_text("%s, ground nuts", "%s, ground nuts"),
        },
        {
            kind = "COMPONENT_ID",
            key = "horseradish_greens",
            name = ccb.content.plural_text("%s, horseradish greens", "%s, horseradish greens"),
        },
        {
            kind = "COMPONENT_ID",
            key = "irradiated_carrot",
            name = ccb.content.plural_text("%s, carrot", "%s, carrot"),
        },
        {
            kind = "COMPONENT_ID",
            key = "japanese_knotweed_stem",
            name = ccb.content.plural_text("%s, Japanese knotweed stem", "%s, Japanese knotweed stem"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "lettuce",
            name = ccb.content.plural_text("%s, lettuce", "%s, lettuce"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "onion",
            name = ccb.content.plural_text("%s, onion", "%s, onion"),
        },
        {
            kind = "COMPONENT_ID",
            key = "plant_sac",
            name = ccb.content.plural_text("%s, fungal fluid sac", "%s, fungal fluid sac"),
        },
        {
            kind = "COMPONENT_ID",
            key = "plantain",
            name = ccb.content.plural_text("%s, cooking banana", "%s, cooking banana"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "potato",
            name = ccb.content.plural_text("%s, potato", "%s, potato"),
        },
        {
            kind = "COMPONENT_ID",
            key = "pumpkin_cut",
            name = ccb.content.plural_text("%s, pumpkin", "%s, pumpkin"),
        },
        {
            kind = "COMPONENT_ID",
            key = "raw_bamboo",
            name = ccb.content.plural_text("%s, bamboo shoots", "%s, bamboo shoots"),
        },
        {
            kind = "COMPONENT_ID",
            key = "raw_burdock",
            name = ccb.content.plural_text("%s, burdock", "%s, burdock"),
        },
        {
            kind = "COMPONENT_ID",
            key = "raw_dandelion",
            name = ccb.content.plural_text("%s, dandelion", "%s, dandelion"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "rhubarb",
            name = ccb.content.plural_text("%s, rhubarb", "%s, rhubarb"),
        },
        {
            kind = "COMPONENT_ID",
            key = "salsify_raw",
            name = ccb.content.plural_text("%s, salsify root", "%s, salsify root"),
        },
        {
            kind = "COMPONENT_ID",
            key = "spinach",
            name = ccb.content.plural_text("%s, spinach", "%s, spinach"),
        },
        {
            kind = "COMPONENT_ID",
            key = "sugar_beet",
            name = ccb.content.plural_text("%s, sugar beet", "%s, sugar beet"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "tomato",
            name = ccb.content.plural_text("%s, tomato", "%s, tomato"),
        },
        {
            kind = "COMPONENT_ID",
            key = "veggy",
            name = ccb.content.plural_text("%s, triffid flesh", "%s, triffid flesh"),
        },
        {
            kind = "COMPONENT_ID",
            key = "veggy_wild",
            name = ccb.content.plural_text("%s, wild vegetables", "%s, wild vegetables"),
        },
        {
            kind = "COMPONENT_ID",
            key = "wild_garlic",
            name = ccb.content.plural_text("%s, wild garlic", "%s, wild garlic"),
        },
        {
            kind = "COMPONENT_ID",
            key = "wild_herbs",
            name = ccb.content.plural_text("%s, wild herbs", "%s, wild herbs"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "zucchini",
            name = ccb.content.plural_text("%s, zucchini", "%s, zucchini"),
        },
    },
    copy_from = "veggy_raw",
    color = "light_green",
    description = ccb.content.text("Reconstituted vegetable flakes, which are much more enjoyable to eat now that they have been rehydrated."),
    display_type = "BY_WEIGHT",
    price = "9 USD",
    survival_price = "50 cent",
    comestible = { shelf_life = "1 day", fun = 2 },
    inheritance = { remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "rehydrated_chili",
    name = ccb.content.text("rehydrated chili pepper"),
    mass = "48 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("Reconstituted chili pepper.  It isn't less spicy after dehydrating and rehydrating but it can be used to flavor your dishes again."),
    price = "16 cent",
    survival_price = "16 cent",
    materials = { "veggy" },
    volume = "70 ml",
    flags = { "EDIBLE_FROZEN" },
    stackable = true,
    comestible = {
        shelf_life = "10 days",
        kind = "FOOD",
        calories = 13,
        quench = -8,
        vitamins = {
            { id = "vitC", amount = 88 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 3 },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = -2,
    },
}

ccb.content.define_item {
    id = "rehydrated_garlic",
    name = ccb.content.text("rehydrated garlic clove"),
    mass = "2 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("Reconstituted garlic cloves, much more edible than its dehydrated state, although the flavor and texture has changed in the process.  Can be used for recipes, albeit its shelf life is shortened by a great margin."),
    price = "8 cent",
    survival_price = "3 cent",
    materials = { "garlic" },
    volume = "21 ml",
    flags = { "EDIBLE_FROZEN" },
    stackable = true,
    comestible = {
        shelf_life = "30 days",
        kind = "FOOD",
        quench = -15,
        calories = 3,
        fun = -3,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "rehydrated_corn_kernels",
    name = ccb.content.plural_text("rehydrated corn kernels", "rehydrated corn kernels"),
    copy_from = "corn_kernels",
    description = ccb.content.text("Reconstituted corn kernels, much more enjoyable to eat now that they have been rehydrated."),
    display_type = "BY_WEIGHT",
    comestible = { shelf_life = "1 day", quench = 2, fun = 2 },
    inheritance = { remove = { flags = { "RAW", "INEDIBLE" } } },
}

ccb.content.define_item {
    id = "veggy_salad",
    name = ccb.content.plural_text("vegetable salad", "vegetable salad"),
    mass = "227 g",
    color = "green",
    default_container = "bowl_plastic",
    symbol = "%",
    description = ccb.content.text("A salad made with all kind of vegetables."),
    price = "3 USD 50 cent",
    survival_price = "1 USD",
    materials = { "veggy" },
    volume = "250 ml",
    flags = { "FREEZERBURN" },
    stackable = true,
    comestible = {
        shelf_life = "5 days 20 hours",
        kind = "FOOD",
        quench = 15,
        calories = 250,
        fun = 6,
        vitamins = {
            { id = "vitC", amount = 30 },
            { id = "calcium", amount = 6 },
            { id = "iron", amount = 10 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "dried_salad",
    name = ccb.content.plural_text("dried salad", "dried salad"),
    copy_from = "veggy_salad",
    mass = "150 g",
    default_container = "box_small",
    description = ccb.content.text("A dried salad packed in a box with mayonnaise and ketchup.  Add water to enjoy."),
    display_type = "BY_WEIGHT",
    materials = { { id = "dried_vegetable", portions = 10 }, { id = "veggy", portions = 1 } },
    price = "2 USD 20 cent",
    survival_price = "1 USD",
    volume = "125 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = { shelf_life = "360 days", quench = -2, fun = -2 },
}

ccb.content.define_item {
    id = "insta_salad",
    name = ccb.content.plural_text("insta-salad", "insta-salad"),
    copy_from = "veggy_salad",
    description = ccb.content.text("A dried salad with water added, not very tasty but still a decent substitution for real salad."),
    display_type = "BY_WEIGHT",
    price = "2 USD 50 cent",
    survival_price = "50 cent",
    comestible = { quench = 16 },
}

ccb.content.define_item {
    id = "dahlia_baked",
    name = ccb.content.text("baked dahlia root"),
    copy_from = "dahlia_root",
    description = ccb.content.text("Baking this dahlia root has broken down the starch, making it softer and sweeter."),
    price = "1 USD 10 cent",
    survival_price = "50 cent",
    flags = { "EATEN_HOT" },
    comestible = { shelf_life = "2 days", fun = 2 },
}

-- From Oregon Trail. Be prepared to lose it as soon as your wagon tips over.
ccb.content.define_item {
    id = "salsify_baked",
    name = ccb.content.plural_text("roasted salsify", "roasted salsifies"),
    copy_from = "salsify_raw",
    description = ccb.content.text("Now that it's been properly cooked, this salsify tastes vaguely like oysters.  Makes a great side dish."),
    price = "90 cent",
    survival_price = "50 cent",
    flags = { "EATEN_HOT" },
    comestible = { shelf_life = "2 days", fun = 2 },
}

ccb.content.define_item {
    id = "sushi_rice",
    name = ccb.content.plural_text("sushi rice", "sushi rice"),
    mass = "55 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("A serving of sticky vinegared rice, commonly used in sushi."),
    display_type = "BY_WEIGHT",
    price = "25 cent",
    survival_price = "1 USD",
    materials = { "veggy" },
    volume = "62 ml",
    stackable = true,
    comestible = {
        shelf_life = "3 days",
        kind = "FOOD",
        quench = -1,
        calories = 267,
        fun = 3,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "onigiri",
    name = ccb.content.plural_text("onigiri", "onigiri"),
    mass = "99 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("A triangular block of tasty sushi rice with a healthy green vegetable folded around it."),
    price = "105 cent",
    survival_price = "50 cent",
    materials = { "veggy" },
    volume = "125 ml",
    stackable = true,
    comestible = {
        shelf_life = "1 day 12 hours",
        kind = "FOOD",
        quench = 1,
        calories = 90,
        fun = 8,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "sushi_veggyroll",
    name = ccb.content.plural_text("vegetable hosomaki", "vegetable hosomaki"),
    mass = "275 g",
    color = "green",
    symbol = "%",
    description = ccb.content.text("Delicious chopped vegetables wrapped in tasty sushi rice and rolled up in a healthy green vegetable."),
    price = "2 USD 90 cent",
    survival_price = "1 USD 50 cent",
    materials = { "veggy" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        shelf_life = "1 day 12 hours",
        kind = "FOOD",
        quench = 1,
        calories = 209,
        fun = 12,
        vitamins = {
            { id = "vitC", amount = 80 },
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 4 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}
