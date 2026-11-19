local ccb = require("ccb")

ccb.content.define_item {
    id = "kelp_sugar",
    copy_from = "spinach",
    name = ccb.content.plural_text("kelp", "kelp"),
    description = ccb.content.text("Thin wafers of kelp, the essential greens of frontier cuisine.  These were probably grown in some farm ship or another."),
    volume = "166 ml",
    comestible = {},
}

ccb.content.define_item {
    id = "afs_soup_veggy",
    looks_like = "water",
    name = ccb.content.plural_text("vegan ramen", "vegan ramen"),
    mass = "254 g",
    color = "red",
    default_container = "can_medium",
    symbol = "~",
    description = ccb.content.text("Most ramen served in the frontier is already vegan through the use of synthetic meat and other meat substitutes.  This variant simply doesn't pretend to include any meat at all.  Slightly spicy."),
    price = "12 USD",
    survival_price = "1 USD 75 cent",
    materials = { "veggy" },
    volume = "500 ml",
    phase = "liquid",
    flags = { "EATEN_HOT", "USE_EAT_VERB" },
    comestible = {
        shelf_life = "5 days",
        kind = "DRINK",
        quench = 8,
        calories = 165,
        servings = 2,
        vitamins = {
            { id = "vitC", amount = 4 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 5 },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = 1,
    },
}

ccb.content.define_item {
    id = "afs_streetfood_veggy",
    copy_from = "flesh",
    mass = "275 g",
    volume = "250 ml",
    name = ccb.content.plural_text("starport yeast cake", "starport yeast cake"),
    description = ccb.content.text("Streetfood from the Salus spaceport.  A large square of fried dough topped with red sauce."),
    price = "8 USD",
    survival_price = "1 USD 50 cent",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "5 day",
        fun = 3,
        parasites = 0,
        calories = 125,
        vitamins = {
            { id = "vitC", amount = 4 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 5 },
            { id = "veggy_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "afs_kibble",
    name = ccb.content.plural_text("spiced chops", "spiced chops"),
    description = ccb.content.text("Kibble made for humans.  A heavy dressing of spices makes it impossible to discern the original flavors it might have had."),
    mass = "223 g",
    volume = "125 ml",
    price = "250 cent",
    accuracy = -5,
    materials = { "veggy" },
    symbol = ";",
    color = "brown",
    comestible = {
        kind = "FOOD",
        shelf_life = "1 day",
        quench = 2,
        calories = 800,
        vitamins = {
            { id = "vitC", amount = 4 },
            { id = "iron", amount = 17 },
            { id = "bad_food", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = 1,
    },
}
