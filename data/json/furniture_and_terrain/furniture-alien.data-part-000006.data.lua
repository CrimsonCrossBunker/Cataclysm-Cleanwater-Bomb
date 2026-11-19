local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_impaled_soldier",
    description = ccb.content.text("A dead body encased in military armor hanging in the air.  Their form seems twisted and refracted in the light of the strange glowing crystal that has seeped out of the ground and impaled their body."),
    name = ccb.content.text("impaled mercenary"),
    symbol = "!",
    color = "brown",
    move_cost_mod = -1,
    coverage = 100,
    deconstruct = { drops = { { item = "glass_shard", count = 1000 } } },
    required_strength = -1,
    bash = {
        minimum_strength = 100,
        maximum_strength = 100,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("an absence of sound."),
        drops = { { item = "glass_shard", count = { 10, 20 } } },
    },
    flags = { "TRANSPARENT", "CONTAINER", "FLAMMABLE", "ORGANIC" },
}
