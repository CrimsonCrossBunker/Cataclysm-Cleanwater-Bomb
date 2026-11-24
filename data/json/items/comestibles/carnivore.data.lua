local ccb = require("ccb")

-- 撤销 PR #86581 — 恢复僵尸尸体的实用性
-- NO_I18N
ccb.content.define_item {
    id = "flesh",
    abstract = true,
    name = ccb.content.text_without_extraction("meat/fish", "meat/fish"),
    materials = { "flesh" },
    symbol = "%",
    color = "red",
    flags = { "RAW" },
    stackable = true,
    comestible = { kind = "FOOD", parasites = 32, vitamins = { { id = "meat_allergen", amount = 1 } } },
}

-- Nutrition information from USDA
ccb.content.define_item {
    id = "froglegs",
    copy_from = "flesh",
    name = ccb.content.plural_text("frog legs (pair)", "frog legs (pair)"),
    description = ccb.content.text("A raw pair of frog legs.  Tastes like chicken when cooked or smoked."),
    mass = "100 g",
    volume = "100 ml",
    price = "10 USD",
    survival_price = "15 cent",
    flags = { "RAW" },
    comestible = {
        shelf_life = "12 hours",
        smoking_result = "froglegs_smoked",
        vitamins = {
            { id = "calcium", amount = 18 },
            { id = "iron", amount = 1 },
            { id = "meat_allergen", amount = 1 },
        },
        calories = 73,
    },
}

ccb.content.define_item {
    id = "froglegs_cooked",
    copy_from = "froglegs",
    name = ccb.content.plural_text("cooked frog legs (pair)", "cooked frog legs (pair)"),
    flags = { "EATEN_HOT" },
    survival_price = "1 USD",
    comestible = { parasites = 0, shelf_life = "1 day" },
}

ccb.content.define_item {
    id = "froglegs_smoked",
    copy_from = "froglegs_cooked",
    name = ccb.content.plural_text("smoked frog legs (pair)", "smoked frog legs (pair)"),
    color = "brown",
    survival_price = "2 USD",
    flags = { "EATEN_HOT", "SMOKED" },
    comestible = { shelf_life = "42 days", quench = -1, fun = 5, smoking_result = "dry_froglegs" },
}

-- Nutrition information based on whitefish
ccb.content.define_item {
    id = "fish",
    copy_from = "flesh",
    name = ccb.content.plural_text("fillet of fish", "fillets of fish"),
    description = ccb.content.text("An uncooked fish fillet.  Makes a passable meal raw."),
    mass = "148 g",
    volume = "150 ml",
    price = "5 USD",
    survival_price = "50 cent",
    flags = { "RAW" },
    comestible = {
        shelf_life = "12 hours",
        smoking_result = "fish_smoked",
        vitamins = {
            { id = "vitC", amount = 2 },
            { id = "calcium", amount = 6 },
            { id = "iron", amount = 14 },
            { id = "meat_allergen", amount = 1 },
        },
        calories = 260,
    },
}

ccb.content.define_item {
    id = "fish_scrap",
    copy_from = "fish",
    name = ccb.content.plural_text("scrap of fish", "scraps of fish"),
    description = ccb.content.text("A tiny scrap of edible fish.  It's not much, but it'll do in a pinch."),
    display_type = "BY_WEIGHT",
    comestible = {
        cooks_like = "fish_scrap_cooked",
        cooked_item = "fish_scrap_cooked",
        cooking_energy = "300 kJ",
        smoking_result = "null",
        vitamins = {
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 1 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { scale = { mass = 0.1, volume = 0.1, price = 0.1, calories = 0.1 } },
}

ccb.content.define_item {
    id = "fish_scrap_cooked",
    copy_from = "fish_scrap",
    name = ccb.content.plural_text("cooked scrap of fish", "cooked scraps of fish"),
    display_type = "BY_WEIGHT",
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = { parasites = 0, shelf_life = "1 day", calories = 51 },
}

ccb.content.define_item {
    id = "fish_cooked",
    copy_from = "fish",
    name = ccb.content.plural_text("cooked fish", "cooked fish"),
    description = ccb.content.text("A cooked fish fillet.  Very nutritious."),
    survival_price = "1 USD",
    flags = { "EATEN_HOT" },
    comestible = { shelf_life = "1 day", parasites = 0 },
    inheritance = { scale = { price = 1.5 } },
}

-- Nutrition information based on whitefish
ccb.content.define_item {
    id = "lobster",
    copy_from = "flesh",
    name = ccb.content.plural_text("chunk of lobster meat", "chunks of lobster meat"),
    description = ccb.content.text("A chunk of uncooked lobster meat."),
    display_type = "BY_WEIGHT",
    mass = "148 g",
    volume = "150 ml",
    price = "5 USD",
    survival_price = "50 cent",
    flags = { "RAW" },
    comestible = {
        shelf_life = "12 hours",
        smoking_result = "lobster_smoked",
        vitamins = {
            { id = "vitC", amount = 2 },
            { id = "calcium", amount = 6 },
            { id = "iron", amount = 14 },
            { id = "meat_allergen", amount = 1 },
        },
        calories = 250,
    },
}

ccb.content.define_item {
    id = "lobster_cooked",
    copy_from = "fish",
    name = ccb.content.plural_text("cooked lobster", "cooked lobster"),
    description = ccb.content.text("A chunk of delicious cooked lobster meat."),
    display_type = "BY_WEIGHT",
    survival_price = "1 USD 50 cent",
    flags = { "EATEN_HOT" },
    comestible = { shelf_life = "1 day", parasites = 0 },
    inheritance = { scale = { price = 1.5 } },
}

-- Nutrition information roughly based on squid. if you know more pls expand
ccb.content.define_item {
    id = "mollusk",
    copy_from = "flesh",
    name = ccb.content.plural_text("fillet of mollusk", "fillets of mollusk"),
    description = ccb.content.text("The raw flesh of a mollusk.  Must be cleaned and cooked before eating."),
    mass = "148 g",
    volume = "150 ml",
    price = "5 USD",
    survival_price = "50 cent",
    flags = { "RAW" },
    comestible = {
        shelf_life = "12 hours",
        smoking_result = "mollusk_smoked",
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 6 },
            { id = "iron", amount = 2 },
            { id = "meat_allergen", amount = 1 },
        },
        calories = 260,
    },
}

ccb.content.define_item {
    id = "mollusk_cooked",
    copy_from = "mollusk",
    name = ccb.content.plural_text("cooked mollusk", "cooked mollusk"),
    description = ccb.content.text("Cooked mollusk meat.  Devoid of any parasites or bacteria due to heat, the only thing left to do is add sauce."),
    survival_price = "1 USD 50 cent",
    flags = { "EATEN_HOT" },
    comestible = { shelf_life = "1 day", parasites = 0 },
    inheritance = { scale = { price = 1.5 } },
}

-- Nutrition information roughly based on a serving of 6 snails. if you know more pls expand
ccb.content.define_item {
    id = "gastropod_purged",
    copy_from = "flesh",
    name = ccb.content.plural_text("purged gastropods", "purged gastropods"),
    description = ccb.content.text("A handful of lucky gastropods that have been prepared for cooking by repeatedly boiling and washing them to remove their mucus and pathogens."),
    mass = "15 g",
    volume = "15 ml",
    price = "5 USD",
    survival_price = "50 cent",
    flags = { "RAW" },
    comestible = {
        shelf_life = "12 hours",
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 1 },
            { id = "meat_allergen", amount = 1 },
        },
        calories = 15,
    },
}

ccb.content.define_item {
    id = "gastropod_cooked",
    copy_from = "gastropod_purged",
    name = ccb.content.plural_text("cooked gastropods", "cooked gastropods"),
    description = ccb.content.text("Cooked gastropods.  A bit low on calories, but high in protein."),
    survival_price = "1 USD 50 cent",
    flags = { "EATEN_HOT" },
    comestible = { shelf_life = "1 day", parasites = 0 },
    inheritance = { scale = { price = 1.5 } },
}

ccb.content.define_item {
    id = "oyster",
    category = "food",
    name = ccb.content.plural_text("oyster in shell", "oysters in shell"),
    mass = "48 g",
    color = "light_gray",
    symbol = "o",
    materials = { "chitin", "flesh" },
    description = ccb.content.text("A medium-sized oyster.  Delicious served raw on the half-shell.  You'll need to shuck it to eat it."),
    price = "1 USD",
    survival_price = "10 cent",
    volume = "40 ml",
    flags = { "INEDIBLE" },
    stackable = true,
    comestible = { kind = "FOOD", shelf_life = "15 days" },
}

ccb.content.define_item {
    id = "oyster_shucked",
    copy_from = "oyster",
    name = ccb.content.text("shucked oyster"),
    mass = "20 g",
    color = "white",
    materials = { "flesh" },
    description = ccb.content.text("A live oyster floating in its liquor."),
    volume = "25 ml",
    flags = { "EATEN_COLD" },
    comestible = {
        calories = 12,
        shelf_life = "1 hour",
        fun = 5,
        vitamins = {
            { id = "meat_allergen", amount = 1 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 6 },
        },
    },
}

ccb.content.define_item {
    id = "hstomach",
    copy_from = "stomach",
    name = ccb.content.text("human stomach"),
    description = ccb.content.text("The stomach of a human.  It is surprisingly durable."),
    materials = { "hflesh" },
    comestible = {
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "human_flesh_vitamin", amount = 1 } },
    },
    inheritance = { remove = { flags = { "PREDATOR_FUN" } } },
}

ccb.content.define_item {
    id = "hstomach_large",
    copy_from = "hstomach",
    name = ccb.content.text("large human stomach"),
    description = ccb.content.text("The stomach of a large humanoid creature.  It is surprisingly durable."),
    comestible = {},
    inheritance = { scale = { mass = 2.0, volume = 2.0, price = 1.5, calories = 2.0 } },
}

ccb.content.define_item {
    id = "human_fat",
    copy_from = "fat",
    name = ccb.content.plural_text("chunk of human fat", "chunks of human fat"),
    description = ccb.content.text("A chunk of raw fat, harvested from a human body."),
    display_type = "BY_WEIGHT",
    materials = { "hflesh" },
    comestible = {
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "human_flesh_vitamin", amount = 1 } },
    },
}

