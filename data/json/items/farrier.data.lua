local ccb = require("ccb")

ccb.content.define_item {
    id = "fitted_horseshoes",
    name = ccb.content.plural_text("set of fitted horseshoes", "sets of fitted horseshoes"),
    description = ccb.content.text("Four fitted iron shoes that protect a horse's hooves and reduce the movement cost of riding it.  Fitting them requires hammering and nail-pulling tools."),
    mass = "3752 g",
    volume = "4 L",
    price = "160 USD",
    survival_price = "4 USD",
    materials = { "mc_steel" },
    symbol = "u",
    color = "light_gray",
    subtype_order = { "tool", "pet_equipment" },
    tool = {},
    pet_equipment = {
        slots = { "horseshoes" },
        install_qualities = { { id = "HAMMER", level = 1 }, { id = "PRYING_NAIL", level = 1 } },
        mounted_move_cost_multiplier = 0.9,
    },
}
