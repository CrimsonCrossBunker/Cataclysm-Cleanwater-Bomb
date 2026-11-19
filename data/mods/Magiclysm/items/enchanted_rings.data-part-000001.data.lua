local ccb = require("ccb")

ccb.content.define_item {
    id = "storage_ring_lesser",
    copy_from = "mring_platinum",
    name = ccb.content.plural_text("lesser storage ring", "lesser storage rings"),
    price = "3000 USD",
    length = "2 cm",
    survival_price = "1000 USD",
    description = ccb.content.text("A glistening ring holding a small dimensional space inside.  Can store only a little but you can draw items instantly."),
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1 L",
            mass_limit = "1 kg",
            max_item_length = "35 cm",
            moves = 1,
            holster = true,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0.0,
        },
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stick what into your ring"),
            message = ccb.content.text("You tuck your %s into your %s"),
        },
    },
}

ccb.content.define_item {
    id = "storage_ring_greater",
    copy_from = "mring_platinum",
    name = ccb.content.plural_text("greater storage ring", "greater storage rings"),
    price = "9000 USD",
    length = "2 cm",
    survival_price = "1750 USD",
    description = ccb.content.text("A glistening ring holding a small dimensional space inside.  Capable of storing a medium-sized weapon you can draw instantly."),
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "2 L",
            mass_limit = "2500 g",
            max_item_length = "100 cm",
            moves = 1,
            holster = true,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0.0,
        },
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stick what into your ring"),
            message = ccb.content.text("You tuck your %s into your %s"),
        },
    },
}
