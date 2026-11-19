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

-- A nested map for lab security.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_3x3_EW",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "LLL",
            "   ",
            "jjj",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        item_groups = {
            L = {
                { group = "prison_weapons", chance = 30 },
                { group = "prison_armor", chance = 30 },
                { group = "security_torso", chance = 20 },
                { group = "security_pants", chance = 20 },
                { group = "security_shoes", chance = 20 },
            },
        },
    },
}

-- A nested map for lab security.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_3x3_EW",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "LLL",
            "   ",
            "LLL",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        item_groups = {
            L = {
                { group = "prison_weapons", chance = 30 },
                { group = "prison_armor", chance = 30 },
                { group = "security_torso", chance = 20 },
                { group = "security_pants", chance = 20 },
                { group = "security_shoes", chance = 20 },
            },
        },
    },
}

-- A nested map for lab security.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_3x3_EW",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "^^^",
            "^A^",
            "^^^",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        field_placements = {
            {
                x = { 0, 2 },
                y = { 0, 2 },
                id = "fd_blood",
                age_turns = 2,
                intensity = 2,
                repetitions = 20,
            },
        },
        loot_placements = {
            { id = "bucket", x = 1, y = 0, chance = 100 },
            { id = "rope_30", x = 1, y = 1, chance = 100 },
        },
        terrain_placements = { { id = "t_thconc_floor_olight", x = 1, y = 1 } },
        glyph_mappings = { A = { item_spawns = { id = "corpse", amount = { 0, 1 } }, fields = { id = "fd_blood" } } },
    },
}

-- A nested map for lab security.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_3x3_EW",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "Yjj",
            "   ",
            "34Y",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
    },
}

-- A nested map for lab security prison cells.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_prison_6x6_E",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "  S|t|",
            "s    =",
            "@@   X",
            "|777||",
            "JɱII +",
            "J h Y|",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "1x6_bash_v", weight = 20 }, { id = "null", weight = 80 } },
                x = 5,
                y = { 1, 4 },
            },
        },
        monster_placements = { { id = "mon_zombie_tough", x = 3, y = 1, chance = 20 } },
    },
}

-- A nested map for lab security prison cells.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_prison_6x6_W",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "|Y h J",
            "+ IIɱJ",
            "||777|",
            "= h @s",
            "X   @ ",
            "|t|S  ",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "1x6_bash_v", weight = 20 }, { id = "null", weight = 80 } },
                x = 0,
                y = { 1, 4 },
            },
        },
        monster_placements = { { id = "mon_zombie_tough", x = 3, y = 4, chance = 20 } },
    },
}

-- A nested map for lab security prison cells.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_prison_6x6_E",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "Y hh |",
            " sss +",
            " h h |",
            "|777||",
            "JɱII +",
            "J h Y|",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
        monster_placements = { { id = "mon_zombie_tough", x = 3, y = 1, chance = 20 } },
    },
}

-- A nested map for lab security prison cells.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_prison_6x6_W",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "|Y h J",
            "+ IIɱJ",
            "||777|",
            "| h h ",
            "+ sss ",
            "|Y h h",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
        monster_placements = { { id = "mon_zombie_tough", x = 3, y = 4, chance = 20 } },
    },
}

-- A nested map for lab security prison cells.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_prison_6x6_E",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "jjjj ¢",
            "j    ¢",
            "j    ¢",
            "j    ¢",
            "j    ȣ",
            "jjjj ¢",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "1x6_bash_v", weight = 20 }, { id = "null", weight = 80 } },
                x = 5,
                y = { 1, 4 },
            },
        },
        monster_placements = { { id = "mon_zombie", x = 3, y = 4, chance = 20, pack_size = { 3, 4 } } },
    },
}

-- A nested map for lab security prison cells.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_prison_6x6_W",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "¢ jjjj",
            "¢    j",
            "¢    j",
            "¢    j",
            "ȣ    j",
            "¢ jjjj",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "1x6_bash_v", weight = 20 }, { id = "null", weight = 80 } },
                x = 0,
                y = { 1, 4 },
            },
        },
        monster_placements = { { id = "mon_zombie", x = 3, y = 4, chance = 20, pack_size = { 3, 4 } } },
    },
}

