local ccb = require("ccb")

ccb.content.define_item {
    id = "quiver_of_holding_plus_one",
    name = ccb.content.plural_text("quiver of holding +1", "quivers of holding +1"),
    description = ccb.content.text("A quiver enchanted to hold 40 arrows or bolts while not taking up any more space than a normal quiver.  Rarely made after the invention of firearms."),
    copy_from = "quiver",
    price = "500 USD",
    survival_price = "20 USD",
    looks_like = "quiver",
    pockets = {
        {
            ammunition = { arrow = 40, bolt = 40, arrow_orichalcum = 40 },
            weight_multiplier = 0.5,
            volume_multiplier = 0.5,
            moves = 20,
        },
    },
    armor = {
        portions = {
            {
                encumbrance = { 3, 11 },
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
    inheritance = { add = { flags = { "TARDIS" } } },
}

ccb.content.define_item {
    id = "quiver_of_holding_plus_two",
    name = ccb.content.plural_text("quiver of holding +2", "quivers of holding +2"),
    description = ccb.content.text("A quiver enchanted to hold 80 arrows or bolts while not taking up any more space than a normal quiver.  Rarely made after the invention of firearms."),
    copy_from = "quiver_of_holding_plus_one",
    pockets = {
        {
            ammunition = { arrow = 80, bolt = 80, arrow_orichalcum = 80 },
            weight_multiplier = 0.25,
            volume_multiplier = 0.25,
            moves = 20,
        },
    },
    armor = {},
}
