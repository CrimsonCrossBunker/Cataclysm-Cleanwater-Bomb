local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "mortuary_2story_roof",
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
            "         ------         ",
            "  --------....--------  ",
            "  -..................-  ",
            "---..................-  ",
            "-....................-  ",
            "-.U..................-  ",
            "-....................-  ",
            "--5..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  --------------------  ",
            "                        ",
        },
        palettes = { "roof_palette" },
        fill_terrain = "t_flat_roof",
        nested = {
            {
                choices = {
                    { id = "null", weight = 20 },
                    { id = "roof_2x2_utilities_b", weight = 15 },
                    { id = "roof_2x2_utilities_c", weight = 5 },
                    { id = "roof_2x2_utilities_d", weight = 40 },
                    { id = "roof_2x2_utilities", weight = 50 },
                },
                x = { 4, 17 },
                y = { 14, 19 },
            },
        },
        nested_glyphs = { U = { id = "roof_2x2_infrastructure" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "whately_bioturret_update",
    layout = {
        size = { width = 1, height = 1 },
        monster_placements = { { id = "mon_migoturret_whately", x = 0, y = 0 } },
    },
}
