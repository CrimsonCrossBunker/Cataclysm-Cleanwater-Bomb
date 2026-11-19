local ccb = require("ccb")

ccb.content.define_item {
    id = "small_relic",
    name = ccb.content.plural_text("small relic", "small relics"),
    description = ccb.content.text("A small relic from a forgotten saint.  As extraordinary as the world has become, it may have some power yet."),
    mass = "60 g",
    volume = "15 ml",
    price = "10 USD",
    survival_price = "75 cent",
    materials = { { id = "bone", portions = 8 }, { id = "silver", portions = 2 } },
    symbol = "[",
    color = "white",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
    use_actions = { "MEDITATE" },
}
