local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "tutorial", "tutorial_underground" },
    name = ccb.content.text("tutorial room"),
    symbol = "O",
    color = "cyan",
    see_cost = "full_high",
    flags = { "NO_ROTATE", "SHOULD_NOT_SPAWN" },
}

ccb.content.define_overmap_terrain {
    id = "tutorial_roof",
    copy_from = "tutorial",
    see_cost = "none",
}
