local ccb = require("ccb")

-- A nested map for general lab security areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_6x6_open",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "pp  HH",
            "ph    ",
            "    Ih",
            " s  I ",
            "wA  Y ",
            "w   PP",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
        loot_placements = { { id = "camera_pro", x = 1, y = 3, chance = 100 } },
        item_groups = { w = { { group = "ID_supplies", chance = 50 } } },
    },
}

-- A nested map for general lab security areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_6x6_open",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "y    P",
            "E   JA",
            " s  J ",
            "      ",
            "ph   w",
            "pp   w",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
        loot_placements = { { id = "camera_pro", x = 1, y = 2, chance = 100 } },
        item_groups = { w = { { group = "ID_supplies", chance = 50 } } },
    },
}

-- A nested map for general lab security areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_6x6_open",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "pp  HH",
            "ph    ",
            "    Ih",
            " s  I ",
            "wA  Y ",
            "w   PP",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
        loot_placements = { { id = "camera_pro", x = 1, y = 3, chance = 100 } },
        item_groups = { w = { { group = "ID_supplies", chance = 50 } } },
    },
}

-- A nested map for military lab security areas, really 14x7 for security corridors.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_14x14_corridor_1",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            "!|    |       ",
            "||    |       ",
            "||    |       ",
            "!|    |       ",
            "||    |       ",
            "||    |       ",
            "!|    |       ",
            "||    |       ",
            "||    |       ",
            "!|    |       ",
            "||    |       ",
            "||    |       ",
            "!|    |       ",
            "||    |       ",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    { id = "null", weight = 30 },
                    { id = "lab_security_sandbag_EW_1", weight = 50 },
                    { id = "lab_security_sandbag_EW_2", weight = 50 },
                },
                x = { 2, 4 },
                y = { 0, 12 },
                repetitions = { 4, 8 },
            },
            {
                choices = {
                    { id = "null", weight = 30 },
                    { id = "lab_security_sandbag_NS_1", weight = 50 },
                    { id = "lab_security_sandbag_NS_2", weight = 50 },
                },
                x = { 2, 4 },
                y = { 0, 12 },
                repetitions = { 3, 6 },
            },
        },
        monster_glyphs = { ["!"] = { id = "mon_turret_riot" } },
    },
}

-- A nested map for military lab security areas, really 14x7 for security corridors.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_14x14_corridor_2",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            "    |!        ",
            "    ||        ",
            "    ||        ",
            "    |!        ",
            "    ||        ",
            "    ||        ",
            "    |!        ",
            "    ||        ",
            "    ||        ",
            "    |!        ",
            "    ||        ",
            "    ||        ",
            "    |!        ",
            "    ||        ",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    { id = "null", weight = 30 },
                    { id = "lab_security_sandbag_EW_1", weight = 50 },
                    { id = "lab_security_sandbag_EW_2", weight = 50 },
                },
                x = { 0, 2 },
                y = { 0, 12 },
                repetitions = { 4, 8 },
            },
            {
                choices = {
                    { id = "null", weight = 30 },
                    { id = "lab_security_sandbag_NS_1", weight = 50 },
                    { id = "lab_security_sandbag_NS_2", weight = 50 },
                },
                x = { 0, 2 },
                y = { 0, 12 },
                repetitions = { 3, 6 },
            },
        },
        monster_glyphs = { ["!"] = { id = "mon_turret_riot" } },
    },
}

-- A nested map for military lab security areas, really 14x7 for security corridors.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_14x14_corridor_1",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            " |    |       ",
            "||    |       ",
            "||    |       ",
            " |    |       ",
            "||    |       ",
            "||    |       ",
            " |    |       ",
            "||    |       ",
            "||    |       ",
            " |    |       ",
            "||    |       ",
            "||    |       ",
            " |    |       ",
            "||    |       ",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    { id = "null", weight = 30 },
                    { id = "lab_security_sandbag_EW_1", weight = 50 },
                    { id = "lab_security_sandbag_EW_2", weight = 50 },
                },
                x = { 2, 4 },
                y = { 0, 12 },
                repetitions = { 4, 8 },
            },
            {
                choices = {
                    { id = "null", weight = 30 },
                    { id = "lab_security_sandbag_NS_1", weight = 50 },
                    { id = "lab_security_sandbag_NS_2", weight = 50 },
                },
                x = { 2, 4 },
                y = { 0, 12 },
                repetitions = { 3, 6 },
            },
        },
        monster_placements = {
            {
                choices = { "mon_secubot", "mon_skitterbot", "mon_tazer_hack", "mon_dispatch" },
                x = 0,
                y = 0,
                chance = 100,
            },
            {
                choices = { "mon_secubot", "mon_skitterbot", "mon_tazer_hack", "mon_dispatch" },
                x = 0,
                y = 3,
                chance = 100,
            },
            {
                choices = { "mon_secubot", "mon_skitterbot", "mon_tazer_hack", "mon_dispatch" },
                x = 0,
                y = 6,
                chance = 100,
            },
            {
                choices = { "mon_secubot", "mon_skitterbot", "mon_tazer_hack", "mon_dispatch" },
                x = 0,
                y = 9,
                chance = 100,
            },
            {
                choices = { "mon_secubot", "mon_skitterbot", "mon_tazer_hack", "mon_dispatch" },
                x = 0,
                y = 12,
                chance = 100,
            },
        },
    },
}

