local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_coral_obelisk",
    name = ccb.content.text("coral obelisk"),
    description = ccb.content.text("Facets of white coral erupt from the ground and assemble themselves into a free standing column.  The living surface is bioluminescent and rarely sparkles with golden light."),
    symbol = "O",
    color = "dark_gray",
    move_cost_mod = -1,
    coverage = 65,
    required_strength = 32,
    flags = { "NOITEM", "MINEABLE", "BLOCK_WIND" },
    bash = {
        minimum_strength = 64,
        maximum_strength = 160,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = { { item = "resin_chunk", count = { 5, 9 } } },
    },
}

ccb.content.define_furniture {
    id = "f_coral_pedestal",
    name = ccb.content.text("coral pedestal"),
    description = ccb.content.text("Fluted white coral gently coils itself into a short pedestal."),
    symbol = "&",
    color = "dark_gray",
    move_cost_mod = 3,
    coverage = 50,
    required_strength = 32,
    flags = { "TRANSPARENT", "MOUNTABLE", "PERMEABLE", "MINEABLE", "PLACE_ITEM" },
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        drops = { { item = "resin_chunk", count = { 15, 19 } } },
    },
}
