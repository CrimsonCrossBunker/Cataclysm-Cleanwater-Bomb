local ccb = require("ccb")

ccb.content.define_city_building {
    id = "store_unit_z1",
    locations = { "space" },
    tiles = { { point = { 0, 0, 0 }, terrain = "store_unit_north" } },
    flags = { "LIGHTHOUSE" },
}
