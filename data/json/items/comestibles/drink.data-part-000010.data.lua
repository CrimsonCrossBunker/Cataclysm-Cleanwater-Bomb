local ccb = require("ccb")

ccb.content.define_item {
    id = "water_spring",
    copy_from = "water_clean",
    name = ccb.content.plural_text("spring water", "spring water"),
    description = ccb.content.text("Natural alpine spring water, bottled at the source."),
    display_type = "BY_VOLUME",
    comestible = {},
    inheritance = { offset = { fun = 1 } },
}

ccb.content.define_item {
    id = "water_mineral",
    copy_from = "water_clean",
    name = ccb.content.plural_text("mineral water", "mineral water"),
    description = ccb.content.text("Fancy mineral water, so fancy it makes you feel fancy just holding it."),
    display_type = "BY_VOLUME",
    comestible = {},
    inheritance = { scale = { quench = 1.2 }, offset = { fun = 1 } },
}

ccb.content.define_item {
    id = "tea_green",
    name = ccb.content.plural_text("green tea", "green tea"),
    conditional_names = {
        {
            kind = "FLAG",
            key = "COLD",
            name = ccb.content.plural_text("iced green tea", "iced green tea"),
        },
    },
    copy_from = "tea",
    color = "green",
    description = ccb.content.text("Made from applying hot water to leaves of the tea plant \"Camellia sinensis\".  Green tea has a lighter, fresher taste than black and is traditionally preferred in Asian cultures."),
    display_type = "BY_VOLUME",
    comestible = { vitamins = { { id = "caffeine", amount = 40 } } },
}

ccb.content.define_item {
    id = "tea_fruit",
    name = ccb.content.plural_text("fruit tea", "fruit tea"),
    conditional_names = {
        {
            kind = "FLAG",
            key = "COLD",
            name = ccb.content.plural_text("iced fruit tea", "iced fruit tea"),
        },
    },
    copy_from = "tea",
    color = "red",
    description = ccb.content.text("A tasty beverage made with herbs and dried fruit from plants other than the tea plant.  While colloquially called 'tea', technically it's an infusion."),
    display_type = "BY_VOLUME",
    comestible = { sleepiness = 0, stimulation = 0, fun = 8 },
}

ccb.content.define_item {
    id = "coffee_sweetened",
    copy_from = "coffee",
    name = ccb.content.plural_text("sweetened coffee", "sweetened coffee"),
    description = ccb.content.text("The morning ritual of the pre-apocalyptic world, created from coffee cherries through a complex process of seed removal, roasting, grinding, and brewing.  Coffee is substantially richer in caffeine than its rival tea.  With added sweetener for better taste."),
    display_type = "BY_VOLUME",
    price = "1 USD 10 cent",
    survival_price = "60 cent",
    materials = { "water" },
    comestible = { calories = 21, fun = 10 },
}

ccb.content.define_item {
    id = "tea_sweetened",
    copy_from = "tea",
    name = ccb.content.plural_text("sweetened tea", "sweetened tea"),
    conditional_names = {
        {
            kind = "FLAG",
            key = "COLD",
            name = ccb.content.plural_text("sweet iced tea", "sweet iced tea"),
        },
    },
    description = ccb.content.text("The beverage of gentlemen everywhere, made from applying hot water to leaves of the tea plant \"Camellia sinensis\".  With added sweetener for a better taste.  Can also be served cold as iced tea."),
    display_type = "BY_VOLUME",
    price = "1 USD",
    survival_price = "35 cent",
    comestible = { calories = 21, fun = 10 },
    inheritance = { add = { flags = { "EATEN_COLD" } } },
}

ccb.content.define_item {
    id = "milk_tea_sweetened",
    copy_from = "milk_tea",
    name = ccb.content.plural_text("sweetened milk tea", "sweetened milk tea"),
    description = ccb.content.text("Hot tea with cold milk and added sweetener."),
    display_type = "BY_VOLUME",
    price = "4 USD 60 cent",
    survival_price = "60 cent",
    comestible = {
        calories = 88,
        vitamins = { { id = "vitC", amount = 2 }, { id = "calcium", amount = 12 } },
        fun = 14,
    },
}

