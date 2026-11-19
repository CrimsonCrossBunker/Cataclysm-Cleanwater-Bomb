local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "window_sandbags_meteorology1",
    layout = {
        nested = {
            { id = "robofachqy_window_sand_wall", x = 2, y = 11 },
            { id = "robofachqy_window_sand_wall", x = 2, y = 19 },
            { id = "robofachqy_window_sand_wall", x = 15, y = 11 },
            { id = "robofachqy_window_sand_wall", x = 15, y = 19 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "window_sandbags_meteorology2",
    layout = {
        nested = {
            { id = "robofachqy_window_sand_wall", x = 4, y = 11 },
            { id = "robofachqy_window_sand_wall", x = 4, y = 19 },
            { id = "robofachq_window_sand_wall_l", x = 13, y = 9 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "window_sandbags_surface_road2",
    layout = {
        nested = { { id = "robofachq_window_sand_wall_l", x = 13, y = 0 } },
    },
}

-- remove the null chunks once there's enough BEM npcs.
ccb.content.define_mapgen {
    kind = "update",
    id = "nest_ancilla_bar_place_BEMs",
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
            "    1    4    2         ",
            "                        ",
            "                        ",
            "           3            ",
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
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "BEM_hireable", weight = 40 },
                    { id = "BEM_jabberwock", weight = 20 },
                    { id = "null", weight = 20 },
                },
            },
            ["2"] = {
                choices = {
                    { id = "BEM_human_sample", weight = 20 },
                    { id = "BEM_anchor_seller", weight = 20 },
                    { id = "BEM_exodii_hunter", weight = 20 },
                    { id = "null", weight = 20 },
                },
            },
            ["3"] = {
                choices = {
                    { id = "BEM_keycard_seller", weight = 20 },
                    { id = "BEM_template_seller", weight = 20 },
                    { id = "null", weight = 20 },
                },
            },
            ["4"] = {
                choices = {
                    { id = "BEM_gunrunner", weight = 20 },
                    { id = "BEM_drugrunner", weight = 20 },
                    { id = "BEM_chatting_veterans", weight = 20 },
                    { id = "null", weight = 20 },
                },
            },
        },
    },
}
