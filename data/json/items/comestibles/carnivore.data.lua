local ccb = require("ccb")

-- Scaled from 100g skin on, boneless, wild duck meat from USDA database
ccb.content.define_item {
    id = "poultry",
    copy_from = "flesh",
    name = ccb.content.plural_text("chunk of poultry meat", "of poultry meat chunks"),
    description = ccb.content.text("A chunk of raw meat from a bird.  Dangerous to eat as-is."),
    display_type = "BY_WEIGHT",
    mass = "104 g",
    volume = "100 ml",
    price = "3 USD",
    survival_price = "25 cent",
    flags = { "RAW", "PREDATOR_FUN" },
    comestible = {
        shelf_life = "1 day",
        calories = 220,
        fun = -18,
        cooks_like = "meat_cooked",
        cooked_item = "meat_cooked",
        cooking_energy = "300 kJ",
        vitamins = {
            { id = "calcium", amount = "5 mg" },
            { id = "iron", amount = "5 mg" },
            { id = "meat_allergen", amount = 1 },
        },
        smoking_result = "poultry_smoked",
    },
}

ccb.content.define_item {
    id = "poultry_scrap",
    copy_from = "poultry",
    name = ccb.content.plural_text("scrap of poultry meat", "of poultry meat scraps"),
    description = ccb.content.text("A tiny scrap of raw meat from a bird.  You figure that one of these should be about one fifth of a portion.  Dangerous to eat as-is."),
    comestible = {
        cooks_like = "meat_scrap_cooked",
        cooked_item = "meat_scrap_cooked",
        cooking_energy = "300 kJ",
        smoking_result = "null",
        vitamins = {
            { id = "calcium", amount = "1 mg" },
            { id = "iron", amount = "1 mg" },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { scale = { mass = 0.2, volume = 0.2, survival_price = 0.2, calories = 0.2 } },
}

ccb.content.define_item {
    id = "poultry_cooked",
    copy_from = "flesh",
    mass = "94 g",
    volume = "100 ml",
    name = ccb.content.plural_text("cooked poultry", "cooked poultry"),
    description = ccb.content.text("A chunk of bird meat that has been cooked.  Nutritious and safe to eat, but a bit bland."),
    price = "4 USD",
    survival_price = "1 USD",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE" },
    comestible = {
        shelf_life = "2 days",
        parasites = 0,
        calories = 220,
        fun = 1,
        vitamins = {
            { id = "calcium", amount = "5 mg" },
            { id = "iron", amount = "5 mg" },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "poultry_pepper",
    copy_from = "flesh",
    mass = "104 g",
    volume = "100 ml",
    name = ccb.content.plural_text("cooked pepper poultry", "cooked pepper poultry"),
    description = ccb.content.text("A cut of bird meat that has been cooked with salt and pepper.  The simple addition of spices has made it much more palatable."),
    price = "5 USD",
    survival_price = "2 USD",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE" },
    comestible = {
        shelf_life = "2 days",
        fun = 3,
        parasites = 0,
        calories = 220,
        vitamins = {
            { id = "calcium", amount = "5 mg" },
            { id = "iron", amount = "5 mg" },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "poultry_scrap_cooked",
    copy_from = "poultry_scrap",
    name = ccb.content.plural_text("cooked scrap of poultry", "of cooked poultry scraps"),
    description = ccb.content.text("A tiny scrap of cooked meat from a bird.  Not very filling, and a bit bland."),
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = {
        parasites = 0,
        fun = 1,
        calories = 55,
        vitamins = {
            { id = "calcium", amount = "1 mg" },
            { id = "iron", amount = "1 mg" },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "poultry_scrap_pepper",
    copy_from = "poultry_scrap",
    name = ccb.content.plural_text("cooked pepper scrap of poultry", "of cooked peppered poultry scraps"),
    description = ccb.content.text("A tiny scrap of cooked bird meat, seasoned with simple spices.  Makes for a nice high-protein snack."),
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = {
        parasites = 0,
        fun = 3,
        calories = 55,
        vitamins = {
            { id = "calcium", amount = "1 mg" },
            { id = "iron", amount = "1 mg" },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "poultry_smoked",
    copy_from = "meat_smoked",
    name = ccb.content.plural_text("chicken jerky", "chicken jerky"),
    mass = "65 g",
    description = ccb.content.text("Strip of bird meat that has been heavily smoked for preservation.  It could be further smoked to dehydrate it completely."),
    color = "brown",
    survival_price = "4 USD",
    flags = { "EATEN_HOT" },
    comestible = { shelf_life = "42 days", calories = 220, smoking_result = "dry_poultry" },
}

ccb.content.define_item {
    id = "mutflesh",
    copy_from = "meat",
    name = ccb.content.plural_text("chunk of mutagenic flesh", "of mutagenic flesh chunks"),
    description = ccb.content.text("A chunk of raw meat with a weirdly off-green coloration.  You could eat it as-is, but are you sure you want to?"),
    flags = { "RAW", "TRADER_AVOID" },
    comestible = {
        smoking_result = "null",
        vitamins = { { id = "mutagenic_slurry", amount = 12 }, { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "nl_flesh_powerbox",
    name = ccb.content.text("fleshy cube"),
    color = "black_red",
    symbol = "%",
    description = ccb.content.text("A dense mound of flesh, shaped into an perfect cube.  It has an oily texture matching that of lubricated, machined parts."),
    price = "30 USD",
    survival_price = "1 USD",
    materials = { "flesh" },
    mass = "1075 g",
    volume = "1000 ml",
    flags = { "RAW", "PREDATOR_FUN" },
    comestible = {
        kind = "FOOD",
        healthy = -1,
        calories = 200,
        quench = 10,
        fun = -25,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}
