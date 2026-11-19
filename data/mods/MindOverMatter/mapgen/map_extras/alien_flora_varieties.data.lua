local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_alien_grass",
    layout = {
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { id = "grass_location_1", x = { 2, 13 }, y = { 2, 13 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "grass_location_1",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "  GGGGG  ",
            " GGGGGGG ",
            "GGGGGGGGG",
            "GGGGGGGGG",
            "GGGGGGGGG",
            "GGGGGGGGG",
            "GGGGGGGGG",
            " GGGGGGG ",
            "  GGGGG  ",
        },
        terrain = {
            G = { { id = "t_grass_alien", copies = 1 }, { id = "t_null", copies = 1 } },
            [" "] = "t_null",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_alien_grass_2",
    layout = {
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { id = "grass_location_2", x = { 2, 10 }, y = { 2, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "grass_location_2",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "    GGGG    ",
            "   GGGGGG   ",
            "  GGGGGGGG  ",
            " GGGGGGGGGG ",
            "GGGGGGGGGGGG",
            "GGGGGGGGGGGG",
            "GGGGGGGGGGGG",
            "GGGGGGGGGGGG",
            " GGGGGGGGGG ",
            "  GGGGGGGG  ",
            "   GGGGGG   ",
            "    GGGG    ",
        },
        terrain = {
            G = {
                { id = "t_grass_alien_2", copies = 2 },
                { id = "t_tree_small_alien_1", copies = 1 },
                { id = "t_null", copies = 1 },
            },
            [" "] = "t_null",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_alien_grass_3",
    layout = {
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { id = "grass_location_3", x = { 2, 13 }, y = { 2, 13 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "grass_location_3",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "  GGGGG  ",
            " GGGGGGG ",
            "GGGGGGGGG",
            "GGGGGGGGG",
            "GGGGGGGGG",
            "GGGGGGGGG",
            "GGGGGGGGG",
            " GGGGGGG ",
            "  GGGGG  ",
        },
        terrain = {
            G = {
                { id = "t_grass_alien_3", copies = 1 },
                { id = "t_moss_alien_1", copies = 1 },
                { id = "t_null", copies = 1 },
            },
            [" "] = "t_null",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_alien_grass_4",
    layout = {
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { id = "grass_location_4", x = { 2, 12 }, y = { 2, 12 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "grass_location_4",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "   GGGG   ",
            "  GGGGGG  ",
            " GGGGGGGG ",
            "GGGGGGGGGG",
            "GGGGGGGGGG",
            "GGGGGGGGGG",
            "GGGGGGGGGG",
            " GGGGGGGG ",
            "  GGGGGG  ",
            "   GGGG   ",
        },
        terrain = {
            G = {
                { id = "t_tree_small_alien_2", copies = 1 },
                { id = "t_moss_alien_2", copies = 1 },
                { id = "t_null", copies = 1 },
            },
            [" "] = "t_null",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_alien_grass_5",
    layout = {
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { id = "grass_location_5", x = { 2, 10 }, y = { 2, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "grass_location_5",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "    GGGG    ",
            "   GGGGGG   ",
            "  GGGGGGGG  ",
            " GGGGGGGGGG ",
            "GGGGGGGGGGGG",
            "GGGGGGGGGGGG",
            "GGGGGGGGGGGG",
            "GGGGGGGGGGGG",
            " GGGGGGGGGG ",
            "  GGGGGGGG  ",
            "   GGGGGG   ",
            "    GGGG    ",
        },
        terrain = {
            G = {
                { id = "t_tree_small_alien_3", copies = 1 },
                { id = "t_vines_alien_1", copies = 1 },
                { id = "t_null", copies = 1 },
            },
            [" "] = "t_null",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_alien_grove",
    layout = {
        rows = {
            ".............GGGGG......",
            "......GGGGGGGGGGGGGG....",
            "....GGGGGGGGGGGGGGGGGG..",
            "...GGGGGGGGGGGGGGGGGGGG.",
            "...GGGGGGGGGGGGGGGGDDGG.",
            "..GGGGGGGGGGGGGDGGGGDDD.",
            ".GGGGGGGGGGGGGGDDGGDDD..",
            ".GGGGGGGGGGGGGGGGDDDGDD.",
            ".GGGGGGGGGGGGGGGDGGDDDD.",
            ".GGGGGGGGGGGGGGDDGDDDDD.",
            "GGGGGGGGGGGGGDGGDDDDDDDD",
            "GGGGGGGGGGGGDDDGDDDDDDDD",
            "GGGGGGGDDGGDDDGGDDDDDDDD",
            "GGGGGGGDDDDDDDDDDDDDDDDD",
            ".GGGGGGGGGDDDDDDDDDDDDD.",
            ".GGGGGGGDDDDDDDDDDDDDDD.",
            ".GGGDGDGDDDDDDDDDDDDDD..",
            ".GGDGDDDGDDDDDDDDDDDDD..",
            "..GGDDDGGDDDDDDDDDDDDD..",
            "..GGGDDDDDDDDDDDDDDDDD..",
            "...DDDDDDDDDDDDDDDDDD...",
            ".....DDDDDDDDDDDDDDD....",
            ".......DDDDDDDDDDDD.....",
            "..........DDDDDD........",
        },
        terrain = {
            G = {
                { id = "t_grass_alien_2", copies = 2 },
                { id = "t_tree_small_alien_1", copies = 1 },
                { id = "t_null", copies = 1 },
            },
            D = {
                { id = "t_tree_small_alien_3", copies = 3 },
                { id = "t_vines_alien_1", copies = 3 },
                { id = "t_null", copies = 2 },
            },
            ["."] = "t_null",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
