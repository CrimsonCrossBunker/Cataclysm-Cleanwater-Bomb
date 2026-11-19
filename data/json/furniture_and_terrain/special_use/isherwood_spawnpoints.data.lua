local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_dirt_isherwood_player_spawnpoint",
    name = ccb.content.text("dirt"),
    description = ccb.content.text("It's dirt.  Looks like some fine soil for tillage.  Could also be dug out for construction projects."),
    symbol = ".",
    color = "brown",
    copy_from = "t_dirt",
}
