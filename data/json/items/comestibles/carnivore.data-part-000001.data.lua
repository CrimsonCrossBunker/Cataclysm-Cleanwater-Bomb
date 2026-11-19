local ccb = require("ccb")

-- Nutrition information from USDA
ccb.content.define_item {
    id = "froglegs",
    copy_from = "flesh",
    name = ccb.content.plural_text("frog legs (pair)", "frog legs (pair)"),
    description = ccb.content.text("A raw pair of frog legs.  Tastes like chicken when cooked or smoked."),
    mass = "100 g",
    volume = "100 ml",
    price = "10 USD",
    survival_price = "15 cent",
    flags = { "RAW" },
    comestible = {
        shelf_life = "12 hours",
        smoking_result = "froglegs_smoked",
        vitamins = {
            { id = "calcium", amount = 18 },
            { id = "iron", amount = 1 },
            { id = "meat_allergen", amount = 1 },
        },
        calories = 73,
    },
}

ccb.content.define_item {
    id = "froglegs_cooked",
    copy_from = "froglegs",
    name = ccb.content.plural_text("cooked frog legs (pair)", "cooked frog legs (pair)"),
    flags = { "EATEN_HOT" },
    survival_price = "1 USD",
    comestible = { parasites = 0, shelf_life = "1 day" },
}

ccb.content.define_item {
    id = "froglegs_smoked",
    copy_from = "froglegs_cooked",
    name = ccb.content.plural_text("smoked frog legs (pair)", "smoked frog legs (pair)"),
    color = "brown",
    survival_price = "2 USD",
    flags = { "EATEN_HOT", "SMOKED" },
    comestible = { shelf_life = "42 days", quench = -1, fun = 5, smoking_result = "dry_froglegs" },
}

-- Nutrition information based on whitefish
ccb.content.define_item {
    id = "fish",
    copy_from = "flesh",
    name = ccb.content.plural_text("fillet of fish", "fillets of fish"),
    description = ccb.content.text("An uncooked fish fillet.  Makes a passable meal raw."),
    mass = "148 g",
    volume = "150 ml",
    price = "5 USD",
    survival_price = "50 cent",
    flags = { "RAW" },
    comestible = {
        shelf_life = "12 hours",
        smoking_result = "fish_smoked",
        vitamins = {
            { id = "vitC", amount = 2 },
            { id = "calcium", amount = 6 },
            { id = "iron", amount = 14 },
            { id = "meat_allergen", amount = 1 },
        },
        calories = 260,
    },
}

