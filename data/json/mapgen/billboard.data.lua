local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "billboard_0" },
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
            "                        ",
            "                        ",
            "                  .<    ",
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
        terrain = { ["."] = "t_column", ["<"] = "t_ladder_up" },
        predecessor_mapgen = "field",
        flags = { "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "billboard_1" },
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
            "                        ",
            "                        ",
            "                  .≷    ",
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
        terrain = { ["."] = "t_column", ["≷"] = "t_ladder_up_down" },
        fill_terrain = "t_open_air",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "billboard_2" },
    weight = 100,
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
            "               _________",
            "               _|||!|||_",
            "               =___>____",
            "               _|||!|||_",
            "               _________",
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
        terrain = {
            ["|"] = "t_wall_w",
            ["!"] = "t_wall_w",
            _ = "t_bridge",
            ["="] = "t_bridge",
            [">"] = "t_ladder_down",
        },
        fill_terrain = "t_open_air",
        nested_glyphs = {
            ["!"] = { id = "billboard_sign_nest" },
            ["="] = {
                choices = {
                    { id = "null", weight = 17 },
                    { id = "billboard_lookout", weight = 2 },
                    { id = "billboard_wasp", weight = 1 },
                },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "billboard_2" },
    weight = 200,
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
            "                        ",
            "               =|||!|||_",
            "               ____>____",
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
        terrain = {
            ["|"] = "t_wall_w",
            ["!"] = "t_wall_w",
            _ = "t_bridge",
            ["="] = "t_bridge",
            [">"] = "t_ladder_down",
        },
        fill_terrain = "t_open_air",
        nested_glyphs = {
            ["!"] = { id = "billboard_sign_nest" },
            ["="] = {
                choices = {
                    { id = "null", weight = 17 },
                    { id = "billboard_lookout", weight = 2 },
                    { id = "billboard_wasp", weight = 1 },
                },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "billboard_wasp",
    weight = 200,
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " |||",
            "|__|",
            "|__|",
            "||| ",
        },
        terrain = { ["|"] = "t_paper_hard", _ = "t_floor_paper_noroof" },
        nested = { { id = "wasp_gibs", x = { 1, 2 }, y = { 1, 2 }, repetitions = { 1, 2 } } },
        loot_placements = {
            { group = "wasp_lair", x = { 1, 2 }, y = { 1, 2 }, repetitions = { 0, 2 } },
            { group = "human_parts", x = { 1, 2 }, y = { 1, 2 } },
        },
        monster_placements = { { group = "GROUP_WASP_QUEEN", x = { 0, 3 }, y = { 0, 3 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "billboard_wasp",
    weight = 100,
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " ||||",
            "|_|_|",
            "||__|",
            " ||||",
            "     ",
        },
        terrain = { ["|"] = "t_paper_hard", _ = "t_floor_paper_noroof" },
        nested = { { id = "wasp_gibs", x = { 1, 2 }, y = { 1, 2 }, repetitions = { 1, 2 } } },
        loot_placements = {
            { group = "wasp_lair", x = { 1, 2 }, y = { 1, 2 }, repetitions = { 0, 2 } },
            { group = "human_parts", x = { 1, 2 }, y = { 1, 2 } },
        },
        monster_placements = {
            { group = "GROUP_WASP_QUEEN", x = { 0, 3 }, y = { 0, 3 } },
            { group = "GROUP_WASP_PUPA", x = { 2, 3 }, y = 2 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "billboard_sign_nest",
    weight = 300,
    layout = {
        size = { width = 1, height = 1 },
        graffiti_placements = { { snippet = "billboard_ad_snippets", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "billboard_sign_nest",
    weight = 100,
    layout = {
        size = { width = 1, height = 1 },
        graffiti_placements = { { snippet = "general_graffiti_snippets", x = 0, y = 0 } },
    },
}
