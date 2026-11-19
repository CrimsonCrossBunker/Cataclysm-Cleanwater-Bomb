local ccb = require("ccb")

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
