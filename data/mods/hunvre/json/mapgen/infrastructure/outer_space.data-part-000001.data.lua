local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_hard_vacuum",
    name = ccb.content.text("hard vacuum"),
    symbol = " ",
    color = "black",
    description = ccb.content.text("The cold inhospitable vacuum of space.  Going this way without an EVA pack will end in either a slow cold death as your life support fades or a slow hot death as you drop into the planet's atmosphere."),
    move_cost = 1000,
    flags = { "DESTROY_ITEM" },
}
