local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "marloss_zealot",
    layout = {
        size = { width = 1, height = 1 },
        monster_placements = { { id = "mon_marloss_zealot_f", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "marloss_zealot",
    layout = {
        size = { width = 1, height = 1 },
        monster_placements = { { id = "mon_marloss_zealot_m", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_marloss_pilgrimage",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "           2            ",
            "                        ",
            "        2     2         ",
            "                        ",
            "       2   1   2        ",
            "                        ",
            "        2     2         ",
            "                        ",
            "           2            ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        nested_glyphs = {
            ["2"] = { choices = { { id = "marloss_zealot", weight = 50 }, { id = "null", weight = 50 } } },
        },
        npc_glyphs = { ["1"] = { id = "marloss_voice" } },
    },
}
