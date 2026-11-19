local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "pond_swamp_chocolate",
    name = ccb.content.text("chocolate bog"),
    symbol = "F",
    color = "blue",
    see_cost = "spaced_high",
    monster_density = 2,
}
