local ccb = require("ccb")

ccb.content.define_spell {
    id = "afs_translocation",
    name = ccb.content.text("Translocation"),
    description = ccb.content.text("Translocates the user to an encoded buoy."),
    valid_targets = { "self" },
    effect = "translocate",
    shape = "blast",
    difficulty = 10,
    max_level = 25,
    base_casting_time = 200,
    base_energy_cost = 500,
    energy_source = "BIONIC",
    flags = { "SILENT", "NO_LEGS", "NO_HANDS", "NO_FAIL" },
    spell_class = "NONE",
}

ccb.content.define_spell {
    id = "afs_translocation_slow",
    name = ccb.content.text("Translocation"),
    description = ccb.content.text("Slowly translocates the user to an encoded buoy."),
    valid_targets = { "self" },
    effect = "translocate",
    shape = "blast",
    difficulty = 10,
    max_level = 25,
    base_casting_time = 2400,
    base_energy_cost = 500,
    energy_source = "BIONIC",
    flags = { "SILENT", "NO_LEGS", "NO_HANDS", "NO_FAIL" },
    spell_class = "NONE",
}
