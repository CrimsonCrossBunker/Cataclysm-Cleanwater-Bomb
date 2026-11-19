local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_experimental_crafter_terminal",
    name = ccb.content.text("Advanced Recycling and Manufacturing terminal"),
    description = ccb.content.text("An ethereal blue glow highlights a command line.  Awaiting input."),
    symbol = "0",
    color = "light_blue",
    move_cost_mod = -1,
    required_strength = -1,
    coverage = 50,
    flags = { "NOITEM", "INDOORS" },
    crafting_pseudo_item = "pseudo_experimental_crafter",
    examine_handler = "examine_f_experimental_crafter_terminal",
}
