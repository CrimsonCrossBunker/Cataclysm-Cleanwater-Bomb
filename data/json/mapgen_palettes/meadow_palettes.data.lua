local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "meadow_palette",
    layout = {
        terrain = {
            ["1"] = {
                { id = "t_region_soil", copies = 1 },
                { id = "t_region_grass", copies = 2 },
                { id = "t_grass_long", copies = 1000 },
                { id = "t_grass_tall", copies = 2000 },
                { id = "t_region_shrub_forest", copies = 2 },
                { id = "t_region_tree_forest", copies = 2 },
            },
            ["2"] = {
                { id = "t_region_soil", copies = 10 },
                { id = "t_region_grass", copies = 2 },
                { id = "t_grass_long", copies = 1500 },
                { id = "t_grass_tall", copies = 100 },
                { id = "t_region_shrub_forest", copies = 1 },
                { id = "t_region_tree_forest", copies = 1 },
            },
        },
        furniture = {
            ["1"] = {
                { id = "f_null", copies = 5000 },
                { id = "f_region_weed", copies = 20 },
                { id = "f_boulder_small", copies = 3 },
                { id = "f_boulder_medium", copies = 2 },
                { id = "f_boulder_large", copies = 1 },
            },
            ["2"] = {
                { id = "f_null", copies = 5000 },
                { id = "f_region_weed", copies = 20 },
                { id = "f_boulder_small", copies = 3 },
                { id = "f_boulder_medium", copies = 2 },
                { id = "f_boulder_large", copies = 1 },
            },
        },
    },
}
