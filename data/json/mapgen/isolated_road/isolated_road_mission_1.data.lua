local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { { "gunshow_0_roof", "gunshow_1_roof" } },
    layout = {
        rows = {
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
            "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
        },
        terrain = { r = "t_canvas_roof" },
        fill_terrain = "t_open_air",
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunshow_table_0",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "TTTT",
            "d hT",
            "d hT",
            "TTTT",
        },
        palettes = { "gunshow" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunshow_table_1",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "m TT",
            "m  T",
            "m  T",
            "m TT",
        },
        palettes = { "gunshow" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunshow_table_2",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "TTTT",
            "d hT",
            "d hT",
            "TTTT",
        },
        palettes = { "gunshow" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunshow_table_3",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "TT m",
            "T  m",
            "T  m",
            "TT m",
        },
        palettes = { "gunshow" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunshow_table_4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "|  d",
            "|mhT",
            "|mhT",
            "|  d",
        },
        palettes = { "gunshow" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunshow_table_5",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "d  |",
            "Thm|",
            "Thm|",
            "d  |",
        },
        palettes = { "gunshow" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { { "gunshow_0", "gunshow_1" } },
    layout = {
        rows = {
            "||||||||||||||||||||||||||||||||||||||||||||||||",
            "|c       c       c       c       c       c     |",
            "|                                              |",
            "|                                              |",
            "|                                              |",
            "|                                              |",
            "|                                              |",
            "         c       c       c       c       c      ",
            "                                                ",
            "                                                ",
            "                                                ",
            "                                                ",
            "         c       c       c       c       c      ",
            "                                                ",
            "                                                ",
            "|                                              |",
            "|                                              |",
            "|                                              |",
            "|c       c       c       c       c       c     |",
            "|                                              |",
            "|                                              |",
            "|                                              |",
            "|                                              |",
            "||||||||||||||||||||||||||||||||||||||||||||||||",
        },
        terrain = { [" "] = "t_region_soil" },
        furniture = { ["|"] = "f_large_canvas_wall" },
        fill_terrain = "t_region_soil",
        nested_glyphs = {
            c = {
                choices = {
                    { id = "gunshow_table_0", weight = 20 },
                    { id = "gunshow_table_1", weight = 20 },
                    { id = "gunshow_table_2", weight = 20 },
                    { id = "gunshow_table_3", weight = 20 },
                    { id = "gunshow_table_4", weight = 20 },
                    { id = "gunshow_table_5", weight = 20 },
                    { id = "null", weight = 4 },
                },
            },
        },
        monster_placements = {
            { id = "mon_secubot_america", x = 8, y = { 3, 22 }, chance = 100 },
            { id = "mon_secubot_america", x = 35, y = { 3, 22 }, chance = 100 },
            { id = "mon_secubot", x = 14, y = { 3, 22 }, chance = 100 },
            { id = "mon_secubot", x = 22, y = { 3, 22 }, chance = 100 },
        },
        loot_placements = {
            { group = "kitted_kord", chance = 100, x = 15, y = 23 },
            {
                group = "corpse_male",
                chance = 100,
                x = { 2, 23 },
                y = { 2, 22 },
                repetitions = { 1, 3 },
            },
            {
                group = "corpse_male",
                chance = 100,
                x = { 24, 46 },
                y = { 2, 22 },
                repetitions = { 1, 3 },
            },
        },
    },
}
