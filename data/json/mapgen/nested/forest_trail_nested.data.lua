local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_trail",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            ".",
        },
        palettes = { "trail_palette" },
        rotation = { 0 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_trail_clear",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "*",
        },
        palettes = { "trail_palette" },
        rotation = { 0 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_predecessor_groundcover",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
        nested = {
            {
                id = "1x1_t_region_groundcover_forest",
                x = 0,
                y = 0,
                predecessors = { "forest", "forest_thick" },
            },
            {
                id = "1x1_t_region_groundcover_swamp",
                x = 0,
                y = 0,
                predecessors = { "forest_water" },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_predecessor_shrub",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
        nested = {
            { id = "1x1_t_region_shrub_forest", x = 0, y = 0, predecessors = { "forest" } },
            {
                id = "1x1_t_region_shrub_forest_dense",
                x = 0,
                y = 0,
                predecessors = { "forest_thick" },
            },
            { id = "1x1_t_region_shrub_swamp", x = 0, y = 0, predecessors = { "forest_water" } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_predecessor_tree",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
        nested = {
            {
                id = "1x1_t_region_tree_forest",
                x = 0,
                y = 0,
                predecessors = { "forest", "forest_water" },
            },
            {
                id = "1x1_t_region_tree_forest_dense",
                x = 0,
                y = 0,
                predecessors = { "forest_thick" },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_t_region_groundcover_forest",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            ".",
        },
        terrain = { ["."] = "t_region_groundcover_forest" },
        rotation = { 0 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_t_region_groundcover_swamp",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            ".",
        },
        terrain = { ["."] = "t_region_groundcover_swamp" },
        rotation = { 0 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_t_region_shrub_forest",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            ".",
        },
        terrain = { ["."] = "t_region_shrub_forest" },
        rotation = { 0 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_t_region_shrub_forest_dense",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            ".",
        },
        terrain = { ["."] = "t_region_shrub_forest_dense" },
        rotation = { 0 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_t_region_shrub_swamp",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            ".",
        },
        terrain = { ["."] = "t_region_shrub_swamp" },
        rotation = { 0 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_t_region_shrub_swamp",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            ".",
        },
        terrain = { ["."] = "t_region_shrub_swamp" },
        rotation = { 0 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_t_region_tree_forest",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            ".",
        },
        terrain = { ["."] = "t_region_tree_forest" },
        rotation = { 0 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_t_region_tree_forest_dense",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            ".",
        },
        terrain = { ["."] = "t_region_tree_forest_dense" },
        rotation = { 0 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_t_railroad_rubble",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            ".",
        },
        terrain = { ["."] = "t_railroad_rubble" },
        rotation = { 0 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_t_dirt",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            ".",
        },
        terrain = { ["."] = "t_dirt" },
        rotation = { 0 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_t_mud",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            ".",
        },
        terrain = { ["."] = "t_mud" },
        rotation = { 0 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_forest_trail_intersection",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "         4444444        ",
            "       44333333344      ",
            "      4332222222334     ",
            "     432211111112234    ",
            "    43211000000011234   ",
            "    43210000000001234   ",
            "   4321000000000001234  ",
            "   4321000000000001234  ",
            "   4321000000000001234  ",
            "   4321000000000001234  ",
            "   4321000000000001234  ",
            "   4321000000000001234  ",
            "   4321000000000001234  ",
            "    43210000000001234   ",
            "    43211000000011234   ",
            "     432211111112234    ",
            "      4332222222334     ",
            "       44333333344      ",
            "         4444444        ",
            "                        ",
            "                        ",
        },
        palettes = { "trail_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                id = "9x9_forest_trail_intersection_north",
                x = 8,
                y = 0,
                neighbors = { north = "trail" },
            },
            {
                id = "9x9_forest_trail_intersection_east",
                x = 18,
                y = 8,
                neighbors = { east = "trail" },
            },
            {
                id = "9x9_forest_trail_intersection_south",
                x = 8,
                y = 18,
                neighbors = { south = "trail" },
            },
            {
                id = "9x9_forest_trail_intersection_west",
                x = 0,
                y = 8,
                neighbors = { west = "trail" },
            },
            {
                id = "11x11_forest_trail_intersection_south_fire_lookout",
                x = 0,
                y = 13,
                neighbors = { south = "ws_fire_lookout_tower_base" },
            },
            {
                choices = { { id = "null", weight = 25 }, { id = "3x3_horseposts", weight = 75 } },
                x = 8,
                y = 8,
            },
            {
                choices = {
                    { id = "null", weight = 25 },
                    { id = "3x3_firering", weight = 25 },
                    { id = "3x3_stumps", weight = 50 },
                },
                x = { 12, 13 },
                y = { 12, 13 },
            },
            {
                choices = { { id = "null", weight = 50 }, { id = "3x3_tree_benches", weight = 50 } },
                x = 17,
                y = 8,
            },
            {
                choices = { { id = "null", weight = 75 }, { id = "3x3_shed_trail_supplies_N", weight = 25 } },
                x = 17,
                y = 17,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "9x9_forest_trail_intersection_north",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "432101234",
            "432101234",
            "432101234",
            "432101234",
            "432101234",
            "  21012  ",
            "  10001  ",
            "         ",
            "         ",
        },
        palettes = { "trail_palette" },
        rotation = { 0, 3 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "9x9_forest_trail_intersection_east",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "   444   ",
            "   333   ",
            "012222   ",
            "001111   ",
            "000000   ",
            "001111   ",
            "012222   ",
            "   333   ",
            "   444   ",
        },
        palettes = { "trail_palette" },
        rotation = { 0, 3 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "9x9_forest_trail_intersection_south",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "  00000  ",
            "  10001  ",
            "  21012  ",
            "432101234",
            "432101234",
            "432101234",
            "         ",
            "         ",
            "         ",
        },
        palettes = { "trail_palette" },
        rotation = { 0, 3 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "9x9_forest_trail_intersection_west",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "4444     ",
            "3333     ",
            "2222210  ",
            "1111100  ",
            "0000000  ",
            "1111100  ",
            "2222210  ",
            "3333     ",
            "4444     ",
        },
        palettes = { "trail_palette" },
        rotation = { 0, 3 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}
