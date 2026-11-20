local ccb = require("ccb")

ccb.content.define_item {
    id = "caramel_ointement",
    name = ccb.content.plural_text("caramel ointment", "caramel ointment"),
    description = ccb.content.text("An ointment made of caramel.  You could use it to heal your wounds, if you were made of sugar."),
    mass = "375 g",
    volume = "27 ml",
    price = "66 cent",
    materials = { "sugar" },
    symbol = "~",
    color = "brown",
    flags = { "NO_INGEST", "CANT_HEAL_EVERYONE" },
    comestible = { kind = "MED" },
    use_actions = { { kind = "heal", bandages_power = 15, limb_power = 5, moves = 300 } },
}
