local ccb = require("ccb")

ccb.content.define_map_extra_collection {
    id = "road_aftershock",
    chance = 75,
    extras = { { extra = "mx_wraitheon_droneswarm", weight = 10 } },
}
