local ccb = require("ccb")

-- A nested map for a 9x9 medical room, includes door and south wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medical_9x9_S",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "......|SJ",
            "......⁸..",
            "......|.9",
            "...ë..|⁸|",
            "......|.L",
            "......|.L",
            "|]⁸⁸]||+|",
            ".........",
            "...ë.....",
        },
        palettes = { "lab_common_palette", "lab_medical_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
        nested = { { choices = { { id = "lab_medical_6x6_open", weight = 100 } }, x = 0, y = 0 } },
    },
}

-- A nested map for a 9x9 medical room, includes door and south wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medical_9x9_S",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "Y.....|JJ",
            "...ë..⁸..",
            "J..8.A]r.",
            "V..b..]ɱh",
            "J.....]r.",
            "......|..",
            "||⁸⁸|||+|",
            ".........",
            "...ë.....",
        },
        palettes = { "lab_common_palette", "lab_medical_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

-- A nested map for a 9x9 medical room, includes door and north wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medical_9x9_N",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "...ë.....",
            ".........",
            "|]⁸⁸]||+|",
            "......|.L",
            "......|.L",
            "...ë..|+|",
            "......|.9",
            "......+..",
            "......|SJ",
        },
        palettes = { "lab_common_palette", "lab_medical_palette" },
        nested = { { choices = { { id = "lab_medical_6x6_open", weight = 100 } }, x = 0, y = 3 } },
        item_groups = { L = { { group = "hazmat_masks", chance = 70 }, { group = "hazmat_suits", chance = 70 } } },
    },
}

-- A nested map for a 9x9 medical room, includes door and north wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medical_9x9_N",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "...ë.....",
            ".........",
            "||⁸⁸|||+|",
            "....A.|.Y",
            "J.....]r.",
            "V..bë.]ɱh",
            "J..8..]r.",
            "Y.....⁸..",
            "....o.|JJ",
        },
        palettes = { "lab_common_palette", "lab_medical_palette" },
    },
}

-- A nested map for a 9x9 medical room, includes door and north wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medical_9x9_N",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "....ë....",
            ".ƃ.......",
            "||||⁸||||",
            ".h.....5Y",
            "....ë....",
            "ppppppppp",
            "....p....",
            ".ë..p..ë.",
            "VГo.p.ГoV",
        },
        palettes = { "lab_common_palette", "lab_medical_palette" },
        vehicle_glyphs = {
            ["ƃ"] = { id = "wheelchair", rotation = 90 },
            ["Г"] = { id = "hospital_bed", rotation = 90 },
        },
    },
}

-- A nested map for a 9x9 medical room, includes door and north wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medical_9x9_S",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "Vւo.p.ւoV",
            ".ë..p.ë.A",
            "A...p....",
            "ppppppppp",
            "....ë....",
            ".4.....E.",
            "||||⁸||||",
            ".........",
            "....ë....",
        },
        palettes = { "lab_common_palette", "lab_medical_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
        vehicle_glyphs = { ["ւ"] = { id = "hospital_bed", rotation = 270 } },
    },
}

-- A nested map for a 9x9 medical room, includes door and north wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medical_9x9_N",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "....ë....",
            ".........",
            "||+|||+||",
            "...h|...Y",
            ".ƨ..|J..ƃ",
            ".ƨ.ƃ|Zhë.",
            ".ƨë.|J.Ƨ.",
            ".ƨ..|pppp",
            "..AZ|h...",
        },
        palettes = { "lab_common_palette", "lab_medical_palette" },
        furniture = { ["Ƨ"] = { { id = "f_treadmill" }, { id = "f_treadmill_mechanical" } } },
        vehicle_glyphs = { ["ƃ"] = { id = "wheelchair", rotation = 90 } },
    },
}

-- A nested map for a 9x9 medical room, includes door and north wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medical_9x9_S",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "A...|Z...",
            "pppp|A.ƨ.",
            ".ɔ.J|..ƨ.",
            "ƃë.Z|.ëƨ.",
            "...J|ƃ.ƨ.",
            ".h.Y|y...",
            "||+|||+||",
            ".........",
            "....ë....",
        },
        palettes = { "lab_common_palette", "lab_medical_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
        vehicle_glyphs = { ["ƃ"] = { id = "wheelchair", rotation = 90 } },
    },
}

-- A nested map for a 9x9 medical room, includes door and north wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medical_9x9_N",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "....ë....",
            ".........",
            "||+|||+||",
            "V..h|...Y",
            "..o4|ÆJJ.",
            ".ë.E|.Aë.",
            "4..s|ÆJJ.",
            "E...|A...",
            "s.o.|JÆJJ",
        },
        palettes = { "lab_common_palette", "lab_medical_palette" },
        vehicle_glyphs = { ["ƃ"] = { id = "wheelchair", rotation = 90 } },
    },
}

