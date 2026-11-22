local ccb = require("ccb")

ccb.content.define_item {
    id = "string_dimension_biosuit",
    name = "gold-latticed biosuit",
    description = "A striated bodysuit constructed from a bilayer of stark-white metallic fabric, coated in a microscopically thin layer of gold.  Some of the fibers are more gold than others, giving it a barely perceptible hex pattern.  The textile bilayer is filled with liquid, giving it a squishy, cool-to-the-touch bodyfeel.",
    symbol = "[",
    color = "yellow",
    category = "armor",
    mass = "4000 g",
    volume = "12 L",
    price = "1 kUSD 175 USD",
    survival_price = "300 USD",
    flags = {
        "VARSIZE",
        "WATERPROOF",
        "RAINPROOF",
        "STURDY",
        "NO_REPAIR",
        "SKINTIGHT",
        "MUNDANE",
        "SOFT",
    },
    materials = {
        { id = "nanotubes", portions = 4 },
        { id = "alien_liquid", portions = 1 },
        { id = "gold", portions = 0.01 },
    },
    armor = {
        warmth = 0,
        environmental_protection = 20,
        portions = {
            {
                covers = { "torso", "leg_l", "leg_r", "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 7,
                materials = {
                    { id = "nanotubes", thickness = 4, coverage = 100 },
                    { id = "alien_liquid", thickness = 1, coverage = 100 },
                    { id = "gold", thickness = 0.01, coverage = 100 },
                },
            },
        },
    },
    artifact = {
        enchantments = { "ench_string_dimension_biosuit" },
    },
    subtype_order = { "armor", "artifact" },
}
