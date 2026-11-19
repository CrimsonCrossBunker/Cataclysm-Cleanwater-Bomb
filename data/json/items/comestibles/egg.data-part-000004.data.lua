local ccb = require("ccb")

ccb.content.define_item {
    id = "egg_burbot",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_burbot", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_sturgeon_lake",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_sturgeon_lake", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_sturgeon_shortnose",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_sturgeon_shortnose", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_fallfish",
    name = ccb.content.plural_text("roe", "roe"),
    copy_from = "egg_fish",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_fallfish", chance = 20 } } },
}

ccb.content.define_item {
    id = "egg_fish_mutant",
    abstract = true,
    name = ccb.content.plural_text("mutant fish roe", "mutant fish roe"),
    description = ccb.content.text("A large half-translucent glob with a mutant fish fry inside."),
    volume = "330 ml",
    mass = "300 g",
    color = "red",
    symbol = "o",
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "egg" },
    flags = { "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "7 days",
        kind = "FOOD",
        calories = 425,
        quench = 50,
        fun = -8,
        vitamins = {
            { id = "vitC", amount = 12 },
            { id = "mutant_toxin", amount = 27 },
            { id = "egg_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "egg_mutant_salmon",
    name = ccb.content.plural_text("mutant fish roe", "mutant fish roe"),
    copy_from = "egg_fish_mutant",
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_fry_mutant_salmon", chance = 45 } } },
}

ccb.content.define_item {
    id = "powder_eggs",
    name = ccb.content.plural_text("powdered egg", "powdered egg"),
    mass = "7 g",
    color = "yellow",
    default_container = "bottle_plastic_small",
    symbol = "%",
    description = ccb.content.text("Whole fresh eggs, dehydrated into an easy to store powder."),
    display_type = "BY_WEIGHT",
    price = "70 cent",
    survival_price = "46 cent",
    materials = { { id = "powder", portions = 10 }, { id = "egg", portions = 1 } },
    volume = "15 ml",
    flags = { "EDIBLE_FROZEN", "NO_AUTO_CONSUME" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        quench = -2,
        calories = 80,
        fun = -4,
        freezing_point = -274,
        vitamins = { { id = "egg_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "rehydrated_eggs",
    copy_from = "egg_chicken",
    name = ccb.content.plural_text("rehydrated egg", "rehydrated egg"),
    color = "yellow",
    symbol = "%",
    looks_like = "powder_egg",
    description = ccb.content.text("Rehydrated eggs.  You can use them instead of eggs when cooking, provided you don't care that they have lost their complete shape."),
    price = "22 cent",
    survival_price = "25 cent",
    flags = {},
    comestible = { quench = 2, fun = -2 },
    inheritance = { add = { rot_spawn = { chance = 0 } } },
}

ccb.content.define_item {
    id = "scrambled_eggs",
    name = ccb.content.plural_text("scrambled eggs", "scrambled eggs"),
    copy_from = "egg_chicken",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("Fluffy and delicious scrambled eggs."),
    price = "4 USD",
    survival_price = "1 USD",
    materials = { "egg" },
    volume = "125 ml",
    flags = { "EATEN_HOT", "FREEZERBURN" },
    stackable = true,
    comestible = { shelf_life = "2 days", fun = 3, vitamins = { { id = "egg_allergen", amount = 1 } } },
    inheritance = { add = { rot_spawn = { chance = 0 } } },
}

ccb.content.define_item {
    id = "seasoned_scrambled_eggs",
    name = ccb.content.plural_text("seasoned scrambled eggs", "seasoned scrambled eggs"),
    copy_from = "scrambled_eggs",
    description = ccb.content.text("Tasty scrambled eggs, with seasoning to taste!"),
    comestible = { fun = 5 },
}

ccb.content.define_item {
    id = "boiled_egg",
    name = ccb.content.text("boiled egg"),
    copy_from = "egg_chicken",
    color = "white",
    symbol = "o",
    description = ccb.content.text("A hard-boiled egg, still in its shell.  Portable and nutritious!"),
    price = "95 cent",
    survival_price = "50 cent",
    materials = { "egg" },
    flags = { "FREEZERBURN" },
    comestible = { quench = -1, fun = 2, vitamins = { { id = "egg_allergen", amount = 1 } } },
    inheritance = { add = { rot_spawn = { chance = 0 } } },
}

ccb.content.define_item {
    id = "egg_salad",
    name = ccb.content.plural_text("egg salad", "egg salad"),
    copy_from = "boiled_egg",
    color = "white",
    symbol = "o",
    description = ccb.content.text("Hard-boiled eggs, mixed into a salad.  Can be made into a sandwich!"),
    price = "95 cent",
    survival_price = "50 cent",
    materials = { "egg" },
    flags = { "FREEZERBURN" },
    comestible = {
        quench = 2,
        shelf_life = "2 hours",
        fun = 4,
        vitamins = { { id = "egg_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "fried_eggs",
    name = ccb.content.plural_text("fried eggs", "fried eggs"),
    copy_from = "scrambled_eggs",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("Sunny-side up eggs fried with a runny yolk and just a bit of crisp on the edges."),
    price = "5 USD",
    survival_price = "1 USD 20 cent",
    materials = { "egg" },
    flags = { "EATEN_HOT", "FREEZERBURN" },
    comestible = { quench = -1, calories = 222, vitamins = { { id = "egg_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "seasoned_fried_eggs",
    name = ccb.content.plural_text("seasoned fried eggs", "seasoned fried eggs"),
    copy_from = "fried_eggs",
    description = ccb.content.text("A tasty fried egg, with seasoning added to taste!"),
    comestible = { fun = 5 },
}

ccb.content.define_item {
    id = "deluxe_fried_eggs",
    name = ccb.content.plural_text("deluxe fried eggs", "deluxe fried eggs"),
    copy_from = "scrambled_eggs",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("Deluxe sunny-side up eggs fried with a runny yolk and just a bit of crisp on the edges with cheese or a vegetable, garnish and condiment."),
    price = "5 USD",
    survival_price = "1 USD 20 cent",
    materials = { "egg", "veggy" },
    flags = { "EATEN_HOT", "FREEZERBURN" },
    comestible = {
        quench = -1,
        calories = 322,
        fun = 10,
        vitamins = { { id = "veggy_allergen", amount = 1 }, { id = "egg_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "fried_egg_sandwich",
    name = ccb.content.plural_text("fried egg sandwich", "fried egg sandwiches"),
    copy_from = "scrambled_eggs",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("Sunny-side up eggs fried with a runny yolk and just a bit of crisp on the edges.  Made into a sandwich, just like Sunday morning."),
    price = "5 USD",
    survival_price = "1 USD 20 cent",
    materials = { "egg", "wheat" },
    flags = { "EATEN_HOT", "FREEZERBURN" },
    comestible = {
        quench = -1,
        calories = 422,
        fun = 4,
        vitamins = { { id = "wheat_allergen", amount = 1 }, { id = "egg_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "deluxe_fried_egg_sandwich",
    name = ccb.content.plural_text("deluxe fried egg sandwich", "deluxe fried egg sandwiches"),
    copy_from = "scrambled_eggs",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("Deluxe sunny-side up eggs fried with a runny yolk and just a bit of crisp on the edges.  Made into a sandwich, just like Sunday morning."),
    price = "5 USD",
    survival_price = "1 USD 20 cent",
    materials = { "egg", "wheat" },
    flags = { "EATEN_HOT", "FREEZERBURN" },
    comestible = {
        quench = -1,
        calories = 422,
        fun = 12,
        vitamins = { { id = "wheat_allergen", amount = 1 }, { id = "egg_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "omelet",
    name = ccb.content.text("omelet"),
    copy_from = "scrambled_eggs",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("A fluffy beaten egg pancaked over with cheese inside."),
    price = "5 USD",
    survival_price = "70 cent",
    materials = { "egg", "milk" },
    flags = { "EATEN_HOT", "FREEZERBURN" },
    comestible = {
        calories = 190,
        vitamins = { { id = "egg_allergen", amount = 1 }, { id = "milk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "vegetable_omelet",
    name = ccb.content.text("vegetable omelet"),
    copy_from = "scrambled_eggs",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("A fluffy beaten egg pancaked over with cheese and vegetables inside."),
    price = "5 USD",
    survival_price = "70 cent",
    materials = { "egg", "milk", "veggy" },
    flags = { "EATEN_HOT", "FREEZERBURN" },
    comestible = {
        calories = 240,
        vitamins = {
            { id = "veggy_allergen", amount = 1 },
            { id = "egg_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "supreme_omelet",
    name = ccb.content.text("supreme omelet"),
    copy_from = "scrambled_eggs",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("A fluffy beaten egg pancaked over with cheese, vegetables, and meat all stuffed inside.  The mother of all omelets."),
    price = "5 USD",
    survival_price = "70 cent",
    materials = { "egg", "milk", "veggy", "flesh" },
    flags = { "EATEN_HOT", "FREEZERBURN" },
    comestible = {
        calories = 350,
        vitamins = {
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
            { id = "egg_allergen", amount = 1 },
            { id = "milk_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "caviar_egg_sandwich",
    name = ccb.content.plural_text("caviar and egg sandwich", "caviar and egg sandwiches"),
    mass = "165 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("A simple sandwich with sliced, hard boiled eggs and mayo to balance out the saltiness of the caviar.  Scandinavian breakfast staple."),
    price = "5 USD",
    survival_price = "3 USD",
    materials = { { id = "bread", portions = 10 }, { id = "egg", portions = 1 } },
    volume = "649 ml",
    comestible = {
        kind = "FOOD",
        calories = 252,
        shelf_life = "4 hours",
        fun = 10,
        vitamins = { { id = "egg_allergen", amount = 1 }, { id = "bread_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "pickled_egg",
    name = ccb.content.text("pickled egg"),
    copy_from = "egg_chicken",
    color = "white",
    symbol = "%",
    description = ccb.content.text("A pickled egg.  Rather salty, but tastes good and lasts for a long time."),
    price = "95 cent",
    survival_price = "75 cent",
    materials = { "egg" },
    flags = { "FREEZERBURN" },
    comestible = {
        shelf_life = "30 days",
        quench = -1,
        fun = 2,
        vitamins = { { id = "egg_allergen", amount = 1 } },
    },
}
