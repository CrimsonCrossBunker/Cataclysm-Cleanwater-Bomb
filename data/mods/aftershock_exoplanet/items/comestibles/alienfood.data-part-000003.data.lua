local ccb = require("ccb")

ccb.content.define_item {
    id = "frost_human_fat",
    name = ccb.content.plural_text("chunk of frostbitten human fat", "chunks of frostbitten human fat"),
    mass = "220 g",
    color = "pink",
    symbol = "%",
    survival_price = "2 USD 50 cent",
    description = ccb.content.text("Light green fat, smelling absolutely rancid.  You could eat it, but it wouldn't be worth it."),
    price = "0 cent",
    materials = { "flesh" },
    volume = "250 ml",
    comestible = {
        shelf_life = "3 days",
        kind = "FOOD",
        quench = -10,
        healthy = -5,
        calories = 1923,
        vitamins = {
            { id = "mutant_toxin", amount = 25 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
        parasites = 32,
        fun = -20,
    },
}

ccb.content.define_item {
    id = "frost_human_tallow",
    name = ccb.content.plural_text("freezerburned human tallow", "freezerburned human tallow"),
    mass = "220 g",
    color = "pink",
    symbol = "%",
    survival_price = "2 USD 50 cent",
    description = ccb.content.text("A smooth light green block of cleaned and rendered human fat.  While it'll remain edible for a very long time, it won't be the most appetizing."),
    price = "5 USD",
    volume = "250 ml",
    materials = { "hflesh" },
    comestible = {
        shelf_life = "60 days",
        kind = "FOOD",
        quench = -10,
        healthy = -5,
        calories = 1923,
        vitamins = {
            { id = "mutant_toxin", amount = 25 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
        parasites = 32,
        fun = -20,
    },
}

ccb.content.define_item {
    id = "frost_raw_hleather",
    category = "spare_parts",
    name = ccb.content.plural_text("raw frostbitten human skin", "raw frostbitten human skin"),
    mass = "100 g",
    volume = "125 ml",
    color = "pink",
    symbol = ",",
    description = ccb.content.text("A carefully folded raw skin harvested from a human corpse.  It is stained blue from frostbite.  You can cure it for storage and tanning, or eat it if you're desperate enough."),
    price = "3 USD 30 cent",
    survival_price = "20 cent",
    materials = { "flesh" },
    flags = { "TRADER_AVOID" },
    comestible = {
        shelf_life = "1 day 12 hours",
        kind = "FOOD",
        quench = -2,
        healthy = -1,
        calories = 350,
        vitamins = {
            { id = "mutant_toxin", amount = 25 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
        fun = -12,
    },
}

ccb.content.define_item {
    id = "alien_flesh",
    copy_from = "flesh",
    name = ccb.content.plural_text("chunk of alien flesh", "chunks of alien flesh"),
    description = ccb.content.text("Freshly butchered meat from an alien corpse.  You could eat it raw or cooked, but this is a completely alien biosphere."),
    mass = "296 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "50 cent",
    flags = { "RAW", "PREDATOR_FUN" },
    comestible = {
        shelf_life = "1 day",
        calories = 402,
        healthy = -1,
        fun = -10,
        cooks_like = "meat_cooked",
        vitamins = {
            { id = "vitC", amount = 13 },
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 53 },
            { id = "mutant_toxin", amount = 25 },
        },
        smoking_result = "meat_smoked",
    },
}

ccb.content.define_item {
    id = "alien_flesh_cooked",
    copy_from = "flesh",
    mass = "296 g",
    volume = "250 ml",
    name = ccb.content.plural_text("cooked alien flesh", "cooked alien flesh"),
    description = ccb.content.text("This is a chunk of freshly cooked alien meat.  It could be either filling and nutritious, or poisonous and lethal."),
    price = "7 USD 50 cent",
    survival_price = "1 USD",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE" },
    comestible = {
        shelf_life = "1 day",
        parasites = 0,
        calories = 402,
        vitamins = {
            { id = "vitC", amount = 16 },
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 69 },
            { id = "mutant_toxin", amount = 25 },
        },
    },
}

ccb.content.define_item {
    id = "alien_meat_scrap",
    copy_from = "meat",
    name = ccb.content.plural_text("scrap of alien flesh", "scraps of alien flesh"),
    description = ccb.content.text("This is a tiny scrap of dubiously edible alien meat.  It's not much, but it might be better than starving."),
    comestible = {
        cooks_like = "meat_scrap_cooked",
        smoking_result = "null",
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 0 },
            { id = "mutant_toxin", amount = 5 },
        },
    },
    inheritance = { scale = { mass = 0.1, volume = 0.1, price = 0.1, calories = 0.1 } },
}

ccb.content.define_item {
    id = "alien_meat_scrap_cooked",
    copy_from = "alien_meat_scrap",
    name = ccb.content.plural_text("cooked scrap of alien flesh", "cooked scraps of alien flesh"),
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = { parasites = 0, fun = 0, healthy = 0, calories = 51 },
}

ccb.content.define_item {
    id = "alien_stomach",
    copy_from = "flesh",
    name = ccb.content.text("alien stomach"),
    description = ccb.content.text("A balloon-like organ you can only guess is a stomach.  It is surprisingly durable."),
    mass = "72 g",
    volume = "250 ml",
    survival_price = "25 cent",
    price = "2 USD",
    comestible = {
        shelf_life = "8 hours",
        calories = 60,
        quench = 1,
        healthy = -1,
        fun = -15,
        vitamins = { { id = "mutant_toxin", amount = 25 } },
    },
    inheritance = { add = { flags = { "PREDATOR_FUN" } } },
}

ccb.content.define_item {
    id = "alien_stomach_large",
    copy_from = "alien_stomach",
    name = ccb.content.text("large alien stomach"),
    description = ccb.content.text("A balloon-like organ of a large alien you can only guess is a stomach.  It is surprisingly durable."),
    comestible = {},
    inheritance = { scale = { mass = 2.0, volume = 2.0, price = 1.5, calories = 2.0 } },
}

ccb.content.define_item {
    id = "alien_lung",
    copy_from = "flesh",
    looks_like = "offal",
    name = ccb.content.plural_text("piece of raw alien lung", "pieces of raw alien lung"),
    description = ccb.content.text("A red sponge-like organ rests in your hands.  It leaks out a strange liquid, and spoils very quickly.  You hazard a guess this is a lung."),
    mass = "56 g",
    volume = "62 ml",
    color = "pink",
    survival_price = "6 cent",
    comestible = {
        shelf_life = "1 day",
        healthy = -2,
        quench = 2,
        fun = -10,
        calories = 50,
        vitamins = {
            { id = "vitC", amount = 9 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 14 },
            { id = "mutant_toxin", amount = 25 },
        },
    },
    inheritance = { add = { flags = { "PREDATOR_FUN" } } },
}

ccb.content.define_item {
    id = "alien_lung_cooked",
    copy_from = "alien_lung",
    looks_like = "offal_cooked",
    name = ccb.content.plural_text("cooked piece of alien lung", "cooked pieces of alien lung"),
    description = ccb.content.text("The organ no longer leaks out a strange liquid, and has faded to a light blue color.  It looks chewy, and has an unpleasant smell."),
    comestible = { parasites = 0 },
    inheritance = { remove = { flags = { "RAW", "PREDATOR_FUN" } } },
}

ccb.content.define_item {
    id = "alien_liver",
    copy_from = "alien_lung",
    looks_like = "offal",
    name = ccb.content.plural_text("raw alien liver", "raw alien liver"),
    description = ccb.content.text("A porous hard organ.  Hazarding a guess from all the large blood vessels going in and out, this is the liver.  It smells rancid."),
    survival_price = "25 cent",
    comestible = {
        quench = -4,
        calories = 92,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 8 },
            { id = "mutant_toxin", amount = 25 },
        },
    },
}

