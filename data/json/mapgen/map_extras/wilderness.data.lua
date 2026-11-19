local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_grass_map",
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
        palettes = { "long_grass_meadow_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_grass2_map",
    layout = {
        nested = {
            {
                choices = { { id = "mx_grass_nested", weight = 100 } },
                x = { 0, 16 },
                y = { 0, 16 },
                repetitions = { 1, 6 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_grass_nested",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            " .... ",
            ".,,,,.",
            ".,|;,.",
            ".,;|,.",
            ".,,,,.",
            " .... ",
        },
        palettes = { "long_grass_meadow_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_grass_nested",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            " ...... ",
            "..,,,,..",
            ".,,|;,,.",
            ".,;||;,.",
            ".,;|;;,.",
            ".,,;|,,.",
            "..,,,,..",
            " ...... ",
        },
        palettes = { "long_grass_meadow_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_knotweed_patch",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "        ;;;|;;;;        ",
            "       ;;;;|||;;        ",
            "      ;;||;||;;;;       ",
            "     ;;;;;||;||;;       ",
            "      ;|||||;|;;;       ",
            "       ;;;;|;||;        ",
            "       ;;|||||;;        ",
            "      ;;|;||;||;;       ",
            "        ;;||;;;;        ",
            "        ;;;;|;;         ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        terrain = {
            [";"] = { { id = "t_region_groundcover" }, { id = "t_grass_long", copies = 2 } },
            ["|"] = { { id = "t_region_groundcover" }, { id = "t_grass_tall", copies = 3 } },
        },
        furniture = { ["|"] = { { id = "f_japanese_knotweed", copies = 10 }, { id = "f_null" } } },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_blackberry_patch",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "        ;;;|;;;;        ",
            "       ;;;;|||;;        ",
            "      ;;||;||;;;;       ",
            "     ;;;;;||;||;;       ",
            "      ;|||||;|;;;       ",
            "       ;;;;|;||;        ",
            "       ;;|||||;;        ",
            "      ;;|;||;||;;       ",
            "        ;;||;;;;        ",
            "        ;;;;|;;         ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        terrain = {
            [";"] = { { id = "t_region_groundcover" }, { id = "t_grass_long", copies = 2 } },
            ["|"] = {
                { id = "t_region_groundcover" },
                { id = "t_shrub_blackberry", copies = 10 },
                { id = "t_region_tree", copies = 3 },
            },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_strawberry_patch",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "        ;;;|;;;;        ",
            "       ;;;;|||;;        ",
            "      ;;||;||;;;;       ",
            "     ;;;;;||;||;;       ",
            "      ;|||||;|;;;       ",
            "       ;;;;|;||;        ",
            "       ;;|||||;;        ",
            "      ;;|;||;||;;       ",
            "        ;;||;;;;        ",
            "        ;;;;|;;         ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        terrain = {
            [";"] = { { id = "t_region_groundcover" }, { id = "t_grass_long", copies = 2 } },
            ["|"] = {
                { id = "t_region_groundcover" },
                { id = "t_shrub_strawberry", copies = 10 },
                { id = "t_region_tree", copies = 3 },
            },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_blueberry_patch",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "        ;;;|;;;;        ",
            "       ;;;;|||;;        ",
            "      ;;||;||;;;;       ",
            "     ;;;;;||;||;;       ",
            "      ;|||||;|;;;       ",
            "       ;;;;|;||;        ",
            "       ;;|||||;;        ",
            "      ;;|;||;||;;       ",
            "        ;;||;;;;        ",
            "        ;;;;|;;         ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        terrain = {
            [";"] = { { id = "t_region_groundcover" }, { id = "t_grass_long", copies = 2 } },
            ["|"] = {
                { id = "t_region_groundcover" },
                { id = "t_shrub_blueberry", copies = 10 },
                { id = "t_region_tree", copies = 3 },
            },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_raspberry_patch",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "        ;;;|;;;;        ",
            "       ;;;;|||;;        ",
            "      ;;||;||;;;;       ",
            "     ;;;;;||;||;;       ",
            "      ;|||||;|;;;       ",
            "       ;;;;|;||;        ",
            "       ;;|||||;;        ",
            "      ;;|;||;||;;       ",
            "        ;;||;;;;        ",
            "        ;;;;|;;         ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        terrain = {
            [";"] = { { id = "t_region_groundcover" }, { id = "t_grass_long", copies = 2 } },
            ["|"] = {
                { id = "t_region_groundcover" },
                { id = "t_shrub_raspberry", copies = 10 },
                { id = "t_region_tree", copies = 3 },
            },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_huckleberry_patch",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "        ;;;|;;;;        ",
            "       ;;;;|||;;        ",
            "      ;;||;||;;;;       ",
            "     ;;;;;||;||;;       ",
            "      ;|||||;|;;;       ",
            "       ;;;;|;||;        ",
            "       ;;|||||;;        ",
            "      ;;|;||;||;;       ",
            "        ;;||;;;;        ",
            "        ;;;;|;;         ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        terrain = {
            [";"] = { { id = "t_region_groundcover" }, { id = "t_grass_long", copies = 2 } },
            ["|"] = {
                { id = "t_region_groundcover" },
                { id = "t_shrub_huckleberry", copies = 10 },
                { id = "t_region_tree", copies = 3 },
            },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_hobblebush_patch",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "        ;;;|;;;;        ",
            "       ;;;;|||;;        ",
            "      ;;||;||;;;;       ",
            "     ;;;;;||;||;;       ",
            "      ;|||||;|;;;       ",
            "       ;;;;|;||;        ",
            "       ;;|||||;;        ",
            "      ;;|;||;||;;       ",
            "        ;;||;;;;        ",
            "        ;;;;|;;         ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        terrain = {
            [";"] = { { id = "t_region_groundcover" }, { id = "t_grass_long", copies = 2 } },
            ["|"] = {
                { id = "t_region_groundcover" },
                { id = "t_shrub_hobblebush", copies = 10 },
                { id = "t_region_tree", copies = 3 },
            },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_autumn_olive_patch",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "        ;;;|;;;;        ",
            "       ;;;;|||;;        ",
            "      ;;||;||;;;;       ",
            "     ;;;;;||;||;;       ",
            "      ;|||||;|;;;       ",
            "       ;;;;|;||;        ",
            "       ;;|||||;;        ",
            "      ;;|;||;||;;       ",
            "        ;;||;;;;        ",
            "        ;;;;|;;         ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        terrain = {
            [";"] = { { id = "t_region_groundcover" }, { id = "t_grass_long", copies = 2 } },
            ["|"] = {
                { id = "t_region_groundcover" },
                { id = "t_shrub_autumn_olive", copies = 10 },
                { id = "t_region_tree", copies = 3 },
            },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_trees_map",
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
        palettes = { "copse_trees_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_trees2_map",
    layout = {
        nested = {
            {
                choices = { { id = "mx_trees_nested", weight = 100 } },
                x = { 0, 16 },
                y = { 0, 16 },
                repetitions = { 1, 6 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_trees_nested",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            " .... ",
            ".,,,,.",
            ".,|;,.",
            ".,;|,.",
            ".,,,,.",
            " .... ",
        },
        palettes = { "copse_trees_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_trees_nested",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            " ...... ",
            "..,,,,..",
            ".,,|;,,.",
            ".,;||;,.",
            ".,;|;;,.",
            ".,,;|,,.",
            "..,,,,..",
            " ...... ",
        },
        palettes = { "copse_trees_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_fallen_shed_map",
    layout = {
        nested = {
            {
                choices = { { id = "mx_grass_nested", weight = 70 }, { id = "mx_trees_nested", weight = 30 } },
                x = { 0, 16 },
                y = { 0, 16 },
                repetitions = { 2, 6 },
            },
            {
                choices = { { id = "mx_fallen_shed_nested", weight = 100 } },
                x = { 0, 11 },
                y = { 0, 11 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "pond_water_furniture",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            " ",
        },
        furniture = {
            [" "] = {
                { id = "f_region_water_plant", copies = 10 },
                { id = "f_boulder_small" },
                { id = "f_boulder_medium" },
                { id = "f_boulder_large" },
                { id = "f_rubble_rock" },
            },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "pond_rocks",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            " ",
        },
        furniture = {
            [" "] = {
                { id = "f_boulder_small" },
                { id = "f_boulder_medium" },
                { id = "f_boulder_large" },
                { id = "f_rubble_rock" },
            },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- blueberry patch
ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_pond_forest_fruit_patch",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "dddd",
            "dddd",
            "cccc",
            "cccc",
        },
        terrain = {
            d = {
                { id = "t_dirt", copies = 1 },
                { id = "t_grass", copies = 1 },
                { id = "t_shrub_blueberry", copies = 1 },
            },
            c = {
                { id = "t_dirt", copies = 2 },
                { id = "t_grass", copies = 2 },
                { id = "t_shrub_blueberry", copies = 1 },
            },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- huckleberry patch
ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_pond_forest_fruit_patch",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "dddd",
            "dddd",
            "cccc",
            "cccc",
        },
        terrain = {
            d = {
                { id = "t_dirt", copies = 1 },
                { id = "t_grass", copies = 1 },
                { id = "t_shrub_huckleberry", copies = 1 },
            },
            c = {
                { id = "t_dirt", copies = 2 },
                { id = "t_grass", copies = 2 },
                { id = "t_shrub_huckleberry", copies = 1 },
            },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- nannyberry trees
ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_pond_forest_fruit_patch",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "dddd",
            "dddd",
            "cccc",
            "cccc",
        },
        terrain = {
            d = {
                { id = "t_dirt", copies = 1 },
                { id = "t_grass", copies = 1 },
                { id = "t_tree_nannyberry", copies = 1 },
            },
            c = {
                { id = "t_dirt", copies = 2 },
                { id = "t_grass", copies = 2 },
                { id = "t_tree_nannyberry", copies = 1 },
            },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "pond_dirt",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            " ",
        },
        terrain = { [" "] = "t_dirt" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "pond_grass",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            " ",
        },
        terrain = { [" "] = "t_grass" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "pond_shrub",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            " ",
        },
        terrain = { [" "] = "t_shrub" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "pond_underbrush",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            " ",
        },
        terrain = { [" "] = "t_underbrush" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "pond_tree",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            " ",
        },
        terrain = { [" "] = "t_tree" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "pond_tree_young",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            " ",
        },
        terrain = { [" "] = "t_tree_young" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "pond_tree_willow",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            " ",
        },
        terrain = { [" "] = "t_tree_willow" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_fallen_shed_nested",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "--++++--||-",
            "-_______RR|",
            "w_______RRw",
            "w________Rw",
            "|_________|",
            "||-_____|||",
            "|_________|",
            "w_________w",
            "w_________w",
            "-_________|",
            "--||||||-||",
        },
        palettes = { "desolatebarn_palette" },
        terrain = { _ = "t_dirt" },
        furniture = { _ = { { id = "f_null", copies = 30 }, { id = "f_rubble" }, { id = "f_rubble_rock" } } },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            _ = { group = "wood_workshop", chance = 1 },
            R = { { group = "wood_workshop", chance = 3 }, { group = "mischw", chance = 2 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_fallen_shed_nested",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "--w_-||-",
            "-______|",
            "|______+",
            "|R_____+",
            "|RR____|",
            "|_RRR__w",
            "-__RRR_w",
            "--w||-||",
        },
        palettes = { "desolatebarn_palette" },
        terrain = { _ = "t_dirt" },
        furniture = { _ = { { id = "f_null", copies = 30 }, { id = "f_rubble" }, { id = "f_rubble_rock" } } },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            _ = { group = "wood_workshop", chance = 1 },
            R = { { group = "wood_workshop", chance = 3 }, { group = "mischw", chance = 2 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_pond_forest",
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
        terrain = {
            ["*"] = "t_pond_water_sh",
            ["?"] = {
                { id = "t_pond_water_sh", copies = 3 },
                { id = "t_dirt", copies = 5 },
                { id = "t_grass", copies = 6 },
                { id = "t_shrub", copies = 2 },
                { id = "t_tree_young" },
                { id = "t_tree", copies = 2 },
                { id = "t_tree_willow" },
            },
            ["["] = { { id = "t_pond_water_dp", copies = 2 }, { id = "t_pond_water_sh", copies = 3 } },
            ["]"] = { { id = "t_pond_water_sh", copies = 8 }, { id = "t_dirt" }, { id = "t_grass" } },
            ["~"] = "t_pond_water_dp",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = { { id = "null", weight = 30 }, { id = "mx_pond_forest_fruit_patch", weight = 1 } },
                x = 2,
                y = 18,
            },
        },
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
                chance = 1,
                repetitions = { 1, 2 },
                density = 0.5,
            },
            { group = "GROUP_FOREST", x = { 0, 23 }, y = { 0, 23 }, chance = 5, density = 0.5 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_pond_forest_2",
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
        furniture = { ["~"] = "f_clear", ["*"] = "f_clear", ["["] = "f_clear", ["]"] = "f_clear" },
        terrain = {
            ["*"] = "t_pond_water_sh",
            ["?"] = {
                { id = "t_pond_water_sh", copies = 3 },
                { id = "t_dirt", copies = 5 },
                { id = "t_grass", copies = 6 },
                { id = "t_shrub", copies = 2 },
                { id = "t_tree_young" },
                { id = "t_tree", copies = 2 },
                { id = "t_tree_willow" },
            },
            ["["] = { { id = "t_pond_water_dp", copies = 2 }, { id = "t_pond_water_sh", copies = 3 } },
            ["]"] = { { id = "t_pond_water_sh", copies = 8 }, { id = "t_dirt" }, { id = "t_grass" } },
            ["~"] = "t_pond_water_dp",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = {
                    { id = "null", weight = 3000 },
                    { id = "mx_pond_forest_fruit_patch", weight = 1000 },
                    { id = "void_spider_webs", weight = 1 },
                },
                x = 16,
                y = 16,
            },
        },
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
                chance = 1,
                repetitions = { 1, 2 },
                density = 0.5,
            },
            { group = "GROUP_FOREST", x = { 0, 23 }, y = { 0, 23 }, chance = 5, density = 0.5 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_worm_sign",
    layout = {
        rows = {
            "        .........       ",
            "     ...............    ",
            "   ...................  ",
            "  ....................  ",
            "  ..................... ",
            " ...................... ",
            " ...................... ",
            "........................",
            "........................",
            "........................",
            "...........x............",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            "........................",
            " ...................... ",
            " ...................... ",
            " ...................... ",
            "  ....................  ",
            "  ....................  ",
            "    ................    ",
            "       ..........       ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["."] = { choices = { { id = "null", weight = 20 }, { id = "1x1_upturn_earth", weight = 1 } } },
            x = { choices = { { id = "null", weight = 20 }, { id = "1x1_upturn_earth", weight = 1 } } },
        },
        monster_group_glyphs = {
            ["."] = { group = "GROUP_WORM", chance = 2, density = 0.0001 },
            x = { group = "GROUP_WORM", chance = 100, density = 0.0001 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_upturn_earth",
    layout = {
        size = { width = 1, height = 1 },
        transform_placements = { { id = "upturn_earth", x = 0, y = 0 } },
    },
}
