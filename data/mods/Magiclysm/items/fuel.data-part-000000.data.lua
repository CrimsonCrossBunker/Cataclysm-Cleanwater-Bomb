local ccb = require("ccb")

ccb.content.define_item {
    id = "dragon_blood",
    name = ccb.content.plural_text("dragon blood", "dragon blood"),
    mass = "1 g",
    color = "red",
    default_container = "flask_glass",
    symbol = "~",
    description = ccb.content.text("Blood of a dragon, it radiates warmth and looking at it you see moving patterns form and disappear in it as if looking at an actual fire."),
    price = "1 USD 50 cent",
    materials = { "dragon_blood" },
    volume = "1 ml",
    phase = "liquid",
    category = "fuel",
    ammunition = {
        type = "dragon_blood",
        damage = { type = "stab", amount = 5, penetration = 5 },
        range = 4,
        effects = { "FLAME", "STREAM", "IGNITE" },
    },
}
