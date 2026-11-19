local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "abandoned_textile_mill",
    layout = {
        item_groups = {
            ["-"] = { group = "collapsed_building_rubble", chance = 75 },
            ["="] = { group = "collapsed_building_outside", chance = 75 },
        },
        terrain = {
            ["]"] = "t_brick_wall",
            ["+"] = "t_door_gray_frame",
            ["*"] = "t_window_empty",
            ["-"] = "t_strconc_floor_no_roof",
            ["="] = "t_region_groundcover_barren",
        },
        furniture = {
            ["-"] = { { id = "f_null", copies = 30 }, { id = "f_rubble" } },
            ["="] = { { id = "f_null", copies = 30 }, { id = "f_rubble" } },
        },
    },
}