ccb.content.define_item {
    id = "fish_scrap",
    copy_from = "fish",
    name = ccb.content.plural_text("scrap of fish", "scraps of fish"),
    description = ccb.content.text("A tiny scrap of edible fish.  It's not much, but it'll do in a pinch."),
    display_type = "BY_WEIGHT",
    comestible = {
        cooks_like = "fish_scrap_cooked",
        cooked_item = "fish_scrap_cooked",
        cooking_energy = "300 kJ",
        smoking_result = "null",
        vitamins = {
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 1 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { scale = { mass = 0.1, volume = 0.1, price = 0.1, calories = 0.1 } },
}

ccb.content.define_item {
    id = "fish_scrap_cooked",
    copy_from = "fish_scrap",
    name = ccb.content.plural_text("cooked scrap of fish", "cooked scraps of fish"),
    display_type = "BY_WEIGHT",
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = { parasites = 0, shelf_life = "1 day", calories = 51 },
}

ccb.content.define_item {
    id = "fish_cooked",
    copy_from = "fish",
    name = ccb.content.plural_text("cooked fish", "cooked fish"),
    description = ccb.content.text("A cooked fish fillet.  Very nutritious."),
    survival_price = "1 USD",
    flags = { "EATEN_HOT" },
    comestible = { shelf_life = "1 day", parasites = 0 },
    inheritance = { scale = { price = 1.5 } },
}

-- Nutrition information based on whitefish
ccb.content.define_item {
    id = "lobster",
    copy_from = "flesh",
    name = ccb.content.plural_text("chunk of lobster meat", "chunks of lobster meat"),
    description = ccb.content.text("A chunk of uncooked lobster meat."),
    display_type = "BY_WEIGHT",
    mass = "148 g",
    volume = "150 ml",
    price = "5 USD",
    survival_price = "50 cent",
    flags = { "RAW" },
    comestible = {
        shelf_life = "12 hours",
        smoking_result = "lobster_smoked",
        vitamins = {
            { id = "vitC", amount = 2 },
            { id = "calcium", amount = 6 },
            { id = "iron", amount = 14 },
            { id = "meat_allergen", amount = 1 },
        },
        calories = 250,
    },
}

ccb.content.define_item {
    id = "lobster_cooked",
    copy_from = "fish",
    name = ccb.content.plural_text("cooked lobster", "cooked lobster"),
    description = ccb.content.text("A chunk of delicious cooked lobster meat."),
    display_type = "BY_WEIGHT",
    survival_price = "1 USD 50 cent",
    flags = { "EATEN_HOT" },
    comestible = { shelf_life = "1 day", parasites = 0 },
    inheritance = { scale = { price = 1.5 } },
}

-- Nutrition information roughly based on squid. if you know more pls expand
ccb.content.define_item {
    id = "mollusk",
    copy_from = "flesh",
    name = ccb.content.plural_text("fillet of mollusk", "fillets of mollusk"),
    description = ccb.content.text("The raw flesh of a mollusk.  Must be cleaned and cooked before eating."),
    mass = "148 g",
    volume = "150 ml",
    price = "5 USD",
    survival_price = "50 cent",
    flags = { "RAW" },
    comestible = {
        shelf_life = "12 hours",
        smoking_result = "mollusk_smoked",
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 6 },
            { id = "iron", amount = 2 },
            { id = "meat_allergen", amount = 1 },
        },
        calories = 260,
    },
}

ccb.content.define_item {
    id = "mollusk_cooked",
    copy_from = "mollusk",
    name = ccb.content.plural_text("cooked mollusk", "cooked mollusk"),
    description = ccb.content.text("Cooked mollusk meat.  Devoid of any parasites or bacteria due to heat, the only thing left to do is add sauce."),
    survival_price = "1 USD 50 cent",
    flags = { "EATEN_HOT" },
    comestible = { shelf_life = "1 day", parasites = 0 },
    inheritance = { scale = { price = 1.5 } },
}

-- Nutrition information roughly based on a serving of 6 snails. if you know more pls expand
ccb.content.define_item {
    id = "gastropod_purged",
    copy_from = "flesh",
    name = ccb.content.plural_text("purged gastropods", "purged gastropods"),
    description = ccb.content.text("A handful of lucky gastropods that have been prepared for cooking by repeatedly boiling and washing them to remove their mucus and pathogens."),
    mass = "15 g",
    volume = "15 ml",
    price = "5 USD",
    survival_price = "50 cent",
    flags = { "RAW" },
    comestible = {
        shelf_life = "12 hours",
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 1 },
            { id = "meat_allergen", amount = 1 },
        },
        calories = 15,
    },
}

ccb.content.define_item {
    id = "gastropod_cooked",
    copy_from = "gastropod_purged",
    name = ccb.content.plural_text("cooked gastropods", "cooked gastropods"),
    description = ccb.content.text("Cooked gastropods.  A bit low on calories, but high in protein."),
    survival_price = "1 USD 50 cent",
    flags = { "EATEN_HOT" },
    comestible = { shelf_life = "1 day", parasites = 0 },
    inheritance = { scale = { price = 1.5 } },
}

ccb.content.define_item {
    id = "oyster",
    category = "food",
    name = ccb.content.plural_text("oyster in shell", "oysters in shell"),
    mass = "48 g",
    color = "light_gray",
    symbol = "o",
    materials = { "chitin", "flesh" },
    description = ccb.content.text("A medium-sized oyster.  Delicious served raw on the half-shell.  You'll need to shuck it to eat it."),
    price = "1 USD",
    survival_price = "10 cent",
    volume = "40 ml",
    flags = { "INEDIBLE" },
    stackable = true,
    comestible = { kind = "FOOD", shelf_life = "15 days" },
}

