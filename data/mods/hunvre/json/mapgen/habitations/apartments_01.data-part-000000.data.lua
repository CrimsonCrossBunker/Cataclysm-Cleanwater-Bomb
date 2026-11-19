local ccb = require("ccb")

ccb.content.define_city_building {
    id = "hab_unit_building_z1",
    locations = { "space" },
    tiles = { { point = { 0, 0, 0 }, terrain = "hab_unit_north" } },
    flags = { "LIGHTHOUSE" },
}

ccb.content.define_city_building {
    id = "hab_unit_building_z2",
    locations = { "space" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "hab_unit_north" },
        { point = { 0, 0, -1 }, terrain = "hab_unit_north" },
    },
    flags = { "LIGHTHOUSE" },
}

ccb.content.define_city_building {
    id = "hab_unit_central_building_z1",
    locations = { "space" },
    tiles = { { point = { 0, 0, 0 }, terrain = "hab_unit_central_north" } },
    flags = { "LIGHTHOUSE" },
}

ccb.content.define_city_building {
    id = "hab_unit_central_building_z2",
    locations = { "space" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "hab_unit_central_north" },
        { point = { 0, 0, -1 }, terrain = "hab_unit_central_north" },
    },
    flags = { "LIGHTHOUSE" },
}

ccb.content.define_city_building {
    id = "hab_unit_central_building_z3",
    locations = { "space" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "hab_unit_central_north" },
        { point = { 0, 0, -1 }, terrain = "hab_unit_central_north" },
        { point = { 0, 0, -2 }, terrain = "hab_unit_central_north" },
    },
    flags = { "LIGHTHOUSE" },
}

ccb.content.define_city_building {
    id = "hab_unit_building_z3",
    locations = { "space" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "hab_unit_north" },
        { point = { 0, 0, -1 }, terrain = "hab_unit_north" },
        { point = { 0, 0, -2 }, terrain = "hab_unit_north" },
    },
    flags = { "LIGHTHOUSE" },
}
