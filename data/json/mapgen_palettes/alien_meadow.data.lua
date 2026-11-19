local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "alien_meadow_palette",
    layout = {
        terrain = {
            ["1"] = {
                { id = "t_region_soil", copies = 1 },
                { id = "t_alien_meadow_grass", copies = 2 },
                { id = "t_alien_meadow_grass_long", copies = 1000 },
                { id = "t_alien_meadow_grass_tall", copies = 2000 },
                { id = "t_alien_meadow_shrub_1", copies = 10 },
                { id = "t_alien_meadow_shrub_2", copies = 10 },
                { id = "t_alien_meadow_shrub_3", copies = 10 },
                { id = "t_alien_meadow_tree_1", copies = 15 },
                { id = "t_alien_meadow_tree_2", copies = 15 },
                { id = "t_alien_meadow_tree_3", copies = 15 },
            },
            ["2"] = {
                { id = "t_region_soil", copies = 10 },
                { id = "t_alien_meadow_grass", copies = 2 },
                { id = "t_alien_meadow_grass_long", copies = 1500 },
                { id = "t_alien_meadow_grass_tall", copies = 100 },
                { id = "t_alien_meadow_shrub_1", copies = 10 },
                { id = "t_alien_meadow_shrub_2", copies = 10 },
                { id = "t_alien_meadow_shrub_3", copies = 10 },
                { id = "t_alien_meadow_tree_1", copies = 15 },
                { id = "t_alien_meadow_tree_2", copies = 15 },
                { id = "t_alien_meadow_tree_3", copies = 15 },
            },
        },
        furniture = {
            ["1"] = {
                { id = "f_null", copies = 2500 },
                { id = "f_alien_weed_1", copies = 5 },
                { id = "f_alien_weed_2", copies = 5 },
                { id = "f_alien_weed_3", copies = 5 },
                { id = "f_boulder_small", copies = 3 },
                { id = "f_boulder_medium", copies = 2 },
                { id = "f_boulder_large", copies = 1 },
            },
            ["2"] = {
                { id = "f_null", copies = 2500 },
                { id = "f_alien_weed_1", copies = 5 },
                { id = "f_alien_weed_2", copies = 5 },
                { id = "f_alien_weed_3", copies = 5 },
                { id = "f_boulder_small", copies = 3 },
                { id = "f_boulder_medium", copies = 2 },
                { id = "f_boulder_large", copies = 1 },
            },
        },
    },
}
