local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_altar",
    name = ccb.content.text("stone altar"),
    move_cost_mod = 10,
    symbol = "H",
    color = "light_gray",
    coverage = 40,
    required_strength = 30,
    description = ccb.content.text("This is a big stone altar.  Most commonly used in morally questionable rituals."),
    bash = {
        minimum_strength = 30,
        maximum_strength = 160,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = { { item = "rock", count = { 5, 15 } }, { item = "sharp_rock", count = { 3, 5 } } },
    },
}
