local ccb = require("ccb")

ccb.content.define_item {
    id = "meat_cooked",
    copy_from = "flesh",
    mass = "296 g",
    volume = "250 ml",
    name = ccb.content.plural_text("cooked meat", "cooked meat"),
    description = ccb.content.text("A chunk of cooked meat.  It's filling and nutritious, but unseasoned and a bit bland."),
    display_type = "BY_WEIGHT",
    price = "7 USD 50 cent",
    survival_price = "1 USD",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE" },
    comestible = {
        shelf_life = "1 day",
        parasites = 0,
        calories = 402,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "peppermeat",
    copy_from = "flesh",
    mass = "275 g",
    volume = "250 ml",
    name = ccb.content.plural_text("cooked pepper meat", "cooked pepper meat"),
    description = ccb.content.text("A piece of cooked meat, properly seasoned with black pepper and salt.  It's nutritious, yet basic seasoning adds a welcoming taste to this simple dish."),
    display_type = "BY_WEIGHT",
    price = "8 USD",
    survival_price = "1 USD 50 cent",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE" },
    comestible = {
        shelf_life = "1 day",
        fun = 2,
        parasites = 0,
        calories = 402,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

-- Luxury good.
ccb.content.define_item {
    id = "meat_fatty_cooked",
    copy_from = "flesh",
    mass = "296 g",
    volume = "250 ml",
    name = ccb.content.plural_text("cooked fatty meat", "cooked fatty meat"),
    description = ccb.content.text("A chunk of cooked fatty meat.  Although absent of vitamins, it is very filling and delightfully greasy."),
    display_type = "BY_WEIGHT",
    price = "9 USD",
    survival_price = "3 USD",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "1 day",
        calories = 1300,
        fun = 2,
        parasites = 0,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "pepperfat",
    copy_from = "flesh",
    mass = "275 g",
    volume = "250 ml",
    name = ccb.content.plural_text("cooked pepper fatty meat", "cooked pepper fatty meat"),
    description = ccb.content.text("A chunk of cooked fatty meat properly seasoned with black pepper and salt.  Although absent of vitamins, it is very filling, tasty and delightfully greasy."),
    display_type = "BY_WEIGHT",
    price = "9 USD 20 cent",
    survival_price = "3 USD 20 cent",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "1 day",
        calories = 1300,
        fun = 3,
        parasites = 0,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "meat_scrap_cooked",
    copy_from = "meat_scrap",
    name = ccb.content.plural_text("cooked scrap of meat", "of cooked meat scraps"),
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = { parasites = 0, fun = 0, calories = 51 },
}

ccb.content.define_item {
    id = "pepperscrap",
    copy_from = "meat_scrap",
    name = ccb.content.plural_text("cooked pepper scrap of meat", "of cooked pepper meat scraps"),
    description = ccb.content.text("A cooked scrap of meat that has been properly seasoned with pepper and salt.  Small, yet has a good taste."),
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = { parasites = 0, fun = 1, calories = 51 },
}

ccb.content.define_item {
    id = "mutant_meat_cooked",
    copy_from = "mutant_meat",
    name = ccb.content.plural_text("cooked mutant meat", "cooked mutant meat"),
    snippet_category = "cooked_mutant_meat_desc",
    description = ccb.content.text("A cooked chunk of meat from a mutated animal."),
    looks_like = "meat_cooked",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE", "BAD_TASTE" },
    comestible = { parasites = 0, fun = -1 },
    inheritance = { scale = { price = 1.5 } },
}

ccb.content.define_item {
    id = "peppermutant",
    copy_from = "mutant_meat",
    name = ccb.content.plural_text("cooked pepper mutant meat", "cooked pepper mutant meat"),
    snippet_category = "cooked_mutant_meat_desc",
    description = ccb.content.text("A cooked chunk of meat from a mutated animal which has been properly seasoned with black pepper and salt, will keep your hunger away, but even seasoned, it has a weird taste."),
    looks_like = "meat_cooked",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE", "BAD_TASTE" },
    comestible = { parasites = 0, fun = 0 },
    inheritance = { scale = { price = 1.5 } },
}

ccb.content.define_item {
    id = "mutant_meat_scrap_cooked",
    copy_from = "mutant_meat_scrap",
    name = ccb.content.plural_text("cooked scrap of mutant meat", "of cooked mutant meat scraps"),
    description = ccb.content.text("A tiny scrap of cooked mutant meat.  It is small enough that it's hard to tell how disgusting it is."),
    looks_like = "meat_scrap_cooked",
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = { parasites = 0, calories = 25, fun = 0 },
}

ccb.content.define_item {
    id = "pepperscrap_mutant",
    copy_from = "mutant_meat_scrap",
    name = ccb.content.plural_text("cooked pepper scrap of mutant meat", "of cooked pepper mutant meat scraps"),
    description = ccb.content.text("A tiny scrap of cooked mutant meat properly seasoned with black pepper and salt.  It is small, and even though it has been seasoned, it has a weird taste."),
    looks_like = "meat_scrap_cooked",
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = { parasites = 0, calories = 25, fun = 1 },
}

ccb.content.define_item {
    id = "cooked_marrow",
    name = ccb.content.plural_text("roasted bone marrow", "of roasted bone marrow"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("Marvin marrow", "Marvin marrow"),
        },
    },
    description = ccb.content.text("Bone marrow, fully cooked to eliminate any parasites.  Tasty!"),
    display_type = "BY_WEIGHT",
    symbol = "%",
    color = "red",
    mass = "60 g",
    volume = "65 ml",
    price = "5 USD",
    survival_price = "50 cent",
    materials = { "flesh" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        shelf_life = "1 day",
        calories = 471,
        fun = 5,
        vitamins = { { id = "iron", amount = 17 }, { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "pepperbone",
    name = ccb.content.plural_text("roasted peppered bone marrow", "of roasted peppered bone marrow"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("Marvin marrow", "Marvin marrow"),
        },
    },
    description = ccb.content.text("Bone marrow, fully cooked to eliminate any parasites and properly seasoned with black pepper and salt.  Tasty!"),
    display_type = "BY_WEIGHT",
    symbol = "%",
    color = "red",
    mass = "55 g",
    volume = "50 ml",
    price = "5 USD",
    survival_price = "50 cent",
    materials = { "flesh" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        shelf_life = "1 day",
        calories = 471,
        fun = 6,
        vitamins = { { id = "iron", amount = 17 }, { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "offal",
    copy_from = "meat",
    name = ccb.content.plural_text("raw offal", "raw offal"),
    description = ccb.content.text("A selection of uncooked internal organs and entrails.  Filled with essential vitamins, but most people consider it a bit gross unless it's very carefully prepared."),
    survival_price = "25 cent",
    comestible = {
        smoking_result = "null",
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 16 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { scale = { parasites = 0.5 }, offset = { fun = -5 } },
}

ccb.content.define_item {
    id = "offal_cooked",
    copy_from = "offal",
    name = ccb.content.plural_text("cooked offal", "cooked offal"),
    description = ccb.content.text("A selection of cooked organs and entrails.  Filled with essential vitamins, but pretty unappetizing in this form."),
    survival_price = "50 cent",
    flags = { "EATEN_HOT" },
    comestible = { parasites = 0, fun = -5 },
}
