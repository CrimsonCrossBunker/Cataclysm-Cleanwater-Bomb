local ccb = require("ccb")

ccb.content.define_item {
    id = "homeopathic_pills",
    name = ccb.content.plural_text("homeopathic pill", "homeopathic pills"),
    description = ccb.content.text("A homeopathic pill, prepared through the repeated dilution of an active ingredient with water.  The label purports that these pills are able to maintain general wellness."),
    materials = { "sugar" },
    mass = "1 g",
    volume = "1 ml",
    price = "50 cent",
    survival_price = "1 cent",
    symbol = "!",
    color = "white",
    flags = { "NO_TEMP" },
    variants = {
        {
            id = "pill1",
            name = ccb.content.plural_text("homeopathic pill", "homeopathic pills"),
            description = ccb.content.text("An Oscillococcinum homeopathic pill, prepared through the dilution of one part duck offal with 10^400 parts water.  The label purports that these pills are able to treat flu-like symptoms and maintain general wellness."),
        },
        {
            id = "pill2",
            name = ccb.content.plural_text("homeopathic pill", "homeopathic pills"),
            description = ccb.content.text("An Arsenicum album homeopathic pill, prepared through the dilution of one part arsenic trioxide with 10^24 parts water.  Purported to treat anxiety, various digestive disorders, and arsenic poisoning."),
        },
        {
            id = "pill3",
            name = ccb.content.plural_text("homeopathic pill", "homeopathic pills"),
            description = ccb.content.text("An Allium cepa homeopathic pill, prepared through the dilution of one part onion with 10^30 parts water.  The label states that these pills can ameliorate symptoms of asthma, gastrointestinal disorders, and bronchitis.  You briefly wonder if it can cure fungal infections."),
        },
        {
            id = "pill4",
            name = ccb.content.plural_text("homeopathic pill", "homeopathic pills"),
            description = ccb.content.text("An Arum tryphillum homeopathic pill, prepared through the dilution of the jack-in-the-pulpit plant with 10^30 parts water.  The label claims that the pills are able to treat voice loss."),
        },
        {
            id = "pill5",
            name = ccb.content.plural_text("homeopathic pill", "homeopathic pills"),
            description = ccb.content.text("An Aesculus hippocastanum homeopathic pill, prepared through the dilution of horse chestnut with 10^30 parts water.  These pills are meant to treat dysentery and hemorrhoids."),
        },
        {
            id = "pill6",
            name = ccb.content.plural_text("homeopathic pill", "homeopathic pills"),
            description = ccb.content.text("A Lachesis mutus pill, prepared through the dilution of the venom of the bushmaster snake with 10^1000 parts water.  These pills are claimed to be an effective treatment for sore throat."),
        },
        {
            id = "sugar_pill",
            name = ccb.content.plural_text("sugar pill", "sugar pills"),
            description = ccb.content.text("A pill that's just made of sugar, meant to help keep the daily routine of taking birth control pills."),
            weight = 0,
        },
    },
    stackable = true,
    comestible = { kind = "MED", fun = 1 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You swallow the %s.  You wait in anticipation of its effects."),
        },
    },
}

ccb.content.define_item {
    id = "inj_iron",
    name = ccb.content.plural_text("injectable iron", "injectable iron"),
    description = ccb.content.text("A small vial of dark yellow liquid containing soluble iron for injection."),
    display_type = "BY_VOLUME",
    mass = "40 g",
    volume = "25 ml",
    price = "2 USD",
    survival_price = "75 cent",
    symbol = "!",
    color = "magenta",
    flags = { "NO_INGEST", "IRREPLACEABLE_CONSUMABLE", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED" },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject some iron."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "iron", minimum = 100 } },
        },
    },
}

ccb.content.define_item {
    id = "weed",
    name = ccb.content.plural_text("marijuana", "marijuana"),
    description = ccb.content.text("The dried flower buds and leaves harvested from a psychoactive variety of hemp plant.  Used to reduce nausea, relieve pain, sleep easier, and elevate mood.  It can be habit-forming."),
    display_type = "BY_WEIGHT",
    mass = "1 g",
    volume = "2 ml",
    price = "25 cent",
    survival_price = "25 cent",
    symbol = "!",
    color = "green",
    materials = { "veggy" },
    flags = { "NO_INGEST", "NO_TEMP" },
    stackable = true,
    comestible = {
        kind = "MED",
        quench = -5,
        healthy = -1,
        fun = 15,
        addiction_potential = 5,
        addiction = "cannabis",
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You smoke some weed."),
            effects = { { id = "weed_high", duration = "5 m" } },
            fields_produced = { fd_weedsmoke = 1 },
            charges_needed = { fire = 1 },
            tools_needed = { apparatus = -1 },
            moves = 1500,
            vitamins = { { id = "cannabis", minimum = 7 } },
        },
    },
}

