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
