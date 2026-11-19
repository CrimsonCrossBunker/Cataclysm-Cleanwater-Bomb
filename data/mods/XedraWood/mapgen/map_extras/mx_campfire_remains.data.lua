local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_campfire_remnants",
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
        nested = { { id = "campfire_remnants_chunk", x = { 2, 8 }, y = { 2, 8 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "campfire_remnants_chunk",
    weight = 1000,
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "  ,,,  ",
            " ,W,W, ",
            ",W___W,",
            ",,_O_,,",
            ",W___W,",
            " ,W,W, ",
            "  ,,,  ",
        },
        terrain = {
            [","] = { { id = "t_dirt", copies = 50 }, { id = "t_region_groundcover", copies = 25 } },
            _ = "t_dirt",
            [" "] = "t_null",
            W = { { id = "t_dirt", copies = 50 }, { id = "t_region_groundcover", copies = 25 } },
        },
        furniture = {
            O = "f_firering",
            W = { { id = "f_logstool", copies = 1 }, { id = "f_null", copies = 1 } },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_placements = { { id = "ash", x = 3, y = 3, chance = 50, repetitions = { 50, 120 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "campfire_remnants_chunk",
    weight = 50,
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "  ,,,  ",
            " ,W,W, ",
            ",W___W,",
            ",,_O_,,",
            ",W___W,",
            " ,W,W, ",
            "  ,,,  ",
        },
        terrain = {
            [","] = { { id = "t_dirt", copies = 50 }, { id = "t_region_groundcover", copies = 25 } },
            _ = "t_dirt",
            [" "] = "t_null",
            W = { { id = "t_dirt", copies = 50 }, { id = "t_region_groundcover", copies = 25 } },
        },
        furniture = {
            O = "f_firering",
            W = { { id = "f_logstool", copies = 1 }, { id = "f_null", copies = 1 } },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested_glyphs = {
            W = {
                choices = {
                    { id = "campfire_remnants_chunk_1x1_body", weight = 1 },
                    { id = "null", weight = 5 },
                },
            },
        },
        item_placements = { { id = "ash", x = 3, y = 3, chance = 50, repetitions = { 50, 120 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "campfire_remnants_chunk_1x1_body",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            " ",
        },
        item_placements = {
            { id = "skull_human", x = 0, y = 0, chance = 50 },
            { id = "bone_human", x = 0, y = 0, chance = 50, repetitions = { 3, 25 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "campfire_remnants_chunk",
    weight = 10,
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "  ,,,  ",
            " ,W,W, ",
            ",W___W,",
            ",,_O_,,",
            ",W___W,",
            " ,W,W, ",
            "  ,,,  ",
        },
        terrain = {
            [","] = { { id = "t_dirt", copies = 50 }, { id = "t_region_groundcover", copies = 25 } },
            _ = "t_dirt",
            [" "] = "t_null",
            W = { { id = "t_dirt", copies = 50 }, { id = "t_region_groundcover", copies = 25 } },
        },
        furniture = {
            O = "f_firering",
            W = {
                { id = "f_statue_woman_sitting", copies = 1 },
                { id = "f_statue_man_standing_looking_away", copies = 1 },
                { id = "f_statue_man_sitting_cooking", copies = 1 },
                { id = "f_statue_woman_lying_down", copies = 1 },
                { id = "f_statue_child_sitting", copies = 1 },
                { id = "f_statue_man_laughing", copies = 1 },
                { id = "f_statue_woman_sitting_away", copies = 1 },
                { id = "f_statue_child_drawing_dirt", copies = 1 },
                { id = "f_statue_man_sharpening_axe", copies = 1 },
                { id = "f_statue_worn_away", copies = 2 },
                { id = "f_logstool", copies = 2 },
                { id = "f_null", copies = 1 },
            },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_placements = { { id = "ash", x = 3, y = 3, chance = 50, repetitions = { 50, 120 } } },
    },
}
