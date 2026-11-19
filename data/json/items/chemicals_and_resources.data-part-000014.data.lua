local ccb = require("ccb")

ccb.content.define_item {
    id = "latex",
    name = ccb.content.plural_text("latex", "latex"),
    description = ccb.content.text("A liquid precursor to rubber found in some plants."),
    mass = "500 mg",
    volume = "50 ml",
    price = "0 cent",
    survival_price = "10 cent",
    symbol = "=",
    color = "white",
    stack_size = 100,
    phase = "liquid",
    looks_like = "milk",
    display_type = "BY_VOLUME",
    comestible = { kind = "INVALID", servings = 1 },
}
