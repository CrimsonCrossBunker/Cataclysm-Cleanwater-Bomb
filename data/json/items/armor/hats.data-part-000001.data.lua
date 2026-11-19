local ccb = require("ccb")

ccb.content.define_item {
    id = "bandana_head",
    category = "clothing",
    name = ccb.content.plural_text("head bandana", "head bandanas"),
    description = ccb.content.text("A cotton bandana, worn over the head."),
    mass = "42 g",
    volume = "250 ml",
    price = "6 USD",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "scarf",
    color = "blue",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 5,
        thickness = 0.1,
        environmental_protection = 1,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_forehead" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You adjust the bandana to cover your mouth."),
            target = "bandana",
            menu_text = ccb.content.text("Cover mouth"),
        },
    },
}
