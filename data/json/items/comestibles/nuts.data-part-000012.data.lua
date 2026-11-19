local ccb = require("ccb")

ccb.content.define_item {
    id = "hickory_nut_ambrosia",
    name = ccb.content.plural_text("hickory nut ambrosia", "hickory nut ambrosia"),
    mass = "64 g",
    color = "brown",
    default_container = "bottle_plastic",
    sealed_container = false,
    symbol = "~",
    description = ccb.content.text("Delicious hickory nut ambrosia.  A drink worthy of the gods."),
    display_type = "BY_VOLUME",
    price = "1 USD",
    survival_price = "4 USD",
    materials = { "nut", "milk" },
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "10 days 19 hours",
        kind = "DRINK",
        quench = 10,
        calories = 130,
        vitamins = { { id = "nut_allergen", amount = 1 }, { id = "milk_allergen", amount = 1 } },
        servings = 4,
        fun = 5,
        freezing_point = -62,
    },
}

-- Two tablespoons per charge.
ccb.content.define_item {
    id = "peanutbutter",
    symbol = "~",
    color = "brown",
    name = ccb.content.plural_text("nut butter", "nut butter"),
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "peanut",
            name = ccb.content.plural_text("peanut butter", "peanut butter"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pine",
            name = ccb.content.plural_text("pine nut butter", "pine nut butter"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pecan",
            name = ccb.content.plural_text("pecan butter", "pecan butter"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "cashew",
            name = ccb.content.plural_text("cashew butter", "cashew butter"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "pistachio",
            name = ccb.content.plural_text("pistachio butter", "pistachio butter"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "almond",
            name = ccb.content.plural_text("almond butter", "almond butter"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "beech",
            name = ccb.content.plural_text("beechnut butter", "beechnut butter"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "hickory",
            name = ccb.content.plural_text("hickory nut butter", "hickory nut butter"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "chestnut",
            name = ccb.content.plural_text("chestnut butter", "chestnut butter"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "hazelnut",
            name = ccb.content.plural_text("hazelnut butter", "hazelnut butter"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "walnut",
            name = ccb.content.plural_text("walnut butter", "walnut butter"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "butternut",
            name = ccb.content.plural_text("butternut butter", "butternut butter"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "acorn",
            name = ccb.content.plural_text("acorn butter", "acorn butter"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "soy",
            name = ccb.content.plural_text("soy nut butter", "soy nut butter"),
        },
    },
    description = ccb.content.text("A brown goo that tastes very little like its namesake.  It's not bad, but it'll stick to the roof of your mouth."),
    display_type = "BY_VOLUME",
    variant_kind = "generic",
    variants = {
        {
            id = "peanutbutter_preapoc",
            name = ccb.content.plural_text("peanut butter", "peanut butter"),
            description = ccb.content.text("A brown goo that tastes very little like its namesake.  It's not bad, but it'll stick to the roof of your mouth."),
            weight = 1,
        },
    },
    price = "1 USD 95 cent",
    survival_price = "10 USD",
    mass = "32 g",
    volume = "250 ml",
    default_container = "jar_glass_sealed",
    materials = { { id = "junk", portions = 10 }, { id = "nut", portions = 1 } },
    phase = "liquid",
    flags = { "USE_EAT_VERB" },
    comestible = {
        shelf_life = "180 days",
        kind = "DRINK",
        quench = -2,
        calories = 190,
        servings = 8,
        vitamins = {
            { id = "iron", amount = 6 },
            { id = "junk_allergen", amount = 1 },
            { id = "nut_allergen", amount = 1 },
        },
        fun = 2,
    },
}

-- make a container called small sealed plastic tub
-- Two tablespoons per charge.
ccb.content.define_item {
    id = "spread_peanutbutter",
    symbol = "%",
    name = ccb.content.text("peanut butter spread"),
    description = ccb.content.text("Processed peanut butter spread."),
    display_type = "BY_VOLUME",
    default_container = "can_food",
    color = "brown",
    price = "1 USD 95 cent",
    survival_price = "10 USD",
    phase = "solid",
    volume = "31 ml",
    mass = "32 g",
    materials = { { id = "junk", portions = 10 }, { id = "nut", portions = 1 } },
    flags = { "USE_EAT_VERB" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        shelf_life = "180 days",
        quench = -2,
        calories = 190,
        vitamins = {
            { id = "iron", amount = 6 },
            { id = "junk_allergen", amount = 1 },
            { id = "nut_allergen", amount = 1 },
        },
        fun = 2,
    },
}

ccb.content.define_item {
    id = "acorns",
    name = ccb.content.plural_text("Handful of acorns", "of acorns"),
    display_type = "BY_WEIGHT",
    mass = "30 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text("A handful of acorns, still in their shells.  Squirrels like them, but they taste terribly bitter and can upset your stomach."),
    price = "1 cent",
    survival_price = "50 cent",
    materials = { "nut" },
    volume = "62 ml",
    flags = { "EDIBLE_FROZEN", "NUTRIENT_OVERRIDE", "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "240 days",
        kind = "FOOD",
        quench = -5,
        calories = 114,
        vitamins = {
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 2 },
            { id = "nut_allergen", amount = 1 },
        },
        fun = -20,
    },
}
