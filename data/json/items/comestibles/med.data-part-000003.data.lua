local ccb = require("ccb")

ccb.content.define_item {
    id = "chem_hydrogen_peroxide",
    name = ccb.content.plural_text("hydrogen peroxide", "hydrogen peroxide"),
    description = ccb.content.text("Dilute hydrogen peroxide, for use as an antiseptic and for bleaching hair or textiles.  Foams a little when in contact with organic matter, but otherwise harmless."),
    display_type = "BY_VOLUME",
    mass = "28 g",
    volume = "250 ml",
    price = "1 USD",
    survival_price = "5 USD",
    symbol = "~",
    color = "white",
    phase = "liquid",
    default_container = "bottle_plastic_small",
    flags = { "NO_INGEST", "WATER_DISSOLVE" },
    comestible = { kind = "MED", servings = 10 },
    use_actions = { { kind = "heal", disinfectant_power = 4, bite = 0.95, moves = 2000 } },
}
