local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_empty_spike",
    name = ccb.content.text("empty spike"),
    description = ccb.content.text("A strange otherworldly spike that refracts light in strange ways.  The body no longer rests on it."),
    symbol = "!",
    color = "black",
    move_cost_mod = -1,
    coverage = 100,
    flags = { "TRANSPARENT", "ORGANIC" },
    deconstruct = { drops = { { item = "glass_shard", count = 1000 } } },
    required_strength = -1,
    bash = {
        minimum_strength = 100,
        maximum_strength = 100,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("an absence of sound."),
        drops = { { item = "glass_shard", count = { 1, 2 } } },
    },
    examine_handler = "examine_f_empty_spike",
}
