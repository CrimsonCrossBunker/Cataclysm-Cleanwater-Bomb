local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "stream_palette",
    layout = {
        item_groups = {
            ["1"] = {
                { group = "SUS_trash_forest_manmade", chance = 2, repetitions = { 0, 2 } },
                { group = "creek_bed", chance = 15, repetitions = { 0, 2 } },
                { group = "wheels", chance = 1 },
            },
            ["2"] = {
                { group = "SUS_trash_forest_manmade", chance = 2, repetitions = { 0, 2 } },
                { group = "creek_bed", chance = 10, repetitions = { 0, 3 } },
            },
        },
        terrain = {
            [" "] = "t_null",
            ["~"] = "t_water_moving_sh",
            ["1"] = {
                { id = "t_null", copies = 100 },
                { id = "t_sand", copies = 1 },
                { id = "t_shrub_spicebush", copies = 10 },
                { id = "t_shrub_hobblebush", copies = 10 },
                { id = "t_clay", copies = 4 },
                { id = "t_grass_long", copies = 900 },
                { id = "t_region_shrub_forest", copies = 20 },
                { id = "t_region_tree_forest", copies = 20 },
            },
            ["2"] = {
                { id = "t_null", copies = 150 },
                { id = "t_grass_long", copies = 10 },
                { id = "t_region_shrub_forest", copies = 1 },
                { id = "t_region_tree_forest", copies = 1 },
            },
        },
        furniture = {
            [" "] = "f_null",
            ["1"] = {
                { id = "f_null", copies = 800 },
                { id = "f_region_weed", copies = 10 },
                { id = "f_boulder_small", copies = 3 },
                { id = "f_boulder_medium", copies = 2 },
                { id = "f_boulder_large", copies = 1 },
            },
            ["2"] = {
                { id = "f_null", copies = 1400 },
                { id = "f_region_weed", copies = 10 },
                { id = "f_boulder_small", copies = 3 },
                { id = "f_boulder_medium", copies = 2 },
                { id = "f_boulder_large", copies = 1 },
            },
        },
    },
}