-- A nested map for military lab security areas, really 14x7 for security corridors.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_14x14_corridor_2",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            "    |         ",
            "    ||        ",
            "    ||        ",
            "    |         ",
            "    ||        ",
            "    ||        ",
            "    |         ",
            "    ||        ",
            "    ||        ",
            "    |         ",
            "    ||        ",
            "    ||        ",
            "    |         ",
            "    ||        ",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    { id = "null", weight = 30 },
                    { id = "lab_security_sandbag_EW_1", weight = 50 },
                    { id = "lab_security_sandbag_EW_2", weight = 50 },
                },
                x = { 0, 2 },
                y = { 0, 12 },
                repetitions = { 4, 8 },
            },
            {
                choices = {
                    { id = "null", weight = 30 },
                    { id = "lab_security_sandbag_NS_1", weight = 50 },
                    { id = "lab_security_sandbag_NS_2", weight = 50 },
                },
                x = { 0, 2 },
                y = { 0, 12 },
                repetitions = { 3, 6 },
            },
        },
        monster_placements = {
            {
                choices = { "mon_secubot", "mon_skitterbot", "mon_tazer_hack", "mon_dispatch" },
                x = 5,
                y = 0,
                chance = 100,
            },
            {
                choices = { "mon_secubot", "mon_skitterbot", "mon_tazer_hack", "mon_dispatch" },
                x = 5,
                y = 3,
                chance = 100,
            },
            {
                choices = { "mon_secubot", "mon_skitterbot", "mon_tazer_hack", "mon_dispatch" },
                x = 5,
                y = 6,
                chance = 100,
            },
            {
                choices = { "mon_secubot", "mon_skitterbot", "mon_tazer_hack", "mon_dispatch" },
                x = 5,
                y = 9,
                chance = 100,
            },
            {
                choices = { "mon_secubot", "mon_skitterbot", "mon_tazer_hack", "mon_dispatch" },
                x = 5,
                y = 12,
                chance = 100,
            },
        },
    },
}

-- A nested map for military lab security areas, really 14x7 for security corridors.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_14x14_corridor_1",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            "6|    |       ",
            "||    |       ",
            "||    |       ",
            "6|    |       ",
            "||    |       ",
            "||    |       ",
            "6|    |       ",
            "||    |       ",
            "||    |       ",
            "6|    |       ",
            "||    |       ",
            "||    |       ",
            "6|    |       ",
            "||    |       ",
        },
        palettes = { "lab_common_palette" },
        furniture = { ["6"] = "f_vent_toxic_belch" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    { id = "null", weight = 30 },
                    { id = "lab_security_sandbag_EW_1", weight = 50 },
                    { id = "lab_security_sandbag_EW_2", weight = 50 },
                },
                x = { 2, 4 },
                y = { 0, 12 },
                repetitions = { 4, 8 },
            },
            {
                choices = {
                    { id = "null", weight = 30 },
                    { id = "lab_security_sandbag_NS_1", weight = 50 },
                    { id = "lab_security_sandbag_NS_2", weight = 50 },
                },
                x = { 2, 4 },
                y = { 0, 12 },
                repetitions = { 3, 6 },
            },
        },
        monster_placements = {
            {
                choices = { "mon_gasbomb_hack", "mon_skitterbot", "mon_tazer_hack", "mon_flashbang_hack" },
                x = 0,
                y = 0,
                chance = 100,
            },
            {
                choices = { "mon_gasbomb_hack", "mon_skitterbot", "mon_tazer_hack", "mon_flashbang_hack" },
                x = 0,
                y = 3,
                chance = 100,
            },
            {
                choices = { "mon_gasbomb_hack", "mon_skitterbot", "mon_tazer_hack", "mon_flashbang_hack" },
                x = 0,
                y = 6,
                chance = 100,
            },
            {
                choices = { "mon_gasbomb_hack", "mon_skitterbot", "mon_tazer_hack", "mon_flashbang_hack" },
                x = 0,
                y = 9,
                chance = 100,
            },
            {
                choices = { "mon_gasbomb_hack", "mon_skitterbot", "mon_tazer_hack", "mon_flashbang_hack" },
                x = 0,
                y = 12,
                chance = 100,
            },
        },
    },
}

