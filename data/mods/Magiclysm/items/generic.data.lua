local ccb = require("ccb")

ccb.content.define_item {
    id = "parabolan_yarn",
    category = "spare_parts",
    price = "0 cent",
    survival_price = "25 cent",
    name = ccb.content.plural_text("parabolan yarn", "parabolan yarn"),
    symbol = "=",
    color = "dark_gray",
    looks_like = "thread",
    description = ccb.content.text("Parabolan wool yarn; could be used to knit iridescent wool clothing."),
    materials = { "parabolan_wool" },
    volume = "250 ml",
    mass = "600 mg",
    stack_size = 200,
    ammunition = { type = "thread", count = 50 },
}
