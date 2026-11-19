local ccb = require("ccb")

ccb.content.define_item {
    id = "cloak_verdant",
    name = ccb.content.plural_text("verdant cloak", "verdant cloaks"),
    description = ccb.content.text("A heavy cloak made of living leaves with long twigs and branches connecting them, meant to be thrown over your body."),
    mass = "1175 g",
    volume = "3 L",
    price = "107 USD",
    survival_price = "5 USD",
    materials = { "veggy" },
    symbol = "[",
    looks_like = "cloak",
    color = "green",
    flags = { "OVERSIZE", "HOOD", "BELTED" },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 30,
        thickness = 0.4,
        environmental_protection = 3,
        portions = {
            {
                encumbrance = 4,
                coverage = 65,
                covers = { "torso", "arm_l", "arm_r", "leg_l", "leg_r" },
            },
        },
    },
    artifact = { enchantments = { "ench_verdant_cloak" } },
}
