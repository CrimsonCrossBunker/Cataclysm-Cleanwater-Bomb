local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_species_snare",
    name = ccb.content.text("species snare trap"),
    color = "red",
    symbol = "~",
    visibility = 1,
    avoidance = 8,
    difficulty = 0,
    action = "snare_species",
}

ccb.content.define_trap {
    id = "tr_nether_snare",
    name = ccb.content.text("pentagram snare trap"),
    color = "red",
    symbol = "X",
    visibility = 1,
    avoidance = 8,
    difficulty = 0,
    action = "snare_species",
}

ccb.content.define_trap {
    id = "tr_robot_snare",
    name = ccb.content.text("QR snare trap"),
    color = "red",
    symbol = "e",
    visibility = 1,
    avoidance = 8,
    difficulty = 0,
    action = "snare_species",
}

ccb.content.define_trap {
    id = "tr_cyborg_snare",
    name = ccb.content.text("ARG snare trap"),
    color = "red",
    symbol = "<",
    visibility = 1,
    avoidance = 8,
    difficulty = 0,
    action = "snare_species",
}

ccb.content.define_trap {
    id = "tr_fae_snare",
    name = ccb.content.text("changeling snare trap"),
    color = "red",
    symbol = "$",
    visibility = 1,
    avoidance = 8,
    difficulty = 0,
    action = "snare_species",
}
