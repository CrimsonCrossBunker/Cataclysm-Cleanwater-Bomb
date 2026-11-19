local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "mbelt_leather",
    abstract = true,
    name = ccb.content.text_without_extraction("magic leather belt"),
    description = ccb.content.text_without_extraction("A leather belt.  Useful for making your pair of pants fit."),
    mass = "102 g",
    volume = "250 ml",
    price = "900 USD",
    materials = { "leather", "steel" },
    symbol = "[",
    color = "brown",
    pockets = {
        {
            holster = true,
            capacity = "1 L",
            mass_limit = "750 g",
            max_item_length = "70 cm",
            moves = 60,
            allowed_flags = { "BELT_CLIP" },
            transparent = true,
        },
    },
    flags = { "BELTED", "WATER_FRIENDLY", "STURDY", "OVERSIZE" },
    melee_damage = { bash = 5 },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        thickness = 2,
        portions = { { coverage = 50, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stick what into your belt"),
            message = ccb.content.text("You tuck your %s into your %s"),
        },
    },
}
