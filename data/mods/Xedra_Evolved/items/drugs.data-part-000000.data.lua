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
