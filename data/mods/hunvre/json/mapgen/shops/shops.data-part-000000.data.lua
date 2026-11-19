local ccb = require("ccb")

ccb.content.define_city_building {
    id = "shop_unit_building",
    locations = { "space" },
    tiles = { { point = { 0, 0, 0 }, terrain = "shop_unit_north" } },
    flags = { "LIGHTHOUSE" },
}