ccb.content.define_item {
    id = "oyster_shucked",
    copy_from = "oyster",
    name = ccb.content.text("shucked oyster"),
    mass = "20 g",
    color = "white",
    materials = { "flesh" },
    description = ccb.content.text("A live oyster floating in its liquor."),
    volume = "25 ml",
    flags = { "EATEN_COLD" },
    comestible = {
        calories = 12,
        shelf_life = "1 hour",
        fun = 5,
        vitamins = {
            { id = "meat_allergen", amount = 1 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 6 },
        },
    },
}

ccb.content.define_item {
    id = "hstomach",
    copy_from = "stomach",
    name = ccb.content.text("human stomach"),
    description = ccb.content.text("The stomach of a human.  It is surprisingly durable."),
    materials = { "hflesh" },
    comestible = {
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "human_flesh_vitamin", amount = 1 } },
    },
    inheritance = { remove = { flags = { "PREDATOR_FUN" } } },
}

ccb.content.define_item {
    id = "hstomach_large",
    copy_from = "hstomach",
    name = ccb.content.text("large human stomach"),
    description = ccb.content.text("The stomach of a large humanoid creature.  It is surprisingly durable."),
    comestible = {},
    inheritance = { scale = { mass = 2.0, volume = 2.0, price = 1.5, calories = 2.0 } },
}

ccb.content.define_item {
    id = "human_fat",
    copy_from = "fat",
    name = ccb.content.plural_text("chunk of human fat", "chunks of human fat"),
    description = ccb.content.text("A chunk of raw fat, harvested from a human body."),
    display_type = "BY_WEIGHT",
    materials = { "hflesh" },
    comestible = {
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "human_flesh_vitamin", amount = 1 } },
    },
}

-- *May* have been commercially traded.
ccb.content.define_item {
    id = "human_tallow",
    name = ccb.content.plural_text("human tallow", "human tallow"),
    copy_from = "tallow",
    description = ccb.content.text("A smooth, white block of cleaned and rendered human fat.  It will remain edible for a very long time, and can be used as an ingredient in many foods and projects."),
    display_type = "BY_WEIGHT",
    price = "5 USD",
    materials = { "hflesh" },
    comestible = {
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "human_flesh_vitamin", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "human_flesh",
    copy_from = "meat",
    name = ccb.content.plural_text("human flesh", "human flesh"),
    description = ccb.content.text("A chunk of raw meat, butchered from a human body."),
    display_type = "BY_WEIGHT",
    materials = { "hflesh" },
    comestible = {
        cooks_like = "human_cooked",
        cooked_item = "human_cooked",
        cooking_energy = "300 kJ",
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "human_flesh_vitamin", amount = 1 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { remove = { flags = { "PREDATOR_FUN" } } },
}

ccb.content.define_item {
    id = "human_cooked",
    copy_from = "human_flesh",
    name = ccb.content.plural_text("cooked creep", "cooked creep"),
    description = ccb.content.text("A cooked slice of 'long pig'.  Tastes vary from person to person."),
    display_type = "BY_WEIGHT",
    flags = { "EATEN_HOT" },
    comestible = { parasites = 0, fun = 0 },
    inheritance = { scale = { price = 1.5 } },
}

ccb.content.define_item {
    id = "pepperhuman",
    copy_from = "human_flesh",
    name = ccb.content.plural_text("peppered person", "peppered person"),
    description = ccb.content.text("A cooked slice of some person, seasoned with black pepper and salt.  Probably has better taste than they did when alive."),
    display_type = "BY_WEIGHT",
    flags = { "EATEN_HOT" },
    comestible = { parasites = 0, fun = 2 },
    inheritance = { scale = { price = 1.5 } },
}

ccb.content.define_item {
    id = "meat",
    copy_from = "flesh",
    name = ccb.content.plural_text("chunk of meat", "of meat chunks"),
    description = ccb.content.text("A chunk of raw meat.  You could eat it as-is, but cooking it is better."),
    display_type = "BY_WEIGHT",
    mass = "275 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "50 cent",
    flags = { "RAW", "PREDATOR_FUN" },
    comestible = {
        shelf_life = "1 day",
        calories = 402,
        fun = -10,
        cooks_like = "meat_cooked",
        cooked_item = "meat_cooked",
        cooking_energy = "300 kJ",
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "meat_allergen", amount = 1 },
        },
        smoking_result = "meat_smoked",
    },
}

