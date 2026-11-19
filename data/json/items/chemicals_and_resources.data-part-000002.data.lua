local ccb = require("ccb")

ccb.content.define_item {
    id = "ammonia_liquid",
    name = ccb.content.plural_text("liquid ammonia", "liquid ammonia"),
    mass = "124 g",
    color = "white",
    flags = { "CORROSIVE" },
    default_container = "pressure_tank",
    sealed_container = false,
    symbol = "~",
    description = ccb.content.text("Anhydrous ammonia, a useful chemical compound.  It must be stored under pressure or refrigerated.  Don't even think about drinking it."),
    price = "67 cent",
    survival_price = "50 cent",
    volume = "250 ml",
    phase = "liquid",
    stack_size = 1,
    category = "chems",
    display_type = "BY_VOLUME",
    ammunition = { type = "ammonia_liquid" },
}
