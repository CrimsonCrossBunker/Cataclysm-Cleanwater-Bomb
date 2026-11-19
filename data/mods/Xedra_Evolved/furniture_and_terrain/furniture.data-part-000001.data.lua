local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_sevenoclock_track",
    name = ccb.content.text("Bloody footsteps"),
    description = ccb.content.text("A trail of old footsteps, still visible despite the blood and rain.  Examine it to track its source."),
    symbol = "l",
    required_strength = -1,
    move_cost_mod = 0,
    color = "brown",
    coverage = 0,
    flags = { "NOITEM", "TRANSPARENT", "PERMEABLE" },
    examine_handler = "examine_f_sevenoclock_track",
}

ccb.content.define_furniture {
    id = "f_deathworm_track",
    name = ccb.content.text("Suspicious hole"),
    description = ccb.content.text("A hole in the ground, bearing acid burns.  Examine it to track its source."),
    symbol = "o",
    required_strength = -1,
    move_cost_mod = 0,
    color = "brown",
    coverage = 0,
    flags = { "NOITEM", "TRANSPARENT", "PERMEABLE" },
    examine_handler = "examine_f_deathworm_track",
}

ccb.content.define_furniture {
    id = "f_hunger_track",
    name = ccb.content.text("Partially devoured human leg"),
    description = ccb.content.text("A human leg, partially devoured.  The femur is cracked open and the marrow sucked out.  Examine it to track its source."),
    symbol = "o",
    required_strength = -1,
    move_cost_mod = 0,
    color = "brown",
    coverage = 0,
    flags = { "NOITEM", "TRANSPARENT", "PERMEABLE" },
    examine_handler = "examine_f_hunger_track",
}
