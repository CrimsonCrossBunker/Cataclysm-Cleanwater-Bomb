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
