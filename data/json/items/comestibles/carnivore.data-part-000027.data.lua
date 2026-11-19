local ccb = require("ccb")

ccb.content.define_item {
    id = "meat_bark",
    copy_from = "meat_frond",
    name = ccb.content.plural_text("leech bark", "scraps of leech bark"),
    description = ccb.content.text("Dry and tough bark matter harvested from an alien plant.  It is slightly translucent, and if placed against the light you can distinguish glistening blue veins running through it."),
    survival_price = "10 cent",
    comestible = {
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 8 },
            { id = "mutant_toxin", amount = 12 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "demihuman_stomach",
    copy_from = "stomach",
    name = ccb.content.text("demihuman stomach"),
    description = ccb.content.text("The stomach of an intelligent demihuman.  It is surprisingly durable."),
    materials = { "flesh" },
    comestible = { vitamins = { { id = "meat_allergen", amount = 1 } } },
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "demihuman_stomach_large",
    copy_from = "stomach_large",
    name = ccb.content.text("large demihuman stomach"),
    description = ccb.content.text("The stomach of a large humanoid creature.  It is surprisingly durable."),
    comestible = {},
    inheritance = {
        add = { flags = { "STRICT_HUMANITARIANISM" } },
        scale = { mass = 2.0, volume = 2.0, price = 1.5, calories = 2.0 },
    },
}

ccb.content.define_item {
    id = "demihuman_fat",
    copy_from = "fat",
    name = ccb.content.plural_text("chunk of demihuman fat", "of demihuman fat chunks"),
    description = ccb.content.text("Raw fat harvested from a demihuman body."),
    materials = { "flesh" },
    comestible = { vitamins = { { id = "meat_allergen", amount = 1 } } },
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

-- *May* have been commercially traded.
ccb.content.define_item {
    id = "demihuman_tallow",
    name = ccb.content.plural_text("demihuman tallow", "demihuman tallow"),
    copy_from = "tallow",
    description = ccb.content.text("A smooth, white block of cleaned and rendered demihuman fat.  It will remain edible for a very long time, and can be used as an ingredient in many foods and projects."),
    price = "5 USD",
    materials = { "flesh" },
    comestible = { vitamins = { { id = "meat_allergen", amount = 1 } } },
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "demihuman_flesh",
    copy_from = "meat",
    name = ccb.content.plural_text("demihuman flesh", "demihuman flesh"),
    description = ccb.content.text("Raw meat butchered from a demihuman body."),
    materials = { "flesh" },
    comestible = {
        cooks_like = "demihuman_cooked",
        cooked_item = "demihuman_cooked",
        cooking_energy = "300 kJ",
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "demihuman_blood",
    copy_from = "demihuman_flesh",
    name = ccb.content.plural_text("demihuman blood", "demihuman blood"),
    description = ccb.content.text("Blood extracted from a demihuman."),
    display_type = "BY_VOLUME",
    mass = "262 g",
    volume = "250 ml",
    looks_like = "blood",
    symbol = "~",
    materials = { "blood" },
    phase = "liquid",
    comestible = { kind = "DRINK", parasites = 0, servings = 1, smoking_result = "null" },
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "demihuman_cooked",
    copy_from = "demihuman_flesh",
    name = ccb.content.plural_text("cooked mongrel", "cooked mongrel"),
    description = ccb.content.text("A cooked slice of something close to being a real person.  Tastes like long pig."),
    comestible = { parasites = 0, fun = 0 },
    inheritance = {
        add = { flags = { "STRICT_HUMANITARIANISM" } },
        remove = { flags = { "RAW" } },
        scale = { price = 1.5 },
    },
}

ccb.content.define_item {
    id = "demihuman_stomach_boiled",
    copy_from = "stomach_boiled",
    name = ccb.content.text("boiled demihuman stomach"),
    description = ccb.content.text("A boiled stomach from a demihuman, nothing else.  It looks all but appetizing."),
    materials = { "flesh" },
    comestible = { calories = 240, vitamins = { { id = "meat_allergen", amount = 1 } } },
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "small_demihuman_stomach_boiled",
    copy_from = "small_stomach_boiled",
    name = ccb.content.text("boiled demihuman stomach"),
    description = ccb.content.text("A small boiled stomach from a demihuman, nothing else.  It looks all but appetizing."),
    materials = { "flesh" },
    comestible = { vitamins = { { id = "meat_allergen", amount = 1 } } },
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "meat_fried",
    copy_from = "meat_cooked",
    name = ccb.content.plural_text("fried meat", "fried meat"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("fried fool", "fried fool"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("fried familiar", "fried familiar"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("%s, mutant", "%s, mutant"),
        },
    },
    description = ccb.content.text("Delicious oil-fried meat."),
    color = "brown",
    survival_price = "2 USD",
    mass = "298 g",
    flags = { "EATEN_HOT" },
    comestible = { quench = -1, fun = 6 },
}
