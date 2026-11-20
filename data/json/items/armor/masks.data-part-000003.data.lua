local ccb = require("ccb")

-- Headpiece for the string dimension biosuit.
ccb.content.define_item {
    id = "string_dimension_biocoif",
    name = ccb.content.plural_text("gold-latticed biocoif", "gold-latticed biocoifs"),
    description = ccb.content.text("A skintight headsock constructed from a bilayer of stark-white metallic fabric coated in a microscopically thin layer of gold.  A few of the fibers are more gold than others, giving it a barely perceptible hex pattern.  The textile bilayer is filled with liquid, giving it a squishy, cool-to-the-touch bodyfeel."),
    mass = "120 g",
    volume = "250 ml",
    price = "1kUSD",
    survival_price = "150 USD",
    materials = {
        { id = "nanotubes", portions = 4 },
        { id = "alien_liquid", portions = 1 },
        { id = "gold", portions = 0.01 },
    },
    symbol = "[",
    color = "yellow",
    flags = {
        "VARSIZE",
        "WATERPROOF",
        "RAINPROOF",
        "STURDY",
        "NO_REPAIR",
        "SKINTIGHT",
        "SOFT",
        "PSYSHIELD_PARTIAL",
    },
    armor = {
        warmth = 0,
        environmental_protection = 20,
        portions = {
            {
                materials = {
                    { id = "nanotubes", coverage = 100, thickness = 4 },
                    { id = "alien_liquid", coverage = 100, thickness = 1 },
                    { id = "gold", coverage = 100, thickness = 0.01 },
                },
                covers = { "head" },
                coverage = 100,
                encumbrance = 7,
            },
        },
    },
}
