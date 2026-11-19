local ccb = require("ccb")

ccb.content.define_item {
    id = "mugwort_oil",
    name = ccb.content.plural_text("mugwort oil", "mugwort oil"),
    description = ccb.content.text("Some essential oil made from mugwort, which may kill parasites when ingested.  Consume it with water!"),
    display_type = "BY_VOLUME",
    mass = "40 g",
    volume = "250 ml",
    price = "0 cent",
    survival_price = "50 cent",
    materials = { "oil" },
    symbol = "~",
    color = "yellow",
    phase = "liquid",
    flags = { "NPC_SAFE" },
    comestible = { kind = "MED", servings = 1, quench = -50, fun = -5, shelf_life = "28 days" },
    use_actions = { "ANTIPARASITIC" },
}

ccb.content.define_item {
    id = "nic_gum",
    name = ccb.content.plural_text("nicotine gum", "nicotine gums"),
    description = ccb.content.text("Sugar-free chewing gum that slowly delivers nicotine over the course of an hour.  It's designed for smokers who want to quit, but that doesn't mean it can't be habit-forming."),
    mass = "3 g",
    volume = "2 ml",
    price = "10 cent",
    survival_price = "25 cent",
    symbol = "*",
    color = "yellow",
    flags = { "NO_INGEST" },
    stackable = true,
    comestible = {
        kind = "MED",
        fun = 4,
        addiction = "nicotine",
        addiction_potential = 25,
        vitamins = { { id = "nicotine_slow", amount = 3 } },
    },
    use_actions = { "CHEW" },
}

ccb.content.define_item {
    id = "nyquil",
    name = ccb.content.plural_text("cough syrup", "cough syrup"),
    description = ccb.content.text("Nighttime cold and flu medication.  Useful when trying to sleep with a head full of virions.  Will cause drowsiness."),
    display_type = "BY_VOLUME",
    mass = "48 g",
    volume = "250 ml",
    price = "8 USD",
    survival_price = "7 USD 50 cent",
    symbol = "~",
    color = "blue",
    phase = "liquid",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    comestible = {
        kind = "MED",
        servings = 5,
        stimulation = -7,
        addiction_potential = 20,
        addiction = "sleeping pill",
    },
    use_actions = { "FLUSLEEP" },
}

-- Flu meds contain antihistamines among other things, so it's intended that there's some overlap between this and cough syrup.
ccb.content.define_item {
    id = "antihistamine",
    name = ccb.content.plural_text("antihistamine pill", "antihistamine pill"),
    description = ccb.content.text("Over-the-counter allergy medication.  These are meant to be taken once a day and can cause drowsiness."),
    materials = { "drug_filler" },
    mass = "1 g",
    volume = "1 ml",
    price = "25 cent",
    survival_price = "25 cent",
    symbol = "!",
    color = "light_red",
    default_container = "bottle_plastic_pill_supplement",
    flags = { "IRREPLACEABLE_CONSUMABLE", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED", stimulation = -6, addiction_potential = 4, addiction = "sleeping pill" },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take an %s."),
            effects = { { id = "took_antihistamine", duration = "10 h" } },
        },
    },
}

-- 15mg Oxycodone pills
ccb.content.define_item {
    id = "oxycodone",
    name = ccb.content.plural_text("oxycodone", "oxycodone"),
    description = ccb.content.text("A strong semi-synthetic narcotic used in the treatment of intense pain.  Highly addictive."),
    materials = { "drug_filler" },
    mass = "1 g",
    volume = "1 ml",
    price = "275 cent",
    survival_price = "2 USD",
    symbol = "!",
    color = "light_green",
    default_container = "bottle_plastic_pill_prescription",
    flags = { "IRREPLACEABLE_CONSUMABLE", "NO_TEMP" },
    stackable = true,
    comestible = {
        kind = "MED",
        healthy = -1,
        stimulation = -4,
        fun = 18,
        addiction_potential = 16,
        vitamins = { { id = "vit_mme", amount = 2250 } },
        addiction = "opiate",
    },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take some %s."),
            effects = { { id = "pkill3", duration = 120 }, { id = "pkill2", duration = 1200 } },
        },
    },
}

ccb.content.define_item {
    id = "pills_sleep",
    name = ccb.content.plural_text("sleeping pill", "sleeping pills"),
    description = ccb.content.text("A habit-forming tranquilizer with a variety of psychoactive side effects.  Used in the treatment of insomnia."),
    mass = "1 g",
    volume = "1 ml",
    price = "15 cent",
    survival_price = "50 cent",
    materials = { "drug_filler" },
    symbol = "!",
    color = "light_red",
    default_container = "bottle_plastic_pill_prescription",
    variant_kind = "drug",
    variants = {
        {
            id = "ambien",
            name = ccb.content.plural_text("Ambien", "Ambien"),
            append = true,
            description = ccb.content.text("Its generic name is zolpidem tartarate."),
        },
    },
    flags = { "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE", "NO_TEMP" },
    stackable = true,
    comestible = {
        kind = "MED",
        stimulation = -8,
        fun = 5,
        addiction_potential = 40,
        addiction = "sleeping pill",
        sleepiness = -40,
    },
    use_actions = { { kind = "consume_drug", message = ccb.content.text("You take a %s.") } },
}

-- 1 ML equivalent to 1 mg of morphine. So in this item 2ML equals 2 mg of morphine.
ccb.content.define_item {
    id = "poppy_pain",
    name = ccb.content.plural_text("poppy painkiller", "poppy painkiller"),
    description = ccb.content.text("A potent opioid palliative produced by the refining of the mutated poppy.  Notably devoid of euphoric or sedative effects, but as an opiate it can still be addictive."),
    display_type = "BY_VOLUME",
    mass = "1 g",
    volume = "2 ml",
    price = "30 cent",
    survival_price = "150 cent",
    materials = { "drug_filler" },
    symbol = "!",
    color = "pink",
    flags = { "NO_TEMP" },
    stackable = true,
    comestible = {
        kind = "MED",
        healthy = -2,
        addiction_potential = 10,
        addiction = "opiate",
        vitamins = { { id = "vit_mme", amount = 200 } },
    },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take some %s."),
            effects = { { id = "pkill2", duration = 1080 } },
        },
    },
}
