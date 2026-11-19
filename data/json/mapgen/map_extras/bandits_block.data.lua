local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_bandits_block",
    layout = {
        nested = {
            {
                x = 0,
                y = 0,
                neighbors = {
                    north = { { terrain = "road", match = "type" } },
                    east = { { terrain = "forest", match = "prefix" } },
                    south = { { terrain = "road", match = "type" } },
                    west = { { terrain = "forest", match = "prefix" } },
                },
                id = "24x24_bandits_block_horizontal",
            },
            {
                x = 0,
                y = 0,
                neighbors = {
                    north = { { terrain = "forest", match = "prefix" } },
                    east = { { terrain = "road", match = "type" } },
                    south = { { terrain = "forest", match = "prefix" } },
                    west = { { terrain = "road", match = "type" } },
                },
                id = "24x24_bandits_block_vertical",
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_bandits_block_horizontal",
    layout = {
        size = { width = 24, height = 24 },
        nested = {
            {
                choices = {
                    "24x24_bandits_block_horizontal_felled_trees",
                    "24x24_bandits_block_horizontal_traps",
                },
                x = 0,
                y = { 3, 14 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_bandits_block_vertical",
    layout = {
        size = { width = 24, height = 24 },
        nested = {
            {
                choices = {
                    "24x24_bandits_block_vertical_felled_trees",
                    "24x24_bandits_block_vertical_traps",
                },
                x = { 3, 14 },
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_bandits_block_horizontal_felled_trees",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "        ---             ",
            " n------                ",
            "                 -----n ",
            "           ------     / ",
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
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        terrain = { ["-"] = "t_trunk", n = "t_stump", ["/"] = "t_improvised_shelter" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { choices = { "1x1_bandit", "null" }, x = 1, y = 2 } },
        npc_glyphs = { ["/"] = { id = "bandit" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_bandits_block_vertical_felled_trees",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "  n/                    ",
            "  |                     ",
            "  |                     ",
            "  |                     ",
            "  |                     ",
            "  |                     ",
            "   |                    ",
            "   |                    ",
            "   |                    ",
            "   |                    ",
            "   |                    ",
            "   |                    ",
            "|                       ",
            "|                       ",
            "|                       ",
            " |                      ",
            " |                      ",
            " |                      ",
            " |                      ",
            " |                      ",
            " |                      ",
            " n                      ",
            "                        ",
        },
        terrain = { ["|"] = "t_trunk", n = "t_stump", ["/"] = "t_improvised_shelter" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { choices = { "1x1_bandit", "null" }, x = 0, y = 22 } },
        npc_glyphs = { ["/"] = { id = "bandit" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_bandit",
    layout = {
        size = { width = 1, height = 1 },
        npc_placements = { { id = "bandit", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_bandit_dirt",
    layout = {
        size = { width = 1, height = 1 },
        npc_placements = { { id = "bandit", x = 0, y = 0 } },
        tile_edits = { { shape = "point", operation = "terrain", id = "t_dirt", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_nailboard",
    layout = {
        size = { width = 1, height = 1 },
        tile_edits = { { shape = "point", operation = "trap", id = "tr_nailboard", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_caltrops",
    layout = {
        size = { width = 1, height = 1 },
        tile_edits = { { shape = "point", operation = "trap", id = "tr_caltrops", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_bandits_block_horizontal_traps",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            " ss                     ",
            "ssss                    ",
            "ssss                    ",
            " ss                     ",
            "X X X X X X  X X X X X X",
            "X X X X X X  X X X X X X",
            "                     ss ",
            "                    ssss",
            "                    ssss",
            "                     ss ",
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
            "                        ",
            "                        ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = {
            { x = { 1, 2 }, y = { 1, 2 }, id = "1x1_bandit_dirt" },
            { x = { 21, 22 }, y = { 7, 8 }, id = "1x1_bandit_dirt" },
        },
        nested_glyphs = {
            X = {
                choices = {
                    {
                        select = { parameter = "trap_type", fallback = "tr_caltrops" },
                        cases = { tr_nailboard = "1x1_nailboard", tr_caltrops = "1x1_caltrops" },
                    },
                    { id = "null", weight = 4 },
                },
            },
        },
        parameters = {
            trap_type = {
                value_type = "string",
                default = { weighted = { "tr_nailboard", "tr_caltrops" } },
                scope = "nested",
            },
        },
        terrain = { s = { { id = "t_underbrush" }, { id = "t_null", copies = 2 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_bandits_block_vertical_traps",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "    XX ss               ",
            "      ssss              ",
            "    XXssss              ",
            "       ss               ",
            "    XX                  ",
            "                        ",
            "    XX                  ",
            "                        ",
            "    XX                  ",
            "                        ",
            "    XX                  ",
            "                        ",
            "                        ",
            "    XX                  ",
            "                        ",
            "    XX                  ",
            "                        ",
            "    XX                  ",
            "                        ",
            "    XX                  ",
            " ss                     ",
            "ssssXX                  ",
            "ssss                    ",
            " ss XX                  ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = {
            { x = { 7, 8 }, y = { 1, 2 }, id = "1x1_bandit_dirt" },
            { x = { 1, 2 }, y = { 21, 22 }, id = "1x1_bandit_dirt" },
        },
        nested_glyphs = {
            X = {
                choices = {
                    {
                        select = { parameter = "trap_type", fallback = "tr_caltrops" },
                        cases = { tr_nailboard = "1x1_nailboard", tr_caltrops = "1x1_caltrops" },
                    },
                    { id = "null", weight = 4 },
                },
            },
        },
        parameters = {
            trap_type = {
                value_type = "string",
                default = { weighted = { "tr_nailboard", "tr_caltrops" } },
                scope = "nested",
            },
        },
        terrain = { s = { { id = "t_underbrush" }, { id = "t_null", copies = 2 } } },
    },
}
