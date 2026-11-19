local ccb = require("ccb")

ccb.content.define_item {
    id = "psionic_serum_base",
    name = ccb.content.plural_text("psychoreactive catalyst", "psychoreactive catalyst"),
    description = ccb.content.text("A thick liquid, mixed with ground matrix crystal and ready to be catalyzed.  In total darkness, it glows very faintly."),
    materials = { "alien_liquid", "nether_crystal", "water" },
    mass = "30 g",
    volume = "25 ml",
    phase = "liquid",
    price = "10 cent",
    survival_price = "1 cent",
    default_container = "flask_glass",
    flags = { "TRADER_AVOID" },
    symbol = "~",
    color = "dark_gray",
    comestible = { kind = "DRINK", servings = 1, freezing_point = -8 },
    use_actions = { "POISON" },
}
