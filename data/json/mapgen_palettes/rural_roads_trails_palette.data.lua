local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "rural_road",
    layout = {
        terrain = {
            ["#"] = {
                { id = "t_dirtmound", copies = 98 },
                { id = "t_region_groundcover_barren", copies = 2 },
            },
            [" "] = {
                { id = "t_region_groundcover_barren", copies = 100 },
                { id = "t_region_groundcover", copies = 100 },
                { id = "t_region_shrub", copies = 1 },
            },
            i = {
                { id = "t_region_groundcover_barren", copies = 2 },
                { id = "t_region_groundcover", copies = 1 },
            },
            ["/"] = {
                { id = "t_region_groundcover_barren", copies = 1 },
                { id = "t_railroad_rubble", copies = 25 },
                { id = "t_region_groundcover", copies = 1 },
            },
            V = "t_splitrail_fence",
            ["3"] = "t_splitrail_fencegate_c",
            ["9"] = "t_region_tree",
            ["8"] = {
                { id = "t_region_shrub_fruit", copies = 5 },
                { id = "t_region_shrub" },
                { id = "t_trunk" },
                { id = "t_stump" },
            },
        },
        furniture = { ["@"] = "f_hay", p = "f_region_flower" },
    },
}
