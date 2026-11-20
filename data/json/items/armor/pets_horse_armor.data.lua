local ccb = require("ccb")

-- each 15 L bag is ~ 60 x 25 x 10 cm
ccb.content.define_item {
    id = "saddlebag",
    name = ccb.content.plural_text("saddle bags (pair)", "saddle bags (pair)"),
    description = ccb.content.text("A pair of covered pouches laid across the back of a horse behind the saddle."),
    mass = "1 kg",
    volume = "7500 ml",
    price = "150 USD",
    survival_price = "25 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "dump_pouch",
    color = "green",
    flags = { "BELTED", "WATER_FRIENDLY", "SADDLE_BAG" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "15 L",
            mass_limit = "20 kg",
            max_item_length = "60 cm",
            moves = 200,
        },
        {
            kind = "CONTAINER",
            capacity = "15 L",
            mass_limit = "20 kg",
            max_item_length = "60 cm",
            moves = 200,
        },
    },
    subtype_order = { "armor", "pet_equipment" },
    armor = {
        warmth = 10,
        thickness = 2,
        portions = { { encumbrance = 30, coverage = 50, covers = { "hand_l", "hand_r" } } },
    },
    pet_equipment = { slots = { "saddlebag" }, passive_effects = { "has_bag" } },
}
