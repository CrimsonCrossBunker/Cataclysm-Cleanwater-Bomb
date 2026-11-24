local ccb = require("ccb")

ccb.content.define_item {
    id = "extra_str_aspirin",
    name = ccb.content.plural_text("eXtra strength aspirin", "eXtra strength aspirins"),
    description = ccb.content.text("Alchemically altered aspirin.  Take to relieve pain and injury.  Will only reduce injuries to body core, will not extend to limbs."),
    mass = "1 g",
    volume = "1 ml",
    price = "2 cent",
    survival_price = "37 cent",
    materials = { "powder" },
    symbol = "!",
    color = "white",
    default_container = "bottle_plastic_pill_painkiller",
    flags = { "WATER_DISSOLVE", "EDIBLE_FROZEN" },
    comestible = { kind = "MED", healthy = -1 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take some %s."),
            effects = { { id = "xtr_str_aspirin", duration = 720 } },
        },
    },
}

ccb.content.define_item {
    id = "truckstop_viagra",
    name = ccb.content.plural_text("horny rhino pill", "horny rhino pills"),
    description = ccb.content.text("DOES YOUR PARTNER FIND YOUR LACK OF SEXUAL POTENCY PATHETIC?!??!  SMASH YOUR BEDROOM LIKE A WILD ANIMAL ALL NIGHT LONG!!!  -ingredients not confirmed with the FDA."),
    mass = "1 g",
    volume = "5 ml",
    price = "4 cent",
    survival_price = "5 cent",
    symbol = "!",
    color = "magenta",
    default_container = "bottle_plastic_pill_supplement",
    flags = { "NO_INGEST", "WATER_DISSOLVE", "EDIBLE_FROZEN" },
    comestible = {
        kind = "MED",
        quench = -4,
        stimulation = 10,
        healthy = -3,
        fun = 10,
        addiction_potential = 10,
        addiction = "amphetamine",
    },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take the %s.  Your skin feels like it is vibrating."),
        },
    },
}

-- Not commercially traded, in case there was any question.
ccb.content.define_item {
    id = "blood_of_saints",
    name = ccb.content.plural_text("blood of the saints", "blood of the saints"),
    description = ccb.content.text("A rare substance of uncertain origins.  Causes you to mutate."),
    price = "2500 USD",
    survival_price = "500 USD",
    category = "mutagen",
    mass = "250 g",
    volume = "250 ml",
    phase = "liquid",
    default_container = "flask_glass",
    symbol = "~",
    color = "light_green",
    flags = { "NO_INGEST", "NUTRIENT_OVERRIDE" },
    materials = { "water" },
    comestible = {
        kind = "MED",
        servings = 1,
        healthy = -2,
        addiction_potential = 2,
        addiction = "mutagen",
        vitamins = {},
        freezing_point = -8,
        on_consume = "drink_blood_of_saints",
    },
}
