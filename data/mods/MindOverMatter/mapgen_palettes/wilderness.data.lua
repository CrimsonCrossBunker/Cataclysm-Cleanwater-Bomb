local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "fear_hawk_copse_trees_palette",
    layout = {
        terrain = {
            ["."] = {
                { id = "t_region_groundcover", copies = 60 },
                { id = "t_region_tree" },
                { id = "t_region_shrub" },
            },
            [","] = {
                { id = "t_region_groundcover", copies = 30 },
                { id = "t_region_groundcover_forest", copies = 8 },
                { id = "t_region_tree", copies = 2 },
                { id = "t_region_shrub" },
            },
            [";"] = {
                { id = "t_region_groundcover", copies = 10 },
                { id = "t_region_groundcover_forest", copies = 8 },
                { id = "t_region_tree", copies = 6 },
                { id = "t_tree_hawk_nest", copies = 1 },
                { id = "t_region_shrub" },
            },
            ["|"] = { { id = "t_region_groundcover_forest", copies = 7 }, { id = "t_puddle" } },
        },
        furniture = {
            ["."] = {
                { id = "f_null", copies = 2000 },
                { id = "f_region_plain", copies = 20 },
                { id = "f_boulder_small", copies = 6 },
                { id = "f_boulder_medium" },
                { id = "f_boulder_large" },
            },
            [","] = {
                { id = "f_null", copies = 2000 },
                { id = "f_region_plain", copies = 40 },
                { id = "f_boulder_small", copies = 6 },
                { id = "f_boulder_medium", copies = 2 },
                { id = "f_boulder_large" },
            },
            [";"] = {
                { id = "f_null", copies = 2000 },
                { id = "f_region_plain", copies = 60 },
                { id = "f_boulder_small", copies = 6 },
                { id = "f_boulder_medium", copies = 2 },
                { id = "f_boulder_large" },
            },
        },
    },
}
