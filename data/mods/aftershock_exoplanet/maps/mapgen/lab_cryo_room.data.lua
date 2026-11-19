local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "afs_cryo_room",
    name = ccb.content.text("afs_cryo_room"),
    symbol = "a",
    color = "red",
    flags = { "SHOULD_NOT_SPAWN" },
    see_cost = "none",
}
