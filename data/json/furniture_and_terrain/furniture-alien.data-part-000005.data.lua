local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_impaled_officer",
    name = ccb.content.text("impaled officer"),
    description = ccb.content.text("A dead body encased in high-tech armor hanging in the air.  Their form seems twisted and refracted in the light of the strange glowing crystal that has seeped out of the ground and impaled their body."),
    symbol = "!",
    color = "red",
    move_cost_mod = -1,
    coverage = 100,
    flags = { "TRANSPARENT", "ORGANIC" },
    deconstruct = { drops = { { item = "glass_shard", count = 1000 } } },
    required_strength = -1,
    bash = {
        minimum_strength = 200,
        maximum_strength = 400,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("an absence of sound."),
        drops = { { item = "glass_shard", count = { 10, 20 } } },
    },
    examine_handler = "examine_f_impaled_officer",
}
