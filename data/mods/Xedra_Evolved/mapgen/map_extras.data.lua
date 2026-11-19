local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "corpse_blood_gibs_fae_3x3",
    layout = {
        size = { width = 3, height = 3 },
        item_group_placements = { { group = "map_extra_fae", x = { 0, 2 }, y = { 0, 2 }, chance = 100 } },
        field_placements = {
            { id = "fd_blood", x = { 0, 2 }, y = { 0, 2 } },
            { id = "fd_gibs_flesh", x = { 0, 2 }, y = { 0, 2 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_golden_monolith",
    layout = {
        rows = {
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "-----------1----------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "                        ",
            "                        ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["-"] = {
                choices = { { id = "corpse_blood_gibs_fae_3x3", weight = 1 }, { id = "null", weight = 150 } },
            },
            ["1"] = { id = "golden_monolith_nest" },
        },
        monster_group_glyphs = {
            [" "] = { group = "GROUP_CHANGELING_MIRRORED_FIELD", chance = 1, density = 0.0001 },
            ["-"] = { group = "GROUP_CHANGELING_MIRRORED_FIELD", chance = 1, density = 0.0001 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "golden_monolith_nest",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "x",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        furniture = { x = "f_golden_monolith" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_trees_map_salamander",
    layout = {
        rows = {
            "        .........       ",
            "     ...............    ",
            "   .......,,,,,.......  ",
            "  .....,,,,,,,,,,.....  ",
            "  ...,,,,,,,,,,,,,,.... ",
            " ....,,,;;;;;;;,,,,.... ",
            " ...,,,;;;;;;;;;,,,,... ",
            "....,,;;;;||;;;;,,,,....",
            "...,,,,;;;;;||;;,,,,,...",
            "...,;,;;||;||;;;;,,,,...",
            "...,,;;;;;;;;||;;,,,,...",
            "...,;,;||;||;;;;;,,,,...",
            "...,,,,;;;;;;||;,,,,,...",
            "...,;,,;;||;||;;,,,,,...",
            "...,,,;;|;;;;||;;,,,,...",
            "...,,,,,;;||;;;;,,,,,...",
            "....,,;,;;;;;;;,,,,,....",
            " ...,,,,,,;;||;;;,,,... ",
            " ....,,,,,;;;;;,,,,.... ",
            " ....,,,,,,,,,,,,,,.... ",
            "  .......,,,,,,.......  ",
            "  ....................  ",
            "    ................    ",
            "       ..........       ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        monster_group_placements = {
            {
                group = "GROUP_GENIUS_SALAMANDER",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 4,
                density = 0.2,
            },
        },
        palettes = { "copse_trees_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_trees_map_sylph",
    layout = {
        rows = {
            "        .........       ",
            "     ...............    ",
            "   .......,,,,,.......  ",
            "  .....,,,,,,,,,,.....  ",
            "  ...,,,,,,,,,,,,,,.... ",
            " ....,,,;;;;;;;,,,,.... ",
            " ...,,,;;;;;;;;;,,,,... ",
            "....,,;;;;||;;;;,,,,....",
            "...,,,,;;;;;||;;,,,,,...",
            "...,;,;;||;||;;;;,,,,...",
            "...,,;;;;;;;;||;;,,,,...",
            "...,;,;||;||;;;;;,,,,...",
            "...,,,,;;;;;;||;,,,,,...",
            "...,;,,;;||;||;;,,,,,...",
            "...,,,;;|;;;;||;;,,,,...",
            "...,,,,,;;||;;;;,,,,,...",
            "....,,;,;;;;;;;,,,,,....",
            " ...,,,,,,;;||;;;,,,... ",
            " ....,,,,,;;;;;,,,,.... ",
            " ....,,,,,,,,,,,,,,.... ",
            "  .......,,,,,,.......  ",
            "  ....................  ",
            "    ................    ",
            "       ..........       ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        monster_group_placements = {
            {
                group = "GROUP_GENIUS_SYLPH",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 4,
                density = 0.2,
            },
        },
        palettes = { "copse_trees_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_trees_map_ierde",
    layout = {
        rows = {
            "        .........       ",
            "     ...............    ",
            "   .......,,,,,.......  ",
            "  .....,,,,,,,,,,.....  ",
            "  ...,,,,,,,,,,,,,,.... ",
            " ....,,,;;;;;;;,,,,.... ",
            " ...,,,;;;;;;;;;,,,,... ",
            "....,,;;;;||;;;;,,,,....",
            "...,,,,;;;;;||;;,,,,,...",
            "...,;,;;||;||;;;;,,,,...",
            "...,,;;;;;;;;||;;,,,,...",
            "...,;,;||;||;;;;;,,,,...",
            "...,,,,;;;;;;||;,,,,,...",
            "...,;,,;;||;||;;,,,,,...",
            "...,,,;;|;;;;||;;,,,,...",
            "...,,,,,;;||;;;;,,,,,...",
            "....,,;,;;;;;;;,,,,,....",
            " ...,,,,,,;;||;;;,,,... ",
            " ....,,,,,;;;;;,,,,.... ",
            " ....,,,,,,,,,,,,,,.... ",
            "  .......,,,,,,.......  ",
            "  ....................  ",
            "    ................    ",
            "       ..........       ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        monster_group_placements = {
            {
                group = "GROUP_GENIUS_IERDE",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 4,
                density = 0.2,
            },
        },
        palettes = { "copse_trees_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_homelesscamp_homullus",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "    7                   ",
            "                   w    ",
            "                 iwww   ",
            "     !!!!!!!!!!!! wwww  ",
            "     !   ccccc  ! wWww  ",
            "     !   cmdmc  ! wWWWw ",
            "     !   cdddc  ! wWWww ",
            "     !   cdddc  ! wwwww ",
            "     !   cc+cc  !   wi  ",
            "     !     _    !       ",
            "     !!!!!!_!!!!!       ",
            "        C ___ S         ",
            "    cccc  _a_           ",
            "    cmdc  ___ S         ",
            "    cddb___             ",
            "    cddc  C C           ",
            "    cccc                ",
            "                        ",
            "                        ",
            "             7          ",
            "                        ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_group_placements = {
            {
                group = "GROUP_GENIUS_HOMULLUS",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 4,
                density = 0.2,
            },
        },
        terrain = {
            [" "] = "t_region_groundcover",
            _ = "t_region_soil",
            ["7"] = "t_region_tree",
            W = "t_water_dp",
            ["+"] = "t_dirtfloor",
            b = "t_dirtfloor",
            d = "t_dirtfloor",
            m = "t_dirtfloor",
            w = "t_water_sh",
            ["!"] = "t_trunk",
        },
        furniture = {
            ["+"] = "f_canvas_door",
            C = "f_camp_chair",
            S = "f_straw_bed",
            a = "f_woodstove",
            b = "f_canvas_door_o",
            c = "f_canvas_wall",
            i = "f_cattails",
            m = "f_makeshift_bed",
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_forest_pond_avore",
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
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested_glyphs = {
            ["*"] = {
                choices = { { id = "pond_water_furniture", weight = 8 }, { id = "null", weight = 92 } },
            },
            ["["] = {
                choices = { { id = "pond_water_furniture", weight = 8 }, { id = "null", weight = 92 } },
            },
            ["]"] = {
                choices = { { id = "pond_water_furniture", weight = 8 }, { id = "null", weight = 92 } },
            },
            ["~"] = {
                choices = { { id = "pond_water_furniture", weight = 8 }, { id = "null", weight = 92 } },
            },
        },
        monster_group_placements = {
            { group = "GROUP_SAFE", x = { 0, 23 }, y = { 0, 23 }, chance = 5, density = 0.5 },
            {
                group = "GROUP_FISH",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 2,
                repetitions = { 1, 2 },
                density = 0.5,
            },
            { group = "GROUP_FOREST", x = { 0, 23 }, y = { 0, 23 }, chance = 5, density = 0.5 },
            {
                group = "GROUP_GENIUS_ARVORE",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 4,
                density = 0.2,
            },
        },
        terrain = {
            ["*"] = "t_water_sh",
            ["?"] = {
                { id = "t_water_sh", copies = 3 },
                { id = "t_dirt", copies = 5 },
                { id = "t_grass", copies = 6 },
                { id = "t_shrub", copies = 2 },
                { id = "t_tree_young" },
                { id = "t_tree", copies = 2 },
                { id = "t_tree_willow" },
            },
            ["["] = { { id = "t_water_dp", copies = 2 }, { id = "t_water_sh", copies = 3 } },
            ["]"] = { { id = "t_water_sh", copies = 8 }, { id = "t_dirt" }, { id = "t_grass" } },
            ["~"] = "t_water_dp",
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_forest_pond_salamander_avore",
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
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested_glyphs = {
            ["*"] = {
                choices = { { id = "pond_water_furniture", weight = 8 }, { id = "null", weight = 92 } },
            },
            ["["] = {
                choices = { { id = "pond_water_furniture", weight = 8 }, { id = "null", weight = 92 } },
            },
            ["]"] = {
                choices = { { id = "pond_water_furniture", weight = 8 }, { id = "null", weight = 92 } },
            },
            ["~"] = {
                choices = { { id = "pond_water_furniture", weight = 8 }, { id = "null", weight = 92 } },
            },
        },
        monster_group_placements = {
            { group = "GROUP_SAFE", x = { 0, 23 }, y = { 0, 23 }, chance = 5, density = 0.5 },
            {
                group = "GROUP_FISH",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 2,
                repetitions = { 1, 2 },
                density = 0.5,
            },
            { group = "GROUP_FOREST", x = { 0, 23 }, y = { 0, 23 }, chance = 5, density = 0.5 },
            {
                group = "GROUP_GENIUS_ARVORE",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 4,
                density = 0.1,
            },
            {
                group = "GROUP_GENIUS_SALAMANDER",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 4,
                density = 0.1,
            },
        },
        terrain = {
            ["*"] = "t_water_sh",
            ["?"] = {
                { id = "t_water_sh", copies = 3 },
                { id = "t_dirt", copies = 5 },
                { id = "t_grass", copies = 6 },
                { id = "t_shrub", copies = 2 },
                { id = "t_tree_young" },
                { id = "t_tree", copies = 2 },
                { id = "t_tree_willow" },
            },
            ["["] = { { id = "t_water_dp", copies = 2 }, { id = "t_water_sh", copies = 3 } },
            ["]"] = { { id = "t_water_sh", copies = 8 }, { id = "t_dirt" }, { id = "t_grass" } },
            ["~"] = "t_water_dp",
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_pond_forest_undine",
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
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested_glyphs = {
            ["*"] = {
                choices = { { id = "pond_water_furniture", weight = 8 }, { id = "null", weight = 92 } },
            },
            ["["] = {
                choices = { { id = "pond_water_furniture", weight = 8 }, { id = "null", weight = 92 } },
            },
            ["]"] = {
                choices = { { id = "pond_water_furniture", weight = 8 }, { id = "null", weight = 92 } },
            },
            ["~"] = {
                choices = { { id = "pond_water_furniture", weight = 8 }, { id = "null", weight = 92 } },
            },
        },
        monster_group_placements = {
            { group = "GROUP_SAFE", x = { 0, 23 }, y = { 0, 23 }, chance = 5, density = 0.5 },
            {
                group = "GROUP_FISH",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 2,
                repetitions = { 1, 2 },
                density = 0.5,
            },
            { group = "GROUP_FOREST", x = { 0, 23 }, y = { 0, 23 }, chance = 5, density = 0.5 },
            {
                group = "GROUP_GENIUS_UNDINE",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 4,
                density = 0.2,
            },
        },
        furniture = { ["~"] = "f_clear", ["*"] = "f_clear", ["["] = "f_clear", ["]"] = "f_clear" },
        terrain = {
            ["*"] = "t_water_sh",
            ["?"] = {
                { id = "t_water_sh", copies = 3 },
                { id = "t_dirt", copies = 5 },
                { id = "t_grass", copies = 6 },
                { id = "t_shrub", copies = 2 },
                { id = "t_tree_young" },
                { id = "t_tree", copies = 2 },
                { id = "t_tree_willow" },
            },
            ["["] = { { id = "t_water_dp", copies = 2 }, { id = "t_water_sh", copies = 3 } },
            ["]"] = { { id = "t_water_sh", copies = 8 }, { id = "t_dirt" }, { id = "t_grass" } },
            ["~"] = "t_water_dp",
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_pond_forest_undine_ierde",
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
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested_glyphs = {
            ["*"] = {
                choices = { { id = "pond_water_furniture", weight = 8 }, { id = "null", weight = 92 } },
            },
            ["["] = {
                choices = { { id = "pond_water_furniture", weight = 8 }, { id = "null", weight = 92 } },
            },
            ["]"] = {
                choices = { { id = "pond_water_furniture", weight = 8 }, { id = "null", weight = 92 } },
            },
            ["~"] = {
                choices = { { id = "pond_water_furniture", weight = 8 }, { id = "null", weight = 92 } },
            },
        },
        monster_group_placements = {
            { group = "GROUP_SAFE", x = { 0, 23 }, y = { 0, 23 }, chance = 5, density = 0.5 },
            {
                group = "GROUP_FISH",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 2,
                repetitions = { 1, 2 },
                density = 0.5,
            },
            { group = "GROUP_FOREST", x = { 0, 23 }, y = { 0, 23 }, chance = 5, density = 0.5 },
            {
                group = "GROUP_GENIUS_UNDINE",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 4,
                density = 0.1,
            },
            {
                group = "GROUP_GENIUS_IERDE",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 4,
                density = 0.1,
            },
        },
        furniture = { ["~"] = "f_clear", ["*"] = "f_clear", ["["] = "f_clear", ["]"] = "f_clear" },
        terrain = {
            ["*"] = "t_water_sh",
            ["?"] = {
                { id = "t_water_sh", copies = 3 },
                { id = "t_dirt", copies = 5 },
                { id = "t_grass", copies = 6 },
                { id = "t_shrub", copies = 2 },
                { id = "t_tree_young" },
                { id = "t_tree", copies = 2 },
                { id = "t_tree_willow" },
            },
            ["["] = { { id = "t_water_dp", copies = 2 }, { id = "t_water_sh", copies = 3 } },
            ["]"] = { { id = "t_water_sh", copies = 8 }, { id = "t_dirt" }, { id = "t_grass" } },
            ["~"] = "t_water_dp",
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_goblin_fruits",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { x = { 2, 13 }, y = { 2, 13 }, id = "goblin_fruit_plants" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_fruit_plants",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "   GGG   ",
            " GGGGGGG ",
            " GGGGGGG ",
            "GGGGGGGGG",
            "GGGGGGGGG",
            "GGGGGGGGG",
            " GGGGGGG ",
            " GGGGGGG ",
            "   GGG   ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain = {
            G = {
                { id = "t_shrub_goblin_fruit_spring", copies = 1 },
                { id = "t_shrub_goblin_fruit_summer", copies = 1 },
                { id = "t_shrub_goblin_fruit_autumn", copies = 1 },
                { id = "t_shrub_goblin_fruit_winter", copies = 1 },
                { id = "t_null", copies = 25 },
            },
            [" "] = "t_null",
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_ring_of_mushrooms",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { x = { 2, 8 }, y = { 2, 8 }, id = "mushroom_ring_chunk" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mushroom_ring_chunk",
    weight = 1000,
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " S,S ",
            "S,,,S",
            ",,,,,",
            "S,,,S",
            " S,S ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain = {
            [","] = {
                { id = "t_moss", copies = 50 },
                { id = "t_grass", copies = 25 },
                { id = "t_grass_dead", copies = 25 },
            },
            S = "t_mushroom_patch",
            [" "] = "t_null",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mushroom_ring_chunk",
    weight = 600,
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " S,S ",
            "S,,,S",
            ",,,,,",
            "S,,,S",
            " S,S ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_placements = {
            {
                group = "GROUP_CHANGELING_STRIKE_FORCE",
                x = { 0, 4 },
                y = { 0, 4 },
                chance = 75,
                repetitions = { 3, 5 },
            },
        },
        terrain = {
            [","] = {
                { id = "t_moss", copies = 50 },
                { id = "t_grass", copies = 25 },
                { id = "t_grass_dead", copies = 25 },
            },
            S = "t_mushroom_patch",
            [" "] = "t_null",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mushroom_ring_chunk",
    weight = 750,
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "   S,,S   ",
            " S,,,,,,S ",
            " ,,,,,,,, ",
            "S,,,,,,,,S",
            ",,,,,,,,,,",
            ",,,,,,,,,,",
            "S,,,,,,,,S",
            " ,,,,,,,, ",
            " S,,,,,,S ",
            "   S,,S   ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain = {
            [","] = {
                { id = "t_moss", copies = 50 },
                { id = "t_grass", copies = 25 },
                { id = "t_grass_dead", copies = 25 },
            },
            S = "t_mushroom_patch",
            [" "] = "t_null",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mushroom_ring_chunk",
    weight = 400,
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "   S,,S   ",
            " S,,,,,,S ",
            " ,,,,,,,, ",
            "S,,,,,,,,S",
            ",,,,,,,,,,",
            ",,,,,,,,,,",
            "S,,,,,,,,S",
            " ,,,,,,,, ",
            " S,,,,,,S ",
            "   S,,S   ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_placements = {
            {
                group = "GROUP_CHANGELING_STRIKE_FORCE",
                x = { 0, 9 },
                y = { 0, 9 },
                chance = 75,
                repetitions = { 5, 10 },
            },
        },
        terrain = {
            [","] = {
                { id = "t_moss", copies = 50 },
                { id = "t_grass", copies = 25 },
                { id = "t_grass_dead", copies = 25 },
            },
            S = "t_mushroom_patch",
            [" "] = "t_null",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mushroom_ring_chunk",
    weight = 500,
    layout = {
        size = { width = 15, height = 15 },
        rows = {
            "      S,S      ",
            "    S,,,,,S    ",
            "  S,,,,,,,,,S  ",
            "  ,,,,,,,,,,,  ",
            " S,,,,,,,,,,,S ",
            " ,,,,,,,,,,,,, ",
            "S,,,,,,,,,,,,,S",
            ",,,,,,,,,,,,,,,",
            "S,,,,,,,,,,,,,S",
            " ,,,,,,,,,,,,, ",
            " S,,,,,,,,,,,S ",
            "  ,,,,,,,,,,,  ",
            "  S,,,,,,,,,S  ",
            "    S,,,,,S    ",
            "      S,S      ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain = {
            [","] = {
                { id = "t_moss", copies = 50 },
                { id = "t_grass", copies = 25 },
                { id = "t_grass_dead", copies = 25 },
            },
            S = "t_mushroom_patch",
            [" "] = "t_null",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mushroom_ring_chunk",
    weight = 200,
    layout = {
        size = { width = 15, height = 15 },
        rows = {
            "      S,S      ",
            "    S,,,,,S    ",
            "  S,,,,,,,,,S  ",
            "  ,,,,,,,,,,,  ",
            " S,,,,,,,,,,,S ",
            " ,,,,,,,,,,,,, ",
            "S,,,,,,,,,,,,,S",
            ",,,,,,,,,,,,,,,",
            "S,,,,,,,,,,,,,S",
            " ,,,,,,,,,,,,, ",
            " S,,,,,,,,,,,S ",
            "  ,,,,,,,,,,,  ",
            "  S,,,,,,,,,S  ",
            "    S,,,,,S    ",
            "      S,S      ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_placements = {
            {
                group = "GROUP_CHANGELING_STRIKE_FORCE",
                x = { 0, 14 },
                y = { 0, 14 },
                chance = 75,
                repetitions = { 7, 15 },
            },
        },
        terrain = {
            [","] = {
                { id = "t_moss", copies = 50 },
                { id = "t_grass", copies = 25 },
                { id = "t_grass_dead", copies = 25 },
            },
            S = "t_mushroom_patch",
            [" "] = "t_null",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "dreamwound_shadow",
    layout = {
        size = { width = 6, height = 6 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        field_placements = {
            {
                id = "fd_dream_wound_shadow",
                x = { 2, 4 },
                y = { 2, 4 },
                intensity = { 1, 3 },
                repetitions = 15,
            },
            { id = "fd_gibs_flesh", x = { 0, 6 }, y = { 0, 6 }, intensity = { 0, 3 } },
        },
        monster_group_placements = { { group = "GROUP_DREAM_WOUND_SHADOW", x = { 0, 6 }, y = { 0, 6 }, density = 0.3 } },
        monster_placements = { { id = "mon_dream_shadowman", x = { 0, 6 }, y = { 0, 6 } } },
        terrain = { [" "] = "t_region_groundcover" },
        furniture = { [" "] = "f_rubble_rock" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "dreamwound_shadow_from_dreams",
    layout = {
        size = { width = 6, height = 6 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        field_placements = {
            {
                id = "fd_dream_wound_shadow",
                x = { 2, 4 },
                y = { 2, 4 },
                intensity = { 1, 3 },
                repetitions = 15,
            },
            { id = "fd_gibs_flesh", x = { 0, 6 }, y = { 0, 6 }, intensity = { 0, 3 } },
        },
        monster_group_placements = { { group = "GROUP_DREAM_WOUND_SHADOW", x = { 0, 6 }, y = { 0, 6 }, density = 0.3 } },
        monster_placements = {
            {
                id = "mon_dream_shadowman",
                name = ccb.content.text("Crowing Shadowman"),
                x = { 0, 6 },
                y = { 0, 6 },
                target = true,
            },
        },
        terrain = { [" "] = "t_region_groundcover" },
        furniture = { [" "] = "f_rubble_rock" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_dreamwound_shadow",
    layout = {
        nested = { { x = { 2, 17 }, y = { 2, 17 }, id = "dreamwound_shadow" } },
        monster_group_glyphs = { [" "] = { group = "GROUP_DREAM_WOUND_SHADOW", chance = 1, density = 0.0001 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_ozma_statue",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { x = { 2, 8 }, y = { 2, 8 }, id = "poppy_ring_chunk" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "poppy_ring_chunk",
    weight = 1000,
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " S,S ",
            "S,,,S",
            ",,@,,",
            "S,,,S",
            " S,S ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain = {
            [","] = {
                { id = "t_moss", copies = 50 },
                { id = "t_grass", copies = 25 },
                { id = "t_grass_dead", copies = 25 },
            },
            [" "] = "t_null",
        },
        furniture = { S = "f_ozma_poppy", ["@"] = "f_statue_fae_ozymandius" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "poppy_ring_chunk",
    weight = 600,
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " S,S ",
            "S,,,S",
            ",,@,,",
            "S,,,S",
            " S,S ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_placements = {
            {
                group = "GROUP_CHANGELING_STRIKE_FORCE",
                x = { 0, 4 },
                y = { 0, 4 },
                chance = 75,
                repetitions = { 3, 5 },
            },
        },
        terrain = {
            [","] = {
                { id = "t_moss", copies = 50 },
                { id = "t_grass", copies = 25 },
                { id = "t_grass_dead", copies = 25 },
            },
            [" "] = "t_null",
        },
        furniture = { S = "f_ozma_poppy", ["@"] = "f_statue_fae_ozymandius" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "poppy_ring_chunk",
    weight = 500,
    layout = {
        size = { width = 15, height = 15 },
        rows = {
            "      S,S      ",
            "    S,,,,,S    ",
            "  S,,,,,,,,,S  ",
            "  ,,,,,,,,,,,  ",
            " S,,,,,,,,,,,S ",
            " ,,,,,,,,,,,,, ",
            "S,,,,,,,,,,,,,S",
            ",,,,,,,@,,,,,,,",
            "S,,,,,,,,,,,,,S",
            " ,,,,,,,,,,,,, ",
            " S,,,,,,,,,,,S ",
            "  ,,,,,,,,,,,  ",
            "  S,,,,,,,,,S  ",
            "    S,,,,,S    ",
            "      S,S      ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain = {
            [","] = {
                { id = "t_moss", copies = 50 },
                { id = "t_grass", copies = 25 },
                { id = "t_grass_dead", copies = 25 },
            },
            [" "] = "t_null",
        },
        furniture = { S = "f_ozma_poppy", ["@"] = "f_statue_fae_ozymandius" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "poppy_ring_chunk",
    weight = 200,
    layout = {
        size = { width = 15, height = 15 },
        rows = {
            "      S,S      ",
            "    S,,,,,S    ",
            "  S,,,,,,,,,S  ",
            "  ,,,,,,,,,,,  ",
            " S,,,,,,,,,,,S ",
            " ,,,,,,,,,,,,, ",
            "S,,,,,,,,,,,,,S",
            ",,,,,,,@,,,,,,,",
            "S,,,,,,,,,,,,,S",
            " ,,,,,,,,,,,,, ",
            " S,,,,,,,,,,,S ",
            "  ,,,,,,,,,,,  ",
            "  S,,,,,,,,,S  ",
            "    S,,,,,S    ",
            "      S,S      ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_placements = {
            {
                group = "GROUP_CHANGELING_STRIKE_FORCE",
                x = { 0, 14 },
                y = { 0, 14 },
                chance = 75,
                repetitions = { 7, 15 },
            },
        },
        terrain = {
            [","] = {
                { id = "t_moss", copies = 50 },
                { id = "t_grass", copies = 25 },
                { id = "t_grass_dead", copies = 25 },
            },
            [" "] = "t_null",
        },
        furniture = { S = "f_ozma_poppy", ["@"] = "f_statue_fae_ozymandius" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_XE_XEDRA_mutagen_transport",
    layout = {
        vehicle_placements = { { id = "armored_car_xedra_tcl", x = 7, y = 15, chance = 100, status = 1, rotation = 0 } },
        monster_placements = {
            { id = "mon_zombie_scientist", x = 5, y = 17 },
            { id = "mon_zombie_labsecurity", x = 3, y = 15 },
            { id = "mon_zombie_labsecurity", x = 4, y = 15 },
            { id = "mon_zombie_labsecurity", x = 7, y = 13 },
            { id = "mon_zombie_labsecurity", x = { 10, 15 }, y = { 3, 13 } },
        },
        loot_placements = {
            {
                id = "9mm_casing",
                x = { 6, 8 },
                y = { 12, 13 },
                repetitions = { 4, 9 },
                chance = 100,
            },
            {
                id = "9mm_casing",
                x = { 10, 13 },
                y = { 3, 13 },
                repetitions = { 8, 22 },
                chance = 100,
            },
        },
        field_placements = {
            { id = "fd_blood", x = { 6, 8 }, y = { 12, 13 }, repetitions = { 3, 6 } },
            { id = "fd_blood", x = { 12, 15 }, y = { 2, 4 }, repetitions = { 5, 10 } },
        },
    },
}
