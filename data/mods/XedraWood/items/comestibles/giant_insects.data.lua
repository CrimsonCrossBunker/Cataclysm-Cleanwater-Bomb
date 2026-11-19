local ccb = require("ccb")

ccb.content.define_item {
    id = "insect_fat",
    copy_from = "fat",
    name = ccb.content.plural_text("chunk of insect fat", "chunks of insect fat"),
    description = ccb.content.text("A chunk of raw fat butchered from a heavily-mutated animal.  It smells, if anything, even more disgusting than the rest of the mutant.  There are little puddles of unidentified oils dripping from it."),
    looks_like = "fat",
    comestible = { vitamins = { { id = "meat_allergen", amount = 1 } } },
    inheritance = { add = { flags = { "XEDRAWOOD_INSECT_BAD_TASTE" } }, scale = { price = 0.2, calories = 0.75 } },
}

ccb.content.define_item {
    id = "insect_meat",
    copy_from = "meat",
    name = ccb.content.plural_text("chunk of insect meat", "chunks of mutant meat"),
    description = ccb.content.text("Raw meat from a giant insect."),
    looks_like = "meat",
    flags = { "XEDRAWOOD_INSECT_BAD_TASTE", "RAW", "PREDATOR_FUN" },
    comestible = {
        cooks_like = "insect_meat_cooked",
        vitamins = {
            { id = "vitC", amount = 2 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 6 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { scale = { price = 0.2, calories = 0.5 } },
}

ccb.content.define_item {
    id = "insect_meat_cooked",
    copy_from = "meat_cooked",
    name = ccb.content.plural_text("cooked insect meat", "cooked insect meat"),
    description = ccb.content.text("A cooked chunk of meat from a giant insect."),
    looks_like = "meat_cooked",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE", "XEDRAWOOD_INSECT_BAD_TASTE" },
    comestible = { parasites = 0, fun = -1 },
    inheritance = { scale = { price = 1.5 } },
}

ccb.content.define_item {
    id = "insect_blood",
    copy_from = "mutant_meat",
    name = ccb.content.plural_text("insect blood", "insect blood"),
    description = ccb.content.text("Blood extracted from a giant insect."),
    mass = "262 g",
    volume = "250 ml",
    looks_like = "blood",
    symbol = "~",
    materials = { "blood" },
    phase = "liquid",
    comestible = { kind = "DRINK", parasites = 0, servings = 1, smoking_result = "null" },
}

ccb.content.define_item {
    id = "mutant_bug_organs",
    copy_from = "offal",
    name = ccb.content.plural_text("insect organs", "insect organs"),
    description = ccb.content.text("Raw organs from a giant bug."),
    comestible = { cooks_like = "mutant_bug_organs_cooked", vitamins = { { id = "meat_allergen", amount = 1 } } },
    inheritance = { add = { flags = { "XEDRAWOOD_INSECT_BAD_TASTE" } }, scale = { price = 0.1, calories = 0.65 } },
}

ccb.content.define_item {
    id = "mutant_bug_organs_cooked",
    copy_from = "mutant_bug_organs",
    name = ccb.content.plural_text("cooked insect organs", "cooked insect organs"),
    description = ccb.content.text("A selection of cooked giant insect organs.  Looks awful, but if you give it a try, you'll find -- that it's worse than it looks."),
    comestible = {},
}

ccb.content.define_item {
    id = "mutant_bug_hydrogen_sacs",
    copy_from = "mutant_bug_hydrogen_sacs",
    symbol = "o",
    color = "light_gray",
    name = ccb.content.plural_text("cluster of gas sacs", "clusters of gas sacs"),
    description = ccb.content.text("A cluster of membranous bubbles, each about the size of a grape, retrieved from inside a giant insect.  They float like tiny helium balloons - perhaps they are full of a lighter-than-air gas."),
    price = "0 cent",
    materials = { "flesh" },
    flags = { "NO_SALVAGE" },
    mass = "50 g",
    volume = "250 ml",
    comestible = {
        kind = "FOOD",
        shelf_life = "8 hours",
        fun = -25,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "insect_meat_fried",
    copy_from = "meat_fried",
    name = ccb.content.plural_text("fried insect meat", "fried insect meat"),
    materials = { "flesh" },
    symbol = "%",
    color = "brown",
    flags = { "EATEN_HOT" },
    mass = "298 g",
    volume = "250 ml",
    description = ccb.content.text("Oil-fried insect meat.  It looks marginally more appetizing now."),
    comestible = {
        kind = "FOOD",
        parasites = 0,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "meat_allergen", amount = 1 },
        },
        shelf_life = "1 day",
        quench = -1,
        fun = 6,
    },
    inheritance = { scale = { price = 0.1, calories = 0.65 } },
}
