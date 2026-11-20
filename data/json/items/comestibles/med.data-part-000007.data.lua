local ccb = require("ccb")

ccb.content.define_item {
    id = "disinfectant",
    name = ccb.content.plural_text("antiseptic", "antiseptic"),
    description = ccb.content.text("A powerful antiseptic commonly used to disinfect wounds."),
    display_type = "BY_VOLUME",
    mass = "27 g",
    volume = "250 ml",
    materials = { { id = "isopropyl", portions = 7 }, { id = "water", portions = 3 } },
    price = "15 USD",
    survival_price = "5 USD",
    symbol = "~",
    color = "light_cyan",
    phase = "liquid",
    default_container = "bottle_plastic_small",
    flags = { "NO_INGEST", "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE" },
    comestible = { kind = "MED", servings = 10, freezing_point = -56 },
    use_actions = { { kind = "heal", disinfectant_power = 4, bite = 0.95, moves = 3000 } },
}

ccb.content.define_item {
    id = "disinfectant_makeshift",
    name = ccb.content.plural_text("makeshift antiseptic", "makeshift antiseptic"),
    survival_price = "2 USD 50 cent",
    copy_from = "disinfectant",
    description = ccb.content.text("Makeshift antiseptic made from ethanol.  Can be used to disinfect wounds."),
    display_type = "BY_VOLUME",
    flags = { "NO_INGEST", "WATER_DISSOLVE" },
    comestible = {},
    use_actions = { { kind = "heal", disinfectant_power = 3, bite = 0.95, moves = 3000 } },
}
