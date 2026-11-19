local ccb = require("ccb")

ccb.content.define_item {
    id = "meat",
    copy_from = "meat",
    variants = {
        {
            id = "synth",
            name = ccb.content.plural_text("synthetic meat", "synthetic meat"),
            description = ccb.content.text("A cut of vat grown lean meat, genetically similar to beef.  Conspicuously uniform in both looks and texture."),
        },
    },
    comestible = { kind = "FOOD", parasites = 0 },
}

ccb.content.define_item {
    id = "jerky",
    copy_from = "jerky",
    survival_price = "1 USD 25 cent",
    variants = {
        {
            id = "synth",
            name = ccb.content.plural_text("meat flakes", "meat flakes"),
            description = ccb.content.text("Transparent thin hexagonal cuts of dried meat.  Conspicuously uniform in both looks and texture."),
        },
    },
    comestible = { kind = "FOOD" },
}

ccb.content.define_item {
    id = "fish",
    copy_from = "fish",
    variants = {
        {
            id = "synth",
            name = ccb.content.plural_text("synth fish", "synth fish"),
            description = ccb.content.text("Pink flesh from a non-existent species of fish, grown in a vat.  Of particularly high quality, it makes for a decent meal even when raw."),
        },
        {
            id = "insect",
            name = ccb.content.plural_text("arthropod meat", "arthropod meat"),
            description = ccb.content.text("A large white fillet of meat from the thorax of an alien insect.  It has a slightly sweet taste, and is very nutritious.  Used interchangeably with fish in many recipes."),
        },
    },
    comestible = { kind = "FOOD" },
}

ccb.content.define_item {
    id = "alien_jerky",
    copy_from = "jerky",
    name = ccb.content.plural_text("dried alien meat", "dried alien meat"),
    survival_price = "1 USD 50 cent",
    description = ccb.content.text("Thin and long strips of white, almost sickly pale meat, clearly belonging to some sort of alien creature.  It has a very strong taste, and is quite chewy."),
    comestible = { kind = "FOOD", fun = 0, quench = -7 },
}

ccb.content.define_item {
    id = "afs_soup_meat",
    looks_like = "soup_meat",
    name = ccb.content.plural_text("ramen", "ramen"),
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("frontier ramen", "frontier ramen"),
        },
    },
    mass = "262 g",
    color = "red",
    default_container = "can_medium",
    symbol = "~",
    description = ccb.content.text("Ramen's adaptability to dried and preserved ingredients make it a staple in the culinary landscapes of frontier outposts and shipping crews alike.  Any spaceport worth visiting has a local ramen tradition of its own, and here the dish is slightly acidic, with a sweet aftertaste produced by the break-down of alien proteins."),
    price = "14 USD",
    survival_price = "2 USD 25 cent",
    materials = {
        { id = "water", portions = 50 },
        { id = "flesh", portions = 25 },
        { id = "veggy", portions = 25 },
    },
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_HOT", "USE_EAT_VERB" },
    comestible = {
        shelf_life = "5 days",
        kind = "DRINK",
        quench = 13,
        calories = 381,
        servings = 1,
        vitamins = {
            { id = "vitC", amount = 30 },
            { id = "calcium", amount = 5 },
            { id = "iron", amount = 28 },
            { id = "meat_allergen", amount = 1 },
            { id = "veggy_allergen", amount = 1 },
        },
        fun = 8,
    },
}

ccb.content.define_item {
    id = "afs_streetfood_meat",
    copy_from = "flesh",
    mass = "275 g",
    volume = "250 ml",
    name = ccb.content.plural_text("starport roast", "starport roast"),
    description = ccb.content.text("Streetfood from the Salus spaceport.  White strips of meat, grilled and served with a heavy dressing of sour sauce.  Who knows where it came from, but it tastes pretty good."),
    price = "8 USD",
    survival_price = "3 USD 50 cent",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE" },
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        fun = 5,
        parasites = 0,
        calories = 652,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "flesh_golem_heart",
    name = ccb.content.text("seeping heart"),
    mass = "2035 g",
    color = "black_red",
    symbol = "%",
    description = ccb.content.text("A thick mass of flesh superficially resembling a mammalian heart.  It's the size of your fist and covered in dimpled grooves."),
    price = "30 USD",
    survival_price = "1 USD",
    materials = { "flesh" },
    volume = "500 ml",
    flags = { "PREDATOR_FUN", "MISSION_ITEM" },
    comestible = {
        kind = "FOOD",
        healthy = -10,
        calories = 200,
        quench = 10,
        fun = -25,
        vitamins = { { id = "mutagen_beast", amount = 250 }, { id = "meat_allergen", amount = 1 } },
    },
}
