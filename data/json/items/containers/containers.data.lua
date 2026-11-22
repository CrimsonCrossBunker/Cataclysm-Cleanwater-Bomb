local ccb = require("ccb")

ccb.content.define_item {
    id = "can_food",
    name = "small tin can",
    description = "A small tin can, like what tuna comes in.",
    symbol = ")",
    color = "blue",
    category = "container",
    looks_like = "can_drink",
    ascii_picture = "can_food",
    mass = "40 g",
    volume = "262 ml",
    length = "8 cm",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "steel" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "250 ml",
            mass_limit = "1 kg",
            rigid = true,
            watertight = true,
            open_container = true,
            sealed_data = { spoil_multiplier = 0.0 },
        },
    },
    qualities = {
        { id = "BOIL", level = 1 },
    },
    use_actions = { "HEAT_LIQUID_ITEMS" },
}

ccb.content.define_item {
    id = "can_medium",
    copy_from = "can_food",
    name = "medium tin can",
    description = "A medium tin can, like what soup comes in.",
    looks_like = "can_food",
    ascii_picture = "can_medium",
    mass = "70 g",
    volume = "525 ml",
    length = "10 cm",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "2 kg",
            rigid = true,
            watertight = true,
            open_container = true,
            sealed_data = { spoil_multiplier = 0.0 },
        },
    },
    qualities = {
        { id = "BOIL", level = 1 },
    },
    use_actions = { "HEAT_LIQUID_ITEMS" },
}
