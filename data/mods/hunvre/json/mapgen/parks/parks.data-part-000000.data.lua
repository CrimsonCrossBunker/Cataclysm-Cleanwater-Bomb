local ccb = require("ccb")

ccb.content.define_city_building {
    id = "park_unit_building",
    locations = { "space" },
    tiles = { { point = { 0, 0, 0 }, terrain = "park_unit_north" } },
    flags = { "LIGHTHOUSE" },
}
