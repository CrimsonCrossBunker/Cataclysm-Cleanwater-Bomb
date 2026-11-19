local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "desolate_shingle_roof_chunk",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            ".",
        },
        terrain = {
            ["."] = { { id = "t_shingle_flat_roof", copies = 90 }, { id = "t_open_air", copies = 10 } },
        },
    },
}

-- a tent and firepit
ccb.content.define_mapgen {
    kind = "nested",
    id = "small_camp_8x8_tent_roof",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "  RRR   ",
            "  RRR   ",
            "  RRR   ",
            "        ",
            "        ",
            "        ",
            "        ",
            "        ",
        },
        terrain = { R = "t_canvas_roof" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "tent_3x3_roof",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "###",
            "###",
            "###",
        },
        terrain = { ["#"] = "t_canvas_roof" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "tent_3x3_S",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "###",
            "#x#",
            "#+#",
        },
        furniture = { ["#"] = "f_canvas_wall", x = "f_groundsheet", ["+"] = "f_canvas_door" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "tent_3x3_roof", x = 0, y = 0, z = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "tent_3x3_E",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "###",
            "#x+",
            "###",
        },
        furniture = { ["#"] = "f_canvas_wall", x = "f_groundsheet", ["+"] = "f_canvas_door" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "tent_3x3_roof", x = 0, y = 0, z = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "tent_3x3_N",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "#+#",
            "#x#",
            "###",
        },
        furniture = { ["#"] = "f_canvas_wall", x = "f_groundsheet", ["+"] = "f_canvas_door" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "tent_3x3_roof", x = 0, y = 0, z = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "tent_3x3_W",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "###",
            "+x#",
            "###",
        },
        furniture = { ["#"] = "f_canvas_wall", x = "f_groundsheet", ["+"] = "f_canvas_door" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "tent_3x3_roof", x = 0, y = 0, z = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "tent_5x5_roof",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "#####",
            "#####",
            "#####",
            "#####",
            "#####",
        },
        terrain = { ["#"] = "t_canvas_roof" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "tent_5x5_S",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "#####",
            "#xxx#",
            "#xXx#",
            "#xxx#",
            "##+##",
        },
        furniture = {
            ["#"] = "f_large_canvas_wall",
            X = "f_center_groundsheet",
            x = "f_large_groundsheet",
            ["+"] = "f_large_canvas_door",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "tent_5x5_roof", x = 0, y = 0, z = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "tent_5x5_E",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "#####",
            "#xxx#",
            "#xXx+",
            "#xxx#",
            "#####",
        },
        furniture = {
            ["#"] = "f_large_canvas_wall",
            X = "f_center_groundsheet",
            x = "f_large_groundsheet",
            ["+"] = "f_large_canvas_door",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "tent_5x5_roof", x = 0, y = 0, z = 1 } },
    },
}

-- Canvas roof since we don't have a skin/leather one
ccb.content.define_mapgen {
    kind = "nested",
    id = "leather_tent_5x5_S",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "#####",
            "#xxx#",
            "#xXx#",
            "#xxx#",
            "##+##",
        },
        furniture = {
            ["#"] = "f_large_skin_wall",
            X = "f_skin_center_groundsheet",
            x = "f_large_skin_groundsheet",
            ["+"] = "f_large_skin_door",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "tent_5x5_roof", x = 0, y = 0, z = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "tent_5x5_N",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "##+##",
            "#xxx#",
            "#xXx#",
            "#xxx#",
            "#####",
        },
        furniture = {
            ["#"] = "f_large_canvas_wall",
            X = "f_center_groundsheet",
            x = "f_large_groundsheet",
            ["+"] = "f_large_canvas_door",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "tent_5x5_roof", x = 0, y = 0, z = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "tent_5x5_W",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "#####",
            "#xxx#",
            "+xXx#",
            "#xxx#",
            "#####",
        },
        furniture = {
            ["#"] = "f_large_canvas_wall",
            X = "f_center_groundsheet",
            x = "f_large_groundsheet",
            ["+"] = "f_large_canvas_door",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "tent_5x5_roof", x = 0, y = 0, z = 1 } },
    },
}

