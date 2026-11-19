local ccb = require("ccb")

ccb.content.define_item {
    id = "can_corn",
    name = ccb.content.plural_text("canned corn", "canned corn"),
    mass = "178 g",
    color = "yellow",
    symbol = "%",
    materials = { "veggy" },
    volume = "250 ml",
    description = ccb.content.text("Canned corn in water.  Eat up!"),
    price = "1 USD",
    survival_price = "75 cent",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "iron", amount = 3 },
            { id = "veggy_allergen", amount = 1 },
        },
        shelf_life = "2 days",
        quench = 5,
        calories = 152,
    },
}

ccb.content.define_item {
    id = "corn_on_cob",
    name = ccb.content.plural_text("corn on the cob", "corn on the cob"),
    mass = "130 g",
    color = "yellow",
    symbol = "%",
    materials = { "veggy" },
    volume = "195 ml",
    description = ccb.content.text("An ear of corn cooked in foil."),
    price = "50 cent",
    survival_price = "1 USD",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "iron", amount = 3 },
            { id = "veggy_allergen", amount = 1 },
        },
        shelf_life = "2 days",
        quench = -2,
        calories = 370,
    },
}

ccb.content.define_item {
    id = "pan_roasted_corn",
    name = ccb.content.plural_text("pan roasted corn", "pan roasted corn"),
    mass = "178 g",
    color = "yellow",
    symbol = "%",
    materials = { "veggy" },
    volume = "250 ml",
    description = ccb.content.text("Corn roasted in a frying pan with herbs and spices."),
    price = "50 cent",
    survival_price = "1 USD",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "iron", amount = 3 },
            { id = "veggy_allergen", amount = 1 },
        },
        shelf_life = "2 days",
        calories = 172,
        fun = 3,
    },
}

ccb.content.define_item {
    id = "hominy",
    name = ccb.content.plural_text("hominy", "hominy"),
    mass = "178 g",
    color = "yellow",
    symbol = "%",
    materials = { "veggy" },
    default_container = "bowl_plastic",
    volume = "250 ml",
    description = ccb.content.text("Popcorn kernels which have been cooked in an alkaline solution and then rinsed, making them better suited for eating or cooking."),
    price = "2 USD",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "iron", amount = 3 },
            { id = "veggy_allergen", amount = 1 },
        },
        shelf_life = "2 days",
        calories = 120,
    },
}

ccb.content.define_item {
    id = "cornmeal",
    name = ccb.content.plural_text("cornmeal", "cornmeal"),
    mass = "12500 mg",
    color = "yellow",
    default_container = "box_small",
    symbol = "%",
    description = ccb.content.text("This yellow cornmeal is useful for baking."),
    display_type = "BY_WEIGHT",
    price = "45 cent",
    survival_price = "2 cent",
    materials = { "veggy", "powder" },
    volume = "24 ml",
    flags = { "EDIBLE_FROZEN" },
    stackable = true,
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        quench = -1,
        calories = 44,
        vitamins = {
            { id = "vitC", amount = 12 },
            { id = "iron", amount = 4 },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = -5,
    },
}

-- real world measurements: 250ml of cooked beans is 240g with 316 calores, and 250ml of veggies is ~100g with ~100 calories
ccb.content.define_item {
    id = "deluxe_veggy_beans",
    name = ccb.content.plural_text("vegetarian baked beans", "vegetarian baked beans"),
    mass = "350 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("Slow-cooked beans with vegetables.  Tasty and very filling."),
    price = "7 USD",
    survival_price = "1 USD",
    materials = { "veggy", "bean" },
    volume = "500 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "15 days",
        kind = "FOOD",
        calories = 295,
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "calcium", amount = 8 },
            { id = "iron", amount = 32 },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = 4,
    },
}
