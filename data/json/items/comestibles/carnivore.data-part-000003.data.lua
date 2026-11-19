local ccb = require("ccb")

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
