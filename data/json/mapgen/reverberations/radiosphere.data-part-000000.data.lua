local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_radiosphere_glowing_floor",
    name = ccb.content.text("vanishing floor"),
    description = ccb.content.text("The sheer fact you can stand on this dumbfounds you, but anything left behind on this plane will vanish."),
    symbol = "~",
    color = "cyan",
    trap = "tr_lava",
    light_emitted = 50,
    move_cost = 4,
    flags = { "TRANSPARENT", "NO_SCENT", "DESTROY_ITEM" },
}
