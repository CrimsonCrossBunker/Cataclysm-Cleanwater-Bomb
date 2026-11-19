local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "mom_shoggothed_world_default" },
    layout = {
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
        fill_terrain = "t_region_groundcover",
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["1"] = {
                choices = { { id = "null", weight = 100 }, { id = "mom_shoggothed_world_nests", weight = 1 } },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mom_shoggothed_world_nests",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "            ",
            "            ",
            "   ..  ..   ",
            "  ..   ...  ",
            "     ...... ",
            "  .. ...... ",
            "  ......  . ",
            "   .. ..... ",
            "     .  ..  ",
            "    ..  ..  ",
            "      ..    ",
        },
        furniture = { ["."] = { { id = "f_boulder_large", copies = 1 }, { id = "f_null", copies = 3 } } },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mom_shoggothed_world_nests",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "            ",
            "            ",
            "    ....    ",
            "   ..~~..   ",
            "   .~~~~.   ",
            "   .~~~~.   ",
            "   ..~~..   ",
            "    ....    ",
            "            ",
            "            ",
            "            ",
        },
        terrain = {
            ["~"] = "t_water_sh",
            ["."] = { { id = "t_water_sh", copies = 1 }, { id = "t_dirt_cracked", copies = 1 } },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
