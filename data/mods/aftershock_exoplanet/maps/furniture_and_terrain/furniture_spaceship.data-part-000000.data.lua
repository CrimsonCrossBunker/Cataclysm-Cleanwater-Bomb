local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_spaceship_kitchenette",
    name = ccb.content.text("habitat kitchenette"),
    symbol = "#",
    looks_like = "f_oven",
    description = ccb.content.text("A tiny cooking surface only big enough to fit an induction top, placed above and below many integrated storage units.  The minimal space in which you could technically cook."),
    color = "blue",
    move_cost_mod = -1,
    coverage = 55,
    required_strength = -1,
    flags = {
        "FLAMMABLE_ASH",
        "USABLE_FIRE",
        "CONTAINER",
        "PLACE_ITEM",
        "ORGANIC",
        "MOUNTABLE",
        "FLAT_SURF",
        "NO_SELF_CONNECT",
    },
    connect_groups = "COUNTER",
    connects_to = "COUNTER",
    deconstruct = {
        drops = {
            { item = "plastic_chunk", count = 3 },
            { item = "rigid_plastic_sheet", count = 1 },
            { item = "polycarbonate_sheet", count = { 2, 8 } },
        },
    },
}