-- No roof due to the ruined state. Could make chunks to sync roof and wall/floor, but too insignificant to bother
ccb.content.define_mapgen {
    kind = "nested",
    id = "tent_b_3x3_S",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "###",
            "#x#",
            "#+#",
        },
        furniture = {
            ["#"] = { { id = "f_large_canvas_wall", copies = 5 }, { id = "f_null" } },
            X = { { id = "f_center_groundsheet", copies = 5 }, { id = "f_null" } },
            x = { { id = "f_large_groundsheet", copies = 5 }, { id = "f_null" } },
            ["+"] = { { id = "f_large_canvas_door", copies = 5 }, { id = "f_null" } },
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- No roof due to the ruined state. Could make chunks to sync roof and wall/floor, but too insignificant to bother
ccb.content.define_mapgen {
    kind = "nested",
    id = "tent_b_3x3_E",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "###",
            "#x+",
            "###",
        },
        furniture = {
            ["#"] = { { id = "f_large_canvas_wall", copies = 5 }, { id = "f_null" } },
            X = { { id = "f_center_groundsheet", copies = 5 }, { id = "f_null" } },
            x = { { id = "f_large_groundsheet", copies = 5 }, { id = "f_null" } },
            ["+"] = { { id = "f_large_canvas_door", copies = 5 }, { id = "f_null" } },
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- No roof due to the ruined state. Could make chunks to sync roof and wall/floor, but too insignificant to bother
ccb.content.define_mapgen {
    kind = "nested",
    id = "tent_b_3x3_N",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "#+#",
            "#x#",
            "###",
        },
        furniture = {
            ["#"] = { { id = "f_large_canvas_wall", copies = 5 }, { id = "f_null" } },
            X = { { id = "f_center_groundsheet", copies = 5 }, { id = "f_null" } },
            x = { { id = "f_large_groundsheet", copies = 5 }, { id = "f_null" } },
            ["+"] = { { id = "f_large_canvas_door", copies = 5 }, { id = "f_null" } },
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- No roof due to the ruined state. Could make chunks to sync roof and wall/floor, but too insignificant to bother
ccb.content.define_mapgen {
    kind = "nested",
    id = "tent_b_3x3_W",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "###",
            "+x#",
            "###",
        },
        furniture = {
            ["#"] = { { id = "f_large_canvas_wall", copies = 5 }, { id = "f_null" } },
            X = { { id = "f_center_groundsheet", copies = 5 }, { id = "f_null" } },
            x = { { id = "f_large_groundsheet", copies = 5 }, { id = "f_null" } },
            ["+"] = { { id = "f_large_canvas_door", copies = 5 }, { id = "f_null" } },
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- No roof due to the ruined state. Could make chunks to sync roof and wall/floor, but too insignificant to bother
ccb.content.define_mapgen {
    kind = "nested",
    id = "tent_b_5x5_S",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "#####",
            "#xxx#",
            "#xXx#",
            "#xxx#",
            "##+##",
        },
        furniture = {
            ["#"] = { { id = "f_large_canvas_wall", copies = 5 }, { id = "f_null" } },
            X = { { id = "f_center_groundsheet", copies = 5 }, { id = "f_null" } },
            x = { { id = "f_large_groundsheet", copies = 5 }, { id = "f_null" } },
            ["+"] = { { id = "f_large_canvas_door", copies = 5 }, { id = "f_null" } },
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- No roof due to the ruined state. Could make chunks to sync roof and wall/floor, but too insignificant to bother
ccb.content.define_mapgen {
    kind = "nested",
    id = "tent_b_5x5_E",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "#####",
            "#xxx#",
            "#xXx+",
            "#xxx#",
            "#####",
        },
        furniture = {
            ["#"] = { { id = "f_large_canvas_wall", copies = 5 }, { id = "f_null" } },
            X = { { id = "f_center_groundsheet", copies = 5 }, { id = "f_null" } },
            x = { { id = "f_large_groundsheet", copies = 5 }, { id = "f_null" } },
            ["+"] = { { id = "f_large_canvas_door", copies = 5 }, { id = "f_null" } },
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- No roof due to the ruined state. Could make chunks to sync roof and wall/floor, but too insignificant to bother
ccb.content.define_mapgen {
    kind = "nested",
    id = "tent_b_5x5_N",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "##+##",
            "#xxx#",
            "#xXx#",
            "#xxx#",
            "#####",
        },
        furniture = {
            ["#"] = { { id = "f_large_canvas_wall", copies = 5 }, { id = "f_null" } },
            X = { { id = "f_center_groundsheet", copies = 5 }, { id = "f_null" } },
            x = { { id = "f_large_groundsheet", copies = 5 }, { id = "f_null" } },
            ["+"] = { { id = "f_large_canvas_door", copies = 5 }, { id = "f_null" } },
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- No roof due to the ruined state. Could make chunks to sync roof and wall/floor, but too insignificant to bother
ccb.content.define_mapgen {
    kind = "nested",
    id = "tent_b_5x5_W",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "#####",
            "#xxx#",
            "+xXx#",
            "#xxx#",
            "#####",
        },
        furniture = {
            ["#"] = { { id = "f_large_canvas_wall", copies = 5 }, { id = "f_null" } },
            X = { { id = "f_center_groundsheet", copies = 5 }, { id = "f_null" } },
            x = { { id = "f_large_groundsheet", copies = 5 }, { id = "f_null" } },
            ["+"] = { { id = "f_large_canvas_door", copies = 5 }, { id = "f_null" } },
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- No roof due to the ruined state.
ccb.content.define_mapgen {
    kind = "nested",
    id = "leather_tent_b_5x5_S",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "#####",
            "#xxx#",
            "#xXx#",
            "#xxx#",
            "##+##",
        },
        furniture = {
            ["#"] = { { id = "f_large_skin_wall", copies = 5 }, { id = "f_null" } },
            X = { { id = "f_skin_center_groundsheet", copies = 5 }, { id = "f_null" } },
            x = { { id = "f_large_skin_groundsheet", copies = 5 }, { id = "f_null" } },
            ["+"] = { { id = "f_large_skin_door", copies = 5 }, { id = "f_null" } },
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- No roof due to the ruined state.
ccb.content.define_mapgen {
    kind = "nested",
    id = "leather_tent_b_5x5_N",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "##+##",
            "#xxx#",
            "#xXx#",
            "#xxx#",
            "#####",
        },
        furniture = {
            ["#"] = { { id = "f_large_skin_wall", copies = 5 }, { id = "f_null" } },
            X = { { id = "f_skin_center_groundsheet", copies = 5 }, { id = "f_null" } },
            x = { { id = "f_large_skin_groundsheet", copies = 5 }, { id = "f_null" } },
            ["+"] = { { id = "f_large_skin_door", copies = 5 }, { id = "f_null" } },
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ruins_4x4_front",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "____",
            "____",
            "__C_",
            "____",
        },
        palettes = { "desolatebarn_palette" },
        rotation = { 0, 3 },
        item_groups = { C = { group = "stash_wood", chance = 60, repetitions = { 1, 4 } } },
        monster_placements = { { id = "mon_dog_zombie_rot", chance = 60, x = 1, y = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ruins_4x4_front",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "____",
            "_h__",
            "__h_",
            "____",
        },
        palettes = { "desolatebarn_palette" },
        rotation = { 0, 3 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ruins_4x4_front",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "____",
            "_C__",
            "____",
            "____",
        },
        palettes = { "desolatebarn_palette" },
        rotation = { 0, 3 },
        item_groups = { C = { group = "hardware", chance = 60 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ruins_4x4_junk",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "____",
            "_^__",
            "__R^",
            "__R_",
        },
        palettes = { "desolatebarn_palette" },
        terrain = { ["^"] = "t_dirtfloor" },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        item_groups = { ["^"] = { group = "hardware", chance = 10 }, R = { group = "hardware", chance = 25 } },
        monster_placements = { { id = "mon_dog_skeleton", chance = 60, x = 2, y = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ruins_4x4_junk",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "____",
            "_h__",
            "hhh_",
            "____",
        },
        palettes = { "desolatebarn_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ruins_4x4_junk",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "___^",
            "____",
            "_^__",
            "_mg^",
        },
        palettes = { "desolatebarn_palette" },
        terrain = { ["^"] = "t_dirtfloor" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        item_groups = { ["^"] = { group = "hardware", chance = 10 } },
    },
}

-- yard with well
ccb.content.define_mapgen {
    kind = "nested",
    id = "ruins_8x8_yard",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "    d   ",
            " r      ",
            "  r   d ",
            "   d    ",
            "    ~   ",
            "        ",
            "      d ",
            "        ",
        },
        palettes = { "desolatebarn_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = { r = { group = "hardware", chance = 10 } },
    },
}

-- yard with tractor
ccb.content.define_mapgen {
    kind = "nested",
    id = "ruins_8x8_yard",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            " dddddd ",
            " dddddd ",
            " dddddd ",
            " dddddd ",
            " dddddd ",
            " dddddd ",
            " dddddd ",
            " dddddd ",
        },
        palettes = { "desolatebarn_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        vehicle_placements = { { chance = 40, fuel = 0, rotation = 90, status = 1, id = "oldtractor", x = 3, y = 3 } },
    },
}

-- yard with rusty tanks
ccb.content.define_mapgen {
    kind = "nested",
    id = "ruins_8x8_yard",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "  d     ",
            "d   d   ",
            "  QQ    ",
            "  QQ    ",
            "  d     ",
            "        ",
            "        ",
            "   d    ",
        },
        palettes = { "desolatebarn_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = { ["."] = { group = "hardware", chance = 10 } },
    },
}

-- yard with ruined shed
ccb.content.define_mapgen {
    kind = "nested",
    id = "ruins_8x8_yard",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "  d     ",
            "d   d   ",
            " r||w|& ",
            "  |rrr& ",
            "  |rdd  ",
            "  |&&ddd",
            "      dd",
            "   d    ",
        },
        palettes = { "desolatebarn_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = { r = { group = "hardware", chance = 10 } },
    },
}

-- a tent and firepit
ccb.content.define_mapgen {
    kind = "nested",
    id = "small_camp_8x8",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "  ###   ",
            "  #x#   ",
            "  #+#   ",
            "        ",
            "     k  ",
            "   b k  ",
            "     k  ",
            "        ",
        },
        terrain = { ["#"] = "t_dirt", x = "t_dirt", ["+"] = "t_dirt", b = "t_dirt", k = "t_trunk" },
        furniture = { ["#"] = "f_canvas_wall", x = "f_groundsheet", ["+"] = "f_canvas_door", b = "f_firering" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "small_camp_8x8_tent_roof", x = 0, y = 0, z = 1 } },
        item_group_placements = {
            { group = "cannedfood", x = 3, y = 1, chance = 75 },
            { group = "cannedfood", x = 3, y = 1, chance = 75 },
            { group = "camping", x = 1, y = 5, chance = 30, repetitions = { 1, 3 } },
            { group = "stash_wood", x = 3, y = 6, chance = 100, repetitions = { 6, 10 } },
        },
    },
}

-- fishing stuff
ccb.content.define_mapgen {
    kind = "nested",
    id = "gone_fishing_3x3",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            " b ",
            "   ",
            "hrh",
        },
        furniture = { h = "f_camp_chair", b = "f_firering", r = "f_tourist_table" },
        rotation = { 0, 3 },
        item_group_placements = {
            { group = "cannedfood", x = 1, y = 2, chance = 75 },
            { group = "fishing_items", x = 1, y = 2, chance = 30, repetitions = { 1, 3 } },
            { group = "stash_wood", x = 0, y = 0, chance = 100, repetitions = { 2, 6 } },
        },
    },
}
