local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_glass_and_crystal",
    layout = {
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = {
            { id = "glass_and_crystal_chunk", x = { 2, 15 }, y = { 2, 15 } },
            {
                choices = {
                    { id = "null", weight = 1 },
                    { id = "mx_glass_and_crystal_monsters_migo", weight = 5 },
                    { id = "mx_glass_and_crystal_monsters_nether", weight = 8 },
                    { id = "mx_glass_and_crystal_monsters_feral_psions", weight = 5 },
                    { id = "mx_glass_and_crystal_monsters_mixed", weight = 3 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "glass_and_crystal_chunk",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "   GGG   ",
            " GGGCGGG ",
            " GGCCCGG ",
            "GGCCCCCGG",
            "GCCCNCCCG",
            "GGCCCCCGG",
            " GGCCCGG ",
            " GGGCGGG ",
            "   GGG   ",
        },
        terrain = {
            c = "t_nether_stone",
            C = "t_nether_stone",
            G = { { id = "t_nether_stone", copies = 2 }, { id = "t_null", copies = 2 } },
            [" "] = "t_null",
        },
        furniture = { C = { { id = "f_nether_crystal_structure", copies = 1 }, { id = "f_null", copies = 1 } } },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested_glyphs = { N = { id = "glass_and_crystal_chunk_center" } },
    },
}
