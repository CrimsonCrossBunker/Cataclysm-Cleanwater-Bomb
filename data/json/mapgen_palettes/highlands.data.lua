local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "highlands",
    layout = {
        glyph_mappings = {
            ["*"] = {
                terrain = { { id = "t_moss", copies = 40 }, { id = "t_dirt", copies = 5 } },
                furniture = { { id = "f_boulder_large", copies = 20 }, { id = "f_boulder_small", copies = 1 } },
            },
        },
        terrain = {
            ["#"] = "t_soil",
            ["'"] = "t_open_air",
            ["."] = "t_moss",
            o = "t_dirt",
            w = "t_water_hot",
            [","] = { { id = "t_fern", copies = 5 }, { id = "t_grass_tall", copies = 2 } },
            s = { { id = "t_moss", copies = 5 }, { id = "t_dirt", copies = 5 } },
            F = { { id = "t_moss", copies = 5 }, { id = "t_dirt", copies = 5 } },
            I = { { id = "t_tree_dead_warped" } },
        },
        furniture = {
            s = { { id = "f_boulder_small", copies = 5 }, { id = "f_null", copies = 5 } },
            F = { { id = "f_boulder_large", copies = 5 }, { id = "f_null", copies = 5 } },
            W = "f_clear",
            o = "f_boulder_small",
            w = "f_clear",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "highland_structure",
    layout = {
        item_spawns = { _ = { id = "highland_censer", chance = 20 }, J = { id = "clay_watercont", chance = 2 } },
        item_groups = { t = { { group = "highland_sarcophagus_common" } } },
        terrain = {
            [" "] = "t_highland_groundcover",
            F = "t_highland_groundcover",
            _ = {
                { id = "t_stone_masonry_floor", copies = 2 },
                { id = "t_highland_groundcover", copies = 1 },
            },
            ["."] = {
                { id = "t_stone_masonry_floor", copies = 10 },
                { id = "t_highland_groundcover", copies = 1 },
            },
            x = "t_highland_mosaic",
            G = "t_highland_flower_bed",
            S = "t_stone_masonry_floor",
            ["|"] = "t_rock_wall",
            w = "t_water_sh",
            I = { { id = "t_tree_dead_warped" } },
            ["-"] = "t_stone_fence",
            v = {
                { id = "t_window_stained_blue", copies = 1 },
                { id = "t_window_stained_red", copies = 2 },
                { id = "t_window_stained_green", copies = 2 },
            },
        },
        furniture = {
            S = "f_highlands_holy_statue",
            t = "f_highland_sarcophagus",
            F = { { id = "f_slab", copies = 2 }, { id = "f_null", copies = 1 } },
            w = { { id = "f_null", copies = 2 }, { id = "f_lilypad", copies = 1 } },
        },
    },
}