-- *May* have been commercially traded.
ccb.content.define_item {
    id = "human_tallow",
    name = ccb.content.plural_text("human tallow", "human tallow"),
    copy_from = "tallow",
    description = ccb.content.text("A smooth, white block of cleaned and rendered human fat.  It will remain edible for a very long time, and can be used as an ingredient in many foods and projects."),
    display_type = "BY_WEIGHT",
    price = "5 USD",
    materials = { "hflesh" },
    comestible = {
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "human_flesh_vitamin", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "human_flesh",
    copy_from = "meat",
    name = ccb.content.plural_text("human flesh", "human flesh"),
    description = ccb.content.text("A chunk of raw meat, butchered from a human body."),
    display_type = "BY_WEIGHT",
    materials = { "hflesh" },
    comestible = {
        cooks_like = "human_cooked",
        cooked_item = "human_cooked",
        cooking_energy = "300 kJ",
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "human_flesh_vitamin", amount = 1 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { remove = { flags = { "PREDATOR_FUN" } } },
}

ccb.content.define_item {
    id = "human_cooked",
    copy_from = "human_flesh",
    name = ccb.content.plural_text("cooked creep", "cooked creep"),
    description = ccb.content.text("A cooked slice of 'long pig'.  Tastes vary from person to person."),
    display_type = "BY_WEIGHT",
    flags = { "EATEN_HOT" },
    comestible = { parasites = 0, fun = 0 },
    inheritance = { scale = { price = 1.5 } },
}

ccb.content.define_item {
    id = "pepperhuman",
    copy_from = "human_flesh",
    name = ccb.content.plural_text("peppered person", "peppered person"),
    description = ccb.content.text("A cooked slice of some person, seasoned with black pepper and salt.  Probably has better taste than they did when alive."),
    display_type = "BY_WEIGHT",
    flags = { "EATEN_HOT" },
    comestible = { parasites = 0, fun = 2 },
    inheritance = { scale = { price = 1.5 } },
}

ccb.content.define_item {
    id = "meat",
    copy_from = "flesh",
    name = ccb.content.plural_text("chunk of meat", "of meat chunks"),
    description = ccb.content.text("A chunk of raw meat.  You could eat it as-is, but cooking it is better."),
    display_type = "BY_WEIGHT",
    mass = "275 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "50 cent",
    flags = { "RAW", "PREDATOR_FUN" },
    comestible = {
        shelf_life = "1 day",
        calories = 402,
        fun = -10,
        cooks_like = "meat_cooked",
        cooked_item = "meat_cooked",
        cooking_energy = "300 kJ",
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "meat_allergen", amount = 1 },
        },
        smoking_result = "meat_smoked",
    },
}

ccb.content.define_item {
    id = "animal_blood",
    display_type = "BY_VOLUME",
    copy_from = "meat",
    name = ccb.content.plural_text("animal blood", "animal blood"),
    description = ccb.content.text("Blood extracted from a living creature."),
    mass = "262 g",
    volume = "250 ml",
    materials = { "blood" },
    looks_like = "blood",
    symbol = "~",
    phase = "liquid",
    comestible = { parasites = 0, kind = "DRINK", servings = 1, smoking_result = "null" },
}

ccb.content.define_item {
    id = "porkbelly",
    copy_from = "flesh",
    name = ccb.content.plural_text("chunk of porkbelly", "of porkbelly chunks"),
    description = ccb.content.text("A fatty cut of pork from the belly, popular in some cuisine.  With proper technique, it can be used to create bacon.  Not safe to consume in its current raw form."),
    display_type = "BY_WEIGHT",
    mass = "296 g",
    volume = "300 ml",
    price = "6 USD 50 cent",
    survival_price = "1 USD 50 cent",
    flags = { "RAW", "PREDATOR_FUN" },
    comestible = {
        shelf_life = "1 day",
        calories = 1300,
        fun = -10,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 22 },
            { id = "meat_allergen", amount = 1 },
        },
        smoking_result = "meat_smoked",
    },
}

ccb.content.define_item {
    id = "raw_cured_fatty_meat",
    copy_from = "porkbelly",
    name = ccb.content.plural_text("slab of raw cured porkbelly", "of raw cured porkbelly slabs"),
    description = ccb.content.text("Porkbelly that has been preserved and flavored with salt and sugar to draw out the moisture from the first layer.  Still raw, it is ready for smoking into bacon."),
    price = "6 USD 50 cent",
    survival_price = "3 USD",
    flags = { "RAW" },
    comestible = { calories = 1556, fun = 0, shelf_life = "14 days", smoking_result = "bacon_uncut" },
    inheritance = { offset = { mass = "-25g", volume = "-25ml" } },
}

-- High price to reflect the rarity and value of bacon. Note that this is three pieces of it.
ccb.content.define_item {
    id = "bacon_uncut",
    copy_from = "raw_cured_fatty_meat",
    name = ccb.content.plural_text("large slab of uncut bacon", "of large uncut bacon slabs"),
    description = ccb.content.text("A huge slab of uncut smoked bacon.  You can eat it as is, but it would be more efficient to cut it into smaller portions with a knife."),
    price = "20 USD",
    survival_price = "30 USD",
    flags = { "EATEN_HOT", "SMOKED" },
    comestible = { calories = 1566, shelf_life = "42 days", fun = 5 },
    inheritance = { offset = { mass = "-25g", volume = "-25ml" } },
}

ccb.content.define_item {
    id = "bacon_uncooked",
    copy_from = "bacon_uncut",
    flags = { "EATEN_HOT", "SMOKED" },
    name = ccb.content.plural_text("uncooked bacon", "pieces of uncooked bacon"),
    description = ccb.content.text("A thick slab of salty cured bacon."),
    mass = "85 g",
    volume = "125 ml",
    color = "pink",
    symbol = "%",
    price = "950 cent",
    survival_price = "250 cent",
    comestible = {
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 6 },
            { id = "meat_allergen", amount = 1 },
        },
        quench = -2,
        calories = 398,
        fun = 1,
    },
}

ccb.content.define_item {
    id = "raw_curing_fatty_meat_active",
    copy_from = "raw_cured_fatty_meat",
    name = ccb.content.plural_text("slab of raw curing porkbelly", "of raw curing porkbelly slabs"),
    description = ccb.content.text("Porkbelly in the process of becoming fully cured with salt and sugar, capable of becoming bacon.  The flavor is slowly developing at this stage, and is significantly unpleasant due to the residual salt.  Activate it once completed to make use of the final product."),
    price = "5 USD",
    survival_price = "2 USD 50 cent",
    flags = { "SPAWN_ACTIVE" },
    revert_to = "raw_cured_fatty_meat",
    comestible = { fun = -15 },
    countdown_interval = "8 hours",
}