ccb.content.define_item {
    id = "alien_liver_cooked",
    copy_from = "alien_liver",
    looks_like = "meat_cooked",
    name = ccb.content.plural_text("cooked alien liver", "cooked alien liver"),
    description = ccb.content.text("After some time cooking, the pores of the organ have shrunk, and it's much, much softer - almost yogurt-like in its consistency.  It still smells awful."),
    survival_price = "50 cent",
    comestible = { parasites = 0, fun = -2, healthy = 0 },
    inheritance = { remove = { flags = { "RAW", "PREDATOR_FUN" } } },
}

ccb.content.define_item {
    id = "alien_brain",
    copy_from = "alien_lung",
    looks_like = "offal",
    name = ccb.content.plural_text("raw alien brains", "raw alien brains"),
    description = ccb.content.text("A brain butchered from an alien organism.  It looks somewhat similar to its earthly analogues, barring its light-blue coloration and gland riddled frontal lobe."),
    color = "light_gray",
    survival_price = "10 cent",
    comestible = {
        healthy = -15,
        quench = 10,
        fun = -20,
        parasites = 15,
        calories = 78,
        vitamins = {
            { id = "vitC", amount = 2 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 8 },
            { id = "mutant_toxin", amount = 25 },
        },
    },
}

ccb.content.define_item {
    id = "alien_brain_cooked",
    copy_from = "alien_brain",
    looks_like = "offal_cooked",
    name = ccb.content.plural_text("cooked alien brains", "cooked alien brains"),
    description = ccb.content.text("Fried and scrambled, this doesn't look the most appetizing, but it's edible (you hope)."),
    survival_price = "25 cent",
    comestible = { parasites = 0, healthy = -2, fun = -8 },
    inheritance = { remove = { flags = { "RAW", "PREDATOR_FUN" } } },
}

