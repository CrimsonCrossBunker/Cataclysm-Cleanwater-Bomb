local ccb = require("ccb")

ccb.content.define_item {
    id = "paste_seed",
    name = ccb.content.plural_text("seed paste", "seed paste"),
    description = ccb.content.text("A mass of ground seeds that are ready to be pressed into oil."),
    display_type = "BY_WEIGHT",
    mass = "100 g",
    volume = "100 ml",
    price = "1 USD",
    survival_price = "25 cent",
    materials = { "veggy" },
    symbol = "%",
    color = "brown",
    comestible = {
        kind = "FOOD",
        shelf_life = "3 days",
        calories = 100,
        quench = -15,
        fun = -15,
        freezing_point = -274,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "paste_nut",
    name = ccb.content.plural_text("nut paste", "nut paste"),
    description = ccb.content.text("A thick mass of ground nuts that are ready to be pressed into oil."),
    display_type = "BY_WEIGHT",
    mass = "100 g",
    volume = "100 ml",
    price = "1 USD",
    survival_price = "25 cent",
    materials = { "nut" },
    symbol = "%",
    color = "brown",
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = {
        kind = "FOOD",
        shelf_life = "3 days",
        calories = 200,
        quench = -15,
        fun = -15,
        freezing_point = -274,
    },
}

-- While bees have mass and volume, it is easier to round to zero for the purposes of the game.
ccb.content.define_item {
    id = "swarm_bees",
    name = ccb.content.plural_text("swarm of bees", "swarms of bees"),
    description = ccb.content.text("A swarm of honey bees, displaced from the hive.  Without the support and nutrients of an apiary, or taking root somewhere, they will die in a few days."),
    price = "0 cent",
    survival_price = "0 cent",
    flags = { "ZERO_WEIGHT", "INEDIBLE" },
    volume = "500 ml",
    symbol = "B",
    color = "yellow",
    comestible = { kind = "INVALID", shelf_life = "2 days" },
}

-- Based on https://www.walmart.ca/en/ip/Club-House-Dry-Sauce-Seasoning-Marinade-Mix-Poutine-Gravy/10053105?classType=REGULAR&athbdg=L3033
ccb.content.define_item {
    id = "gravy_mix",
    name = ccb.content.plural_text("instant gravy mix", "instant gravy mix"),
    looks_like = "meal_bone",
    mass = "5 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Instant gravy mix, used for making gravy, instantly.  Not very appetizing in its current form."),
    display_type = "BY_WEIGHT",
    price = "16 cent",
    survival_price = "10 cent",
    materials = { "powder" },
    volume = "5 ml",
    stackable = true,
    comestible = {
        kind = "FOOD",
        quench = -3,
        calories = 15,
        vitamins = { { id = "meat_allergen", amount = 1 } },
        fun = -10,
    },
}

-- Based on https://www.walmart.com/ip/McCormick-No-Artificial-Flavors-Mushroom-Gravy-Mix-0-75-oz-Envelope/10308934?classType=VARIANT
ccb.content.define_item {
    id = "vegan_gravy_mix",
    name = ccb.content.plural_text("instant vegan gravy mix", "instant vegan gravy mix"),
    looks_like = "meal_bone",
    mass = "5 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Instant gravy mix, used for making gravy, instantly.  Not very appetizing in its current form.  This one has been made with mushrooms, and as such is vegan friendly."),
    display_type = "BY_WEIGHT",
    price = "20 cent",
    survival_price = "10 cent",
    materials = { "powder" },
    volume = "5 ml",
    stackable = true,
    comestible = {
        kind = "FOOD",
        quench = -3,
        calories = 20,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
        fun = -10,
    },
}

ccb.content.define_item {
    id = "gravy_prepared",
    name = ccb.content.plural_text("gravy", "gravy"),
    conditional_names = {
        {
            kind = "COMPONENT_ID",
            key = "vegan_gravy_mix",
            name = ccb.content.plural_text("vegan gravy", "vegan gravy"),
        },
    },
    description = ccb.content.text("A serving of gravy."),
    display_type = "BY_VOLUME",
    mass = "15 g",
    volume = "60 ml",
    phase = "liquid",
    price = "15 cent",
    survival_price = "0 cent",
    materials = { "water" },
    symbol = "0",
    color = "brown",
    flags = { "EATEN_HOT" },
    comestible = {
        kind = "FOOD",
        servings = 4,
        shelf_life = "3 days",
        calories = 20,
        quench = 1,
        fun = -2,
        freezing_point = 0,
    },
}
