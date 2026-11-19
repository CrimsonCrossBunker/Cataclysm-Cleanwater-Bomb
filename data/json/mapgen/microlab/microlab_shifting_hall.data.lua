local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "microlab_shifting_hall",
    layout = {
        nested = { { id = "microlab_shifting_hall", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "microlab_shifting_hall_2",
    layout = {
        nested = { { id = "microlab_shifting_hall_2", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_shifting_hall",
    layout = {
        size = { width = 24, height = 24 },
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
            "|||||||||||||||||||||2||",
            "|#########|Ty.S....^...Y",
            "|#########|Ty..........Y",
            "||||||||||||||||||||||||",
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
        palettes = { "microlab_generic" },
        terrain = { ["."] = "t_strconc_floor", S = "t_strconc_floor", ["^"] = "t_strconc_floor" },
        traps = { T = "tr_microlab_shifting_hall_2" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        sign_glyphs = {
            S = {
                text = ccb.content.text("Warning:\nHallway dimensionally unstable.\nDo not step beyond yellow line.\n\nRegulation EX-127 applies."),
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_shifting_hall_2",
    layout = {
        size = { width = 24, height = 24 },
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
            "||||||2|||||||||||||||||",
            "YyyyyyyyySyyT|##########",
            "YyyyyyyyyyyyT|##########",
            "||||||||||||||||||||||||",
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
        palettes = { "microlab_generic" },
        terrain = { ["."] = "t_strconc_floor", S = "t_strconc_floor" },
        traps = { T = "tr_microlab_shifting_hall" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        sign_glyphs = {
            S = {
                text = ccb.content.text("Warming;\nWallhay dime table.\nDo step on lowland nile.\n\nRation VC+983 appliance."),
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_generic_tile",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "     | cc |  | cc |     ",
            "     2    2  2    | c c ",
            "   F|||||||  |||||||c c ",
            "   F|0ccc0|22|0ccc0|c c ",
            "   F|     d        |    ",
            "|||||c   hd   c c c|  ||",
            "  66|c    d   c c c|    ",
            "    |c        c c c|  c ",
            "  cc|c      c c c c|  c ",
            "    |  |FFF|      c|    ",
            "|||||||||||||||||||||2||",
            "|#########|Ty S    ^   Y",
            "|#########|Ty          Y",
            "||||||||||||||||||||||||",
            "   c|      d6d     |c   ",
            " c c| d6d   h   d6d|c c ",
            " c c|  h         h |c c ",
            "    2              |F   ",
            "|||||  h       h   |||2|",
            "c66c|666666  |dd6dd|cc  ",
            " c c|||||||22|||||||    ",
            " c cc(ccc |  |FFFF|  cc ",
            " c        2  ||22||  cc ",
            "     (    |  |    |     ",
        },
        palettes = { "microlab" },
        terrain = { ["0"] = "t_vat" },
        traps = { T = "tr_microlab_shifting_hall_2" },
        sign_glyphs = {
            S = {
                text = ccb.content.text("Warning:\nHallway dimensionally unstable.\nDo not step beyond yellow line.\n\nRegulation EX-127 applies."),
            },
        },
    },
}
