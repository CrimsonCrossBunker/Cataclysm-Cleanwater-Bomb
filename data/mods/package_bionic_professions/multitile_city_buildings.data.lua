local ccb = require("ccb")

ccb.content.define_city_building {
    id = "house_09",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_09_north" },
        { point = { 0, 0, 1 }, terrain = "house_09_roof_north" },
        { point = { 0, 0, -1 }, terrain = "basement_bionic_north" },
    },
}
