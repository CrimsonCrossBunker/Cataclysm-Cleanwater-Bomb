local ccb = require("ccb")

-- Universal pocket, can store almost anything sans liquid and very small items, at the price of high move and encumbrance cost.
ccb.content.define_item {
    id = "rope_30",
    copy_from = "rope_6",
    name = ccb.content.text("long rope"),
    description = ccb.content.text("A 30-foot (or about 9 m) long rope.  Useful for keeping yourself safe from falls.  Wear it over a shoulder and tie items to it as a temporary carrying solution."),
    qualities = { { id = "ROPE", level = 2 } },
    pockets = {
        {
            min_item_volume = "100 ml",
            capacity = "10 L",
            mass_limit = "10 kg",
            max_item_length = "110 cm",
            moves = 3000,
            holster = true,
        },
    },
    armor = {
        portions = {
            {
                materials = { { id = "cotton", coverage = 100, thickness = 6.0 } },
                encumbrance = 12,
                coverage = 10,
                covers = { "torso" },
            },
        },
    },
    inheritance = { scale = { mass = 5, volume = 5, price = 5 } },
}
