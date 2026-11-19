local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_Trapdoor_spider_den",
    layout = {
        rows = {
            "                   s    ",
            "                        ",
            "                        ",
            "                        ",
            "  s                     ",
            "                        ",
            "                        ",
            "                s       ",
            "                        ",
            "        s            s  ",
            "                        ",
            "              S         ",
            "                        ",
            "                        ",
            "       s                ",
            "                s       ",
            "                        ",
            "                        ",
            "                        ",
            "  s                     ",
            "      s                 ",
            "                  s     ",
            "                        ",
            "                        ",
        },
        terrain = { s = { { id = "t_region_soil" } } },
        traps = { S = "tr_spider" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested_glyphs = { s = { choices = { { id = "null", weight = 1 }, { id = "trapdoor_trap", weight = 1 } } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "trapdoor_trap",
    weight = 1,
    layout = {
        size = { width = 3, height = 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = { { id = "null", weight = 2 }, { id = "wasp_gibs", weight = 1 } },
                x = { 0, 2 },
                y = { 0, 2 },
                repetitions = { 3, 8 },
            },
        },
        trap_placements = { { id = "tr_spider", x = 1, y = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "trapdoor_trap",
    weight = 1,
    layout = {
        size = { width = 3, height = 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = { { id = "null", weight = 2 }, { id = "wasp_gibs", weight = 1 } },
                x = { 0, 2 },
                y = { 0, 2 },
                repetitions = { 3, 8 },
            },
        },
        terrain_placements = { { id = "t_dirtmound", x = 1, y = 1 } },
    },
}
