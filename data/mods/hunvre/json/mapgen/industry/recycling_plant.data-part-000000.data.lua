local ccb = require("ccb")

ccb.content.define_city_building {
    id = "recycling_plant_building",
    locations = { "space" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "recycling_plant_x0_y0_z0_north" },
        { point = { 1, 0, 0 }, terrain = "recycling_plant_x1_y0_z0_north" },
        { point = { 2, 0, 0 }, terrain = "recycling_plant_x2_y0_z0_north" },
        { point = { 0, 1, 0 }, terrain = "recycling_plant_x0_y1_z0_north" },
        { point = { 1, 1, 0 }, terrain = "recycling_plant_x1_y1_z0_north" },
        { point = { 2, 1, 0 }, terrain = "recycling_plant_x2_y1_z0_north" },
        { point = { 0, 0, -1 }, terrain = "recycling_plant_x0_y0_z-1_north" },
        { point = { 1, 0, -1 }, terrain = "recycling_plant_x1_y0_z-1_north" },
        { point = { 2, 0, -1 }, terrain = "recycling_plant_x2_y0_z-1_north" },
        { point = { 0, 1, -1 }, terrain = "recycling_plant_x0_y1_z-1_north" },
        { point = { 1, 1, -1 }, terrain = "recycling_plant_x1_y1_z-1_north" },
        { point = { 2, 1, -1 }, terrain = "recycling_plant_x2_y1_z-1_north" },
        { point = { 0, 0, -2 }, terrain = "recycling_plant_x0_y0_z-2_north" },
        { point = { 1, 0, -2 }, terrain = "recycling_plant_x1_y0_z-2_north" },
        { point = { 2, 0, -2 }, terrain = "recycling_plant_x2_y0_z-2_north" },
        { point = { 0, 1, -2 }, terrain = "recycling_plant_x0_y1_z-2_north" },
        { point = { 1, 1, -2 }, terrain = "recycling_plant_x1_y1_z-2_north" },
        { point = { 2, 1, -2 }, terrain = "recycling_plant_x2_y1_z-2_north" },
    },
    flags = { "LIGHTHOUSE" },
}
