local ccb = require("ccb")

ccb.content.define_item {
    id = "water",
    copy_from = "water_clean",
    name = ccb.content.plural_text("water", "water"),
    description = "Water, the stuff of life, necessary for all kinds of crafting, cleaning, and avoiding an agonizing death by dehydration.  You should boil or purify it before using it as drinking water.",
    color = "light_blue",
    display_type = "BY_VOLUME",
    default_container = "bottle_plastic",
    sealed_container = false,
    comestible = {
        contamination = {
            { disease = "highly_contaminated_food", probability = 0.1 },
            { disease = "bad_food", probability = 1 },
        },
    },
    inheritance = {
        remove = {
            flags = { "DECAYS_IN_AIR" },
        },
    },
}

ccb.content.define_item {
    id = "water_murky",
    copy_from = "water",
    name = ccb.content.plural_text("murky water", "murky water"),
    description = "Water, the stuff of life.  This water looks like it has quite a bit of life in it in fact, and not the good kind.  You should filter and sterilize it if you want to drink it.",
    display_type = "BY_VOLUME",
    comestible = {
        quench = 30,
        parasites = 5,
        contamination = {
            { disease = "highly_contaminated_food", probability = 100 },
        },
    },
}

ccb.content.define_item {
    id = "water_clean",
    name = ccb.content.plural_text("clean water", "clean water"),
    description = "Fresh, clean water.  Truly the best thing to quench your thirst.",
    symbol = "~",
    color = "light_cyan",
    category = "food",
    phase = "liquid",
    display_type = "BY_VOLUME",
    default_container = "bottle_plastic",
    mass = "250 g",
    volume = "250 ml",
    price = "50 cent",
    survival_price = "1 cent",
    revert_to = "water",
    sealed_container = true,
    flags = { "EATEN_COLD", "NUTRIENT_OVERRIDE", "DECAYS_IN_AIR" },
    materials = { "water" },
    properties = { max_air_exposure_hours = "720" },
    comestible = { kind = "DRINK", quench = 50, servings = 1 },
    ammunition = { type = "water" },
    subtype_order = { "comestible", "ammunition" },
}

ccb.content.define_item {
    id = "water_clean_scarlet",
    name = ccb.content.plural_text("acrid water", "acrid water"),
    description = "This looks very much like water, and you think it would quench your thirst.  Now that it's been removed from the large, scarlet body of water, you see that it's in fact slightly yellow.  It smells like a forgotten swimming pool.",
    symbol = "~",
    color = "yellow",
    category = "food",
    phase = "liquid",
    display_type = "BY_VOLUME",
    default_container = "bottle_plastic",
    mass = "250 g",
    volume = "250 ml",
    price = "50 cent",
    survival_price = "1 cent",
    revert_to = "water_clean",
    sealed_container = true,
    flags = { "DECAYS_IN_AIR" },
    materials = { "water" },
    properties = { max_air_exposure_hours = "144" },
    comestible = {
        kind = "DRINK",
        fun = -3,
        quench = 50,
        servings = 1,
        vitamins = {
            { id = "water_clean_scarlet_toxin", amount = 2 },
        },
    },
}
