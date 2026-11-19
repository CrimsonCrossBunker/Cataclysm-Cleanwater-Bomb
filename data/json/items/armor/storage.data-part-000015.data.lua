local ccb = require("ccb")

ccb.content.define_item {
    id = "net_backpack",
    name = ccb.content.text("net backpack"),
    description = ccb.content.text("A bag woven together from strings, with straps to wear it on back.  Lighter than a standard backpack, but more awkward to carry when loaded and unable to hold small or heavy items."),
    mass = "192 g",
    volume = "750 ml",
    price = "10 USD",
    materials = { "cotton" },
    symbol = "[",
    color = "green",
    pockets = {
        {
            kind = "CONTAINER",
            min_item_volume = "100 ml",
            capacity = "15 L",
            mass_limit = "8 kg",
            max_item_length = "40 cm",
            moves = 300,
        },
    },
    flags = { "BELTED", "WATER_FRIENDLY" },
    armor = {
        thickness = 1,
        portions = {
            {
                encumbrance = 1,
                volume_encumbrance = 0.4,
                coverage = 40,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}
