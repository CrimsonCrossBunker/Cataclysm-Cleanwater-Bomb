local ccb = require("ccb")

ccb.content.define_city_building {
    id = "hab_unit_central_building_z2",
    locations = { "space" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "central_elevator_0_0_north" },
        { point = { 1, 0, 0 }, terrain = "central_elevator_1_0_north" },
        { point = { 0, 1, 0 }, terrain = "central_elevator_2_0_north" },
        { point = { 1, 1, 0 }, terrain = "central_elevator_3_0_north" },
    },
    flags = { "LIGHTHOUSE" },
}
