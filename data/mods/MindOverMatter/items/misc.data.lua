local ccb = require("ccb")

ccb.content.define_item {
    id = "force_field_generator_broken",
    category = "other",
    name = ccb.content.plural_text("device labeled OS647-P", "devices labeled OS647-P"),
    description = ccb.content.text("A small plastic device about the size of two smartphones stacked on top of each other, with a toggle on one end and \"OS647-P\" written prominently on one side above the XEDRA logo.  Parts of the device seem melted and the toggle no longer moves."),
    mass = "496 g",
    volume = "200 ml",
    materials = {
        { id = "aluminum", portions = 65 },
        { id = "plastic", portions = 25 },
        { id = "nether_crystal", portions = 10 },
    },
    symbol = "[",
    color = "dark_gray",
    tool = {},
}
