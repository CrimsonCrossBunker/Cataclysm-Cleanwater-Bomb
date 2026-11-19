local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "cave_palette",
    layout = {
        monster_glyphs = { [" "] = { id = "mon_sewer_rat", chance = 20 } },
        terrain = { ["."] = "t_soil", [" "] = "t_dirt_underground" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cave_nw",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "...........",
            "     ...  .",
            "     ...  .",
            "...   ..  .",
            "....      .",
            ".....    ..",
            ".....     .",
            ".....     .",
            ".....     .",
            ".....      ",
            ".....      ",
        },
        palettes = { "cave_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cave_nw",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "...........",
            "..   ......",
            "..   ......",
            "....   ....",
            "....      .",
            "....      .",
            "....   ....",
            "....   ....",
            ".        ..",
            ".        ..",
            ".          ",
        },
        palettes = { "cave_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cave_nw",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "...........",
            "  .........",
            "     ......",
            ".    ......",
            ".      ....",
            "...      ..",
            ".....    ..",
            ".......  ..",
            "........ ..",
            "........  .",
            "........   ",
        },
        palettes = { "cave_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cave_nw",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "...........",
            "...........",
            "...........",
            "...........",
            "...........",
            "...........",
            "...........",
            "...........",
            "...........",
            ".......... ",
            "......     ",
        },
        palettes = { "cave_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cave_ne",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "............",
            "..      ....",
            "..         .",
            ".......    .",
            "........   .",
            "........   .",
            ".....      .",
            ".....      .",
            ".....      .",
            "        ....",
            "        ....",
            "        ....",
        },
        palettes = { "cave_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cave_ne",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "............",
            "............",
            "............",
            "............",
            "............",
            "............",
            "............",
            "............",
            "............",
            "............",
            "............",
            "        ....",
        },
        palettes = { "cave_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cave_ne",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "............",
            "....    ....",
            "....       .",
            "..   ...   .",
            "..   ....  .",
            "....   ..  .",
            "....   .....",
            "..   .......",
            "..    ......",
            ".....     ..",
            ".....     ..",
            "        ....",
        },
        palettes = { "cave_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cave_ne",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "............",
            "..        ..",
            ".. .....  ..",
            ".. ...... ..",
            ".. ...... ..",
            ".. ...... ..",
            "..    ... ..",
            "..        ..",
            "..    ......",
            ".. .........",
            ".. .........",
            "        ....",
        },
        palettes = { "cave_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cave_se",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "           ",
            ".   ..     ",
            ".   ..     ",
            ".   ..     ",
            ".   ..     ",
            ".   .......",
            ".   .......",
            ".         .",
            "...       .",
            "...        ",
        },
        palettes = { "cave_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cave_se",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "     ......",
            "..   .... .",
            "..   .... .",
            "...  .... .",
            "...  .... .",
            "...        ",
            "...        ",
            "...       .",
            "...   ..  .",
            "...  ....  ",
            ".........  ",
        },
        palettes = { "cave_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cave_se",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "....       ",
            "....       ",
            "....       ",
            "....       ",
            "......     ",
            "......     ",
            "......     ",
            "......     ",
            ".......    ",
            ".......    ",
        },
        palettes = { "cave_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cave_se",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            ".....      ",
            "......     ",
            ".......    ",
            ".......    ",
            "......     ",
            ".......    ",
            ".......    ",
            "........   ",
            ".........  ",
            ".........  ",
        },
        palettes = { "cave_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cave_sw",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "...         ",
            "..        ..",
            "..        ..",
            ".       ....",
            ".        ...",
            "...   ..  ..",
            "...  ...  ..",
            "...  ....  .",
            "...  ....  .",
            "...  ..... .",
            "............",
            "............",
        },
        palettes = { "cave_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cave_sw",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "...         ",
            "...       ..",
            "....     ...",
            "...       ..",
            "....     ...",
            ".....    ...",
            "..         .",
            "...      ...",
            "....     ...",
            ".....   ....",
            "...       ..",
            "............",
        },
        palettes = { "cave_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cave_sw",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "...         ",
            "............",
            "............",
            "............",
            "............",
            "............",
            "............",
            "............",
            "............",
            "............",
            "............",
            "............",
        },
        palettes = { "cave_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cave_sw",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "...         ",
            "...    .....",
            "...    .. ..",
            ".....  . ...",
            ".....   ....",
            "..     .....",
            ".....   ....",
            ".... .  ....",
            "... ...  ...",
            ".. ....  ...",
            "............",
            "............",
        },
        palettes = { "cave_palette" },
    },
}
