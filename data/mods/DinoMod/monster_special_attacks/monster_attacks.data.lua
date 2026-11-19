local ccb = require("ccb")

ccb.content.define_spell {
    id = "CBM_TRex_recording",
    name = ccb.content.text("T-Rex Bio-Operator recording"),
    description = ccb.content.text("Causes some noise"),
    message = ccb.content.text("IF YOU CAN HEAR THIS RECORDING, PLEASE EXIT THE FACILITY.  THE TIGER IS LOOSE."),
    sound_description = ccb.content.text("a recorded message"),
    sound_type = "combat",
    sound_ambient = true,
    sound_id = "misc",
    sound_variant = "shockwave",
    min_damage = 0,
    max_damage = 0,
    valid_targets = { "self" },
    shape = "blast",
    effect = "noise",
}
