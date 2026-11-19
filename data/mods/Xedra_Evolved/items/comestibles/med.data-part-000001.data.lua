local ccb = require("ccb")

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
