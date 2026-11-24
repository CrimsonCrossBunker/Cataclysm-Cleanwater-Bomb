local ccb = require("ccb")

ccb.content.define_item {
    id = "faewild",
    name = ccb.content.plural_text("faewild dust", "faewild dust"),
    description = ccb.content.text("A shimmering silvery dust.  Narcotic with the street name of Faewild.  Causes the user to see colors not normally visible to the naked human eye."),
    mass = "1 g",
    volume = "2 ml",
    price = "1 USD",
    survival_price = "25 cent",
    symbol = ":",
    color = "pink",
    flags = { "NO_INGEST", "EDIBLE_FROZEN" },
    comestible = { kind = "MED", stimulation = 20, fun = 25, addiction = "faewild", addiction_potential = 10 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You rub the glittering dust into your gums."),
            effects = { { id = "faewild", duration = 3600 } },
        },
    },
}

ccb.content.define_item {
    id = "lotus_blossom",
    name = ccb.content.plural_text("lotus blossom", "lotus blossoms"),
    description = ccb.content.text("A drug that became popular over the last few years before the Cataclysm.  It appears to be exactly as its street name, a dark purple lotus blossom.  It's known to be a strong painkiller while also causing vivid hallucinations."),
    mass = "1 g",
    volume = "2 ml",
    price = "1 USD",
    survival_price = "25 cent",
    symbol = "*",
    color = "magenta",
    flags = { "NO_INGEST", "EDIBLE_FROZEN" },
    comestible = {
        kind = "MED",
        stimulation = -20,
        fun = 45,
        addiction = "lotus_blossom",
        addiction_potential = 40,
    },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You eat the purple lotus blossom."),
            effects = {
                { id = "visuals", duration = 900 },
                { id = "hallu", duration = 9000 },
                { id = "pkill3", duration = 180 },
                { id = "pkill2", duration = 600 },
            },
        },
    },
}

ccb.content.define_item {
    id = "wyld_candy",
    name = ccb.content.plural_text("wyld candy", "wyld candies"),
    description = ccb.content.text("Mixed candies purporting to come from 'Fair Folk Industries' these candies appear in areas of the country thought to have significant crossover events.  It remains unknown whether these candies are produced by a company from here taking advantage of a thin place or if they came from somewhere else."),
    mass = "1 g",
    volume = "5 ml",
    price = "250 cent",
    survival_price = "1 USD",
    symbol = "!",
    color = "magenta",
    default_container = "wrapper_wyld",
    flags = { "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE", "EDIBLE_FROZEN" },
    comestible = { kind = "MED" },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take the %s."),
            vitamins = { { id = "underhill_essence", minimum = 44, maximum = 122 } },
        },
    },
}

ccb.content.define_item {
    id = "blood_treatment",
    name = ccb.content.plural_text("questionable blood treatment", "questionable blood treatment"),
    description = ccb.content.text("This homemade blood treatment purports to reduce the cravings brought on by vampirism and if applied often and early to even reverse some stages of the disease.  But vampires surely can't be real, can they?"),
    mass = "1 g",
    volume = "12ml",
    price = "50 USD",
    phase = "liquid",
    survival_price = "20 USD",
    materials = { "hflesh" },
    stack_size = 4,
    symbol = "!",
    color = "magenta",
    flags = { "NPC_SAFE", "TRADER_AVOID" },
    comestible = {
        kind = "MED",
        servings = 4,
        vitamins = { { id = "meat_allergen", amount = 1 } },
        on_consume = "drink_blood_treatment",
    },
}

ccb.content.define_item {
    id = "cthonic_poultice",
    name = ccb.content.plural_text("cthonic poultice", "cthonic poultices"),
    description = ccb.content.text("A poultice made from the elements of the earth.  You could use it to heal your wounds, if you were made of stone."),
    mass = "175 g",
    volume = "250 ml",
    price = "6 USD",
    materials = { "dreamstuff" },
    symbol = "~",
    color = "brown",
    flags = { "NO_INGEST", "CANT_HEAL_EVERYONE" },
    comestible = { kind = "MED" },
    use_actions = { { kind = "heal", bandages_power = 15, limb_power = 5, bleed = 5, moves = 300 } },
}

ccb.content.define_item {
    id = "verdant_poultice",
    name = ccb.content.plural_text("verdant poultice", "verdant poultices"),
    description = ccb.content.text("A poultice made from plant life.  You could use it to heal your wounds, if you were grown from plants."),
    mass = "175 g",
    volume = "250 ml",
    price = "6 USD",
    materials = { "dreamstuff" },
    symbol = "~",
    color = "brown",
    flags = { "NO_INGEST", "CANT_HEAL_EVERYONE" },
    comestible = { kind = "MED" },
    use_actions = { { kind = "heal", bandages_power = 15, limb_power = 5, bleed = 5, moves = 300 } },
}

