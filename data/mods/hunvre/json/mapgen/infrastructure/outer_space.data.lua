local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "outer_space",
    vision_levels = "large_building",
    see_cost = "full_high",
    name = ccb.content.text("outer space"),
    symbol = ".",
    color = "black",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "ship_frame",
    vision_levels = "large_building",
    see_cost = "full_high",
    name = ccb.content.text("frame"),
    symbol = ".",
    color = "black",
    flags = { "NO_ROTATE" },
}