-- A nested map for lab security prison cells.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_prison_6x6_E",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|QQQ||",
            "|J  = ",
            "|JA |6",
            "|∞∞∞||",
            "||||||",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        terrain = { ["|"] = "t_wall_metal" },
        rotation = { 0, 3 },
        computer_glyphs = {
            ["6"] = {
                name = ccb.content.text("Armory Access"),
                security = 3,
                menu = { { label = ccb.content.text("Open Armory Door"), action = "unlock" } },
                failures = { "shutdown", "alarm" },
            },
        },
        monster_placements = { { id = "mon_zombie_labsecurity", x = 3, y = 4, chance = 20, pack_size = { 1, 2 } } },
        loot_placements = { { id = "large_repairkit", x = 1, y = 3, chance = 90 } },
        item_groups = {
            J = { group = "gun_cases", chance = 70, repetitions = { 0, 2 } },
            Q = { group = "cop_armory", chance = 70 },
            ["∞"] = { group = "ammo_cop", chance = 40, repetitions = { 0, 2 } },
        },
    },
}

-- A nested map for lab security prison cells.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_prison_6x6_W",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "||QQQ|",
            " =  J|",
            "6| AJ|",
            "||∞∞∞|",
            "||||||",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        terrain = { ["|"] = "t_wall_metal" },
        rotation = { 0, 3 },
        computer_glyphs = {
            ["6"] = {
                name = ccb.content.text("Armory Access"),
                security = 3,
                menu = { { label = ccb.content.text("Open Armory Door"), action = "unlock" } },
                failures = { "shutdown", "alarm" },
            },
        },
        monster_placements = { { id = "mon_zombie_labsecurity", x = 3, y = 4, chance = 20, pack_size = { 1, 2 } } },
        loot_placements = { { id = "large_repairkit", x = 4, y = 3, chance = 90 } },
        item_groups = {
            J = { group = "gun_cases", chance = 70, repetitions = { 0, 2 } },
            Q = { group = "cop_armory", chance = 70 },
            ["∞"] = { group = "ammo_cop", chance = 70, repetitions = { 2, 4 } },
        },
    },
}

-- A nested map for lab security prison cells.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_prison_6x6_E",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "t|@@ ¢",
            "     ¢",
            "sA   ¢",
            "s    ¢",
            "     ȣ",
            "S|@@ ¢",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "1x6_bash_v", weight = 20 }, { id = "null", weight = 80 } },
                x = 5,
                y = { 1, 4 },
            },
        },
        monster_placements = { { id = "mon_zombie", x = 3, y = 4, chance = 20, pack_size = { 1, 2 } } },
    },
}

-- A nested map for lab security prison cells.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_prison_6x6_W",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "¢ @@|t",
            "¢     ",
            "¢   As",
            "¢    s",
            "ȣ     ",
            "¢ @@|S",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "1x6_bash_v", weight = 20 }, { id = "null", weight = 80 } },
                x = 0,
                y = { 1, 4 },
            },
        },
        monster_placements = { { id = "mon_zombie", x = 3, y = 4, chance = 20, pack_size = { 1, 2 } } },
    },
}

-- A nested map for general lab security areas, door to the south, wall to the east.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_10x10_S",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "   ն   | |",
            "   ն   | =",
            "նինննին|+|",
            "U        |",
            "նինն     |",
            "   ն   h |",
            "   ն  rrP|",
            "||||+|||||",
            " +      H|",
            "U|      H|",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "1x6_bash", weight = 50 }, { id = "null", weight = 50 } },
                x = { 2, 4 },
                y = 2,
            },
            {
                choices = { { id = "1x6_bash", weight = 50 }, { id = "null", weight = 50 } },
                x = { 2, 3 },
                y = 4,
            },
        },
        loot_placements = {
            { id = "dogfood_dry", x = 0, y = 3, chance = 100 },
            { id = "dogfood", x = 0, y = 3, chance = 100 },
        },
        monster_placements = {
            { choices = { "mon_dog_zombie_cop", "mon_dog_gshepherd" }, x = 1, y = 1, chance = 100 },
            { choices = { "mon_dog_zombie_cop", "mon_dog_gshepherd" }, x = 5, y = 1, chance = 100 },
            { choices = { "mon_dog_zombie_cop", "mon_dog_gshepherd" }, x = 1, y = 5, chance = 100 },
        },
    },
}