ccb.content.define_item {
    id = "alien_kidney",
    copy_from = "alien_lung",
    looks_like = "offal",
    name = ccb.content.plural_text("raw alien kidney", "raw alien kidney"),
    description = ccb.content.text("You are guessing here, but this is likely the kidney of the animal.  The ammonia smell was the biggest hint."),
    color = "brown",
    survival_price = "25 cent",
    comestible = {
        healthy = -8,
        quench = -5,
        calories = 54,
        vitamins = {
            { id = "vitC", amount = 2 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 8 },
            { id = "mutant_toxin", amount = 25 },
        },
    },
}

ccb.content.define_item {
    id = "alien_kidney_cooked",
    copy_from = "alien_kidney",
    looks_like = "offal_cooked",
    name = ccb.content.plural_text("cooked alien kidney", "cooked alien kidney"),
    description = ccb.content.text("Thoroughly cooked and prepared, this alien organ has acquired the filthy ammonia smell of a poorly mopped spaceship deck.  Even if it were safe to eat, you are not sure you'd want to."),
    survival_price = "25 cent",
    comestible = { healthy = -2, quench = -2, fun = -3, parasites = 0 },
    inheritance = { remove = { flags = { "RAW", "PREDATOR_FUN" } } },
}

ccb.content.define_item {
    id = "alien_sweetbread",
    copy_from = "alien_lung",
    looks_like = "offal",
    name = ccb.content.plural_text("raw alien sweetbread", "raw alien sweetbread"),
    description = ccb.content.text("You got this chunk of meat from the throat of the animal; it looks different?"),
    color = "brown",
    survival_price = "25 cent",
    comestible = {
        healthy = 0,
        quench = 0,
        calories = 133,
        vitamins = {
            { id = "vitC", amount = 32 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 6 },
            { id = "mutant_toxin", amount = 25 },
        },
    },
}

ccb.content.define_item {
    id = "alien_sweetbread_cooked",
    copy_from = "alien_sweetbread",
    looks_like = "meat_cooked",
    name = ccb.content.plural_text("cooked alien sweetbread", "cooked alien sweetbread"),
    survival_price = "50 cent",
    description = ccb.content.text("Well, it's definitely not muscle, you can tell now.  It oozes a purple liquid out onto your hand as you hold it."),
    comestible = { fun = -1, parasites = 0 },
    inheritance = { remove = { flags = { "RAW", "PREDATOR_FUN" } } },
}
