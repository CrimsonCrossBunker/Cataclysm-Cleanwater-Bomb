local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_finalshowdown",
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
        nested = {
            {
                choices = {
                    { id = "corpse_blood_gibs_victim_3x3", weight = 50 },
                    { id = "null", weight = 50 },
                },
                x = { 8, 14 },
                y = { 8, 14 },
            },
        },
        nested_glyphs = { ["1"] = { id = "corpse_blood_gibs_victim_3x3" } },
        monster_group_glyphs = {
            [" "] = { group = "GROUP_VANILLA_DORMANT", chance = 1, density = 0.0001 },
            ["-"] = { group = "GROUP_VANILLA_DORMANT", chance = 1, density = 0.0001 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "corpse_blood_gibs_victim_3x3",
    layout = {
        size = { width = 3, height = 3 },
        item_group_placements = { { group = "map_extra_showdown_victim", x = { 0, 2 }, y = { 0, 2 }, chance = 100 } },
        field_placements = {
            { id = "fd_blood", x = { 0, 2 }, y = { 0, 2 } },
            { id = "fd_gibs_flesh", x = { 0, 2 }, y = { 0, 2 } },
        },
    },
}