ccb.content.define_item {
    id = "cerulean_poultice",
    name = ccb.content.plural_text("cerulean poultice", "cerulean poultices"),
    description = ccb.content.text("A poultice made from the elements of the sea.  You could use it to heal your wounds, if you were liquid as well."),
    mass = "175 g",
    volume = "250 ml",
    price = "6 USD",
    materials = { "dreamstuff" },
    symbol = "~",
    color = "brown",
    flags = { "NO_INGEST", "CANT_HEAL_EVERYONE" },
    comestible = { kind = "MED" },
    use_actions = { { kind = "heal", bandages_power = 15, limb_power = 5, bleed = 5, moves = 300 } },
}

ccb.content.define_item {
    id = "charred_sacrifice",
    name = ccb.content.plural_text("charred sacrifice", "charred sacrifice"),
    description = ccb.content.text("A devotion to the powers of fire.  You could use it to heal your wounds, if you were born of the flames."),
    mass = "175 g",
    volume = "250 ml",
    price = "6 USD",
    materials = { "dreamstuff" },
    symbol = "~",
    color = "brown",
    flags = { "NO_INGEST", "CANT_HEAL_EVERYONE" },
    comestible = { kind = "MED" },
    use_actions = { { kind = "heal", bandages_power = 15, limb_power = 5, bleed = 5, moves = 300 } },
}

ccb.content.define_item {
    id = "doll_repair_paste",
    name = ccb.content.plural_text("doll repair paste", "doll repair paste"),
    description = ccb.content.text("A paste made from paint and glue.  You could use it to heal your wounds, if you were made in man's image."),
    mass = "175 g",
    volume = "250 ml",
    price = "6 USD",
    materials = { "dreamstuff" },
    symbol = "~",
    color = "brown",
    flags = { "NO_INGEST", "CANT_HEAL_EVERYONE" },
    comestible = { kind = "MED" },
    use_actions = { { kind = "heal", bandages_power = 15, limb_power = 5, bleed = 5, moves = 300 } },
}

ccb.content.define_item {
    id = "ethereal_draught",
    name = ccb.content.plural_text("ethereal draught", "ethereal draughts"),
    description = ccb.content.text("A concoction made from honey and bread.  You could use it to heal your wounds, if you were born of air and darkness."),
    mass = "175 g",
    volume = "250 ml",
    price = "6 USD",
    materials = { "dreamstuff" },
    symbol = "~",
    color = "brown",
    flags = { "NO_INGEST", "CANT_HEAL_EVERYONE" },
    comestible = { kind = "MED" },
    use_actions = { { kind = "heal", bandages_power = 15, limb_power = 5, bleed = 5, moves = 300 } },
}

-- NO_I18N
ccb.content.define_item {
    id = "elemental_mana_draught",
    name = ccb.content.plural_text("elemental mana draught", "elemental mana draughts"),
    description = ccb.content.text_without_extraction("Converting"),
    mass = "245 g",
    volume = "250ml",
    symbol = "~",
    default_container = "flask_glass",
    color = "light_blue",
    flags = { "EATEN_COLD", "NO_AUTO_CONSUME", "NUTRIENT_OVERRIDE" },
    phase = "liquid",
    price = "25 USD",
    comestible = { quench = 1, calories = 0, servings = 1, fun = -1, kind = "DRINK", freezing_point = 4 },
    use_actions = { { kind = "cast_spell", spell = "potion_recover_mana_xe", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "anathema_blood_catalyst_unready",
    category = "drugs",
    looks_like = "vampire_blood",
    name = ccb.content.plural_text("churning vampire blood mixture", "churning vampire blood mixture"),
    description = ccb.content.text("Vampire blood mixed with blood none would consume and different toxic substances.  The hostile environment is already driving the vampire blood to devour itself.  It will be ready to consume in a few days."),
    materials = { "vampire_blood" },
    phase = "liquid",
    mass = "5360 g",
    color = "red",
    flags = { "TRADER_AVOID", "INEDIBLE" },
    symbol = "~",
    price = "0 cent",
    volume = "6000 ml",
    comestible = { kind = "DRINK", servings = 1 },
    use_actions = {
        {
            kind = "delayed_transform",
            target = "anathema_blood_catalyst",
            message = ccb.content.text("The vampire blood has completely devoured itself, leaving a small dose of very potent vampire blood behind."),
            moves = 50,
            age = 345600,
            not_ready_message = ccb.content.text("The vampire blood is still devouring itself."),
        },
    },
}
