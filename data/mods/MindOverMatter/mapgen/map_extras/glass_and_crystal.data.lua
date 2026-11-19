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

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_glass_and_crystal_monsters_migo",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = {
            {
                group = "GROUP_MI-GO_CAMP_OM",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 75,
                repetitions = { 3, 6 },
            },
            {
                group = "GROUP_MI-GO_PSIONS",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 65,
                repetitions = { 0, 2 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_glass_and_crystal_monsters_nether",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = {
            {
                group = "GROUP_NETHER_PORTAL",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 85,
                repetitions = { 4, 8 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_glass_and_crystal_monsters_feral_psions",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = {
            {
                group = "GROUP_FERAL_PSYCHIC",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 85,
                repetitions = { 2, 4 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_glass_and_crystal_monsters_mixed",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = {
            {
                group = "GROUP_CRYSTAL_FIELD",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 85,
                repetitions = { 5, 13 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "glass_and_crystal_chunk_center",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        terrain = { X = "t_nether_stone" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = { X = { group = "dist_matrix_crystals", chance = 100 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "glass_and_crystal_chunk_center",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        terrain = { X = "t_nether_stone" },
        furniture = { X = "f_nether_crystal_structure" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "glass_and_crystal_chunk_center",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        terrain = { X = "t_nether_stone" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        field_placements = { { id = "fd_fatigue", x = 0, y = 0, intensity = 3 } },
    },
}
