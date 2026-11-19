local ccb = require("ccb")

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
        palettes = { "lab_common_palette", "fcl_vanilla_lab_medical_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
        vehicle_glyphs = { ["ƃ"] = { id = "wheelchair", rotation = 90 } },
    },
}

-- A nested map for a 9x9 medical room, includes door and south wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medical_9x9_S_autodoc",
    weight = 2500,
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
        palettes = { "lab_common_palette", "fcl_vanilla_lab_medical_palette" },
        monster_placements = { { choices = { "mon_nursebot", "mon_nursebot_defective" }, x = 4, y = 2, chance = 100 } },
        item_groups = { L = { { group = "hazmat_masks", chance = 70 }, { group = "hazmat_suits", chance = 70 } } },
    },
}

-- A nested map for a 9x9 medical room, includes door and north wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medical_9x9_N_autodoc",
    weight = 2500,
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
        palettes = { "lab_common_palette", "fcl_vanilla_lab_medical_palette" },
        monster_placements = { { choices = { "mon_nursebot", "mon_nursebot_defective" }, x = 4, y = 6, chance = 100 } },
        item_groups = { L = { { group = "hazmat_masks", chance = 70 }, { group = "hazmat_suits", chance = 70 } } },
    },
}
