local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "trailhead",
    layout = {
        nested_glyphs = { ["6"] = { choices = { { id = "null", weight = 1 } } } },
        terrain = {
            [" "] = "t_region_soil",
            [","] = { { id = "t_region_groundcover", copies = 2 }, { id = "t_region_soil" } },
            [";"] = { { id = "t_region_groundcover" }, { id = "t_region_soil" } },
            ["."] = { { id = "t_region_groundcover", copies = 2 }, { id = "t_region_soil" } },
            b = "t_region_soil",
            t = "t_trunk",
            s = "t_region_soil",
            ["6"] = "t_region_soil",
            ["="] = "t_region_soil",
            ["-"] = { { id = "t_region_groundcover", copies = 2 }, { id = "t_region_soil" } },
            ["|"] = { { id = "t_region_groundcover", copies = 2 }, { id = "t_region_soil" } },
            ["#"] = { { id = "t_region_groundcover", copies = 2 }, { id = "t_region_soil" } },
            B = { { id = "t_region_groundcover", copies = 2 }, { id = "t_region_soil" } },
            w = { { id = "t_region_groundcover", copies = 2 }, { id = "t_region_soil" } },
            ["+"] = { { id = "t_region_groundcover", copies = 2 }, { id = "t_region_soil" } },
            [":"] = { { id = "t_region_groundcover", copies = 2 }, { id = "t_region_soil" } },
            c = { { id = "t_region_groundcover", copies = 2 }, { id = "t_region_soil" } },
            W = { { id = "t_region_groundcover", copies = 2 }, { id = "t_region_soil" } },
            T = { { id = "t_region_groundcover", copies = 2 }, { id = "t_region_soil" } },
            ["7"] = { { id = "t_region_tree" }, { id = "t_region_shrub" } },
            f = "t_region_soil",
        },
        furniture = {
            b = "f_boulder_small",
            s = { { id = "f_region_flower", copies = 1 }, { id = "f_null", copies = 100 } },
            B = { { id = "f_region_flower", copies = 1 }, { id = "f_null", copies = 100 } },
            ["="] = { { id = "f_region_flower", copies = 1 }, { id = "f_null", copies = 100 } },
            w = { { id = "f_region_flower", copies = 1 }, { id = "f_null", copies = 100 } },
            [","] = { { id = "f_region_flower", copies = 1 }, { id = "f_null", copies = 100 } },
            [";"] = { { id = "f_region_flower", copies = 1 }, { id = "f_null", copies = 100 } },
            ["."] = { { id = "f_region_flower", copies = 1 }, { id = "f_null", copies = 100 } },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "trail_terrain_furniture_palette",
    layout = {
        palettes = { "trail_path_palette" },
        terrain = {
            ["."] = "t_dirt",
            t = "t_trunk",
            n = "t_stump",
            m = "t_dirtmound",
            M = "t_moss",
            [","] = "t_forestfloor",
            u = "t_underbrush",
            f = "t_fungus_colony",
            F = "t_fern",
            G = {
                { id = "t_grass_long", copies = 2 },
                { id = "t_grass_tall", copies = 1 },
            },
            ["6"] = "t_region_tree_shade",
            ["7"] = {
                { id = "t_tree_dead" },
                { id = "t_tree_very_dead" },
                { id = "t_tree_dead_warped" },
            },
        },
        furniture = {
            _ = {
                { id = "f_null", copies = 17 },
                { id = "f_boulder_small", copies = 1 },
                { id = "f_boulder_medium", copies = 1 },
                { id = "f_boulder_large", copies = 1 },
            },
        },
        nested_glyphs = {
            B = {
                choices = {
                    { id = "null", weight = 3 },
                },
            },
            I = {
                choices = {
                    { id = "null", weight = 3 },
                },
            },
            T = {
                choices = {
                    { id = "1x1_predecessor_tree", weight = 2 },
                    { id = "1x1_predecessor_groundcover", weight = 1 },
                },
            },
            ["*"] = { id = "1x1_predecessor_groundcover" },
            s = { id = "1x1_predecessor_shrub" },
            S = {
                choices = {
                    { id = "1x1_predecessor_groundcover", weight = 2 },
                    { id = "1x1_predecessor_shrub", weight = 3 },
                },
            },
            _ = {
                choices = {
                    { id = "1x1_t_dirt", weight = 1 },
                    { id = "1x1_predecessor_groundcover", weight = 3 },
                },
            },
            ["~"] = {
                choices = {
                    { id = "1x1_t_mud", weight = 6 },
                    { id = "1x1_t_dirt", weight = 1 },
                    { id = "1x1_predecessor_groundcover", weight = 1 },
                },
            },
        },
    },
}
