local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_rock_troll_statue",
    name = ccb.content.text("rock troll statue"),
    description = ccb.content.text("A massive block of stone in the shape of a rock troll, because it used to be a rock troll."),
    looks_like = "f_statue",
    symbol = "T",
    color = "dark_gray",
    move_cost_mod = -1,
    coverage = 50,
    required_strength = 10,
    flags = { "PLACE_ITEM", "BLOCKSDOOR", "MINEABLE", "SIGN" },
    bash = {
        minimum_strength = 16,
        maximum_strength = 40,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = { { item = "rock", count = { 2, 12 } } },
    },
}
