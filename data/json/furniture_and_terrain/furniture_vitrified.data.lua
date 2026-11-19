local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_vitrified_doll",
    name = ccb.content.text("incomplete plush doll"),
    symbol = "D",
    description = ccb.content.text("A soft plush torso, empty of features, is lying on this sofa."),
    color = "dark_gray",
    move_cost_mod = 1,
    coverage = 60,
    comfort = 1,
    required_strength = 900,
    flags = { "TRANSPARENT", "BLOCKSDOOR", "MOUNTABLE", "CAN_SIT" },
    rotates_to = "INDOORFLOOR",
    bash = {
        minimum_strength = 900,
        maximum_strength = 900,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("whump."),
    },
    examine_handler = "examine_f_vitrified_doll",
}

ccb.content.define_furniture {
    id = "f_vitrified_bookcase_talker",
    name = ccb.content.text("black glass bookcase"),
    symbol = "{",
    description = ccb.content.text("This bookcase is missing a book."),
    color = "dark_gray",
    looks_like = "f_vitrified_bookcase",
    move_cost_mod = -1,
    coverage = 80,
    required_strength = 900,
    flags = { "BLOCKSDOOR" },
    rotates_to = "INDOORFLOOR",
    emissions = { "emit_glimmer" },
    examine_handler = "examine_f_vitrified_bookcase_talker",
}