-- A nested map for military lab security areas, really 14x7 for security corridors.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_14x14_corridor_2",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            "    |6        ",
            "    ||        ",
            "    ||        ",
            "    |6        ",
            "    ||        ",
            "    ||        ",
            "    |6        ",
            "    ||        ",
            "    ||        ",
            "    |6        ",
            "    ||        ",
            "    ||        ",
            "    |6        ",
            "    ||        ",
        },
        palettes = { "lab_common_palette" },
        furniture = { ["6"] = "f_vent_toxic_belch" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    { id = "null", weight = 30 },
                    { id = "lab_security_sandbag_EW_1", weight = 50 },
                    { id = "lab_security_sandbag_EW_2", weight = 50 },
                },
                x = { 0, 2 },
                y = { 0, 12 },
                repetitions = { 4, 8 },
            },
            {
                choices = {
                    { id = "null", weight = 30 },
                    { id = "lab_security_sandbag_NS_1", weight = 50 },
                    { id = "lab_security_sandbag_NS_2", weight = 50 },
                },
                x = { 0, 2 },
                y = { 0, 12 },
                repetitions = { 3, 6 },
            },
        },
        monster_placements = {
            {
                choices = { "mon_gasbomb_hack", "mon_skitterbot", "mon_tazer_hack", "mon_flashbang_hack" },
                x = 5,
                y = 0,
                chance = 100,
            },
            {
                choices = { "mon_gasbomb_hack", "mon_skitterbot", "mon_tazer_hack", "mon_flashbang_hack" },
                x = 5,
                y = 3,
                chance = 100,
            },
            {
                choices = { "mon_gasbomb_hack", "mon_skitterbot", "mon_tazer_hack", "mon_flashbang_hack" },
                x = 5,
                y = 6,
                chance = 100,
            },
            {
                choices = { "mon_gasbomb_hack", "mon_skitterbot", "mon_tazer_hack", "mon_flashbang_hack" },
                x = 5,
                y = 9,
                chance = 100,
            },
            {
                choices = { "mon_gasbomb_hack", "mon_skitterbot", "mon_tazer_hack", "mon_flashbang_hack" },
                x = 5,
                y = 12,
                chance = 100,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "12x12_obstacle_course_N",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "       !!!  ",
            "       $ $  ",
            "      i$ $ i",
            "      i!!! i",
            "      i$ $ i",
            "       $ $  ",
            "       ===  ",
            "   &   =%=  ",
            " &&&   ===  ",
            "            ",
            "            ",
        },
        palettes = { "standard_domestic_palette" },
        terrain = { ["="] = "t_linoleum_white", ["%"] = "t_linoleum_white" },
        furniture = {
            ["&"] = "f_barricade_road",
            ["%"] = "f_punching_bag",
            ["!"] = "f_sandbag_wall",
            ["$"] = "f_sandbag_half",
        },
        loot_placements = {
            { id = "towel", x = 5, y = { 3, 5 }, chance = 100, repetitions = { 1, 2 } },
            { id = "wheel_wide", x = 1, y = 1, chance = 100 },
            { id = "wheel_wide", x = 2, y = 2, chance = 100 },
            { id = "wheel_wide", x = 1, y = 3, chance = 100 },
            { id = "wheel_wide", x = 2, y = 4, chance = 100 },
            { id = "wheel_wide", x = 1, y = 5, chance = 100 },
            { id = "wheel_wide", x = 2, y = 6, chance = 100 },
            { id = "wheel_wide", x = 1, y = 7, chance = 100 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "12x12_obstacle_course_N",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "    ĉĉĉ     ",
            "  ććĉ!ĉćććć ",
            "  ć ĉĉĉ ć   ",
            "  ć    ććć j",
            " ƨƨƨ   ććć j",
            " ƨƨƨ   ććć j",
            " ƨƨƨ     ć  ",
            " ƨƨƨ   ććć  ",
            " ƨƨƨ   ć    ",
            "       ć    ",
            "            ",
            "            ",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        terrain = { ["ĉ"] = "t_sandbox", ["!"] = "t_sandbox", ["ć"] = "t_monkey_bars" },
        furniture = { ["!"] = "f_dancing_pole" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "12x12_obstacle_course_S",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            " ƨƨƨƨ       ",
            " ƨƨƨƨ  ĉĉĉĉ ",
            " ƨƨƨƨ  ĉĉĉĉ ",
            " ƨƨƨƨ  ĉĉĉĉ ",
            "       ĉĉĉĉ ",
            " ʋʋʋʋ  ĉĉĉĉ ",
            "    ʉ  ĉĉĉĉ ",
            "    ʉ  ĉĉĉĉ ",
            "  ʋ ʉ  ĉĉĉĉ ",
            "  ʋ    ĉĉĉĉ ",
            " 5ʋ5ʉ       ",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        terrain = { ["ĉ"] = "t_sandbox" },
        furniture = { ["!"] = "f_barricade_road", A = "f_punching_bag" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "towel", x = 5, y = { 3, 5 }, chance = 100, repetitions = { 1, 2 } },
            { id = "wheel_wide", x = 9, y = 9, chance = 100 },
            { id = "wheel_wide", x = 8, y = 8, chance = 100 },
            { id = "wheel_wide", x = 9, y = 7, chance = 100 },
            { id = "wheel_wide", x = 8, y = 6, chance = 100 },
            { id = "wheel_wide", x = 9, y = 5, chance = 100 },
            { id = "wheel_wide", x = 8, y = 4, chance = 100 },
            { id = "wheel_wide", x = 9, y = 3, chance = 100 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "12x12_obstacle_course_S",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "            ",
            " ʉʉʉʉʉʉʉʉʉʉ ",
            " ʉ5         ",
            " ʉ ʉʉʉʉʉʉʉʉʉ",
            " ʉ         5",
            " ʉʉʉʉ ʉʉʉ ʉ ",
            "5   ʉ ʉ   ʉ ",
            "ʉʉʉ ʉ ʉ ʉʉʉ ",
            " 5ʉ ʉ5ʉ  5ʉ ",
            " ʉʉ ʉʉʉʉʉ ʉ ",
            "5         ʉ5",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "power_armor_roulette",
    weight = 300,
    layout = {
        size = { width = 1, height = 1 },
        loot_placements = { { group = "power_armor_sets", x = 0, y = 0, chance = 100 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "power_armor_roulette",
    weight = 400,
    layout = {
        size = { width = 1, height = 1 },
        monster_placements = { { id = "mon_zombie_armored", x = 0, y = 0 } },
    },
}

-- A nested map bash damage, vertical line.
ccb.content.define_mapgen {
    kind = "nested",
    id = "1x6_bash_v",
    layout = {
        size = { width = 6, height = 6 },
        tile_edits = { { shape = "point", operation = "bash", x = 0, y = { 1, 4 } } },
    },
}

-- A nested map bash damage, a single point.
ccb.content.define_mapgen {
    kind = "nested",
    id = "1x6_bash",
    layout = {
        size = { width = 1, height = 1 },
        tile_edits = { { shape = "point", operation = "bash", x = 0, y = 0 } },
    },
}

-- A nested map for military lab security areas, 2x2 sandbag configuration.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_sandbag_NS_1",
    layout = {
        size = { width = 2, height = 2 },
        rotation = { 0, 3 },
        furniture_placements = { { id = "f_sandbag_half", x = 0, y = 0 }, { id = "f_sandbag_half", x = 0, y = 1 } },
    },
}

-- A nested map for military lab security areas, 2x2 sandbag configuration.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_sandbag_NS_2",
    layout = {
        size = { width = 2, height = 2 },
        rotation = { 0, 3 },
        furniture_placements = { { id = "f_sandbag_half", x = 1, y = 0 }, { id = "f_sandbag_half", x = 1, y = 1 } },
    },
}

-- A nested map for military lab security areas, 2x2 sandbag configuration.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_sandbag_EW_1",
    layout = {
        size = { width = 2, height = 2 },
        rotation = { 0, 3 },
        furniture_placements = { { id = "f_sandbag_half", x = 0, y = 0 }, { id = "f_sandbag_half", x = 1, y = 0 } },
    },
}

-- A nested map for military lab security areas, 2x2 sandbag configuration.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_sandbag_EW_2",
    layout = {
        size = { width = 2, height = 2 },
        rotation = { 0, 3 },
        furniture_placements = { { id = "f_sandbag_half", x = 0, y = 1 }, { id = "f_sandbag_half", x = 1, y = 1 } },
    },
}
