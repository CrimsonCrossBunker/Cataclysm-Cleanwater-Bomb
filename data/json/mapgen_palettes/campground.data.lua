local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "campground_palette",
    layout = {
        toilets = { "&" },
        nested_glyphs = {
            N = {
                choices = { { id = "tent_b_5x5_N", weight = 2 }, { id = "tent_5x5_N", weight = 10 } },
            },
            S = {
                choices = { { id = "tent_b_5x5_S", weight = 2 }, { id = "tent_5x5_S", weight = 10 } },
            },
            E = {
                choices = { { id = "tent_b_5x5_E", weight = 2 }, { id = "tent_5x5_E", weight = 10 } },
            },
            W = {
                choices = { { id = "tent_b_5x5_W", weight = 2 }, { id = "tent_5x5_W", weight = 10 } },
            },
        },
        item_groups = {
            ["&"] = { group = "SUS_toilet", chance = 50 },
            [";"] = {
                { group = "dresser", chance = 5, repetitions = { 1, 2 } },
                { group = "creepy", chance = 2 },
                { group = "camping", chance = 5 },
                { group = "archery", chance = 2 },
            },
            t = {
                { group = "barbecue", chance = 5, repetitions = { 1, 2 } },
                { group = "misc_smoking", chance = 2 },
                { group = "cannedfood", chance = 2, repetitions = { 1, 2 } },
            },
        },
        terrain = {
            ["#"] = {
                { id = "t_region_groundcover_forest", copies = 40 },
                { id = "t_region_shrub", copies = 5 },
                { id = "t_region_tree", copies = 7 },
            },
            [" "] = { { id = "t_region_groundcover_barren", copies = 15 }, { id = "t_region_groundcover" } },
            ["."] = "t_region_groundcover",
            ["|"] = "t_wall_w",
            w = "t_window",
            ["&"] = "t_thconc_floor",
            s = "t_thconc_floor",
            _ = "t_thconc_floor",
            ["+"] = { { id = "t_door_c" }, { id = "t_door_o" } },
            o = "t_pit_shallow",
            O = "t_gutter_downspout",
        },
        furniture = {
            H = "f_camp_chair",
            B = "f_brazier",
            s = "f_sink",
            b = "f_bench",
            t = "f_table",
            n = "f_tourist_table",
            o = "f_firering",
        },
    },
}