-- A nested map for general lab security areas, door to the north, wall to the east.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_10x10_N",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "U|      j|",
            " +      j|",
            "||||+|||||",
            "   ն  rrP|",
            "   ն   h |",
            "նինն     |",
            "U        |",
            "նինննին|+|",
            "   ն   | =",
            "   ն   | |",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "1x6_bash", weight = 50 }, { id = "null", weight = 50 } },
                x = { 2, 3 },
                y = 5,
            },
            {
                choices = { { id = "1x6_bash", weight = 50 }, { id = "null", weight = 50 } },
                x = { 2, 4 },
                y = 7,
            },
        },
        loot_placements = {
            { id = "dogfood_dry", x = 0, y = 6, chance = 100 },
            { id = "dogfood", x = 0, y = 6, chance = 100 },
        },
        monster_placements = {
            { choices = { "mon_dog_zombie_cop", "mon_dog_gshepherd" }, x = 1, y = 8, chance = 100 },
            { choices = { "mon_dog_zombie_cop", "mon_dog_gshepherd" }, x = 5, y = 8, chance = 100 },
            { choices = { "mon_dog_zombie_cop", "mon_dog_gshepherd" }, x = 1, y = 4, chance = 100 },
        },
    },
}

-- A nested map for general lab security areas, door to the north, wall to the east.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_10x10_N",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            " hrX    j|",
            "  ɱX    j|",
            "|+||+|||||",
            "r      ɱr|",
            "ɱ   r   ɱ|",
            "rh  6 h r|",
            "ɱ   r   ɱ|",
            "r h 6 A|||",
            "ɱ   r  + =",
            "rɱ    y| |",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
        computer_glyphs = {
            ["6"] = {
                name = ccb.content.text("Log Console"),
                security = 3,
                menu = {
                    {
                        label = ccb.content.text("View Research Logs"),
                        action = "research",
                        security = 0,
                    },
                    { label = ccb.content.text("Download Map Data"), action = "maps", security = 0 },
                },
                failures = { "damage", "alarm", "shutdown" },
            },
        },
    },
}

-- A nested map for general lab security areas, door to the south, wall to the east.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_10x10_S",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "rɱ    Y| |",
            "ɱ   r  + =",
            "r A 6 h|||",
            "ɱ   r   ɱ|",
            "r h 6 A r|",
            "ɱ   r   ɱ|",
            "r      ɱr|",
            "|+||+|||||",
            "  rX    j|",
            " hrX    j|",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
        computer_glyphs = {
            ["6"] = {
                name = ccb.content.text("Log Console"),
                security = 3,
                menu = {
                    {
                        label = ccb.content.text("View Research Logs"),
                        action = "research",
                        security = 0,
                    },
                    { label = ccb.content.text("Download Map Data"), action = "maps", security = 0 },
                },
                failures = { "damage", "alarm", "shutdown" },
            },
        },
    },
}

-- A nested map for general lab security areas, door to the north, wall to the east.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_10x10_N",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "UUU|  HHH|",
            "U  +    H|",
            "||||-|||||",
            "PPY| |EsE|",
            " h + +  h|",
            "rr | |Yrr|",
            "|||| |||||",
            "P y| |YPP|",
            " r + +   =",
            "hr | |rh |",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general lab security areas, door to the south, wall to the east.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_10x10_S",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "hr | |hP |",
            " r + +   =",
            "|||| |||||",
            "P y| |YPP|",
            "rr | |Yrr|",
            " h + +  h|",
            "PPY| |EsE|",
            "||||-|||||",
            "UUU|    H|",
            "U  +  HHH|",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general lab security areas, door to the north, wall to the east.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_10x10_N",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "U  #     |",
            "UUU| jjY |",
            "||||#||| |",
            "       | |",
            "JJJ|JJJ| |",
            "   ʋ   | |",
            "   ʋ   | |",
            "   ʉ   | |",
            " 5 ʉ 5 | =",
            "ʉʉʉʉʉʉʉ| |",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general lab security areas, door to the south, wall to the east.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_security_10x10_S",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "ʉʉʉʉʉʉʉ| |",
            " 5 ʉ 5 | =",
            "   ʉ   | |",
            "   ʋ   | |",
            "   ʋ   | |",
            "JJJ|JJJ| |",
            "       | |",
            "||||#||| |",
            "U  | jjY |",
            "U  #     |",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
    },
}