ccb.content.define_item {
    id = "animal_blood",
    display_type = "BY_VOLUME",
    copy_from = "meat",
    name = ccb.content.plural_text("animal blood", "animal blood"),
    description = ccb.content.text("Blood extracted from a living creature."),
    mass = "262 g",
    volume = "250 ml",
    materials = { "blood" },
    looks_like = "blood",
    symbol = "~",
    phase = "liquid",
    comestible = { parasites = 0, kind = "DRINK", servings = 1, smoking_result = "null" },
}

ccb.content.define_item {
    id = "porkbelly",
    copy_from = "flesh",
    name = ccb.content.plural_text("chunk of porkbelly", "of porkbelly chunks"),
    description = ccb.content.text("A fatty cut of pork from the belly, popular in some cuisine.  With proper technique, it can be used to create bacon.  Not safe to consume in its current raw form."),
    display_type = "BY_WEIGHT",
    mass = "296 g",
    volume = "300 ml",
    price = "6 USD 50 cent",
    survival_price = "1 USD 50 cent",
    flags = { "RAW", "PREDATOR_FUN" },
    comestible = {
        shelf_life = "1 day",
        calories = 1300,
        fun = -10,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 22 },
            { id = "meat_allergen", amount = 1 },
        },
        smoking_result = "meat_smoked",
    },
}

ccb.content.define_item {
    id = "raw_cured_fatty_meat",
    copy_from = "porkbelly",
    name = ccb.content.plural_text("slab of raw cured porkbelly", "of raw cured porkbelly slabs"),
    description = ccb.content.text("Porkbelly that has been preserved and flavored with salt and sugar to draw out the moisture from the first layer.  Still raw, it is ready for smoking into bacon."),
    price = "6 USD 50 cent",
    survival_price = "3 USD",
    flags = { "RAW" },
    comestible = { calories = 1556, fun = 0, shelf_life = "14 days", smoking_result = "bacon_uncut" },
    inheritance = { offset = { mass = "-25g", volume = "-25ml" } },
}

-- High price to reflect the rarity and value of bacon. Note that this is three pieces of it.
ccb.content.define_item {
    id = "bacon_uncut",
    copy_from = "raw_cured_fatty_meat",
    name = ccb.content.plural_text("large slab of uncut bacon", "of large uncut bacon slabs"),
    description = ccb.content.text("A huge slab of uncut smoked bacon.  You can eat it as is, but it would be more efficient to cut it into smaller portions with a knife."),
    price = "20 USD",
    survival_price = "30 USD",
    flags = { "EATEN_HOT", "SMOKED" },
    comestible = { calories = 1566, shelf_life = "42 days", fun = 5 },
    inheritance = { offset = { mass = "-25g", volume = "-25ml" } },
}

ccb.content.define_item {
    id = "bacon_uncooked",
    copy_from = "bacon_uncut",
    flags = { "EATEN_HOT", "SMOKED" },
    name = ccb.content.plural_text("uncooked bacon", "pieces of uncooked bacon"),
    description = ccb.content.text("A thick slab of salty cured bacon."),
    mass = "85 g",
    volume = "125 ml",
    color = "pink",
    symbol = "%",
    price = "950 cent",
    survival_price = "250 cent",
    comestible = {
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 6 },
            { id = "meat_allergen", amount = 1 },
        },
        quench = -2,
        calories = 398,
        fun = 1,
    },
}
