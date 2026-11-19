local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "mom_mycus_world_default",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "           1            ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "   1                    ",
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
        nested_glyphs = {
            ["1"] = {
                choices = { { id = "null", weight = 100 }, { id = "mom_mycus_world_extra_1", weight = 1 } },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mom_mycus_world_extra_1",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "            ",
            "            ",
            "   ..  ..   ",
            "  ..   ...  ",
            "         .. ",
            "  ..     .. ",
            "  ...     . ",
            "   ..   ... ",
            "     .  ..  ",
            "    ..  ..  ",
            "      ..    ",
        },
        terrain = { ["."] = "t_fungus_mound" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
