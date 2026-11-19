local ccb = require("ccb")

ccb.content.define_item {
    id = "fae_organs",
    copy_from = "offal",
    name = ccb.content.plural_text("nether organs", "nether organs"),
    snippet_category = "fae_organs_desc",
    description = ccb.content.text("These organs came from a beast from the Underhill."),
    looks_like = "offal",
    comestible = {
        parasites = 0,
        addiction = "faewild",
        addiction_potential = 5,
        vitamins = { { id = "underhill_essence", amount = 25 } },
    },
    inheritance = { scale = { price = 0.1, calories = 0.65 } },
}

ccb.content.define_item {
    id = "fae_fur",
    category = "spare_parts",
    copy_from = "raw_fur",
    name = ccb.content.plural_text("raw shimmer pelt", "raw shimmer pelt"),
    mass = "114 g",
    volume = "170 ml",
    color = "brown_red",
    symbol = ",",
    description = ccb.content.text("A carefully folded raw skin harvested from a fur-bearing animal from a specific region of the Nether.  It still has the fur attached.  You can cure it for storage and tanning, or eat it if you're desperate enough."),
    price = "3 USD 30 cent",
    survival_price = "1 USD",
    materials = { "fae_fur", "fae_flesh" },
    comestible = {
        shelf_life = "1 day 12 hours",
        kind = "FOOD",
        quench = -20,
        parasites = 0,
        healthy = -5,
        calories = 350,
        addiction = "faewild",
        addiction_potential = 3,
        vitamins = { { id = "underhill_essence", amount = 15 } },
        fun = -24,
    },
}

ccb.content.define_item {
    id = "fae_meat",
    name = ccb.content.plural_text("chunk of fae meat", "chunks of fae meat"),
    description = ccb.content.text("Freshly butchered meat from a fae beast.  You could eat it raw, but cooking it is better."),
    mass = "296 g",
    volume = "250 ml",
    price = "5 USD",
    symbol = "O",
    survival_price = "50 cent",
    flags = { "RAW", "PREDATOR_FUN" },
    comestible = {
        kind = "FOOD",
        shelf_life = "1 day",
        calories = 402,
        healthy = -1,
        parasites = 0,
        fun = -10,
        addiction = "faewild",
        addiction_potential = 3,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "underhill_essence", amount = 15 },
        },
        smoking_result = "meat_smoked",
    },
}

ccb.content.define_item {
    id = "fae_meat_scrap",
    copy_from = "fae_meat",
    symbol = "o",
    name = ccb.content.plural_text("scrap of fae meat", "scraps of fae meat"),
    description = ccb.content.text("This is a tiny scrap of edible meat from a fae beast.  It's not much, but it'll do in a pinch."),
    comestible = {
        smoking_result = "null",
        addiction = "faewild",
        addiction_potential = 1,
        vitamins = {
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 1 },
            { id = "underhill_essence", amount = 2 },
        },
    },
    inheritance = { scale = { mass = 0.1, volume = 0.1, price = 0.1, calories = 0.1 } },
}

ccb.content.define_item {
    id = "fae_blood",
    name = ccb.content.plural_text("fae blood", "fae blood"),
    mass = "260 g",
    color = "cyan",
    default_container = "flask_glass",
    symbol = "~",
    description = ccb.content.text("Blood, from a specific part of the Nether.  Disgusting!"),
    price = "75 cent",
    materials = { "fae_blood" },
    volume = "250 ml",
    phase = "liquid",
    copy_from = "animal_blood",
    comestible = { kind = "DRINK" },
}

ccb.content.define_item {
    id = "fae_meat_cooked",
    copy_from = "fae_meat",
    mass = "296 g",
    volume = "250 ml",
    name = ccb.content.plural_text("cooked fae meat", "cooked fae meat"),
    description = ccb.content.text("This is a chunk of freshly cooked fae meat.  It's filling and nutritious, but unseasoned and a bit bland."),
    price = "7 USD 50 cent",
    survival_price = "1 USD",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE" },
    comestible = { shelf_life = "1 day", parasites = 0, calories = 402 },
}

