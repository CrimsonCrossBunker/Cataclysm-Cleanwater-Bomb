local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_dermatikvictim",
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
            "              sss       ",
            "              sSs       ",
            "              sss       ",
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
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested_glyphs = {
            S = { id = "corpse_blood_gibs_dermatik_3x3" },
            s = { choices = { { id = "null", weight = 4 }, { id = "dermatik_trap", weight = 1 } } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "corpse_blood_gibs_dermatik_3x3",
    layout = {
        size = { width = 3, height = 3 },
        item_group_placements = {
            {
                group = "map_extra_dermatik_victim_itemgroup",
                x = { 0, 0 },
                y = { 0, 0 },
                chance = 100,
            },
        },
        field_placements = {
            { id = "fd_blood", x = { 0, 1 }, y = { 0, 1 } },
            { id = "fd_gibs_flesh", x = { 0, 1 }, y = { 0, 1 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "dermatik_trap",
    weight = 1,
    layout = {
        size = { width = 1, height = 1 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        trap_placements = { { id = "tr_dermatik", x = 0, y = 0 } },
    },
}
