local ccb = require("ccb")

ccb.content.define_start_location {
    id = "sloc_cave_innawood",
    name = ccb.content.text("Cave - on the surface"),
    targets = { "cave_innawood" },
}

ccb.content.define_start_location {
    id = "sloc_cave_underground_innawood",
    name = ccb.content.text("Cave - underground"),
    targets = { "cave_underground_innawood" },
}

ccb.content.define_start_location {
    id = "sloc_river",
    copy_from = "sloc_river",
    targets = { "river", "stream", "stream_corner", "stream_end" },
}
