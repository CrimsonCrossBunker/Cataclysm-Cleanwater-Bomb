local ccb = require("ccb")

ccb.content.define_item {
    id = "triffid_heart_chunk",
    name = ccb.content.text("triffid heart chunk"),
    mass = "4535 g",
    color = "black_green",
    symbol = "%",
    description = ccb.content.text("A thick, hulking mass of plant matter and wood that's easily the size of your head, torn from a triffid heart."),
    price = "0 USD",
    survival_price = "0 USD",
    materials = { "veggy", "wood" },
    volume = "5 L",
    comestible = { kind = "FOOD", healthy = -10, calories = 147, fun = -25 },
}
