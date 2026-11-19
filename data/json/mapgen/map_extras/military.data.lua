local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_military",
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
        nested_glyphs = {
            ["-"] = { choices = { { id = "soldier_guns_3x3", weight = 1 }, { id = "null", weight = 149 } } },
            ["1"] = { id = "soldier_guns_3x3" },
        },
        monster_placements = {
            { id = "mon_dispatch", x = { 1, 23 }, y = { 1, 23 }, chance = 4 },
            {
                group = "GROUP_NETHER_CAPTURED",
                x = { 1, 23 },
                y = { 1, 23 },
                repetitions = { 0, 2 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "soldier_guns_3x3",
    layout = {
        size = { width = 3, height = 3 },
        item_group_placements = { { group = "military_squad_guns", x = { 0, 2 }, y = { 0, 2 }, chance = 100 } },
        field_placements = {
            { id = "fd_blood", x = { 0, 2 }, y = { 0, 2 } },
            { id = "fd_gibs_flesh", x = { 0, 2 }, y = { 0, 2 } },
        },
        monster_placements = { { group = "GROUP_MIL_EXTRA", x = { 0, 2 }, y = { 0, 2 } } },
    },
}
