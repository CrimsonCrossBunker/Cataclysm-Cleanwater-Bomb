local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "pond_saltwater_shallow",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            " ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain = { [" "] = "t_swater_sh" },
        furniture = { [" "] = { { id = "f_region_water_plant" }, { id = "f_null", copies = 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "pond_saltwater_deep",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            " ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain = { [" "] = "t_swater_dp" },
        furniture = { [" "] = { { id = "f_region_water_plant" }, { id = "f_null", copies = 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_pond_swamp",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "     ????????????????   ",
            "   ???????????????????  ",
            "   ?**]]]]]*]***]]]]??  ",
            "  ???**************]??  ",
            "  ???*************]]??  ",
            "  ????***[[[*******]??  ",
            "  ???***[[[[[[[[**]]??  ",
            "  ???***[[[[[[[[**]]??  ",
            "  ???***[[[~~~[[**]]??  ",
            "  ??****[[[~~~[[***]??  ",
            "  ??]***[[~~~~[[***]??  ",
            "  ??]***[[~~~~[[**]]??  ",
            "  ??]***[[~[[[[[**]]??  ",
            "  ??]***[[[[[[[[**]]??  ",
            "  ??]*****[[******]]??  ",
            "  ??]**************]??  ",
            "  ??]**************]??  ",
            "  ????]??]]]]]]]]]]]??  ",
            "  ????????]]]????????   ",
            "  ?????????????????     ",
            "                        ",
            "                        ",
        },
        nested_glyphs = {
            [" "] = {
                choices = {
                    { id = "pond_saltwater_shallow", weight = 3 },
                    { id = "pond_saltwater_deep", weight = 2 },
                    { id = "pond_dirt", weight = 4 },
                    { id = "pond_grass", weight = 6 },
                    { id = "pond_shrub", weight = 1 },
                    { id = "pond_underbrush", weight = 1 },
                    { id = "pond_tree", weight = 1 },
                    { id = "pond_tree_willow", weight = 1 },
                    { id = "pond_tree_young", weight = 1 },
                    { id = "pond_rocks", weight = 1 },
                },
            },
            ["*"] = {
                choices = {
                    { id = "pond_saltwater_shallow", weight = 8 },
                    { id = "pond_dirt", weight = 1 },
                    { id = "pond_grass", weight = 1 },
                    { id = "pond_underbrush", weight = 1 },
                    { id = "pond_tree_willow", weight = 1 },
                    { id = "pond_rocks", weight = 1 },
                },
            },
            ["?"] = {
                choices = {
                    { id = "pond_saltwater_shallow", weight = 3 },
                    { id = "pond_dirt", weight = 5 },
                    { id = "pond_grass", weight = 6 },
                    { id = "pond_shrub", weight = 1 },
                    { id = "pond_tree", weight = 1 },
                    { id = "pond_tree_willow", weight = 1 },
                    { id = "pond_tree_young", weight = 1 },
                    { id = "pond_rocks", weight = 1 },
                },
            },
            ["["] = {
                choices = {
                    { id = "pond_saltwater_deep", weight = 4 },
                    { id = "pond_saltwater_shallow", weight = 4 },
                    { id = "pond_underbrush", weight = 1 },
                    { id = "pond_rocks", weight = 1 },
                },
            },
            ["]"] = {
                choices = {
                    { id = "pond_saltwater_shallow", weight = 8 },
                    { id = "pond_dirt", weight = 1 },
                    { id = "pond_grass", weight = 1 },
                    { id = "pond_tree_willow", weight = 1 },
                    { id = "pond_rocks", weight = 1 },
                },
            },
            ["~"] = {
                choices = {
                    { id = "pond_saltwater_deep", weight = 8 },
                    { id = "pond_dirt", weight = 1 },
                    { id = "pond_grass", weight = 1 },
                    { id = "pond_tree_willow", weight = 1 },
                    { id = "pond_underbrush", weight = 1 },
                    { id = "pond_rocks", weight = 1 },
                },
            },
        },
        monster_group_placements = {
            { group = "GROUP_SAFE", x = { 0, 23 }, y = { 0, 23 }, chance = 5, density = 0.5 },
            {
                group = "GROUP_FISH",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 10,
                repetitions = { 1, 2 },
                density = 0.5,
            },
            { group = "GROUP_SWAMP", x = { 0, 23 }, y = { 0, 23 }, chance = 5, density = 0.5 },
        },
        furniture = {
            ["~"] = "f_clear",
            ["*"] = "f_clear",
            ["["] = "f_clear",
            ["]"] = "f_clear",
            ["?"] = "f_clear",
            [" "] = "f_clear",
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_pond_swamp_2",
    layout = {
        rows = {
            "                        ",
            "         ??             ",
            "         ???            ",
            "          ???? ?        ",
            "          ?????         ",
            "        ]]]**]]]]       ",
            "        ]]*****]]]      ",
            "       ]***[******]     ",
            "      ]]***[[[[****]    ",
            "     ]]***[[[[*****]    ",
            "     ?**[[~~~~[****]]   ",
            "     ]**[[~~~~[****]]   ",
            "    ]]***[~~~~[***]]]   ",
            "    ]]***[~~~~[[]]]     ",
            "    ]]****[[[[**]???    ",
            "     ]]***[[***]]???    ",
            "     ]]]]*****]]  ? ?   ",
            "       ??]]****]        ",
            "           **           ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        nested_glyphs = {
            [" "] = {
                choices = {
                    { id = "pond_saltwater_shallow", weight = 3 },
                    { id = "pond_saltwater_deep", weight = 2 },
                    { id = "pond_dirt", weight = 4 },
                    { id = "pond_grass", weight = 6 },
                    { id = "pond_shrub", weight = 1 },
                    { id = "pond_underbrush", weight = 1 },
                    { id = "pond_tree", weight = 1 },
                    { id = "pond_tree_willow", weight = 1 },
                    { id = "pond_tree_young", weight = 1 },
                    { id = "pond_rocks", weight = 1 },
                },
            },
            ["*"] = {
                choices = {
                    { id = "pond_saltwater_shallow", weight = 8 },
                    { id = "pond_dirt", weight = 1 },
                    { id = "pond_grass", weight = 1 },
                    { id = "pond_underbrush", weight = 1 },
                    { id = "pond_tree_willow", weight = 1 },
                    { id = "pond_rocks", weight = 1 },
                },
            },
            ["?"] = {
                choices = {
                    { id = "pond_saltwater_shallow", weight = 3 },
                    { id = "pond_dirt", weight = 5 },
                    { id = "pond_grass", weight = 6 },
                    { id = "pond_shrub", weight = 1 },
                    { id = "pond_tree", weight = 1 },
                    { id = "pond_tree_willow", weight = 1 },
                    { id = "pond_tree_young", weight = 1 },
                    { id = "pond_rocks", weight = 1 },
                },
            },
            ["["] = {
                choices = {
                    { id = "pond_saltwater_deep", weight = 4 },
                    { id = "pond_saltwater_shallow", weight = 4 },
                    { id = "pond_underbrush", weight = 1 },
                    { id = "pond_rocks", weight = 1 },
                },
            },
            ["]"] = {
                choices = {
                    { id = "pond_saltwater_shallow", weight = 8 },
                    { id = "pond_dirt", weight = 1 },
                    { id = "pond_grass", weight = 1 },
                    { id = "pond_tree_willow", weight = 1 },
                    { id = "pond_rocks", weight = 1 },
                },
            },
            ["~"] = {
                choices = {
                    { id = "pond_saltwater_deep", weight = 8 },
                    { id = "pond_dirt", weight = 1 },
                    { id = "pond_grass", weight = 1 },
                    { id = "pond_tree_willow", weight = 1 },
                    { id = "pond_underbrush", weight = 1 },
                    { id = "pond_rocks", weight = 1 },
                },
            },
        },
        monster_group_placements = {
            { group = "GROUP_SAFE", x = { 0, 23 }, y = { 0, 23 }, chance = 5, density = 0.5 },
            {
                group = "GROUP_FISH",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 10,
                repetitions = { 1, 2 },
                density = 0.5,
            },
            { group = "GROUP_SWAMP", x = { 0, 23 }, y = { 0, 23 }, chance = 5, density = 0.5 },
        },
        furniture = {
            ["~"] = "f_clear",
            ["*"] = "f_clear",
            ["["] = "f_clear",
            ["]"] = "f_clear",
            ["?"] = "f_clear",
            [" "] = "f_clear",
        },
    },
}