ccb.content.define_item {
    id = "fae_meat_scrap_cooked",
    copy_from = "fae_meat_scrap",
    name = ccb.content.plural_text("cooked scrap of fae meat", "cooked scraps of fae meat"),
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = { parasites = 0, fun = 0, healthy = 0, calories = 51 },
}

ccb.content.define_item {
    id = "meat_smoked",
    copy_from = "meat_cooked",
    name = ccb.content.plural_text("smoked meat", "smoked meat"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("smoked sucker", "smoked sucker"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("smoked Narnian", "smoked Narnian"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("%s, mutant", "%s, mutant"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "fae",
            name = ccb.content.plural_text("smoked fae", "smoked fae"),
        },
    },
    description = ccb.content.text("Tasty meat that has been heavily smoked for preservation.  It could be further smoked to dehydrate it completely."),
    color = "brown",
    survival_price = "2 USD",
    flags = { "EATEN_HOT", "SMOKED" },
    comestible = { shelf_life = "24 days", quench = -1, fun = 5, smoking_result = "dry_meat" },
}

ccb.content.define_item {
    id = "omnivore_stomach",
    copy_from = "stomach",
    name = ccb.content.text("omnivore stomach"),
    description = ccb.content.text("The stomach of an omnivorous creature.  It is surprisingly durable."),
    comestible = {},
}

ccb.content.define_item {
    id = "ruminant_stomach",
    copy_from = "stomach",
    name = ccb.content.text("ruminant stomach"),
    description = ccb.content.text("The four stomachs of a grazing creature.  It is surprisingly durable."),
    comestible = {},
    inheritance = { scale = { mass = 2.0, volume = 2.0, price = 1.5, calories = 2.0 } },
}

ccb.content.define_item {
    id = "herbivore_stomach",
    copy_from = "stomach",
    name = ccb.content.text("herbivore stomach"),
    description = ccb.content.text("The stomach of a herbivore.  It is surprisingly durable."),
    comestible = {},
}

ccb.content.define_item {
    id = "carnivore_stomach",
    copy_from = "stomach",
    name = ccb.content.text("carnivore stomach"),
    description = ccb.content.text("The stomach of an carnivorous creature.  It is surprisingly durable."),
    comestible = {},
}

ccb.content.define_item {
    id = "small_carnivore_stomach",
    copy_from = "stomach",
    name = ccb.content.text("small carnivore stomach"),
    description = ccb.content.text("The stomach of a small carnivorous creature.  It is surprisingly durable."),
    comestible = {},
    inheritance = { scale = { mass = 0.5, volume = 0.5, price = 0.5, calories = 0.5 } },
}

ccb.content.define_item {
    id = "small_omnivore_stomach",
    copy_from = "stomach",
    name = ccb.content.text("small omnivore stomach"),
    description = ccb.content.text("The stomach of a small omnivorous creature.  It is surprisingly durable."),
    comestible = {},
    inheritance = { scale = { mass = 0.5, volume = 0.5, price = 0.5, calories = 0.5 } },
}

ccb.content.define_item {
    id = "small_herbivore_stomach",
    copy_from = "stomach",
    name = ccb.content.text("small herbivore stomach"),
    description = ccb.content.text("The stomach of a small herbivore.  It is surprisingly durable."),
    comestible = {},
    inheritance = { scale = { mass = 0.5, volume = 0.5, price = 0.5, calories = 0.5 } },
}

ccb.content.define_item {
    id = "ant_stomach",
    copy_from = "stomach",
    name = ccb.content.text("ant stomach"),
    description = ccb.content.text("The two stomachs of a giant ant.  One stomach is for digestion and one stomach is for storing food for the colony."),
    comestible = {},
    inheritance = { scale = { mass = 1.5, volume = 1.5, calories = 1.25 } },
}

ccb.content.define_item {
    id = "vampire_blood",
    copy_from = "demihuman_blood",
    name = ccb.content.plural_text("vampire blood", "vampire blood"),
    description = ccb.content.text("Blood extracted from a vampire.  It's heavier than human blood.  Drinking it feels like a bad idea but there might be other ways to use it."),
    materials = { "vampire_blood" },
    comestible = {},
    inheritance = { scale = { mass = 1.1 } },
}
