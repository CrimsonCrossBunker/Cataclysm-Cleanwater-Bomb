local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_magus_permanent_light",
    name = ccb.content.text("imperishable light"),
    description = ccb.content.text("A glowing orb of light floats here, emitting a soft radiance."),
    symbol = "*",
    color = "white",
    move_cost_mod = 0,
    light_emitted = 35,
    required_strength = -1,
    flags = { "TRANSPARENT", "PERMEABLE", "TINY", "THIN_OBSTACLE" },
    bash = {
        minimum_strength = 9999,
        maximum_strength = 9999,
    },
    examine_handler = "examine_f_magus_permanent_light",
}
