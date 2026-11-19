local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_experimental_crafter",
    name = ccb.content.text("Advanced Recycling and Manufacturing Ouroboros"),
    description = ccb.content.text("A smooth metal casing, icy cold to the touch.  The whirrs of complex machinery hasten as you approach."),
    symbol = "A",
    builtin_examine = "iso_recycler",
    color = "blue",
    move_cost_mod = -1,
    required_strength = -1,
    coverage = 50,
    flags = { "INDOORS" },
}