-- Meat that is still in the timed curing stage; distinct from fully cured raw meat.
ccb.content.define_item {
    id = "raw_curing_meat_active",
    copy_from = "flesh",
    name = ccb.content.plural_text("raw meat (curing)", "raw meat (curing)"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("raw human meat (curing)", "raw human meat (curing)"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("raw demihuman meat (curing)", "raw demihuman meat (curing)"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("raw mutant meat (curing)", "raw mutant meat (curing)"),
        },
    },
    description = ccb.content.text("Raw meat packed in salt and undergoing a week-long cure.  It is unpleasantly salty and cannot be cooked normally until the cure finishes and the meat is washed."),
    looks_like = "raw_curing_fatty_meat_active",
    display_type = "BY_WEIGHT",
    mass = "275 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "1 USD",
    flags = { "RAW", "SPAWN_ACTIVE" },
    revert_to = "raw_cured_meat",
    comestible = {
        shelf_life = "21 days",
        calories = 402,
        quench = -15,
        fun = -10,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    countdown_interval = "7 days",
}

-- Meat whose timed cure has completed, but which is still raw and must be washed before normal cooking.
ccb.content.define_item {
    id = "raw_cured_meat",
    copy_from = "flesh",
    name = ccb.content.plural_text("raw cured meat", "raw cured meat"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("raw cured human meat", "raw cured human meat"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("raw cured demihuman meat", "raw cured demihuman meat"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("raw cured mutant meat", "raw cured mutant meat"),
        },
    },
    description = ccb.content.text("Raw meat that has completed a week-long salt cure.  It keeps well, but remains extremely salty and must be washed before normal cooking.  It can also be dehydrated for indefinite storage."),
    looks_like = "raw_cured_fatty_meat",
    display_type = "BY_WEIGHT",
    mass = "250 g",
    volume = "250 ml",
    price = "6 USD",
    survival_price = "2 USD",
    materials = { { id = "cured_meat", portions = 3 }, { id = "flesh", portions = 1 } },
    flags = { "RAW" },
    comestible = {
        shelf_life = "21 days",
        calories = 402,
        quench = -15,
        fun = -10,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "meat_allergen", amount = 1 },
        },
        smoking_result = "dehydrated_cured_meat",
    },
}

ccb.content.define_item {
    id = "meat_scrap",
    copy_from = "meat",
    name = ccb.content.plural_text("scrap of meat", "of meat scraps"),
    description = ccb.content.text("A tiny scrap of raw meat.  It's not much, but it'll do in a pinch."),
    display_type = "BY_WEIGHT",
    comestible = {
        cooks_like = "meat_scrap_cooked",
        cooked_item = "meat_scrap_cooked",
        cooking_energy = "300 kJ",
        smoking_result = "null",
        vitamins = {
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 1 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { scale = { mass = 0.1, volume = 0.1, survival_price = 0.1, calories = 0.1 } },
}

ccb.content.define_item {
    id = "human_meat_scrap",
    copy_from = "meat_scrap",
    looks_like = "meat_scrap",
    name = ccb.content.plural_text("scrap of human flesh", "of human flesh scraps"),
    description = ccb.content.text("A tiny scrap of raw human flesh."),
    materials = { "hflesh" },
    comestible = {
        vitamins = {
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "demihuman_meat_scrap",
    copy_from = "meat_scrap",
    looks_like = "meat_scrap",
    name = ccb.content.plural_text("scrap of demihuman flesh", "of demihuman flesh scraps"),
    description = ccb.content.text("A tiny scrap of raw demihuman flesh."),
    comestible = {},
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "mutant_meat",
    copy_from = "meat",
    name = ccb.content.plural_text("chunk of mutant meat", "of mutant meat chunks"),
    snippet_category = "mutant_meat_desc",
    description = ccb.content.text("Raw meat from a heavily mutated animal."),
    display_type = "BY_WEIGHT",
    looks_like = "meat",
    flags = { "BAD_TASTE", "RAW", "PREDATOR_FUN" },
    comestible = {
        cooks_like = "mutant_meat_cooked",
        cooked_item = "mutant_meat_cooked",
        cooking_energy = "300 kJ",
        vitamins = {
            { id = "vitC", amount = 2 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 6 },
            { id = "mutant_toxin", amount = 25 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { scale = { price = 0.2, calories = 0.5 } },
}

ccb.content.define_item {
    id = "mutant_blood",
    display_type = "BY_VOLUME",
    copy_from = "mutant_meat",
    name = ccb.content.plural_text("mutant blood", "mutant blood"),
    description = ccb.content.text("Blood extracted from a heavily mutated creature."),
    mass = "262 g",
    volume = "250 ml",
    looks_like = "blood",
    symbol = "~",
    materials = { "blood" },
    phase = "liquid",
    comestible = { kind = "DRINK", parasites = 0, servings = 1, smoking_result = "null" },
}

ccb.content.define_item {
    id = "mutant_meat_scrap",
    copy_from = "meat_scrap",
    name = ccb.content.plural_text("scrap of mutant meat", "of mutant meat scraps"),
    description = ccb.content.text("A tiny scrap of raw meat from a heavily mutated animal.  It smells unappealing, to say the least."),
    looks_like = "meat_scrap",
    comestible = {
        cooks_like = "mutant_meat_scrap_cooked",
        cooked_item = "mutant_meat_scrap_cooked",
        cooking_energy = "300 kJ",
        vitamins = { { id = "mutant_toxin", amount = 2 }, { id = "meat_allergen", amount = 1 } },
    },
    inheritance = { scale = { survival_price = 0.2, calories = 0.5 } },
}

ccb.content.define_item {
    id = "mutant_human_flesh",
    copy_from = "mutant_meat",
    name = ccb.content.plural_text("mutant humanoid meat", "mutant humanoid meat"),
    description = ccb.content.text("Raw meat butchered from the body of a heavily mutated creature that was unsettlingly humanoid in appearance.  It has odd bits of fur and other tissue lodged in it that clearly don't belong.  You'd have to be crazy or starving to eat this."),
    materials = { "hflesh" },
    comestible = {
        cooks_like = "mutant_human_cooked",
        cooked_item = "mutant_human_cooked",
        cooking_energy = "300 kJ",
        vitamins = {
            { id = "vitC", amount = 2 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 6 },
            { id = "mutant_toxin", amount = 25 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "mutant_human_blood",
    copy_from = "mutant_human_flesh",
    name = ccb.content.plural_text("mutant human blood", "mutant human blood"),
    description = ccb.content.text("Blood extracted from a heavily mutated human."),
    display_type = "BY_VOLUME",
    mass = "262 g",
    volume = "250 ml",
    looks_like = "blood",
    symbol = "~",
    materials = { "hblood" },
    phase = "liquid",
    comestible = {
        kind = "DRINK",
        parasites = 0,
        servings = 1,
        smoking_result = "null",
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "mutant_human_cooked",
    copy_from = "mutant_human_flesh",
    name = ccb.content.plural_text("cooked cretin", "cooked cretin"),
    description = ccb.content.text("Cooked meat from a heavily mutated humanoid.  Now that the worst bits have been picked out, it's probably digestible, if not very appetizing."),
    display_type = "BY_WEIGHT",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE", "BAD_TASTE" },
    comestible = { calories = 402, parasites = 0, fun = 0 },
    inheritance = { scale = { price = 1.5 } },
}

ccb.content.define_item {
    id = "peppermutant_human",
    copy_from = "mutant_human_flesh",
    name = ccb.content.plural_text("cooked pepper cretin", "cooked pepper cretin"),
    description = ccb.content.text("Cooked meat from a heavily mutated humanoid.  Now that the worst bits have been picked out, it's probably digestible.  It has also been properly seasoned with black pepper and salt, giving it a better taste.  Still, it is somewhat gross, but hey, it's food!"),
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE", "BAD_TASTE" },
    comestible = { calories = 402, parasites = 0, fun = 1 },
    inheritance = { scale = { price = 1.5 } },
}

ccb.content.define_item {
    id = "meat_mutant_tainted",
    copy_from = "mutant_meat",
    name = ccb.content.plural_text("chunk of tainted mutant meat", "of tainted mutant meat chunks"),
    color = "magenta",
    snippet_category = "tainted_mutant_meat_desc",
    looks_like = "meat",
    price = "0 cent",
    survival_price = "5 cent",
    flags = { "TRADER_AVOID", "BAD_TASTE", "RAW" },
    comestible = {
        cooks_like = "meat_mutant_tainted_cooked",
        cooked_item = "meat_mutant_tainted_cooked",
        cooking_energy = "300 kJ",
        shelf_life = "4 hours",
        fun = -15,
        smoking_result = "meat_mutant_tainted_smoked",
    },
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "meat_mutant_tainted_cooked",
    copy_from = "meat_mutant_tainted",
    name = ccb.content.plural_text("cooked tainted mutant meat", "cooked tainted mutant meat"),
    snippet_category = "cooked_tainted_mutant_meat_desc",
    looks_like = "meat_cooked",
    comestible = { parasites = 0 },
    inheritance = {
        add = { flags = { "EATEN_HOT" } },
        remove = { flags = { "RAW" } },
        scale = { survival_price = 1.5, fun = 0.7 },
    },
}

ccb.content.define_item {
    id = "meat_mutant_tainted_smoked",
    copy_from = "meat_mutant_tainted_cooked",
    name = ccb.content.plural_text("smoked tainted mutant meat", "smoked tainted mutant meat"),
    description = ccb.content.text("Rotten mutant meat that has been heavily smoked for preservation."),
    comestible = { shelf_life = "42 days", quench = -1 },
    inheritance = { add = { flags = { "EATEN_HOT", "SMOKED" } }, scale = { survival_price = 1.8, fun = 0.7 } },
}

ccb.content.define_item {
    id = "ruined_chunks",
    name = ccb.content.plural_text("butchery refuse", "butchery refuse"),
    description = "Eugh.  This is a mess of dirt, excreta, connective tissue, and bits of matter like hair and claws, leftover from the butchering process.  Eating it isn't even worth thinking about.",
    symbol = "¨",
    color = "black",
    category = "other",
    looks_like = "feces_manure",
    display_type = "BY_WEIGHT",
    mass = "250 g",
    volume = "300 ml",
    stackable = true,
    materials = { "flesh" },
    use_actions = { "POISON" },
    comestible = {
        kind = "FOOD",
        fun = -18,
        shelf_life = "8 hours",
        vitamins = {
            { id = "meat_allergen", amount = 1 },
        },
        contamination = {
            { disease = "bad_food", probability = 100 },
        },
    },
}

ccb.content.define_item {
    id = "meat_cooked",
    copy_from = "flesh",
    mass = "296 g",
    volume = "250 ml",
    name = ccb.content.plural_text("cooked meat", "cooked meat"),
    description = ccb.content.text("A chunk of cooked meat.  It's filling and nutritious, but unseasoned and a bit bland."),
    display_type = "BY_WEIGHT",
    price = "7 USD 50 cent",
    survival_price = "1 USD",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE" },
    comestible = {
        shelf_life = "1 day",
        parasites = 0,
        calories = 402,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "peppermeat",
    copy_from = "flesh",
    mass = "275 g",
    volume = "250 ml",
    name = ccb.content.plural_text("cooked pepper meat", "cooked pepper meat"),
    description = ccb.content.text("A piece of cooked meat, properly seasoned with black pepper and salt.  It's nutritious, yet basic seasoning adds a welcoming taste to this simple dish."),
    display_type = "BY_WEIGHT",
    price = "8 USD",
    survival_price = "1 USD 50 cent",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE" },
    comestible = {
        shelf_life = "1 day",
        fun = 2,
        parasites = 0,
        calories = 402,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

-- Luxury good.
ccb.content.define_item {
    id = "meat_fatty_cooked",
    copy_from = "flesh",
    mass = "296 g",
    volume = "250 ml",
    name = ccb.content.plural_text("cooked fatty meat", "cooked fatty meat"),
    description = ccb.content.text("A chunk of cooked fatty meat.  Although absent of vitamins, it is very filling and delightfully greasy."),
    display_type = "BY_WEIGHT",
    price = "9 USD",
    survival_price = "3 USD",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "1 day",
        calories = 1300,
        fun = 2,
        parasites = 0,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "pepperfat",
    copy_from = "flesh",
    mass = "275 g",
    volume = "250 ml",
    name = ccb.content.plural_text("cooked pepper fatty meat", "cooked pepper fatty meat"),
    description = ccb.content.text("A chunk of cooked fatty meat properly seasoned with black pepper and salt.  Although absent of vitamins, it is very filling, tasty and delightfully greasy."),
    display_type = "BY_WEIGHT",
    price = "9 USD 20 cent",
    survival_price = "3 USD 20 cent",
    flags = { "EATEN_HOT" },
    comestible = {
        shelf_life = "1 day",
        calories = 1300,
        fun = 3,
        parasites = 0,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "meat_scrap_cooked",
    copy_from = "meat_scrap",
    name = ccb.content.plural_text("cooked scrap of meat", "of cooked meat scraps"),
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = { parasites = 0, fun = 0, calories = 51 },
}

ccb.content.define_item {
    id = "pepperscrap",
    copy_from = "meat_scrap",
    name = ccb.content.plural_text("cooked pepper scrap of meat", "of cooked pepper meat scraps"),
    description = ccb.content.text("A cooked scrap of meat that has been properly seasoned with pepper and salt.  Small, yet has a good taste."),
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = { parasites = 0, fun = 1, calories = 51 },
}

ccb.content.define_item {
    id = "mutant_meat_cooked",
    copy_from = "mutant_meat",
    name = ccb.content.plural_text("cooked mutant meat", "cooked mutant meat"),
    snippet_category = "cooked_mutant_meat_desc",
    description = ccb.content.text("A cooked chunk of meat from a mutated animal."),
    looks_like = "meat_cooked",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE", "BAD_TASTE" },
    comestible = { parasites = 0, fun = -1 },
    inheritance = { scale = { price = 1.5 } },
}

ccb.content.define_item {
    id = "peppermutant",
    copy_from = "mutant_meat",
    name = ccb.content.plural_text("cooked pepper mutant meat", "cooked pepper mutant meat"),
    snippet_category = "cooked_mutant_meat_desc",
    description = ccb.content.text("A cooked chunk of meat from a mutated animal which has been properly seasoned with black pepper and salt, will keep your hunger away, but even seasoned, it has a weird taste."),
    looks_like = "meat_cooked",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE", "BAD_TASTE" },
    comestible = { parasites = 0, fun = 0 },
    inheritance = { scale = { price = 1.5 } },
}

ccb.content.define_item {
    id = "mutant_meat_scrap_cooked",
    copy_from = "mutant_meat_scrap",
    name = ccb.content.plural_text("cooked scrap of mutant meat", "of cooked mutant meat scraps"),
    description = ccb.content.text("A tiny scrap of cooked mutant meat.  It is small enough that it's hard to tell how disgusting it is."),
    looks_like = "meat_scrap_cooked",
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = { parasites = 0, calories = 25, fun = 0 },
}

ccb.content.define_item {
    id = "pepperscrap_mutant",
    copy_from = "mutant_meat_scrap",
    name = ccb.content.plural_text("cooked pepper scrap of mutant meat", "of cooked pepper mutant meat scraps"),
    description = ccb.content.text("A tiny scrap of cooked mutant meat properly seasoned with black pepper and salt.  It is small, and even though it has been seasoned, it has a weird taste."),
    looks_like = "meat_scrap_cooked",
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = { parasites = 0, calories = 25, fun = 1 },
}

ccb.content.define_item {
    id = "cooked_marrow",
    name = ccb.content.plural_text("roasted bone marrow", "of roasted bone marrow"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("Marvin marrow", "Marvin marrow"),
        },
    },
    description = ccb.content.text("Bone marrow, fully cooked to eliminate any parasites.  Tasty!"),
    display_type = "BY_WEIGHT",
    symbol = "%",
    color = "red",
    mass = "60 g",
    volume = "65 ml",
    price = "5 USD",
    survival_price = "50 cent",
    materials = { "flesh" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        shelf_life = "1 day",
        calories = 471,
        fun = 5,
        vitamins = { { id = "iron", amount = 17 }, { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "pepperbone",
    name = ccb.content.plural_text("roasted peppered bone marrow", "of roasted peppered bone marrow"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("Marvin marrow", "Marvin marrow"),
        },
    },
    description = ccb.content.text("Bone marrow, fully cooked to eliminate any parasites and properly seasoned with black pepper and salt.  Tasty!"),
    display_type = "BY_WEIGHT",
    symbol = "%",
    color = "red",
    mass = "55 g",
    volume = "50 ml",
    price = "5 USD",
    survival_price = "50 cent",
    materials = { "flesh" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        shelf_life = "1 day",
        calories = 471,
        fun = 6,
        vitamins = { { id = "iron", amount = 17 }, { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "offal",
    copy_from = "meat",
    name = ccb.content.plural_text("raw offal", "raw offal"),
    description = ccb.content.text("A selection of uncooked internal organs and entrails.  Filled with essential vitamins, but most people consider it a bit gross unless it's very carefully prepared."),
    survival_price = "25 cent",
    comestible = {
        smoking_result = "null",
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 16 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { scale = { parasites = 0.5 }, offset = { fun = -5 } },
}

ccb.content.define_item {
    id = "offal_cooked",
    copy_from = "offal",
    name = ccb.content.plural_text("cooked offal", "cooked offal"),
    description = ccb.content.text("A selection of cooked organs and entrails.  Filled with essential vitamins, but pretty unappetizing in this form."),
    survival_price = "50 cent",
    flags = { "EATEN_HOT" },
    comestible = { parasites = 0, fun = -5 },
}

ccb.content.define_item {
    id = "tainted_innards",
    copy_from = "offal",
    name = ccb.content.plural_text("tainted innards", "tainted innards"),
    description = ccb.content.text("An unidentifiable selection of rotted innards that barely hold their form.  It is revolting and certainly no longer healthy to eat."),
    display_type = "BY_WEIGHT",
    snippet_category = "tainted_innards_desc",
    survival_price = "0 cent",
    comestible = { shelf_life = "4 hours", fun = -25 },
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "tainted_innards_human",
    copy_from = "tainted_innards",
    name = ccb.content.plural_text("tainted innards", "tainted innards"),
    description = ccb.content.text("An unidentifiable selection of rotted human innards that barely hold their form.  It is revolting and certainly no longer healthy to eat."),
    snippet_category = "tainted_innards_desc",
    comestible = {
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 16 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "mutant_bug_organs",
    copy_from = "offal",
    name = ccb.content.plural_text("mutant organs", "mutant organs"),
    snippet_category = "bug_organs_desc",
    description = ccb.content.text("Raw organs from a giant mutant bug."),
    display_type = "BY_WEIGHT",
    looks_like = "offal",
    comestible = {
        cooks_like = "mutant_bug_organs_cooked",
        cooked_item = "mutant_bug_organs_cooked",
        cooking_energy = "300 kJ",
        vitamins = { { id = "mutant_toxin", amount = 25 }, { id = "meat_allergen", amount = 1 } },
    },
    inheritance = { add = { flags = { "BAD_TASTE" } }, scale = { price = 0.1, calories = 0.65 } },
}

ccb.content.define_item {
    id = "mutant_bug_organs_cooked",
    copy_from = "mutant_bug_organs",
    name = ccb.content.plural_text("cooked mutant bug organs", "cooked mutant bug organs"),
    snippet_category = "cooked_bug_organs_desc",
    description = ccb.content.text("A selection of cooked mutant bug organs.  Looks awful, but if you give it a try, you'll find -- that it's worse than it looks."),
    looks_like = "offal_cooked",
    comestible = { parasites = 0 },
    inheritance = { remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "offal_pickled",
    copy_from = "offal",
    name = ccb.content.plural_text("pickled offal", "pickled offal"),
    description = ccb.content.text("A mass of entrails and organ meat, preserved in brine.  Packed with essential vitamins, and although it looks like a lab specimen, it actually tastes pretty palatable."),
    display_type = "BY_WEIGHT",
    survival_price = "150 cent",
    default_container = "jar_glass_sealed",
    comestible = { parasites = 0, shelf_life = "1 day 12 hours", quench = -1, fun = -1 },
    inheritance = { remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "offal_canned",
    copy_from = "offal",
    name = ccb.content.plural_text("canned offal", "canned offal"),
    description = ccb.content.text("Cooked organ meat and entrails, preserved by canning.  Unappetizing, but filled with essential vitamins."),
    survival_price = "150 cent",
    default_container = "can_medium",
    comestible = { parasites = 0, fun = -2 },
    inheritance = { remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "stomach",
    copy_from = "flesh",
    name = ccb.content.text("stomach"),
    description = ccb.content.text("The stomach of a woodland creature.  It is surprisingly durable."),
    mass = "72 g",
    volume = "250 ml",
    survival_price = "25 cent",
    price = "2 USD",
    comestible = { shelf_life = "8 hours", calories = 60, quench = 1, fun = -15 },
    inheritance = { add = { flags = { "PREDATOR_FUN" } } },
}

ccb.content.define_item {
    id = "stomach_large",
    copy_from = "stomach",
    name = ccb.content.text("large stomach"),
    description = ccb.content.text("The stomach of a large woodland creature.  It is surprisingly durable."),
    comestible = {},
    inheritance = { scale = { mass = 2.0, volume = 2.0, price = 1.5, calories = 2.0 } },
}

ccb.content.define_item {
    id = "jerky",
    copy_from = "flesh",
    name = ccb.content.plural_text("meat jerky", "meat jerky"),
    conditional_names = {
        {
            kind = "VITAMIN",
            key = "human_flesh_vitamin",
            name = ccb.content.plural_text("jerk jerky", "jerk jerky"),
        },
        {
            kind = "FLAG",
            key = "STRICT_HUMANITARIANISM",
            name = ccb.content.plural_text("talking animal jerky", "talking animal jerky"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "mutant",
            name = ccb.content.plural_text("monster jerky", "monster jerky"),
        },
    },
    description = ccb.content.text("Salty dried meat that lasts for a long time, but will make you thirsty."),
    materials = { { id = "cured_meat", portions = 1 } },
    mass = "85 g",
    default_container = "bag_plastic_small",
    color = "brown",
    volume = "250 ml",
    price = "3 USD 20 cent",
    survival_price = "2 USD 50 cent",
    comestible = {
        shelf_life = "42 days",
        parasites = 0,
        quench = -5,
        fun = 4,
        calories = 348,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 26 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "salted_fish",
    copy_from = "fish",
    name = ccb.content.plural_text("salted fish", "salted fish"),
    description = ccb.content.text("Salty dried fish that lasts for a long time, but will make you thirsty."),
    materials = { { id = "cured_meat", portions = 1 } },
    default_container = "bag_plastic",
    color = "light_gray",
    survival_price = "2 USD 50 cent",
    volume = "50 ml",
    comestible = {
        shelf_life = "42 days",
        parasites = 0,
        quench = -5,
        fun = 4,
        vitamins = {
            { id = "vitC", amount = 1 },
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 7 },
            { id = "meat_allergen", amount = 1 },
        },
        calories = 130,
    },
    inheritance = { remove = { flags = { "RAW" } }, scale = { price = 2.0, mass = 0.345 } },
}

ccb.content.define_item {
    id = "salted_mollusk",
    copy_from = "mollusk",
    name = ccb.content.text("salted mollusk"),
    description = ccb.content.text("Salty dried mollusk that lasts for a long time, but will make you thirsty."),
    materials = { { id = "cured_meat", portions = 1 } },
    default_container = "bag_plastic",
    color = "light_red",
    survival_price = "2 USD 50 cent",
    comestible = { shelf_life = "42 days", parasites = 0, quench = -5, fun = 4 },
    inheritance = { remove = { flags = { "RAW" } }, scale = { price = 2.0, mass = 0.345 } },
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
    },
    description = ccb.content.text("Tasty meat that has been heavily smoked for preservation.  It could be further smoked until complete dehydration."),
    color = "brown",
    survival_price = "2 USD",
    flags = { "EATEN_HOT", "SMOKED" },
    comestible = { shelf_life = "28 days", quench = -1, fun = 5, smoking_result = "dry_meat" },
}

ccb.content.define_item {
    id = "fish_smoked",
    copy_from = "fish_cooked",
    name = ccb.content.plural_text("smoked fish", "smoked fish"),
    description = ccb.content.text("Tasty fish that has been heavily smoked for long term preservation.  It could be further smoked until complete dehydration."),
    color = "brown",
    survival_price = "2 USD",
    flags = { "EATEN_HOT", "SMOKED" },
    comestible = { shelf_life = "42 days", fun = 6, smoking_result = "dry_fish" },
}

ccb.content.define_item {
    id = "lobster_smoked",
    copy_from = "fish_smoked",
    name = ccb.content.text("smoked lobster"),
    description = ccb.content.text("Tasty lobster that has been heavily smoked for long term preservation.  It could be further smoked until complete dehydration."),
    color = "brown",
    survival_price = "3 USD",
    flags = { "EATEN_HOT", "SMOKED" },
    comestible = { fun = 10, smoking_result = "dry_lobster" },
}

ccb.content.define_item {
    id = "mollusk_smoked",
    copy_from = "fish_smoked",
    name = ccb.content.text("smoked mollusk"),
    description = ccb.content.text("Tasty mollusk that has been heavily smoked for long term preservation.  It could be further smoked until complete dehydration."),
    color = "brown",
    survival_price = "3 USD",
    flags = { "EATEN_HOT" },
    comestible = { fun = 10, smoking_result = "dry_mollusk" },
}

ccb.content.define_item {
    id = "lung",
    copy_from = "flesh",
    looks_like = "offal",
    name = ccb.content.plural_text("piece of raw lung", "of raw lung pieces"),
    description = ccb.content.text("A portion of lung from an animal.  It's spongy and pink, and spoils very quickly.  It can be a delicacy if properly prepared - but if improperly prepared, it's a chewy lump of flavorless connective tissue."),
    display_type = "BY_WEIGHT",
    mass = "45 g",
    volume = "50 ml",
    color = "pink",
    survival_price = "6 cent",
    comestible = {
        shelf_life = "1 day",
        quench = 2,
        fun = -10,
        calories = 40,
        vitamins = {
            { id = "vitC", amount = 9 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 14 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { add = { flags = { "PREDATOR_FUN" } } },
}

ccb.content.define_item {
    id = "human_lung",
    copy_from = "lung",
    looks_like = "lung",
    name = ccb.content.plural_text("piece of raw human lung", "of raw human lung pieces"),
    description = ccb.content.text("A portion of lung from a human.  It's spongy and pink, and spoils very quickly.  It appears to have been extracted too crudely to ever be useful as a transplant."),
    materials = { "hflesh" },
    comestible = {
        vitamins = {
            { id = "vitC", amount = 9 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 14 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "demihuman_lung",
    copy_from = "lung",
    looks_like = "lung",
    name = ccb.content.plural_text("piece of raw demihuman lung", "of raw demihuman lung pieces"),
    description = ccb.content.text("A portion of lung from a demihuman being.  It's spongy and pink, and spoils very quickly."),
    comestible = {},
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "lung_cooked",
    copy_from = "lung",
    looks_like = "offal_cooked",
    name = ccb.content.plural_text("cooked piece of lung", "of cooked lung pieces"),
    description = ccb.content.text("A chewy, grayish lump of flavorless connective tissue.  It doesn't look any tastier than it did raw, but any parasites are all cooked out."),
    comestible = { fun = -5, parasites = 0 },
    inheritance = { add = { flags = { "EATEN_HOT" } }, remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "mutant_lung",
    copy_from = "lung",
    name = ccb.content.plural_text("piece of raw mutant lung", "of raw mutant lung pieces"),
    snippet_category = "mutant_lung_desc",
    comestible = {
        fun = -15,
        vitamins = {
            { id = "vitC", amount = 9 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 14 },
            { id = "mutant_toxin", amount = 10 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { add = { flags = { "BAD_TASTE" } }, scale = { survival_price = 0.5 } },
}

ccb.content.define_item {
    id = "mutant_lung_cooked",
    copy_from = "lung_cooked",
    name = ccb.content.plural_text("cooked piece of mutant lung", "of cooked mutant lung pieces"),
    snippet_category = "cooked_mutant_lung_desc",
    comestible = {},
}

ccb.content.define_item {
    id = "heart",
    copy_from = "flesh",
    looks_like = "offal",
    name = ccb.content.plural_text("piece of raw heart", "of raw heart pieces"),
    description = ccb.content.text("A portion of an animal's heart.  It's tough but not that chewy, and it spoils very quickly."),
    display_type = "BY_WEIGHT",
    mass = "55 g",
    volume = "50 ml",
    color = "pink",
    survival_price = "6 cent",
    comestible = {
        shelf_life = "1 day",
        fun = -10,
        calories = 67,
        vitamins = {
            { id = "vitC", amount = "3 mg" },
            { id = "calcium", amount = "2840 μg" },
            { id = "iron", amount = "2660 μg" },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { add = { flags = { "PREDATOR_FUN" } } },
}

ccb.content.define_item {
    id = "human_heart",
    copy_from = "heart",
    looks_like = "heart",
    name = ccb.content.plural_text("piece of raw human heart", "of raw human heart pieces"),
    description = ccb.content.text("A portion of heart from a human.  It's tough but not that chewy, and it spoils very quickly.  It appears to have been extracted too crudely to ever be useful as a transplant."),
    materials = { "hflesh" },
    comestible = {
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 14 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "demihuman_heart",
    copy_from = "heart",
    looks_like = "heart",
    name = ccb.content.plural_text("piece of raw demihuman heart", "of raw demihuman heart pieces"),
    description = ccb.content.text("A portion of heart from a demihuman being.  It's tough but not that chewy, and it spoils very quickly."),
    comestible = {},
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "heart_cooked",
    copy_from = "heart",
    looks_like = "offal_cooked",
    name = ccb.content.plural_text("cooked piece of heart", "of cooked heart pieces"),
    description = ccb.content.text("A roasted piece of heart.  It doesn't look any tastier than it did raw, but any parasites are all cooked out."),
    comestible = { fun = -5, parasites = 0 },
    inheritance = { add = { flags = { "EATEN_HOT" } }, remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "mutant_heart",
    copy_from = "heart",
    name = ccb.content.plural_text("piece of raw mutant heart", "of raw mutant heart pieces"),
    snippet_category = "mutant_heart_desc",
    comestible = {
        fun = -15,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 14 },
            { id = "mutant_toxin", amount = 10 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { add = { flags = { "BAD_TASTE" } }, scale = { survival_price = 0.5 } },
}

ccb.content.define_item {
    id = "mutant_human_heart",
    copy_from = "heart",
    name = ccb.content.plural_text("piece of raw mutant humanoid heart", "of raw mutant humanoid heart pieces"),
    snippet_category = "mutant_heart_desc",
    comestible = {
        fun = -15,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 3 },
            { id = "iron", amount = 14 },
            { id = "mutant_toxin", amount = 10 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
    inheritance = { add = { flags = { "BAD_TASTE" } }, scale = { survival_price = 0.5 } },
}

ccb.content.define_item {
    id = "mutant_heart_cooked",
    copy_from = "heart_cooked",
    name = ccb.content.plural_text("cooked piece of mutant heart", "of cooked mutant heart pieces"),
    snippet_category = "cooked_mutant_heart_desc",
    comestible = {},
}

ccb.content.define_item {
    id = "mutant_bug_lungs",
    copy_from = "lung",
    name = ccb.content.plural_text("piece of raw mutant lung", "of raw mutant lung pieces"),
    snippet_category = "mutant_bug_lung_desc",
    description = ccb.content.text("You're pretty sure this is lung tissue."),
    looks_like = "lung",
    comestible = {
        vitamins = {
            { id = "vitC", amount = 9 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 14 },
            { id = "mutant_toxin", amount = 25 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { add = { flags = { "BAD_TASTE" } }, scale = { survival_price = 0.1, calories = 0.65 } },
}

ccb.content.define_item {
    id = "liver",
    copy_from = "lung",
    looks_like = "offal",
    name = ccb.content.plural_text("piece of raw liver", "of raw liver pieces"),
    description = ccb.content.text("A piece of liver from an animal.  Although many dislike its texture, it's one of the more vitamin-rich parts of the animal.  It is very good in sausages, but maybe a little less appetizing when cooked on its own."),
    display_type = "BY_WEIGHT",
    survival_price = "25 cent",
    comestible = {
        quench = -4,
        calories = 92,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 28 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "human_liver",
    copy_from = "liver",
    looks_like = "liver",
    name = ccb.content.plural_text("piece of raw human liver", "of raw human liver pieces"),
    description = ccb.content.text("A piece of liver from a human, which appears to have been extracted too crudely to ever be useful as a transplant."),
    materials = { "hflesh" },
    comestible = {
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 28 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "demihuman_liver",
    copy_from = "liver",
    looks_like = "liver",
    name = ccb.content.plural_text("piece of raw demihuman liver", "of raw demihuman liver pieces"),
    description = ccb.content.text("A chunk of liver from a demihuman being."),
    comestible = {},
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "liver_cooked",
    copy_from = "liver",
    looks_like = "meat_cooked",
    name = ccb.content.plural_text("cooked piece of liver", "of cooked liver pieces"),
    description = ccb.content.text("Chock-full of A- and B-Vitamins!  Cooked liver isn't all that bad, depending on how you feel about the texture, but this is probably the least fancy way to do it."),
    survival_price = "50 cent",
    comestible = { parasites = 0, fun = 0 },
    inheritance = { remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "mutant_liver",
    copy_from = "liver",
    name = ccb.content.plural_text("piece of raw mutant liver", "of raw mutant liver pieces"),
    snippet_category = "mutant_liver_desc",
    comestible = {
        fun = -15,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 28 },
            { id = "mutant_toxin", amount = 40 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { add = { flags = { "BAD_TASTE" } }, scale = { survival_price = 0.5 } },
}

ccb.content.define_item {
    id = "mutant_liver_cooked",
    copy_from = "liver_cooked",
    name = ccb.content.plural_text("cooked piece of mutant liver", "of cooked mutant liver pieces"),
    snippet_category = "cooked_mutant_liver_desc",
    comestible = { fun = -5 },
}

ccb.content.define_item {
    id = "bone_marrow",
    copy_from = "flesh",
    name = ccb.content.plural_text("portion of raw bone marrow", "of raw bone marrow portions"),
    description = ccb.content.text("A soft, spongy substance found in bones, rich in fat.  Chock-full of good stuff and doesn't taste too bad even raw, but beware of parasites."),
    display_type = "BY_WEIGHT",
    mass = "60 g",
    volume = "65 ml",
    price = "5 USD",
    survival_price = "50 cent",
    flags = { "RAW", "PREDATOR_FUN" },
    comestible = {
        shelf_life = "1 day",
        calories = 471,
        fun = -3,
        vitamins = { { id = "iron", amount = 17 }, { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "human_marrow",
    copy_from = "bone_marrow",
    name = ccb.content.plural_text("portion of raw human bone marrow", "of raw human bone marrow portions"),
    description = ccb.content.text("Soft, spongy marrow tissue from a human bone."),
    materials = { "hflesh" },
    comestible = {
        vitamins = {
            { id = "iron", amount = 17 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "demihuman_marrow",
    copy_from = "bone_marrow",
    name = ccb.content.plural_text("portion of raw demihuman bone marrow", "of raw demihuman bone marrow portions"),
    description = ccb.content.text("Soft, spongy marrow tissue from a demihuman bone."),
    comestible = {},
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "mutant_marrow",
    copy_from = "bone_marrow",
    name = ccb.content.plural_text("portion of raw mutant bone marrow", "of raw mutant bone marrow portions"),
    description = ccb.content.text("Soft, spongy, and oddly-colored marrow tissue from the bone of a heavily mutated animal."),
    flags = { "BAD_TASTE", "RAW", "PREDATOR_FUN" },
    comestible = {
        vitamins = {
            { id = "iron", amount = 7 },
            { id = "mutant_toxin", amount = 25 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { scale = { price = 0.2, calories = 0.5 } },
}

ccb.content.define_item {
    id = "mutant_human_marrow",
    copy_from = "mutant_marrow",
    name = ccb.content.plural_text("portion of raw mutant human bone marrow", "of raw mutant human bone marrow portions"),
    description = ccb.content.text("Soft, spongy, and oddly-colored marrow tissue from the bone of a heavily mutated creature that was unsettlingly humanoid in appearance."),
    materials = { "hflesh" },
    comestible = {
        vitamins = {
            { id = "iron", amount = 17 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "brain",
    copy_from = "lung",
    looks_like = "offal",
    name = ccb.content.plural_text("piece of raw brain", "of raw brain pieces"),
    description = ccb.content.text("A chunk of brain from an animal.  You wouldn't want to eat this raw…"),
    display_type = "BY_WEIGHT",
    color = "light_gray",
    survival_price = "10 cent",
    comestible = {
        quench = 10,
        parasites = 15,
        calories = 78,
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 10 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "human_brain",
    copy_from = "brain",
    looks_like = "brain",
    name = ccb.content.plural_text("piece of raw human brain", "of raw human brain pieces"),
    description = ccb.content.text("A chunk of brain from a human.  Eating this may cause kuru, but you probably won't live long enough to care about that anyway."),
    materials = { "hflesh" },
    comestible = {
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 10 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "demihuman_brain",
    copy_from = "brain",
    looks_like = "brain",
    name = ccb.content.plural_text("piece of raw demihuman brain", "of raw demihuman brain pieces"),
    description = ccb.content.text("A chunk of brain from a demihuman being.  Don't prion diseases cross species barriers?"),
    comestible = {},
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "brain_cooked",
    copy_from = "brain",
    looks_like = "offal_cooked",
    name = ccb.content.plural_text("cooked piece of brain", "of cooked brain pieces"),
    description = ccb.content.text("Now you can emulate those zombies you love so much!  Preparing brain for eating is challenging, and this doesn't seem to be the best way to do it."),
    survival_price = "25 cent",
    comestible = { parasites = 0, fun = -5 },
    inheritance = { add = { flags = { "EATEN_HOT" } }, remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "mutant_brain",
    copy_from = "brain",
    looks_like = "brain",
    name = ccb.content.plural_text("piece of raw mutant brain", "of raw mutant brain pieces"),
    snippet_category = "mutant_brain_desc",
    comestible = {
        fun = -20,
        vitamins = {
            { id = "vitC", amount = 3 },
            { id = "iron", amount = 10 },
            { id = "mutant_toxin", amount = 50 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { add = { flags = { "BAD_TASTE" } }, scale = { survival_price = 0.5 } },
}

ccb.content.define_item {
    id = "mutant_brain_cooked",
    copy_from = "brain_cooked",
    name = ccb.content.plural_text("cooked piece of mutant brain", "of cooked mutant brain pieces"),
    snippet_category = "cooked_mutant_brain_desc",
    comestible = { fun = -12 },
}

ccb.content.define_item {
    id = "kidney",
    copy_from = "lung",
    looks_like = "offal",
    name = ccb.content.plural_text("piece of raw kidney", "of raw kidney pieces"),
    description = ccb.content.text("A chunk of kidney from an animal.  Preparing it for cooking is a challenge unless you want the kitchen to smell strongly of urine."),
    display_type = "BY_WEIGHT",
    color = "brown",
    survival_price = "25 cent",
    comestible = {
        calories = 54,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 25 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "human_kidney",
    copy_from = "kidney",
    looks_like = "kidney",
    name = ccb.content.plural_text("piece of raw human kidney", "of raw human kidney pieces"),
    description = ccb.content.text("A chunk of kidney from a human, which appears to have been extracted too crudely to ever be useful as a transplant."),
    materials = { "hflesh" },
    comestible = {
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 25 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "demihuman_kidney",
    copy_from = "kidney",
    looks_like = "kidney",
    name = ccb.content.plural_text("piece of raw demihuman kidney", "of raw demihuman kidney pieces"),
    description = ccb.content.text("This is probably a piece of kidney extracted from a demihuman being."),
    comestible = {},
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "kidney_cooked",
    copy_from = "kidney",
    looks_like = "offal_cooked",
    name = ccb.content.plural_text("cooked piece of kidney", "of cooked kidney pieces"),
    description = ccb.content.text("No, this is not beans."),
    survival_price = "25 cent",
    comestible = { quench = 0, fun = -2, parasites = 0 },
    inheritance = { remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "mutant_kidney",
    copy_from = "kidney",
    name = ccb.content.plural_text("piece of raw mutant kidney", "of raw mutant kidney pieces"),
    snippet_category = "mutant_kidney_desc",
    comestible = {
        fun = -15,
        vitamins = {
            { id = "vitC", amount = 0 },
            { id = "calcium", amount = 1 },
            { id = "iron", amount = 25 },
            { id = "mutant_toxin", amount = 25 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { add = { flags = { "BAD_TASTE" } }, scale = { survival_price = 0.5 } },
}

ccb.content.define_item {
    id = "mutant_kidney_cooked",
    copy_from = "kidney_cooked",
    name = ccb.content.plural_text("cooked piece of mutant kidney", "of cooked mutant kidney pieces"),
    snippet_category = "cooked_mutant_kidney_desc",
    comestible = { fun = -12 },
}

ccb.content.define_item {
    id = "sweetbread",
    copy_from = "lung",
    looks_like = "offal",
    name = ccb.content.plural_text("piece of raw sweetbread", "of raw sweetbread pieces"),
    description = ccb.content.text("A piece of the thymus or pancreas of an animal.  These are a delicacy, if prepared properly."),
    display_type = "BY_WEIGHT",
    color = "brown",
    survival_price = "25 cent",
    comestible = {
        quench = 0,
        calories = 133,
        vitamins = {
            { id = "vitC", amount = 11 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 5 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "human_sweetbread",
    copy_from = "sweetbread",
    looks_like = "sweetbread",
    name = ccb.content.plural_text("piece of raw human sweetbread", "of raw human sweetbread pieces"),
    description = ccb.content.text("A piece of the thymus or pancreas of a human, which appears to have been extracted too crudely to ever be useful as a transplant."),
    materials = { "hflesh" },
    comestible = {
        vitamins = {
            { id = "vitC", amount = 11 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 5 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "demihuman_sweetbread",
    copy_from = "sweetbread",
    looks_like = "sweetbread",
    name = ccb.content.plural_text("piece of raw demihuman sweetbread", "of raw demihuman sweetbread pieces"),
    description = ccb.content.text("The consistency of this chunk of organ suggests possibly a thymus or pancreas equivalent."),
    comestible = {},
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "sweetbread_cooked",
    copy_from = "sweetbread",
    looks_like = "meat_cooked",
    name = ccb.content.plural_text("cooked piece of sweetbread", "of cooked sweetbread pieces"),
    survival_price = "50 cent",
    description = ccb.content.text("Normally a delicacy, but this style of preparation is missing something."),
    comestible = { fun = -1, parasites = 0 },
    inheritance = { remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "blood",
    name = ccb.content.plural_text("blood", "blood"),
    copy_from = "human_flesh",
    mass = "262 g",
    color = "red",
    default_container = "bag_iv",
    symbol = "~",
    survival_price = "10 cent",
    description = ccb.content.text("Blood extracted from a human being."),
    display_type = "BY_VOLUME",
    price = "0 cent",
    materials = { "hblood" },
    volume = "250 ml",
    phase = "liquid",
    comestible = {
        kind = "DRINK",
        servings = 1,
        smoking_result = "null",
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "meat_allergen", amount = 1 },
            { id = "human_flesh_vitamin", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "fat",
    name = ccb.content.plural_text("chunk of fat", "of fat chunks"),
    mass = "22 g",
    color = "pink",
    symbol = "%",
    price = "0 cent",
    survival_price = "25 cent",
    description = ccb.content.text("A chunk of raw fat.  You could eat it as-is, but it is better used as an ingredient in other foods or projects."),
    display_type = "BY_WEIGHT",
    materials = { "flesh" },
    volume = "25 ml",
    stackable = true,
    comestible = {
        shelf_life = "7 days",
        kind = "FOOD",
        quench = -1,
        calories = 192,
        parasites = 3,
        fun = -20,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "tallow",
    copy_from = "fat",
    name = ccb.content.plural_text("tallow", "tallow"),
    description = ccb.content.text("A smooth, white block of cleaned and rendered animal fat.  It will remain edible for a very long time, and can be used as an ingredient in many foods and projects."),
    color = "white",
    price = "125 cent",
    survival_price = "50 cent",
    comestible = { kind = "FOOD", shelf_life = "60 days", parasites = 0 },
}

ccb.content.define_item {
    id = "mutant_fat",
    copy_from = "fat",
    name = ccb.content.plural_text("chunk of mutant fat", "of mutant fat chunks"),
    description = ccb.content.text("A chunk of raw fat butchered from a heavily-mutated animal.  It smells, if anything, even more disgusting than the rest of the mutant.  There are little puddles of unidentified oils dripping from it."),
    looks_like = "fat",
    comestible = { vitamins = { { id = "mutant_toxin", amount = 36 }, { id = "meat_allergen", amount = 1 } } },
    inheritance = { scale = { price = 0.2 } },
}

ccb.content.define_item {
    id = "mutant_tallow",
    copy_from = "tallow",
    name = ccb.content.plural_text("mutant tallow", "mutant tallow"),
    description = ccb.content.text("A smooth, white block of cleaned and rendered fat, sourced from a mutant animal.  It will remain edible for a very long time, and can be used as an ingredient in many foods and projects."),
    looks_like = "tallow",
    comestible = { vitamins = { { id = "mutant_toxin", amount = 18 }, { id = "meat_allergen", amount = 1 } } },
    inheritance = { scale = { price = 0.2 } },
}

ccb.content.define_item {
    id = "mutant_human_fat",
    copy_from = "mutant_fat",
    name = ccb.content.plural_text("chunk of mutant humanoid fat", "of mutant humanoid fat chunks"),
    description = ccb.content.text("Raw fat butchered from a heavily-mutated humanoid."),
    materials = { "hflesh" },
    comestible = {},
    inheritance = { add = { vitamins = { { id = "human_flesh_vitamin", amount = 1 } } } },
}

ccb.content.define_item {
    id = "mutant_human_tallow",
    name = ccb.content.plural_text("mutant humanoid tallow", "mutant humanoid tallow"),
    copy_from = "mutant_tallow",
    description = ccb.content.text("A smooth, white block of cleaned and rendered fat, sourced from a mutant humanoid.  It won't rot for a very long time, and can be used as an ingredient in many foods and projects."),
    materials = { "hflesh" },
    comestible = {},
    inheritance = { add = { vitamins = { { id = "human_flesh_vitamin", amount = 1 } } } },
}

ccb.content.define_item {
    id = "meat_tainted",
    category = "other",
    name = ccb.content.plural_text("chunk of tainted meat", "of tainted meat chunks"),
    mass = "238 g",
    color = "red",
    symbol = "%",
    description = ccb.content.text("A piece of meat that's obviously unhealthy.  You could eat it, but it will poison you."),
    display_type = "BY_WEIGHT",
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "flesh" },
    volume = "250 ml",
    flags = { "TRADER_AVOID", "NUTRIENT_OVERRIDE", "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "4 hours",
        kind = "FOOD",
        calories = 174,
        fun = -10,
        smoking_result = "dry_meat_tainted",
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "meat_tainted_human",
    copy_from = "meat_tainted",
    category = "other",
    name = ccb.content.plural_text("chunk of tainted human meat", "of tainted human meat chunks"),
    description = ccb.content.text("A piece of rotted meat that has been harvested from something human, or at the very least something once human, as if cannibalism wasn't abhorrent enough."),
    materials = { "hflesh" },
    comestible = {
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "human_flesh_vitamin", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "arm_zed",
    category = "other",
    name = ccb.content.plural_text("tainted limb", "tainted limbs"),
    description = ccb.content.text("A rotted and then shredded arm.  Not much use unless you want to scrape the meat from the bones."),
    snippet_category = "arm_zed_desc",
    color = "red",
    symbol = "%",
    materials = { "flesh" },
    mass = "3767 g",
    volume = "4500 ml",
    price = "0 cent",
    survival_price = "0 cent",
    flags = { "TRADER_AVOID", "NUTRIENT_OVERRIDE", "NO_REPAIR" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        calories = 278,
        fun = -20,
        vitamins = { { id = "meat_allergen", amount = 1 } },
        shelf_life = "2 days",
    },
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "leg_zed",
    category = "other",
    name = ccb.content.plural_text("tainted limb", "tainted limbs"),
    description = ccb.content.text("What's left of some zombie's limb.  Most likely a leg based on the proportions.  Though it's rotted, there is quite a bit of meat still on it."),
    snippet_category = "leg_zed_desc",
    color = "red",
    symbol = "%",
    materials = { "flesh" },
    mass = "11071 g",
    volume = "12 L",
    price = "0 cent",
    survival_price = "0 cent",
    flags = { "TRADER_AVOID", "NUTRIENT_OVERRIDE", "NO_REPAIR" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        calories = 399,
        fun = -20,
        vitamins = { { id = "meat_allergen", amount = 1 } },
        shelf_life = "2 days",
    },
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "blood_tainted",
    copy_from = "meat_tainted",
    name = ccb.content.plural_text("tainted blood", "tainted blood"),
    description = ccb.content.text("Blood that's obviously unhealthy.  You could drink it, but it will poison you."),
    display_type = "BY_VOLUME",
    mass = "262 g",
    volume = "250 ml",
    looks_like = "blood",
    symbol = "~",
    materials = { "blood" },
    phase = "liquid",
    comestible = { kind = "DRINK", servings = 1, smoking_result = "null" },
}

ccb.content.define_item {
    id = "blood_tainted_human",
    copy_from = "meat_tainted_human",
    name = ccb.content.plural_text("tainted human blood", "tainted human blood"),
    description = ccb.content.text("Blood that's obviously unhealthy, and from a human to boot.  You could drink it, but it will poison you."),
    display_type = "BY_VOLUME",
    mass = "262 g",
    volume = "250 ml",
    looks_like = "blood",
    symbol = "~",
    materials = { "hblood" },
    phase = "liquid",
    comestible = { kind = "DRINK", servings = 1, smoking_result = "null" },
}

ccb.content.define_item {
    id = "tainted_marrow",
    category = "other",
    name = ccb.content.plural_text("portion of tainted bone marrow", "of tainted bone marrow portions"),
    mass = "60 g",
    volume = "65 ml",
    color = "red",
    symbol = "%",
    description = ccb.content.text("A wet, green chunk of spongy goop extracted from a rotten bone.  You could eat it, but it will poison you."),
    display_type = "BY_WEIGHT",
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "flesh" },
    flags = { "TRADER_AVOID", "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "4 hours",
        kind = "FOOD",
        calories = 235,
        fun = -10,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "tainted_marrow_human",
    copy_from = "tainted_marrow",
    category = "other",
    name = ccb.content.plural_text("portion of tainted human bone marrow", "of tainted human bone marrow portions"),
    description = ccb.content.text("A wet, green chunk of spongy goop extracted from a rotten human bone.  You could eat it, but it will poison you."),
    materials = { "hflesh" },
    comestible = {
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "human_flesh_vitamin", amount = 1 } },
    },
}

-- Not for use in edible recipes, and should require ~200% as much as normal for applicable inedible recipes.
ccb.content.define_item {
    id = "fat_tainted",
    category = "other",
    name = ccb.content.plural_text("chunk of tainted fat", "of tainted fat chunks"),
    mass = "192 g",
    color = "yellow",
    symbol = "%",
    description = ccb.content.text("A watery yellow glob of fat from some unnatural creature or other.  Something is… wrong with it.  It doesn't seem like normal fat."),
    display_type = "BY_WEIGHT",
    price = "0 cent",
    survival_price = "25 cent",
    materials = { "flesh" },
    volume = "250 ml",
    flags = { "RAW" },
    stackable = true,
    comestible = {
        shelf_life = "4 hours",
        kind = "FOOD",
        calories = 9,
        fun = -10,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
    use_actions = { "POISON" },
}

-- Not for use in any recipes except mutagenics.
ccb.content.define_item {
    id = "fat_tainted_human",
    copy_from = "fat_tainted",
    category = "other",
    name = ccb.content.plural_text("chunk of tainted human fat", "of tainted human fat chunks"),
    description = ccb.content.text("A watery yellow glob of fat from some zombified human.  Something is… wrong with it.  It doesn't seem like normal fat."),
    materials = { "hflesh" },
    comestible = {
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "human_flesh_vitamin", amount = 1 } },
    },
}

-- Not for use in edible/foodsafe recipes.  Inefficiency is handled by tainted tallow recipe requiring 200% as much materials input as regular tallow recipe.
ccb.content.define_item {
    id = "tallow_tainted",
    name = ccb.content.plural_text("tainted tallow", "tainted tallow"),
    category = "chems",
    mass = "128 g",
    color = "light_gray",
    symbol = "%",
    description = ccb.content.text("A smooth grayish block of cleaned and rendered monster fat.  It will remain 'fresh' for a very long time, and can be used as an ingredient in many projects.  You could eat it, but it will poison you."),
    price = "1 cent",
    survival_price = "12 cent",
    materials = { "flesh" },
    volume = "62 ml",
    stackable = true,
    comestible = {
        kind = "FOOD",
        quench = -10,
        calories = 18,
        fun = -18,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "stomach_boiled",
    copy_from = "small_stomach_boiled",
    name = ccb.content.text("large boiled stomach"),
    description = ccb.content.text("A boiled stomach from an animal, nothing else.  It looks all but appetizing."),
    comestible = { fun = -5 },
    inheritance = { scale = { price = 2.0, calories = 2.0, volume = 2.0, mass = 2.0 } },
}

ccb.content.define_item {
    id = "hstomach_boiled",
    copy_from = "stomach_boiled",
    name = ccb.content.text("boiled large human stomach"),
    description = ccb.content.text("A boiled stomach from a large humanoid creature, nothing else.  It looks all but appetizing."),
    materials = { "hflesh" },
    comestible = {
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "human_flesh_vitamin", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "small_stomach_boiled",
    name = ccb.content.text("boiled stomach"),
    mass = "72 g",
    color = "red",
    symbol = ",",
    description = ccb.content.text("A small boiled stomach from an animal, nothing else.  It looks all but appetizing."),
    price = "3 USD 75 cent",
    survival_price = "10 cent",
    materials = { "flesh" },
    volume = "250 ml",
    flags = { "EATEN_HOT" },
    stackable = true,
    comestible = {
        shelf_life = "1 day",
        kind = "FOOD",
        calories = 60,
        fun = -3,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "small_hstomach_boiled",
    copy_from = "small_stomach_boiled",
    name = ccb.content.text("boiled human stomach"),
    description = ccb.content.text("A small boiled stomach from a human, nothing else.  It looks all but appetizing."),
    materials = { "hflesh" },
    comestible = {
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "human_flesh_vitamin", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "raw_leather",
    category = "spare_parts",
    name = ccb.content.plural_text("raw hide", "raw hide"),
    mass = "100 g",
    volume = "125 ml",
    color = "pink",
    symbol = ",",
    description = ccb.content.text("A carefully folded raw skin harvested from an animal.  You can cure it for storage and tanning, or eat it if you're desperate enough."),
    price = "3 USD 30 cent",
    survival_price = "20 cent",
    materials = { "flesh" },
    flags = { "TRADER_AVOID" },
    stackable = true,
    comestible = {
        shelf_life = "1 day 12 hours",
        kind = "FOOD",
        quench = -2,
        calories = 350,
        fun = -12,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "raw_tainted_leather",
    copy_from = "raw_leather",
    name = ccb.content.plural_text("tainted hide", "tainted hide"),
    survival_price = "10 cent",
    description = ccb.content.text("A carefully folded raw skin harvested from an unnatural creature.  The smell of rot is overwhelming, and it has an ghastly unnatural feeling with a wide variety of cuts, divots, and malformed lumps covering the sickly green-gray skin.  This can't be used for anything useful."),
    price = "0 cent",
    comestible = { shelf_life = "6 hours" },
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "raw_tainted_leather_scraps",
    copy_from = "raw_leather",
    name = ccb.content.plural_text("tainted skin scraps", "tainted skin scraps"),
    mass = "1 g",
    volume = "5 ml",
    survival_price = "0 cent",
    description = ccb.content.text("Shredded scraps of raw skin from an unnatural creature.  It can't have much use."),
    price = "0 cent",
    comestible = { shelf_life = "3 hours", calories = 3 },
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "raw_hleather",
    copy_from = "raw_leather",
    name = ccb.content.plural_text("raw human skin", "raw human skin"),
    description = ccb.content.text("A carefully folded raw skin harvested from a human.  Despite some dubious historical accounts, the usefulness of human skin is limited, and can't be made into leather.  The skin is still edible, if you're that desperate."),
    materials = { "hflesh" },
    comestible = {
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "human_flesh_vitamin", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "raw_demihumanleather",
    copy_from = "raw_leather",
    name = ccb.content.plural_text("raw demihuman skin", "raw demihuman skin"),
    description = ccb.content.text("A carefully folded raw skin harvested from a demihuman.  Despite being from a human-enough body, the leather has this distinct unnatural and alien feeling to it, and would be a very poor substitute for leather.  The skin is still edible, if you're that desperate."),
    materials = { "flesh" },
    comestible = { vitamins = { { id = "meat_allergen", amount = 1 } } },
    inheritance = { add = { flags = { "STRICT_HUMANITARIANISM" } } },
}

ccb.content.define_item {
    id = "raw_fur",
    category = "spare_parts",
    name = ccb.content.plural_text("raw pelt", "raw pelt"),
    mass = "114 g",
    volume = "170 ml",
    color = "brown",
    symbol = ",",
    description = ccb.content.text("A carefully folded raw skin harvested from a fur-bearing animal.  It still has the fur attached.  You can cure it for storage and tanning, or eat it if you're desperate enough."),
    price = "3 USD 30 cent",
    survival_price = "1 USD",
    materials = { "fur", "flesh" },
    flags = { "NO_SALVAGE", "TRADER_AVOID" },
    stackable = true,
    comestible = {
        shelf_life = "1 day 12 hours",
        kind = "FOOD",
        quench = -20,
        calories = 350,
        fun = -24,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "raw_tainted_fur",
    name = ccb.content.plural_text("tainted pelt", "tainted pelt"),
    copy_from = "raw_fur",
    description = ccb.content.text("A carefully folded raw pelt harvested from an unnatural creature.  The smell of rot is overwhelming, with bits of flesh cling to the mangy, sickly patches of fur still present on the pelt.  This can't be used for anything useful."),
    price = "0 cent",
    comestible = { shelf_life = "6 hours" },
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "raw_hfur",
    copy_from = "raw_fur",
    name = ccb.content.plural_text("raw human pelt", "raw human pelt"),
    description = ccb.content.text("A carefully folded raw skin harvested from a fur-bearing mutant human.  It still has the fur attached.  You can cure it for storage and tanning, or eat it if you're desperate enough."),
    materials = { "fur", "hflesh" },
    comestible = {
        vitamins = { { id = "meat_allergen", amount = 1 }, { id = "human_flesh_vitamin", amount = 1 } },
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
    flags = { "PREDATOR_FUN" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        healthy = -10,
        calories = 200,
        quench = 10,
        fun = -25,
        vitamins = { { id = "mutagen_beast", amount = 250 }, { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "jabberwock_heart",
    name = ccb.content.text("putrid heart"),
    mass = "4535 g",
    color = "black_red",
    symbol = "%",
    description = ccb.content.text("A thick, hulking mass of flesh that's easily the size of your head, superficially resembling a mammalian heart and covered in ribbed grooves.  It's still full of whatever passes for blood in jabberwocks, and is heavy in your hands.  After everything you've seen lately, you can't help but remember old sayings about eating the hearts of your enemies…"),
    price = "65 USD",
    survival_price = "5 USD",
    materials = { "flesh" },
    volume = "1 L",
    flags = { "PREDATOR_FUN" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        healthy = -10,
        calories = 347,
        fun = -25,
        vitamins = { { id = "mutagen_beast", amount = 300 }, { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "jabberwock_heart_desiccated",
    name = ccb.content.plural_text("desiccated putrid heart", "desiccated putrid hearts"),
    mass = "1360 g",
    color = "black_red",
    symbol = "%",
    description = ccb.content.text("A huge strip of muscle - all that remains of a putrid heart that has been sliced open and drained of blood.  It could be eaten if you're hungry, but looks *disgusting*."),
    price = "10 USD",
    survival_price = "25 cent",
    materials = { "flesh" },
    volume = "250 ml",
    stackable = true,
    comestible = {
        kind = "FOOD",
        healthy = -1,
        calories = 217,
        fun = -30,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "nether_huntsman_organ",
    name = ccb.content.text("reverberating organ"),
    mass = "800 g",
    color = "black_red",
    symbol = ",",
    description = ccb.content.text("A tubular leathery organ of an alien creature, comprised of tough muscle tissue.  Dozens of deep ridges make up the slimy surface, like a disgusting rendition of an accordion."),
    price = "0 cent",
    materials = { "flesh" },
    volume = "1 L",
    flags = { "STRICT_HUMANITARIANISM" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        healthy = -1,
        calories = 186,
        fun = -30,
        shelf_life = "1 day",
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "nether_grub",
    name = ccb.content.text("alien grub"),
    mass = "54 g",
    color = "black_red",
    symbol = "g",
    description = ccb.content.text("A segmented chitinous shell with curious markings is sheltering a weird alien larva, squirming and wiggling around.  Theorizing what it could eventually turn into, you're unsure if it is safe to keep around."),
    price = "0 cent",
    materials = { "flesh" },
    volume = "50 ml",
    stackable = true,
    comestible = {
        kind = "FOOD",
        healthy = -1,
        calories = 213,
        fun = -20,
        shelf_life = "30 days",
        vitamins = {
            { id = "vitC", amount = 8 },
            { id = "calcium", amount = 72 },
            { id = "iron", amount = 231 },
            { id = "mutant_toxin", amount = 110 },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "meat_frond",
    copy_from = "meat_tainted",
    name = ccb.content.plural_text("alien fronds", "alien fronds"),
    description = ccb.content.text("The fleshy fronds harvested from an alien plant.  Eating these membranous leaves and gut-like stems is likely a terrible idea, and yet they have a paradoxically pleasant and inviting sweet smell.  Might be non-vegan."),
    comestible = {
        fun = 15,
        stimulation = 3,
        vitamins = {
            { id = "vitC", amount = 2 },
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 8 },
            { id = "mutant_toxin", amount = 8 },
            { id = "meat_allergen", amount = 1 },
        },
    },
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "leech_flower",
    name = ccb.content.plural_text("leech flower", "leech flowers"),
    color = "blue",
    mass = "10 g",
    volume = "250 ml",
    symbol = "%",
    description = ccb.content.text("The alien beauty of this indigo flower is betrayed by its disgustingly fleshy composition.  What from afar appear to be petals are but layered membranes of transparent veiny flesh, given color by a covering of blue iridescent ichor.  Even if it is certainly poisonous, it has a pleasant medicinal smell to it."),
    survival_price = "10 cent",
    stackable = true,
    comestible = { kind = "MED", shelf_life = "30 days", stimulation = 30, healthy = -10, fun = 15 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("Even a close smell of this alien flower feels deeply intoxicating."),
            effects = {
                { id = "pkill3", duration = 360 },
                { id = "pkill2", duration = 810 },
                { id = "foodpoison", duration = 810 },
                { id = "badpoison", duration = 3600 },
                { id = "shakes", duration = 810 },
            },
        },
    },
}

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

-- It's so alien few micro organisms are able to degrade it.
ccb.content.define_item {
    id = "meat_mi-go",
    category = "other",
    name = ccb.content.plural_text("chunk of mi-go meat", "of mi-go meat chunks"),
    mass = "238 g",
    color = "pink",
    symbol = "%",
    description = ccb.content.text("A piece of mi-go meat that's obviously alien, given its pink color, odd odor, and strange texture.  It would not be advisable to try to eat it."),
    display_type = "BY_WEIGHT",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mi-go_flesh" },
    volume = "250 ml",
    flags = { "TRADER_AVOID", "NUTRIENT_OVERRIDE" },
    stackable = true,
    comestible = { shelf_life = "90 days", kind = "FOOD", calories = 0, fun = -10 },
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "blood_mi-go",
    copy_from = "meat_mi-go",
    name = ccb.content.plural_text("mi-go ichor", "mi-go ichor"),
    description = ccb.content.text("Goo from inside a mi-go, perhaps some kind of blood?  It's obviously alien, given its pink color and strange, nostril-stinging odor.  It would not be advisable to try to eat it."),
    display_type = "BY_VOLUME",
    looks_like = "blood",
    symbol = "~",
    materials = { "mi-go_blood" },
    phase = "liquid",
    comestible = { kind = "DRINK", servings = 1 },
}

ccb.content.define_item {
    id = "bone_mi-go",
    category = "other",
    name = ccb.content.plural_text("mi-go bone", "mi-go bones"),
    mass = "350 g",
    color = "light_green",
    symbol = "%",
    description = ccb.content.text("An unrecognized structural element from inside a mi-go.  It's strong and springy, somewhat like cartilage, but a bit stiffer.  It's also a deep green color, and might possibly serve a scaffolding role, like bone."),
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mi-go_bone" },
    volume = "250 ml",
    stackable = true,
    comestible = { kind = "FOOD", calories = 0, fun = -10 },
    use_actions = { "POISON" },
}

-- Scaled from 100g skin on, boneless, wild duck meat from USDA database
ccb.content.define_item {
    id = "poultry",
    copy_from = "flesh",
    name = ccb.content.plural_text("chunk of poultry meat", "of poultry meat chunks"),
    description = ccb.content.text("A chunk of raw meat from a bird.  Dangerous to eat as-is."),
    display_type = "BY_WEIGHT",
    mass = "104 g",
    volume = "100 ml",
    price = "3 USD",
    survival_price = "25 cent",
    flags = { "RAW", "PREDATOR_FUN" },
    comestible = {
        shelf_life = "1 day",
        calories = 220,
        fun = -18,
        cooks_like = "meat_cooked",
        cooked_item = "meat_cooked",
        cooking_energy = "300 kJ",
        vitamins = {
            { id = "calcium", amount = "5 mg" },
            { id = "iron", amount = "5 mg" },
            { id = "meat_allergen", amount = 1 },
        },
        smoking_result = "poultry_smoked",
    },
}

ccb.content.define_item {
    id = "poultry_scrap",
    copy_from = "poultry",
    name = ccb.content.plural_text("scrap of poultry meat", "of poultry meat scraps"),
    description = ccb.content.text("A tiny scrap of raw meat from a bird.  You figure that one of these should be about one fifth of a portion.  Dangerous to eat as-is."),
    comestible = {
        cooks_like = "meat_scrap_cooked",
        cooked_item = "meat_scrap_cooked",
        cooking_energy = "300 kJ",
        smoking_result = "null",
        vitamins = {
            { id = "calcium", amount = "1 mg" },
            { id = "iron", amount = "1 mg" },
            { id = "meat_allergen", amount = 1 },
        },
    },
    inheritance = { scale = { mass = 0.2, volume = 0.2, survival_price = 0.2, calories = 0.2 } },
}

ccb.content.define_item {
    id = "poultry_cooked",
    copy_from = "flesh",
    mass = "94 g",
    volume = "100 ml",
    name = ccb.content.plural_text("cooked poultry", "cooked poultry"),
    description = ccb.content.text("A chunk of bird meat that has been cooked.  Nutritious and safe to eat, but a bit bland."),
    price = "4 USD",
    survival_price = "1 USD",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE" },
    comestible = {
        shelf_life = "2 days",
        parasites = 0,
        calories = 220,
        fun = 1,
        vitamins = {
            { id = "calcium", amount = "5 mg" },
            { id = "iron", amount = "5 mg" },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "poultry_pepper",
    copy_from = "flesh",
    mass = "104 g",
    volume = "100 ml",
    name = ccb.content.plural_text("cooked pepper poultry", "cooked pepper poultry"),
    description = ccb.content.text("A cut of bird meat that has been cooked with salt and pepper.  The simple addition of spices has made it much more palatable."),
    price = "5 USD",
    survival_price = "2 USD",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE" },
    comestible = {
        shelf_life = "2 days",
        fun = 3,
        parasites = 0,
        calories = 220,
        vitamins = {
            { id = "calcium", amount = "5 mg" },
            { id = "iron", amount = "5 mg" },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "poultry_scrap_cooked",
    copy_from = "poultry_scrap",
    name = ccb.content.plural_text("cooked scrap of poultry", "of cooked poultry scraps"),
    description = ccb.content.text("A tiny scrap of cooked meat from a bird.  Not very filling, and a bit bland."),
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = {
        parasites = 0,
        fun = 1,
        calories = 55,
        vitamins = {
            { id = "calcium", amount = "1 mg" },
            { id = "iron", amount = "1 mg" },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "poultry_scrap_pepper",
    copy_from = "poultry_scrap",
    name = ccb.content.plural_text("cooked pepper scrap of poultry", "of cooked peppered poultry scraps"),
    description = ccb.content.text("A tiny scrap of cooked bird meat, seasoned with simple spices.  Makes for a nice high-protein snack."),
    flags = { "NUTRIENT_OVERRIDE" },
    comestible = {
        parasites = 0,
        fun = 3,
        calories = 55,
        vitamins = {
            { id = "calcium", amount = "1 mg" },
            { id = "iron", amount = "1 mg" },
            { id = "meat_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "poultry_smoked",
    copy_from = "meat_smoked",
    name = ccb.content.plural_text("chicken jerky", "chicken jerky"),
    mass = "65 g",
    description = ccb.content.text("Strip of bird meat that has been heavily smoked for preservation.  It could be further smoked to dehydrate it completely."),
    color = "brown",
    survival_price = "4 USD",
    flags = { "EATEN_HOT" },
    comestible = { shelf_life = "42 days", calories = 220, smoking_result = "dry_poultry" },
}

ccb.content.define_item {
    id = "mutflesh",
    copy_from = "meat",
    name = ccb.content.plural_text("chunk of mutagenic flesh", "of mutagenic flesh chunks"),
    description = ccb.content.text("A chunk of raw meat with a weirdly off-green coloration.  You could eat it as-is, but are you sure you want to?"),
    flags = { "RAW", "TRADER_AVOID" },
    comestible = {
        smoking_result = "null",
        vitamins = { { id = "mutagenic_slurry", amount = 12 }, { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "nl_flesh_powerbox",
    name = ccb.content.text("fleshy cube"),
    color = "black_red",
    symbol = "%",
    description = ccb.content.text("A dense mound of flesh, shaped into an perfect cube.  It has an oily texture matching that of lubricated, machined parts."),
    price = "30 USD",
    survival_price = "1 USD",
    materials = { "flesh" },
    mass = "1075 g",
    volume = "1000 ml",
    flags = { "RAW", "PREDATOR_FUN" },
    comestible = {
        kind = "FOOD",
        healthy = -1,
        calories = 200,
        quench = 10,
        fun = -25,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}
