local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "stream", "stream_end", "stream_corner" },
    copy_from = "generic_open_land",
    name = ccb.content.text("stream"),
    symbol = ".",
    color = "light_blue",
    travel_cost = "forest",
    vision_levels = "blends_till_details",
    flags = { "REQUIRES_PREDECESSOR", "STREAM" },
}
