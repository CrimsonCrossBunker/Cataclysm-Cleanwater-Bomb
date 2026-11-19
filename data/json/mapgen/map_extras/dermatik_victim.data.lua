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
