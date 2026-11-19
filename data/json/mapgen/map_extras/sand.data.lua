local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "sand_patch",
    layout = {
        size = { width = 3, height = 3 },
        terrain = { [" "] = { { id = "t_sand" }, { id = "t_null" } } },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_sand_patch",
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
            "         - --           ",
            "        -----           ",
            "         ----           ",
            "        ----            ",
            "        -----           ",
            "       ------           ",
            "          -             ",
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
        nested_glyphs = {
            ["-"] = { choices = { { id = "sand_patch", weight = 75 }, { id = "null", weight = 25 } } },
        },
    },
}
