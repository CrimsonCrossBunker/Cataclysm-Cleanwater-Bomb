local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_sundew",
    name = ccb.content.plural_text("Spite Soda", "Spite Soda"),
    mass = "10 g",
    color = "yellow",
    symbol = "~",
    description = ccb.content.text("Spite Soda, the only soda native to the Salus system.  'Stay Frosty, Drink Spite'.  Visitors to the Salus system who have drank Spite Soda have described it as the taste of transhumanist dialectical materialism."),
    price = "10 USD",
    looks_like = "diesel",
    default_container = "can_drink",
    materials = { "alcohol" },
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_COLD" },
    comestible = {
        addiction = "alcohol",
        kind = "DRINK",
        calories = 163,
        quench = 26,
        healthy = -2,
        addiction_potential = 6,
        servings = 2,
        fun = 10,
        freezing_point = -9999,
    },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take a swig, it tastes like it was distilled in a hyperspace engine."),
            effects = {
                { id = "pkill1_generic", duration = "60 m" },
                { id = "pkill2", duration = "30 m" },
                { id = "high", duration = "15 m" },
            },
        },
    },
}
