local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_pit_BEM_human_sample",
    looks_like = "t_pit_shallow",
    name = ccb.content.text("dead drop pit"),
    description = ccb.content.text("A seemingly innocuous shallow pit.  Careful inspection reveals a black canister half-buried in the exposed soil."),
    symbol = "0",
    color = "yellow",
    move_cost = 8,
    flags = { "TRANSPARENT" },
    examine_handler = "examine_t_pit_BEM_human_sample",
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}
