local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_attunement_altar",
    name = ccb.content.text("attunement altar"),
    move_cost_mod = 10,
    symbol = "H",
    color = "light_gray",
    coverage = 40,
    looks_like = "t_pedestal_temple",
    required_strength = 30,
    examine_handler = "examine_f_attunement_altar",
    description = ccb.content.text("An ancient stone plinth covered in symbols that appear to be combinations and variations of the eight magic classes.  Eight depressions are on the top with the original symbols of the classes, each look as though they can hold an item."),
    bash = {
        minimum_strength = 30,
        maximum_strength = 160,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = {
            { item = "rock", count = { 5, 15 } },
            { item = "sharp_rock", count = { 3, 5 } },
        },
    },
}
