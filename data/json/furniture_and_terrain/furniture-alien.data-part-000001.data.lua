local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_exodii_signpost",
    name = ccb.content.text("pictographic signpost"),
    looks_like = "f_sign",
    description = ccb.content.text("This simple scrap metal sign has a series of pictographs on it depicting what seems to be a trade interaction.  There is a crude but understandable map beneath it.  You should take a closer look."),
    symbol = "!",
    color = "red",
    move_cost_mod = 1,
    coverage = 35,
    required_strength = -1,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "ORGANIC", "MOUNTABLE", "SIGN", "FREE_TO_EXAMINE" },
    deconstruct = {
        drops = { { item = "sheet_metal_small", count = 2 }, { item = "nail", charges = { 2, 5 } } },
    },
    bash = {
        minimum_strength = 6,
        maximum_strength = 40,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("whump."),
        drops = { { item = "sheet_metal_small", count = { 1, 2 } }, { item = "nail", charges = { 2, 4 } } },
    },
    examine_handler = "examine_f_exodii_signpost",
}
