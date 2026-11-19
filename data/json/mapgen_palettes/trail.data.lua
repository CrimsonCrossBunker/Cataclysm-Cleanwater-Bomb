local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "trail_palette",
    layout = {
        palettes = { "trail_terrain_furniture_palette", "trail_width_palette", "trail_item_palette" },
    },
}

ccb.content.define_mapgen_palette { id = "trail_path_palette", layout = { terrain = { ["."] = "t_dirt" } } }

ccb.content.define_mapgen_palette {
    id = "trail_terrain_furniture_palette",
    layout = {
        nested_glyphs = {
            B = { choices = { { id = "null", weight = 3 }, { id = "1x1_trailmap", weight = 1 } } },
            I = { choices = { { id = "null", weight = 3 }, { id = "1x1_trail_sign", weight = 1 } } },
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
                    { id = "1x1_t_railroad_rubble", weight = 3 },
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
            G = { { id = "t_grass_long", copies = 2 }, { id = "t_grass_tall", copies = 1 } },
            ["6"] = "t_region_tree_shade",
            ["7"] = { { id = "t_tree_dead" }, { id = "t_tree_very_dead" }, { id = "t_tree_dead_warped" } },
        },
        furniture = {
            _ = {
                { id = "f_null", copies = 17 },
                { id = "f_boulder_small", copies = 1 },
                { id = "f_boulder_medium", copies = 1 },
                { id = "f_boulder_large", copies = 1 },
            },
        },
    },
}

-- Number indicates number of tiles from center
ccb.content.define_mapgen_palette {
    id = "trail_width_palette",
    layout = {
        nested_glyphs = {
            ["0"] = { choices = { { id = "1x1_trail", weight = 1 }, { id = "null", weight = 0 } } },
            ["1"] = { choices = { { id = "1x1_trail", weight = 1 }, { id = "null", weight = 1 } } },
            ["2"] = { choices = { { id = "1x1_trail", weight = 1 }, { id = "null", weight = 3 } } },
            ["3"] = { choices = { { id = "1x1_trail", weight = 0 }, { id = "null", weight = 1 } } },
            ["4"] = { choices = { { id = "1x1_trail", weight = 0 }, { id = "null", weight = 1 } } },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "trail_item_palette",
    layout = {
        item_groups = {
            ["0"] = { group = "forest_trail", chance = 1 },
            ["1"] = { group = "forest_trail", chance = 1 },
            ["2"] = { group = "forest_trail", chance = 1 },
            ["3"] = { group = "forest_trail", chance = 1 },
            ["4"] = { group = "forest_trail", chance = 1 },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "trail_small_den_empty_palette",
    layout = {
        monster_glyphs = { A = { id = "mon_null", chance = 100 }, a = { id = "mon_null", chance = 100 } },
        terrain = { d = "t_den_small" },
    },
}

ccb.content.define_mapgen_palette {
    id = "trail_large_den_empty_palette",
    layout = {
        monster_glyphs = { A = { id = "mon_null", chance = 100 }, a = { id = "mon_null", chance = 100 } },
        terrain = { d = "t_den_large" },
    },
}

ccb.content.define_mapgen_palette {
    id = "trail_small_den_groundhog_palette",
    layout = {
        monster_glyphs = { A = { id = "mon_groundhog", chance = 100 }, a = { id = "mon_groundhog", chance = 10 } },
        terrain = { d = "t_den_small" },
    },
}

ccb.content.define_mapgen_palette {
    id = "trail_small_den_hare_palette",
    layout = {
        monster_glyphs = { A = { id = "mon_hare", chance = 100 }, a = { id = "mon_hare", chance = 25 } },
        terrain = { d = "t_den_small" },
    },
}

ccb.content.define_mapgen_palette {
    id = "trail_large_den_fox_gray_palette",
    layout = {
        monster_glyphs = { A = { id = "mon_fox_gray", chance = 100 }, a = { id = "mon_fox_gray", chance = 5 } },
        terrain = { d = "t_den_large" },
    },
}

ccb.content.define_mapgen_palette {
    id = "trail_large_den_fox_red_palette",
    layout = {
        monster_glyphs = { A = { id = "mon_fox_red", chance = 100 }, a = { id = "mon_fox_red", chance = 5 } },
        terrain = { d = "t_den_large" },
    },
}

ccb.content.define_mapgen_palette {
    id = "trail_large_den_bear_palette",
    layout = {
        monster_glyphs = { A = { id = "mon_bear", chance = 100 }, a = { id = "mon_bear_cub", chance = 5 } },
        terrain = { d = "t_den_large" },
    },
}
