local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_collegekids",
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
            ["-"] = {
                choices = {
                    { id = "corpse_blood_gibs_college_3x3", weight = 1 },
                    { id = "null", weight = 150 },
                },
            },
            ["1"] = { id = "corpse_blood_gibs_college_3x3" },
        },
        monster_group_glyphs = {
            [" "] = { group = "GROUP_NETHER_CAPTURED", chance = 1, density = 0.0001 },
            ["-"] = { group = "GROUP_NETHER_CAPTURED", chance = 1, density = 0.0001 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "corpse_blood_gibs_college_3x3",
    layout = {
        size = { width = 3, height = 3 },
        item_group_placements = {
            {
                group = {
                    entries = {
                        { group = "map_extra_college_camping", probability = 33 },
                        { group = "map_extra_college_sports", probability = 33 },
                        { group = "map_extra_college_lake", probability = 33 },
                    },
                    kind = "distribution",
                },
                x = { 0, 2 },
                y = { 0, 2 },
                chance = 100,
            },
        },
        field_placements = {
            { id = "fd_blood", x = { 0, 2 }, y = { 0, 2 } },
            { id = "fd_gibs_flesh", x = { 0, 2 }, y = { 0, 2 } },
        },
    },
}