ccb.content.define_item {
    id = "coffee_substitute_sweetened",
    copy_from = "coffee_substitute",
    name = ccb.content.plural_text("sweetened coffee substitute", "sweetened coffee substitute"),
    description = ccb.content.text("Homemade not-coffee created from the Kentucky coffeetree, just like the Meskwaki tribe!  Doesn't actually have any caffeine, but it'll pass in a pinch.  The added sweetener neutralizes the bitterness somewhat."),
    display_type = "BY_VOLUME",
    price = "1 USD 10 cent",
    survival_price = "35 cent",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE" },
    comestible = { calories = 21, fun = 1 },
}

ccb.content.define_item {
    id = "milk_coffee_sweetened",
    copy_from = "milk_coffee",
    name = ccb.content.plural_text("sweetened coffee milk", "sweetened coffee milk"),
    description = ccb.content.text("Coffee syrup mixed into milk.  It's been the state drink of Rhode Island since 1993.  With added sweetener for those who like it even sweeter.  Can also be served cold."),
    display_type = "BY_VOLUME",
    price = "4 USD 90 cent",
    survival_price = "60 cent",
    comestible = { calories = 88, fun = 14 },
    inheritance = { add = { flags = { "EATEN_COLD" } } },
}

ccb.content.define_item {
    id = "tomato_juice",
    name = ccb.content.plural_text("tomato juice", "tomato juice"),
    mass = "243 g",
    color = "red",
    default_container = "bottle_plastic",
    symbol = "~",
    description = ccb.content.text("A thick red liquid, made from tomatoes.  Not to everyone's taste, it is a healthy and refreshing drink when chilled."),
    display_type = "BY_VOLUME",
    price = "23 cent",
    survival_price = "40 cent",
    materials = { { id = "water", portions = 10 }, { id = "tomato", portions = 1 } },
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_COLD" },
    comestible = {
        shelf_life = "5 days",
        kind = "DRINK",
        quench = 65,
        calories = 41,
        servings = 1,
        vitamins = {
            { id = "vitC", amount = "170300 μg" },
            { id = "iron", amount = "900 μg" },
            { id = "calcium", amount = "24300 μg" },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = 2,
    },
}

ccb.content.define_item {
    id = "ayran",
    name = ccb.content.plural_text("ayran", "ayran"),
    mass = "240 g",
    color = "white",
    default_container = "bottle_plastic",
    symbol = "~",
    description = ccb.content.text("A cold savory yogurt-based beverage popular across Western Asia, Central Asia, Southeastern Europe, North Asia and Eastern Europe."),
    display_type = "BY_VOLUME",
    price = "90 cent",
    survival_price = "40 cent",
    volume = "236 ml",
    phase = "liquid",
    flags = { "EATEN_COLD" },
    comestible = { shelf_life = "3 days", kind = "DRINK", quench = 40, calories = 126, servings = 1, fun = 6 },
}

ccb.content.define_item {
    id = "zerocola",
    looks_like = "cola",
    name = ccb.content.plural_text("diet cola", "diet cola"),
    mass = "248 g",
    color = "brown",
    symbol = "~",
    description = ccb.content.text("Things go lighter with Cola Zero!  No sugar, no caffeine, no worries!"),
    display_type = "BY_VOLUME",
    price = "95 cent",
    survival_price = "40 cent",
    materials = { { id = "water", portions = 10 }, { id = "junk", portions = 1 } },
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_COLD" },
    comestible = {
        kind = "DRINK",
        quench = 50,
        calories = 0,
        servings = 1,
        fun = 4,
        vitamins = { { id = "junk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "zeroorange",
    looks_like = "orangesoda",
    name = ccb.content.plural_text("diet orange soda", "diet orange soda"),
    mass = "248 g",
    color = "yellow",
    symbol = "~",
    description = ccb.content.text("Trofica brand zero-sugar soda with natural orange flavors.  Now with 99% less calories!"),
    display_type = "BY_VOLUME",
    price = "95 cent",
    survival_price = "40 cent",
    materials = { { id = "water", portions = 10 }, { id = "junk", portions = 1 } },
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_COLD" },
    comestible = {
        kind = "DRINK",
        quench = 50,
        calories = 0,
        servings = 1,
        fun = 4,
        vitamins = { { id = "junk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "zerotropical",
    looks_like = "lemonlime",
    name = ccb.content.plural_text("diet tropical soda", "diet tropical soda"),
    mass = "248 g",
    color = "light_green",
    symbol = "~",
    description = ccb.content.text("Trofica brand zero-sugar soda.  Made with all-natural pineapple, kiwi, and passionfruit flavors that taste just like real fruit with none of the real sugar!"),
    display_type = "BY_VOLUME",
    price = "95 cent",
    survival_price = "40 cent",
    materials = { { id = "water", portions = 10 }, { id = "junk", portions = 1 } },
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_COLD" },
    comestible = {
        kind = "DRINK",
        quench = 50,
        calories = 0,
        servings = 1,
        fun = 4,
        vitamins = { { id = "junk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "zeromdew",
    looks_like = "colamdew",
    name = ccb.content.plural_text("diet energy cola", "diet energy cola"),
    mass = "250 g",
    color = "light_cyan",
    symbol = "~",
    description = ccb.content.text("Hill Mist 'Puebla Punch', a popular zero-sugar energy drink with enough caffeine to keep you awake but none of the calories that keep you going.  It looks and tastes like blue automotive coolant."),
    display_type = "BY_VOLUME",
    price = "1 USD",
    survival_price = "45 cent",
    materials = { { id = "water", portions = 10 }, { id = "junk", portions = 1 } },
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_COLD", "NO_AUTO_CONSUME" },
    comestible = {
        addiction = "caffeine",
        kind = "DRINK",
        quench = 50,
        healthy = -1,
        addiction_potential = 2,
        calories = 0,
        servings = 1,
        vitamins = { { id = "caffeine", amount = 54 }, { id = "junk_allergen", amount = 1 } },
        fun = 4,
    },
}

ccb.content.define_item {
    id = "foodplace_zero_drink",
    looks_like = "lemonlime",
    name = ccb.content.plural_text("Foodplace's refreshing drink™", "Foodplace's refreshing drink™"),
    mass = "248 g",
    color = "light_red",
    symbol = "~",
    description = ccb.content.text("A curious entry to the diet soda market by Foodplace, the \"Refreshing Drink™\" tastes just like real human beverages and contains no additives proven to cause diabetes or heart diseases!"),
    display_type = "BY_VOLUME",
    price = "95 cent",
    survival_price = "35 cent",
    materials = { { id = "water", portions = 10 }, { id = "junk", portions = 1 } },
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_COLD" },
    comestible = {
        kind = "DRINK",
        quench = 50,
        calories = 0,
        servings = 1,
        fun = 2,
        vitamins = { { id = "junk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "sparkling",
    looks_like = "water_mineral",
    name = ccb.content.plural_text("sparkling water", "sparkling water"),
    mass = "248 g",
    color = "light_cyan",
    symbol = "~",
    description = ccb.content.text("Plain, naturally carbonated mineral water with a subtle bitterness."),
    display_type = "BY_VOLUME",
    price = "1 USD 20 cent",
    survival_price = "35 cent",
    materials = { "water" },
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_COLD" },
    comestible = { kind = "DRINK", quench = 50, calories = 0, servings = 1, fun = 2 },
}

ccb.content.define_item {
    id = "sparkling_peach",
    looks_like = "sparkling",
    name = ccb.content.plural_text("peach sparkling water", "peach sparkling water"),
    mass = "248 g",
    color = "light_cyan",
    symbol = "~",
    description = ccb.content.text("Naturally carbonated mineral water with a hint of peach flavoring."),
    display_type = "BY_VOLUME",
    price = "1 USD 20 cent",
    survival_price = "35 cent",
    materials = { "water" },
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_COLD" },
    comestible = { kind = "DRINK", quench = 50, calories = 0, servings = 1, fun = 3 },
}

ccb.content.define_item {
    id = "sparkling_pomegranate",
    looks_like = "sparkling",
    name = ccb.content.plural_text("pomegranate sparkling water", "pomegranate sparkling water"),
    mass = "248 g",
    color = "light_cyan",
    symbol = "~",
    description = ccb.content.text("Naturally carbonated mineral water with pomegranate flavoring.  Fruity and bitter."),
    display_type = "BY_VOLUME",
    price = "1 USD 20 cent",
    survival_price = "35 cent",
    materials = { "water" },
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_COLD" },
    comestible = { kind = "DRINK", quench = 50, calories = 0, servings = 1, fun = 3 },
}
