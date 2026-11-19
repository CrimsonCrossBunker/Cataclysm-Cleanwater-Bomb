local ccb = require("ccb")

ccb.content.define_item {
    id = "alumentum",
    category = "spare_parts",
    price = "9 USD",
    name = ccb.content.plural_text("alumentum", "alumentum"),
    symbol = "=",
    color = "light_blue",
    description = ccb.content.text("Alumentum is magically processed coal or charcoal.  It burns as hot as magnesium, and for a significantly longer period of time.  One of the very few magical materials that is still produced in any quantity today due to its usefulness."),
    phase = "solid",
    volume = "250 ml",
    mass = "11 g",
    materials = { "alumentum" },
    stack_size = 10,
    ammunition = { type = "alumentum", count = 50 },
}