-- Yeah, kinda guessing at these ones, but generic is cheaper.
ccb.content.define_item {
    id = "xanax",
    name = ccb.content.plural_text("fast-acting sedative", "fast-acting sedative"),
    description = ccb.content.text("An anti-anxiety agent with a powerful sedative effect.  May cause dissociation and loss of memory.  It is dangerously addictive, and withdrawal from regular use should be gradual."),
    materials = { "drug_filler" },
    mass = "1 g",
    volume = "1 ml",
    price = "30 cent",
    survival_price = "25 cent",
    symbol = "!",
    color = "cyan",
    default_container = "bottle_plastic_pill_prescription",
    variant_kind = "drug",
    variants = {
        {
            id = "xanax",
            name = ccb.content.plural_text("Xanax", "Xanax"),
            description = ccb.content.text("An anti-anxiety agent with a powerful sedative effect.  May cause dissociation and loss of memory.  It is dangerously addictive, and withdrawal from regular use should be gradual."),
        },
    },
    flags = { "IRREPLACEABLE_CONSUMABLE", "NO_TEMP" },
    stackable = true,
    comestible = {
        kind = "MED",
        stimulation = -4,
        healthy = -2,
        fun = 20,
        addiction_potential = 40,
        addiction = "diazepam",
    },
    use_actions = { "XANAX" },
}

ccb.content.define_item {
    id = "weak_antibiotic",
    name = ccb.content.plural_text("narrow-spectrum antibiotics", "narrow-spectrum antibiotics"),
    description = ccb.content.text("A narrow-spectrum antibiotic used to suppress infections and prevent them from spreading.  It isn't broad enough to purge most infections outright, but it boosts the body's resistance against them.  One dose lasts twelve hours."),
    mass = "611 mg",
    volume = "1 ml",
    price = "7 cent",
    survival_price = "1 USD",
    materials = { "drug_filler" },
    symbol = "!",
    color = "white",
    default_container = "bottle_plastic_pill_prescription",
    flags = { "NPC_SAFE", "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED", healthy = -2 },
    use_actions = { "WEAK_ANTIBIOTIC" },
}

ccb.content.define_item {
    id = "pepto",
    name = ccb.content.plural_text("heartburn medicine", "heartburn medicine"),
    description = ccb.content.text("Creamy pink heartburn syrup that soothes upset stomachs and quells vomitous urges."),
    display_type = "BY_VOLUME",
    materials = { "drug_filler" },
    mass = "1 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "2 USD 50 cent",
    default_container = "bottle_plastic_small",
    symbol = "%",
    phase = "liquid",
    color = "white",
    flags = { "NPC_SAFE", "IRREPLACEABLE_CONSUMABLE" },
    comestible = { kind = "MED", servings = 10 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take some %s."),
            effects = { { id = "tummy_tablet", duration = 6400 } },
        },
    },
}

ccb.content.define_item {
    id = "tums",
    name = ccb.content.plural_text("antacid tablet", "antacid tablets"),
    description = ccb.content.text("A common stomach soother in flavored tablet form.  Makes you less likely to vomit."),
    materials = { "drug_filler" },
    mass = "2 g",
    looks_like = "melatonin_tablet",
    volume = "10 ml",
    price = "20 cent",
    survival_price = "10 cent",
    symbol = "!",
    color = "white",
    default_container = "bottle_plastic_small",
    flags = { "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE", "NPC_SAFE", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED", fun = 1 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take an %s."),
            effects = { { id = "tummy_tablet", duration = 6400 } },
            vitamins = { { id = "calcium", minimum = 25 } },
        },
    },
}

ccb.content.define_item {
    id = "panacea",
    name = ccb.content.plural_text("Panaceus", "Panaceii"),
    description = ccb.content.text("An apple-red gel capsule the size of your thumbnail, filled with a thick, oily liquid that shifts from black to purple at unpredictable intervals, flecked with tiny gray dots.  Given the place you got it from, it's either very potent, or highly experimental.  Holding it, all the little aches and pains seem to fade, just for a moment…"),
    mass = "1 g",
    volume = "2 ml",
    price = "2 kUSD",
    survival_price = "16 USD",
    materials = { "drug_filler" },
    symbol = "!",
    color = "red",
    default_container = "bottle_plastic_pill_prescription",
    flags = { "NPC_SAFE", "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED", healthy = 25 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You feel AMAZING!"),
            effects = { { id = "panacea", duration = "1 m" }, { id = "cureall" } },
        },
    },
}
