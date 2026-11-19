local ccb = require("ccb")

ccb.content.define_item {
    id = "small_blessing_brigit",
    name = ccb.content.plural_text("small blessing of Brigit", "small blessing of Brigit"),
    description = ccb.content.text("A small pill made from royal jelly, ash, and poppies.  Blessed with prayers to Brigit over several hours.  Will end any cold or flu instantaneously."),
    mass = "1 g",
    volume = "1 ml",
    price = "2 USD",
    survival_price = "16 USD",
    materials = { "veggy" },
    symbol = "!",
    color = "green",
    flags = { "NPC_SAFE", "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE", "EDIBLE_FROZEN", "SINGLE_USE" },
    comestible = { kind = "MED", healthy = 15, vitamins = { { id = "veggy_allergen", amount = 1 } } },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You feel better almost instantly."),
            effects = { { id = "curesome" } },
        },
    },
}

ccb.content.define_item {
    id = "prophets_lsd",
    name = ccb.content.plural_text("prophet's LSD", "prophet's LSD"),
    description = ccb.content.text("A windowpane worth of Rainbow Skull LSD tabs.  These tabs are said to grant the consumer the ability to see several seconds into the future."),
    mass = "1 g",
    volume = "2 ml",
    price = "1 USD",
    survival_price = "25 cent",
    symbol = "!",
    color = "pink",
    flags = { "EATEN_COLD", "NO_AUTO_CONSUME", "NUTRIENT_OVERRIDE", "SINGLE_USE" },
    comestible = { kind = "MED", stimulation = 20, fun = 25 },
    use_actions = { { kind = "cast_spell", spell = "future_sight", no_fail = true, level = 25 } },
}
