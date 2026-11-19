local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "nether_crystal_field",
    layout = {
        rows = {
            "  A_A_A_A_A_A_A_A_A_A_  ",
            " A_A_A_A_A_A_A_A_A_A_A_ ",
            "A_A_A_A_A_A_A_A_A_A_A___",
            "_A_A_A_A_A_A_A_A_A_A_A__",
            "A_A_A_A_A_A_A_A_A_A_A___",
            "_A_A_A_A_A_A_A_A_A_A_A__",
            "A_A_A_A_A_A_A_A_A_A_A___",
            "_A_A_A___________A_A_A__",
            "A_A_A_A___________A_A___",
            "_A_A_A___________A_A_A__",
            "A_A_A_A___________A_A___",
            "_A_A_A___________A_A_A__",
            "A_A_A_A___________A_A___",
            "_A_A_A___________A_A_A__",
            "A_A_A_A___________A_A___",
            "_A_A_A___________A_A_A__",
            "A_A_A_A___________A_A___",
            "_A_A_A_A_A_A_A_A_A_A_A__",
            "A_A_A_A_A_A_A_A_A_A_A___",
            "_A_A_A_A_A_A_A_A_A_A_A__",
            "A_A_A_A_A_A_A_A_A_A_A___",
            "_A_A_A_A_A_A_A_A_A_A_A__",
            " ______________________ ",
            "  ____________________  ",
        },
        terrain = {
            _ = {
                { id = "t_region_groundcover", copies = 3 },
                { id = "t_dirt", copies = 3 },
                { id = "t_grass_alien", copies = 1 },
                { id = "t_grass_alien_2", copies = 1 },
                { id = "t_grass_alien_3", copies = 1 },
                { id = "t_grass_alien_4", copies = 1 },
                { id = "t_nether_stone", copies = 1 },
            },
        },
        fill_terrain = "t_region_groundcover",
        nested = {
            { id = "crystal_field_central_10x10", x = 7, y = 7 },
            {
                choices = {
                    { id = "null", weight = 1 },
                    { id = "mx_glass_and_crystal_monsters_migo", weight = 8 },
                    { id = "mx_glass_and_crystal_monsters_nether", weight = 16 },
                    { id = "mx_glass_and_crystal_monsters_feral_psions", weight = 8 },
                    { id = "mx_glass_and_crystal_monsters_mixed", weight = 4 },
                },
                x = 0,
                y = 0,
            },
        },
        nested_glyphs = {
            A = {
                choices = { { id = "crystal_moss_or_trees_3x3", weight = 1 }, { id = "null", weight = 15 } },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "crystal_moss_or_trees_3x3",
    layout = {
        size = { width = 3, height = 3 },
        terrain = {
            [" "] = {
                { id = "t_grass_alien_2", copies = 2 },
                { id = "t_tree_small_alien_1", copies = 1 },
                { id = "t_null", copies = 1 },
            },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "crystal_moss_or_trees_3x3",
    layout = {
        size = { width = 3, height = 3 },
        terrain = {
            [" "] = {
                { id = "t_grass_alien_3", copies = 1 },
                { id = "t_moss_alien_1", copies = 1 },
                { id = "t_null", copies = 1 },
            },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "crystal_moss_or_trees_3x3",
    layout = {
        size = { width = 3, height = 3 },
        terrain = {
            [" "] = {
                { id = "t_tree_small_alien_2", copies = 1 },
                { id = "t_moss_alien_2", copies = 1 },
                { id = "t_null", copies = 1 },
            },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "crystal_moss_or_trees_3x3",
    layout = {
        size = { width = 3, height = 3 },
        terrain = {
            [" "] = {
                { id = "t_tree_small_alien_3", copies = 1 },
                { id = "t_vines_alien_1", copies = 1 },
                { id = "t_null", copies = 1 },
            },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "crystal_moss_or_trees_3x3",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "   ",
            " N ",
            "   ",
        },
        terrain = {
            [" "] = { { id = "t_nether_stone", copies = 1 }, { id = "t_null", copies = 1 } },
            N = "t_nether_stone",
        },
        furniture = { N = { { id = "f_nether_crystal_structure", copies = 1 }, { id = "f_null", copies = 1 } } },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "crystal_field_central_10x10",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "   SSSS   ",
            "  SSssSS  ",
            " SSsddsSS ",
            "SSsdDDdsSS",
            "SsdDDDDdsS",
            "SsdDDDDdsS",
            "SSsdDDdsSS",
            " SSsddsSS ",
            "  SSssSS  ",
            "   SSSS   ",
        },
        terrain = {
            D = "t_nether_water_dp",
            d = { { id = "t_nether_water_dp", copies = 1 }, { id = "t_nether_water_sh", copies = 1 } },
            s = { { id = "t_nether_water_dp", copies = 1 }, { id = "t_nether_water_sh", copies = 4 } },
            S = { { id = "t_nether_water_sh", copies = 1 }, { id = "t_nether_stone", copies = 1 } },
            [" "] = "t_null",
        },
        furniture = { S = { { id = "f_nether_crystal_structure", copies = 1 }, { id = "f_null", copies = 3 } } },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "crystal_field_central_10x10",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "   GGGG   ",
            " GGGCCGGG ",
            " GGCCCCGG ",
            "GGCCCCCCGG",
            "GCCCCCCCCG",
            "GCCCCCCCCG",
            "GGCCCCCCGG",
            " GGCCCCGG ",
            " GGGCCGGG ",
            "   GGGG   ",
        },
        terrain = {
            C = "t_nether_stone",
            G = { { id = "t_nether_stone", copies = 2 }, { id = "t_null", copies = 2 } },
            N = "t_nether_stone",
            [" "] = "t_null",
        },
        furniture = { C = { { id = "f_nether_crystal_structure", copies = 1 }, { id = "f_null", copies = 1 } } },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "crystal_field_chunk_center_2x2", x = 4, y = 4 } },
    },
}