-- A nested map for a 9x9 medical room, includes door and north wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medical_9x9_S",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "A...|Z...",
            "pppp|A.ƨ.",
            ".Ƨ.J|..ƨ.",
            "ƃ.ëZ|.ëƨ.",
            "...J|ƃ.ƨ.",
            ".h.Y|y...",
            "||+|||+||",
            ".........",
            "....ë....",
        },
        palettes = { "lab_common_palette", "lab_medical_palette" },
        furniture = { ["Ƨ"] = { { id = "f_treadmill" }, { id = "f_treadmill_mechanical" } } },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
        vehicle_glyphs = { ["ƃ"] = { id = "wheelchair", rotation = 90 } },
    },
}

-- A nested map for a 9x9 medical room, includes door and south wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medical_9x9_S_autodoc",
    weight = 100,
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "J.o...|SJ",
            "k.ɔЯ..⁸..",
            "J..ë..|.9",
            "XXXXXX|⁸|",
            "rrrɱrr|.L",
            "A..A..|.L",
            "|]⁸⁸]||+|",
            "j........",
            "j...ë....",
        },
        palettes = { "lab_common_palette", "lab_medical_palette" },
        monster_placements = { { choices = { "mon_nursebot", "mon_nursebot_defective" }, x = 4, y = 2, chance = 100 } },
        item_groups = { L = { { group = "hazmat_masks", chance = 70 }, { group = "hazmat_suits", chance = 70 } } },
    },
}

-- A nested map for a 9x9 medical room, includes door and north wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medical_9x9_N_autodoc",
    weight = 100,
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "j....ë...",
            "j........",
            "|]⁸⁸]||+|",
            ".A..A.|.L",
            "rrrɱrr|.L",
            "XXXXXX|+|",
            "J..ë..|.9",
            "k.ɔЯ..+..",
            "J....o|SJ",
        },
        palettes = { "lab_common_palette", "lab_medical_palette" },
        monster_placements = { { choices = { "mon_nursebot", "mon_nursebot_defective" }, x = 4, y = 6, chance = 100 } },
        item_groups = { L = { { group = "hazmat_masks", chance = 70 }, { group = "hazmat_suits", chance = 70 } } },
    },
}

-- A custom nest for the mutant child boss
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medical_boss_child",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            ".O...Q",
            "...O.N",
            ".....Q",
            ".ff7..",
            "...HH.",
            ".O....",
        },
        palettes = { "lab_common_palette", "lab_medical_palette" },
        furniture = { O = "f_floor_mattress" },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
        item_group_placements = {
            { group = "mutagen_or_serum_kit", x = 5, y = 0, repetitions = { 3, 5 }, chance = 100 },
            { group = "lab_mutagen_ingredients", x = 5, y = 0, repetitions = { 1, 8 }, chance = 90 },
            { group = "supplies_reagents_lab", x = 5, y = 2, repetitions = { 1, 4 }, chance = 90 },
            { group = "chem_lab", x = 5, y = 2, repetitions = { 3, 5 }, chance = 80 },
            { group = "dissection", x = 1, y = 3, repetitions = { 1, 3 }, chance = 50 },
            {
                group = "stash_food",
                x = { 0, 5 },
                y = { 4, 5 },
                chance = 75,
                repetitions = { 1, 2 },
            },
        },
        monster_placements = {
            { group = "GROUP_LAB_MUTANT_BOSS", x = { 0, 5 }, y = { 0, 5 }, repetitions = { 6, 8 } },
            { id = "mon_mutant_alpha_boss", x = 2, y = 2 },
        },
    },
}

-- A nested map for a 6x6 medical room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medical_6x6_open",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "......",
            ".7A...",
            ".oւ..Q",
            "...ë.V",
            "......",
            "5...Y.",
        },
        palettes = { "lab_common_palette", "lab_medical_palette" },
        vehicle_glyphs = { ["ւ"] = { id = "hospital_bed", rotation = 270 } },
    },
}

-- A nested map for a 6x6 medical room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medical_6x6_open",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "......",
            ".|||..",
            ".J|J.Q",
            ".J|k.Q",
            ".|||..",
            "......",
        },
        palettes = { "lab_common_palette", "lab_medical_palette" },
    },
}

-- A nested map for a 6x6 medical room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medical_6x6_open",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "QQ..qq",
            "......",
            ".J6e.a",
            "..ëA..",
            ".3JJY.",
            ".A....",
        },
        palettes = { "lab_common_palette", "lab_medical_palette" },
        computer_glyphs = { ["6"] = {} },
    },
}
