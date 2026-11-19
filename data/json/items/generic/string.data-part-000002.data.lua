local ccb = require("ccb")

-- Universal pocket, can store almost anything sans liquid, at the price of high move and encumbrance cost.
ccb.content.define_item {
    id = "seatbelt",
    copy_from = "rope_6",
    name = ccb.content.plural_text("seat belt", "seat belts"),
    description = ccb.content.text("A length of synthetic fiber weaved into a flat band, usually used to securely fasten passenger inside vehicles."),
    materials = { "nylon" },
    mass = "800 g",
    volume = "696 ml",
    pockets = {
        {
            capacity = "10 L",
            mass_limit = "5 kg",
            max_item_length = "110 cm",
            moves = 2000,
            holster = true,
        },
    },
    inheritance = { add = { flags = { "TIE_UP", "BELTED", "WATER_FRIENDLY", "OVERSIZE" } } },
    armor = {
        portions = {
            {
                materials = { { id = "nylon", coverage = 100, thickness = 1.0 } },
                encumbrance = 3,
                coverage = 10,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Tie what to the rope?"),
            message = ccb.content.text("You use an elaborate knot to tie your %s to your %s"),
        },
    },
}
