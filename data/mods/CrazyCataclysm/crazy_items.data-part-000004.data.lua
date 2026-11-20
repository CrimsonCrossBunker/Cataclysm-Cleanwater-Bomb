local ccb = require("ccb")

-- Lightweight 10 oz denim jeans.
ccb.content.define_item {
    id = "red_jeans",
    name = ccb.content.plural_text("red jeans", "red jeans"),
    description = ccb.content.text("A pair of tight-fitting candy-apple-red jeans with two deep pockets."),
    mass = "600 g",
    volume = "2 L",
    price = "50 USD",
    survival_price = "1 USD 50 cent",
    materials = { "denim" },
    symbol = "[",
    looks_like = "jeans",
    color = "red",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "4 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "4 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
    },
    flags = { "VARSIZE", "POCKETS" },
    armor = {
        warmth = 10,
        thickness = 0.65,
        portions = { { encumbrance = { 7, 11 }, coverage = 100, covers = { "leg_l", "leg_r" } } },
    },
}
