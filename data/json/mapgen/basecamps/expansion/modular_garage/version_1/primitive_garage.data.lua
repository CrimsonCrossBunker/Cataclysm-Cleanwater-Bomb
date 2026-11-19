local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmg_0",
    layout = {
        size = { width = 6, height = 6 },
        palettes = { "acidia_camp_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_garage_0",
    layout = {
        nested = { { id = "fbmg_0", x = 10, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_garage_0",
    layout = {
        size = { width = 17, height = 17 },
        rows = {
            "_____            ",
            "_________________",
            "_________________",
            "_________________",
            "____UU___________",
            "____U____________",
            "_________________",
            "    _____________",
            "    _____________",
            "    _____________",
            "    U____________",
            "    UU___________",
            "    _____________",
            "    _____________",
            "    _____________",
            "                 ",
            "                 ",
        },
        palettes = { "acidia_camp_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_ITEMS", "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_garage_1",
    layout = {
        size = { width = 17, height = 17 },
        rows = {
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "    ***          ",
            "    *r'          ",
            "    *r'          ",
            "    *c'          ",
            "    *c'          ",
            "    *''          ",
            "    *''          ",
            "    ***          ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
        },
        palettes = { "acidia_camp_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_ITEMS", "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_garage_1_roof",
    layout = {
        size = { width = 17, height = 17 },
        rows = {
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "    sss          ",
            "    sss          ",
            "    sss          ",
            "    sss          ",
            "    sss          ",
            "    sss          ",
            "    sss          ",
            "    sss          ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
        },
        palettes = { "acidia_camp_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_garage_2",
    layout = {
        size = { width = 17, height = 17 },
        rows = {
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "              ***",
            "              ''*",
            "              '''",
            "              ''*",
            "              ''*",
            "              '''",
            "              ''*",
            "              ***",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
        },
        palettes = { "acidia_camp_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_ITEMS", "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_garage_2_roof",
    layout = {
        size = { width = 17, height = 17 },
        rows = {
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "              sss",
            "              sss",
            "              sss",
            "              sss",
            "              sss",
            "              sss",
            "              sss",
            "              sss",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
        },
        palettes = { "acidia_camp_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_garage_3",
    layout = {
        size = { width = 17, height = 17 },
        rows = {
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "       '''''''   ",
            "       '''''''   ",
            "       '''''''   ",
            "       '''''''   ",
            "       '''''''   ",
            "       '''''''   ",
            "       '''''''   ",
            "       '''''''   ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
        },
        palettes = { "acidia_camp_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_ITEMS", "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_garage_3_roof",
    layout = {
        size = { width = 17, height = 17 },
        rows = {
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "       sssssss   ",
            "       sssssss   ",
            "       sssssss   ",
            "       sssssss   ",
            "       sssssss   ",
            "       sssssss   ",
            "       sssssss   ",
            "       sssssss   ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
        },
        palettes = { "acidia_camp_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_garage_4",
    layout = {
        size = { width = 17, height = 17 },
        rows = {
            "                 ",
            "    ***       ***",
            "    *           *",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "                '",
            "                '",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "    *           *",
            "    ***       ***",
            "                 ",
            "                 ",
        },
        palettes = { "acidia_camp_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_ITEMS", "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_garage_4_roof",
    layout = {
        size = { width = 17, height = 17 },
        rows = {
            "                 ",
            "    sss       sss",
            "    s           s",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "                s",
            "                s",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "    s           s",
            "    sss       sss",
            "                 ",
            "                 ",
        },
        palettes = { "acidia_camp_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_garage_5",
    layout = {
        size = { width = 17, height = 17 },
        rows = {
            "                 ",
            "       '''''''   ",
            "     ''''''''''3 ",
            "    '''''''''''''",
            "     ''       '''",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "     r           ",
            "     r           ",
            "     ''       '''",
            "    '''''''''''''",
            "     ''''''''''' ",
            "       '''''''   ",
            "                 ",
            "                 ",
        },
        palettes = { "acidia_camp_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_ITEMS", "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_garage_5_roof",
    layout = {
        size = { width = 17, height = 17 },
        rows = {
            "                 ",
            "       sssssss   ",
            "     sssssssssss ",
            "    sssssssssssss",
            "     ss       sss",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "     s           ",
            "     s           ",
            "     ss       sss",
            "    sssssssssssss",
            "     sssssssssss ",
            "       sssssss   ",
            "                 ",
            "                 ",
        },
        palettes = { "acidia_camp_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_garage_6",
    layout = {
        size = { width = 17, height = 17 },
        rows = {
            "*****            ",
            "*'bb             ",
            "*'''             ",
            "*'''+            ",
            "*(('             ",
            "*ttr             ",
            "****             ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
        },
        palettes = { "acidia_camp_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_ITEMS", "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bc_prim_garage_6_roof",
    layout = {
        size = { width = 17, height = 17 },
        rows = {
            "sssss            ",
            "ssss             ",
            "ssss             ",
            "sssss            ",
            "ssss             ",
            "ssss             ",
            "ssss             ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
            "                 ",
        },
        palettes = { "acidia_camp_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmg_1",
    layout = {
        nested = { { id = "bc_prim_garage_0", x = 2, y = 6 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_field_camp_garage_1",
    layout = {
        nested = {
            { id = "bc_prim_garage_1", x = 2, y = 6, z = 0 },
            { id = "bc_prim_garage_1_roof", x = 2, y = 6, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_field_camp_garage_2",
    layout = {
        nested = {
            { id = "bc_prim_garage_2", x = 2, y = 6, z = 0 },
            { id = "bc_prim_garage_2_roof", x = 2, y = 6, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_field_camp_garage_3",
    layout = {
        nested = {
            { id = "bc_prim_garage_3", x = 2, y = 6, z = 0 },
            { id = "bc_prim_garage_3_roof", x = 2, y = 6, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_field_camp_garage_4",
    layout = {
        nested = {
            { id = "bc_prim_garage_4", x = 2, y = 6, z = 0 },
            { id = "bc_prim_garage_4_roof", x = 2, y = 6, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_field_camp_garage_5",
    layout = {
        nested = {
            { id = "bc_prim_garage_5", x = 2, y = 6, z = 0 },
            { id = "bc_prim_garage_5_roof", x = 2, y = 6, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_field_camp_garage_6",
    layout = {
        nested = {
            { id = "bc_prim_garage_6", x = 2, y = 6, z = 0 },
            { id = "bc_prim_garage_6_roof", x = 2, y = 6, z = 1 },
        },
    },
}
