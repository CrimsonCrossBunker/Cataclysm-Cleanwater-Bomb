local ccb = require("ccb")

-- A nested map for the Phavian secret office lab room south of the hall, door in the upper left. This is a meeting room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DN8x8",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "....dddd",
            "..ꞝccꞝ.d",
            "..cttc.&",
            "..cttc..",
            "..cttc..",
            "..cttc..",
            "..ꞝccꞝ..",
            "y......y",
        },
        palettes = { "office_phavian_palette" },
        terrain = { t = "t_carpet_linoleum_gray_green", c = "t_carpet_linoleum_gray_green" },
        item_placements = {
            { id = "water_clean", x = 4, y = 0, chance = 30, repetitions = { 1, 2 } },
            { id = "water_clean", x = 5, y = 0, chance = 30, repetitions = { 1, 2 } },
            { id = "water_clean", x = 6, y = 0, chance = 30, repetitions = { 1, 2 } },
            { id = "water_clean", x = 7, y = 0, chance = 30, repetitions = { 1, 2 } },
            { id = "water_clean", x = 7, y = 1, chance = 30, repetitions = { 1, 2 } },
        },
        item_groups = {
            d = { { group = "SUS_office_desk", chance = 50, repetitions = { 1, 2 } } },
            t = { group = "SUS_office_desk", chance = 20 },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 0, 7 },
                y = { 0, 7 },
                repetitions = { 1, 3 },
                chance = 50,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab room north of the hall, door in the lower right. This is a meeting room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DS8x8",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "y......y",
            "..ꞝccꞝ..",
            "..cttc..",
            "..cttc..",
            "..cttc..",
            "&.cttc..",
            "d.ꞝccꞝ..",
            "dddd....",
        },
        palettes = { "office_phavian_palette" },
        terrain = { t = "t_carpet_linoleum_gray_green", c = "t_carpet_linoleum_gray_green" },
        item_placements = {
            { id = "water_clean", x = 0, y = 6, chance = 30, repetitions = { 1, 2 } },
            { id = "water_clean", x = 0, y = 7, chance = 30, repetitions = { 1, 2 } },
            { id = "water_clean", x = 1, y = 7, chance = 30, repetitions = { 1, 2 } },
            { id = "water_clean", x = 2, y = 7, chance = 30, repetitions = { 1, 2 } },
            { id = "water_clean", x = 3, y = 7, chance = 30, repetitions = { 1, 2 } },
        },
        item_groups = {
            d = { { group = "SUS_office_desk", chance = 50, repetitions = { 1, 2 } } },
            t = { group = "SUS_office_desk", chance = 20 },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 0, 7 },
                y = { 0, 7 },
                repetitions = { 1, 3 },
                chance = 50,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab room south of the hall, door in the upper left. This is a presentation room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DN8x8",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "..cccc.t",
            "..dddd.t",
            ".......&",
            "..cccc..",
            "..dddd..",
            "........",
            ".......t",
            "..ddddɱt",
        },
        palettes = { "office_phavian_palette" },
        item_placements = {
            { id = "water_clean", x = 7, y = 0, chance = 30, repetitions = { 1, 2 } },
            { id = "water_clean", x = 7, y = 1, chance = 30, repetitions = { 1, 2 } },
            { id = "television", x = 3, y = 7, chance = 100 },
            { id = "television", x = 4, y = 7, chance = 100 },
        },
        item_groups = {
            t = { group = "SUS_office_desk", chance = 40 },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 0, 7 },
                y = { 0, 7 },
                repetitions = { 1, 3 },
                chance = 50,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab room north of the hall, door in the lower right. This is a presentation room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DS8x8",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "tɱdddd..",
            "t.......",
            "........",
            "..dddd..",
            "..cccc..",
            "&.......",
            "t.dddd..",
            "t.cccc..",
        },
        palettes = { "office_phavian_palette" },
        item_placements = {
            { id = "water_clean", x = 0, y = 6, chance = 30, repetitions = { 1, 2 } },
            { id = "water_clean", x = 0, y = 7, chance = 30, repetitions = { 1, 2 } },
            { id = "television", x = 3, y = 0, chance = 100 },
            { id = "television", x = 4, y = 0, chance = 100 },
        },
        item_groups = {
            t = { group = "SUS_office_desk", chance = 40 },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 0, 7 },
                y = { 0, 7 },
                repetitions = { 1, 3 },
                chance = 50,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab room south of the hall, door in the upper left.  This is a general office room for writing reports
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DN8x8",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "&.ll-dɱd",
            "....-.c&",
            "d...-..I",
            "ɱc.....d",
            "I.....cɱ",
            "--....--",
            "&c..c.cɱ",
            "ddɱIɱ&dd",
        },
        palettes = { "office_phavian_palette" },
        terrain = {
            ["."] = "t_carpet_linoleum_white_purple",
            c = "t_carpet_linoleum_white_purple",
            ["&"] = "t_carpet_linoleum_white_purple",
            ["-"] = "t_carpet_linoleum_white_purple",
        },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 30, repetitions = { 1, 3 } },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            I = { group = "SUS_office_filing_cabinet", chance = 80 },
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 1, 6 },
                y = { 1, 6 },
                repetitions = { 1, 3 },
                chance = 60,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab room north of the hall, door in the lower right.  This is a general office room for writing reports
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DS8x8",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "dd&ɱIɱdd",
            "ɱc.c..c&",
            "--....--",
            "ɱc.....I",
            "d.....cɱ",
            "I..-...d",
            "&c.-....",
            "dɱd-ll.&",
        },
        palettes = { "office_phavian_palette" },
        terrain = {
            ["."] = "t_carpet_linoleum_white_purple",
            c = "t_carpet_linoleum_white_purple",
            ["&"] = "t_carpet_linoleum_white_purple",
            ["-"] = "t_carpet_linoleum_white_purple",
        },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 30, repetitions = { 1, 3 } },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            I = { group = "SUS_office_filing_cabinet", chance = 80 },
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 1, 6 },
                y = { 1, 6 },
                repetitions = { 1, 3 },
                chance = 60,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab room south of the hall, door in the upper left. This is a matrix crystal analysis room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DN8x8",
    weight = 900,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "..&lçççɱ",
            "......cc",
            "...çç...",
            "C.AççA..",
            "C..ɱɱ...",
            "ɱ......U",
            "çc..c..U",
            "çE.ççUUU",
        },
        palettes = { "office_phavian_palette" },
        item_placements = {
            { id = "matrix_channeling_tool", x = 3, y = 2, chance = 25 },
            { id = "matrix_channeling_tool", x = 3, y = 3, chance = 25 },
            { id = "matrix_channeling_tool", x = 4, y = 2, chance = 25 },
            { id = "matrix_channeling_tool", x = 4, y = 3, chance = 25 },
        },
        item_groups = {
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            C = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            E = { { group = "dist_matrix_crystals_50_50", chance = 80 } },
            U = { group = "psi_lab", chance = 70, repetitions = { 1, 3 } },
            ["ç"] = { group = "psi_lab", chance = 20 },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 1, 6 },
                y = { 1, 6 },
                repetitions = { 1, 3 },
                chance = 50,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab room north of the hall, door in the lower right. This is a candidate testing room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DS8x8",
    weight = 900,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "........",
            "cP....Pc",
            "---..---",
            "cP....Pc",
            "........",
            "---..---",
            "cc......",
            "ɱçççl&..",
        },
        palettes = { "office_phavian_palette" },
        item_placements = { { id = "phavian_noetic_resonance_detector_instructions", x = 2, y = 7, chance = 50 } },
        item_groups = {
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            C = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            ["ç"] = { group = "psi_lab", chance = 20 },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 1, 6 },
                y = { 1, 6 },
                repetitions = { 1, 3 },
                chance = 50,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab room south of the hall, door in the upper left. This is a candidate testing room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DN8x8",
    weight = 900,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "..&lçççɱ",
            "......cc",
            "---..---",
            "........",
            "cP....Pc",
            "---..---",
            "cP....Pc",
            "........",
        },
        palettes = { "office_phavian_palette" },
        item_placements = { { id = "phavian_noetic_resonance_detector_instructions", x = 5, y = 0, chance = 50 } },
        item_groups = {
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            C = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            ["ç"] = { group = "psi_lab", chance = 20 },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 1, 6 },
                y = { 1, 6 },
                repetitions = { 1, 3 },
                chance = 50,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab room north of the hall, door in the lower right. This is a matrix crystal analysis room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DS8x8",
    weight = 900,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "UUUçç.Eç",
            "U..c..cç",
            "U......ɱ",
            "...ɱɱ..C",
            "..AççA.C",
            "...çç...",
            "cc......",
            "ɱçççl&..",
        },
        palettes = { "office_phavian_palette" },
        item_placements = {
            { id = "matrix_channeling_tool", x = 3, y = 4, chance = 25 },
            { id = "matrix_channeling_tool", x = 3, y = 5, chance = 25 },
            { id = "matrix_channeling_tool", x = 4, y = 4, chance = 25 },
            { id = "matrix_channeling_tool", x = 4, y = 5, chance = 25 },
        },
        item_groups = {
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            C = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            E = { { group = "dist_matrix_crystals_50_50", chance = 80 } },
            U = { group = "psi_lab", chance = 70, repetitions = { 1, 3 } },
            ["ç"] = { group = "psi_lab", chance = 20 },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 1, 6 },
                y = { 1, 6 },
                repetitions = { 1, 3 },
                chance = 50,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab room south of the hall, door in the upper left.  This is a manufactory.
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DN8x8",
    weight = 800,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "..&llSĆĆ",
            "........",
            ":::==:::",
            "&......C",
            "U..CC..C",
            "U..CC..p",
            "U..MM..C",
            "U......C",
        },
        palettes = { "office_phavian_palette" },
        furniture = { ["Ć"] = "f_counter" },
        item_placements = {
            { id = "force_field_generator_broken", x = 3, y = 4, chance = 50 },
            { id = "force_field_generator", x = 3, y = 4, chance = 10 },
        },
        item_groups = {
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
                { group = "hardware_clothing", chance = 60, repetitions = { 1, 5 } },
                { group = "decontamination_room", chance = 10, repetitions = { 1, 3 } },
            },
            C = {
                { group = "psi_lab", chance = 10, repetitions = { 1, 3 } },
                { group = "supplies_electronics", chance = 40, repetitions = { 1, 4 } },
                { group = "hardware", chance = 20, repetitions = { 1, 3 } },
            },
            U = {
                { group = "psi_lab", chance = 40, repetitions = { 1, 3 } },
                { group = "supplies_electronics", chance = 60, repetitions = { 1, 4 } },
                { group = "hardware", chance = 30, repetitions = { 1, 5 } },
            },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                id = "mon_zombie_technician",
                x = { 1, 6 },
                y = { 3, 7 },
                repetitions = { 2, 4 },
                chance = 50,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab room north of the hall, door in the lower right.  This is a manufactory.
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DS8x8",
    weight = 800,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "C......U",
            "C..MM..U",
            "p..CC..U",
            "C..CC..U",
            "C......&",
            ":::==:::",
            "........",
            "ĆĆSll&..",
        },
        palettes = { "office_phavian_palette" },
        furniture = { ["Ć"] = "f_counter" },
        item_placements = {
            { id = "force_field_generator_broken", x = 4, y = 3, chance = 50 },
            { id = "force_field_generator", x = 4, y = 3, chance = 10 },
        },
        item_groups = {
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
                { group = "hardware_clothing", chance = 60, repetitions = { 1, 5 } },
                { group = "decontamination_room", chance = 10, repetitions = { 1, 3 } },
            },
            C = {
                { group = "psi_lab", chance = 10, repetitions = { 1, 3 } },
                { group = "supplies_electronics", chance = 40, repetitions = { 1, 4 } },
                { group = "hardware", chance = 20, repetitions = { 1, 3 } },
            },
            U = {
                { group = "psi_lab", chance = 40, repetitions = { 1, 3 } },
                { group = "supplies_electronics", chance = 60, repetitions = { 1, 4 } },
                { group = "hardware", chance = 30, repetitions = { 1, 5 } },
            },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                id = "mon_zombie_technician",
                x = { 1, 6 },
                y = { 0, 4 },
                repetitions = { 2, 4 },
                chance = 50,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab room south of the hall, door in the upper left.  This is a bedroom for crashing in.
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DN8x8",
    weight = 750,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "..y&|9CS",
            "....+..T",
            "Y...||||",
            "B.B..B.B",
            "B.B..B.B",
            "l......l",
            "B.B..B.B",
            "B.BllB.B",
        },
        palettes = { "office_phavian_palette" },
        furniture = { ["9"] = "f_shower" },
        toilets = { "T" },
        item_groups = {
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
                { group = "underwear_womens", chance = 20, repetitions = { 1, 4 } },
                { group = "underwear_mens", chance = 35, repetitions = { 1, 4 } },
                { group = "clothing_work_pants", chance = 40, repetitions = { 1, 8 } },
                { group = "dress_shoes", chance = 15, repetitions = { 1, 2 } },
                { group = "shirts", chance = 15, repetitions = { 1, 3 } },
            },
            C = {
                { group = "SUS_bathroom_medicine", chance = 100 },
                { group = "SUS_bathroom_cabinet", chance = 50 },
            },
            S = { group = "SUS_bathroom_sink", chance = 100, repetitions = { 1, 2 } },
            Y = { group = "jackets", chance = 33, repetitions = { 1, 2 } },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            T = { group = "SUS_toilet", chance = 50 },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 1, 6 },
                y = { 1, 6 },
                repetitions = { 3, 6 },
                chance = 70,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab room north of the hall, door in the lower right.  This is a bedroom for crashing in.
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DS8x8",
    weight = 750,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "B.BllB.B",
            "B.B..B.B",
            "l......l",
            "B.B..B.B",
            "B.B..B.B",
            "||||...Y",
            "T..+....",
            "SC9|&y..",
        },
        palettes = { "office_phavian_palette" },
        furniture = { ["9"] = "f_shower" },
        toilets = { "T" },
        item_groups = {
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
                { group = "underwear_womens", chance = 20, repetitions = { 1, 4 } },
                { group = "underwear_mens", chance = 35, repetitions = { 1, 4 } },
                { group = "clothing_work_pants", chance = 40, repetitions = { 1, 8 } },
                { group = "dress_shoes", chance = 15, repetitions = { 1, 2 } },
                { group = "shirts", chance = 15, repetitions = { 1, 3 } },
            },
            C = {
                { group = "SUS_bathroom_medicine", chance = 100 },
                { group = "SUS_bathroom_cabinet", chance = 50 },
            },
            S = { group = "SUS_bathroom_sink", chance = 100, repetitions = { 1, 2 } },
            Y = { group = "jackets", chance = 33, repetitions = { 1, 2 } },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            T = { group = "SUS_toilet", chance = 50 },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 1, 6 },
                y = { 1, 6 },
                repetitions = { 3, 6 },
                chance = 70,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab room south of the hall, door in the upper left.  This room is for biokinetic testing.
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DN8x8",
    weight = 750,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "..&llSCC",
            "........",
            "........",
            "d...V.HɃ",
            "ɱc......",
            "d...V.HɃ",
            "ɱc......",
            "d...V.HɃ",
        },
        furniture = {
            H = { { id = "f_treadmill" }, { id = "f_treadmill_mechanical" } },
            V = "f_exercise",
            ["Ƀ"] = "f_bigmirror",
        },
        palettes = { "office_phavian_palette" },
        item_group_placements = {
            {
                group = "matrix_crystal_biokin_dust_group",
                x = 0,
                y = 3,
                chance = 45,
                repetitions = { 1, 3 },
            },
            {
                group = "matrix_crystal_vitakin_dust_group",
                x = 0,
                y = 3,
                chance = 45,
                repetitions = { 1, 3 },
            },
            {
                group = "matrix_crystal_biokin_dust_group",
                x = 0,
                y = 5,
                chance = 45,
                repetitions = { 1, 3 },
            },
            {
                group = "matrix_crystal_vitakin_dust_group",
                x = 0,
                y = 5,
                chance = 45,
                repetitions = { 1, 3 },
            },
            {
                group = "matrix_crystal_biokin_dust_group",
                x = 0,
                y = 7,
                chance = 45,
                repetitions = { 1, 3 },
            },
            {
                group = "matrix_crystal_vitakin_dust_group",
                x = 0,
                y = 7,
                chance = 45,
                repetitions = { 1, 3 },
            },
        },
        item_placements = {
            { id = "matrix_crystal_biokinesis", x = 0, y = 5, chance = 25 },
            { id = "matrix_crystal_vitakinesis", x = 0, y = 5, chance = 10 },
            { id = "lab_file_biokinesis_item", x = 0, y = 3, chance = 20 },
            { id = "lab_file_vitakinesis_item", x = 0, y = 3, chance = 20 },
        },
        item_groups = {
            l = { { group = "boxing_clothes", chance = 40, repetitions = { 1, 8 } } },
            d = {
                { group = "SUS_office_desk", chance = 60, repetitions = { 1, 2 } },
                { group = "psi_lab", chance = 30, repetitions = { 0, 2 } },
            },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 1, 6 },
                y = { 1, 6 },
                repetitions = { 2, 4 },
                chance = 60,
            },
            {
                group = "GROUP_FERAL_BIOKINETIC",
                x = { 1, 6 },
                y = { 1, 6 },
                repetitions = { 1, 2 },
                chance = 60,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab room north of the hall, door in the lower right.  This room is for biokinetic testing.
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DS8x8",
    weight = 750,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "ɃH.V...d",
            "......cɱ",
            "ɃH.V...d",
            "......cɱ",
            "ɃH.V...d",
            "........",
            "........",
            "CCSll&..",
        },
        furniture = {
            H = { { id = "f_treadmill" }, { id = "f_treadmill_mechanical" } },
            V = "f_exercise",
            ["Ƀ"] = "f_bigmirror",
        },
        palettes = { "office_phavian_palette" },
        item_group_placements = {
            {
                group = "matrix_crystal_biokin_dust_group",
                x = 7,
                y = 2,
                chance = 45,
                repetitions = { 1, 3 },
            },
            {
                group = "matrix_crystal_vitakin_dust_group",
                x = 7,
                y = 2,
                chance = 45,
                repetitions = { 1, 3 },
            },
            {
                group = "matrix_crystal_biokin_dust_group",
                x = 7,
                y = 4,
                chance = 45,
                repetitions = { 1, 3 },
            },
            {
                group = "matrix_crystal_vitakin_dust_group",
                x = 7,
                y = 4,
                chance = 45,
                repetitions = { 1, 3 },
            },
            {
                group = "matrix_crystal_biokin_dust_group",
                x = 7,
                y = 6,
                chance = 45,
                repetitions = { 1, 3 },
            },
            {
                group = "matrix_crystal_vitakin_dust_group",
                x = 7,
                y = 6,
                chance = 45,
                repetitions = { 1, 3 },
            },
        },
        item_placements = {
            { id = "matrix_crystal_biokinesis", x = 7, y = 2, chance = 25 },
            { id = "matrix_crystal_vitakinesis", x = 7, y = 2, chance = 10 },
            { id = "lab_file_biokinesis_item", x = 7, y = 4, chance = 20 },
            { id = "lab_file_vitakinesis_item", x = 7, y = 4, chance = 20 },
        },
        item_groups = {
            l = { { group = "boxing_clothes", chance = 40, repetitions = { 1, 8 } } },
            d = {
                { group = "SUS_office_desk", chance = 60, repetitions = { 1, 2 } },
                { group = "psi_lab", chance = 30, repetitions = { 0, 2 } },
            },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 1, 6 },
                y = { 1, 6 },
                repetitions = { 2, 4 },
                chance = 60,
            },
            {
                group = "GROUP_FERAL_BIOKINETIC",
                x = { 1, 6 },
                y = { 1, 6 },
                repetitions = { 1, 2 },
                chance = 60,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab room south of the hall, door in the upper left.  This room is for clairsentient/telepathic testing.
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DN8x8",
    weight = 750,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "..&llSCC",
            "........",
            "........",
            "ɱc..P...",
            "đ...P...",
            "U.dcPcd.",
            "đ...P...",
            "ɱc..P...",
        },
        furniture = { P = "f_curtain", ["đ"] = "f_desk" },
        palettes = { "office_phavian_palette" },
        item_placements = {
            { id = "deck_of_cards", x = 2, y = 5, chance = 60 },
            { id = "cards_zener", x = 2, y = 5, chance = 80 },
            { id = "pen", x = 2, y = 5, chance = 60 },
            { id = "blue_pen", x = 2, y = 5, chance = 60 },
            { id = "green_pen", x = 2, y = 5, chance = 60 },
            { id = "red_pen", x = 2, y = 5, chance = 60 },
            { id = "envelope", x = 2, y = 5, chance = 60, repetitions = { 1, 4 } },
            { id = "paper", x = 2, y = 5, repetitions = { 2, 10 }, chance = 90 },
            { id = "pen", x = 6, y = 5, chance = 100 },
            { id = "paper", x = 6, y = 5, repetitions = { 2, 10 }, chance = 90 },
            { id = "lab_file_telepathy_item", x = 0, y = 6, chance = 40 },
        },
        item_groups = {
            U = {
                { group = "cleaning", chance = 70, repetitions = { 1, 3 } },
                { group = "novels", chance = 100, repetitions = { 1, 3 } },
            },
            ["đ"] = { group = "SUS_office_desk", chance = 30, repetitions = { 1, 3 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 1, 6 },
                y = { 1, 6 },
                repetitions = { 2, 4 },
                chance = 60,
            },
            {
                group = "GROUP_FERAL_CLAIRSENTIENT",
                x = 5,
                y = { 3, 6 },
                repetitions = { 1, 2 },
                chance = 80,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab room north of the hall, door in the lower right.  This room is for clairsentient/telepathic testing.
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DS8x8",
    weight = 750,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "...P..cɱ",
            "...P...đ",
            ".dcPcd.U",
            "...P...đ",
            "...P..cɱ",
            "........",
            "........",
            "CCSll&..",
        },
        furniture = { P = "f_curtain", ["đ"] = "f_desk" },
        palettes = { "office_phavian_palette" },
        item_placements = {
            { id = "deck_of_cards", x = 5, y = 2, chance = 60 },
            { id = "pen", x = 5, y = 2, chance = 60 },
            { id = "blue_pen", x = 5, y = 2, chance = 60 },
            { id = "green_pen", x = 5, y = 2, chance = 60 },
            { id = "red_pen", x = 5, y = 2, chance = 60 },
            { id = "envelope", x = 5, y = 2, chance = 60, repetitions = { 1, 4 } },
            { id = "paper", x = 5, y = 2, repetitions = { 2, 10 }, chance = 90 },
            { id = "pen", x = 1, y = 2, chance = 100 },
            { id = "paper", x = 1, y = 2, repetitions = { 2, 10 }, chance = 90 },
            { id = "lab_file_telepathy_item", x = 7, y = 1, chance = 40 },
        },
        item_groups = {
            U = {
                { group = "cleaning", chance = 70, repetitions = { 1, 3 } },
                { group = "novels", chance = 100, repetitions = { 1, 3 } },
            },
            ["đ"] = { group = "SUS_office_desk", chance = 30, repetitions = { 1, 3 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 1, 6 },
                y = { 1, 6 },
                repetitions = { 2, 4 },
                chance = 60,
            },
            {
                group = "GROUP_FERAL_CLAIRSENTIENT",
                x = 1,
                y = { 0, 3 },
                repetitions = { 1, 2 },
                chance = 80,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab room south of the hall, door in the upper left.  This is a telepathic amplifier.
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DN8x8",
    weight = 650,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "..&llSCC",
            "........",
            ":::==:::",
            "ɱ.....Aɱ",
            "A......ç",
            "...ɱŦ..ç",
            "U..Aɱ..S",
            "UU.....U",
        },
        palettes = { "office_phavian_palette" },
        item_group_placements = {
            {
                group = "matrix_crystal_telepath_dust_group",
                x = 7,
                y = 4,
                chance = 40,
                repetitions = { 1, 3 },
            },
        },
        item_groups = {
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            U = {
                { group = "psi_lab", chance = 50, repetitions = { 1, 3 } },
                { group = "SUS_bathroom_medicine", chance = 100 },
            },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 1, 6 },
                y = { 1, 6 },
                repetitions = { 1, 3 },
                chance = 60,
            },
            { group = "GROUP_FERAL_TELEPATH", x = 5, y = 5, chance = 80 },
        },
    },
}

-- A nested map for the Phavian secret office lab room north of the hall, door in the lower right.  This is a telepathic amplifier.
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DS8x8",
    weight = 650,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "U.....UU",
            "S..ɱA..U",
            "ç..Ŧɱ...",
            "ç......A",
            "ɱA.....ɱ",
            ":::==:::",
            "........",
            "CCSll&..",
        },
        palettes = { "office_phavian_palette" },
        item_group_placements = {
            {
                group = "matrix_crystal_telepath_dust_group",
                x = 0,
                y = 3,
                chance = 40,
                repetitions = { 1, 3 },
            },
        },
        item_groups = {
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            U = {
                { group = "psi_lab", chance = 50, repetitions = { 1, 3 } },
                { group = "SUS_bathroom_medicine", chance = 100 },
            },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 1, 6 },
                y = { 1, 6 },
                repetitions = { 1, 3 },
                chance = 60,
            },
            { group = "GROUP_FERAL_TELEPATH", x = 2, y = 2, chance = 80 },
        },
    },
}

-- A nested map for the Phavian secret office lab room south of the hall, door in the upper left.  This is a weapons lab
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DN8x8",
    weight = 450,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "..&l....",
            "........",
            "...çç...",
            "...ⱮⱮ..ç",
            "C..Aɱ..è",
            "C......M",
            "CA....cɱ",
            "C.....UU",
        },
        palettes = { "office_phavian_palette" },
        furniture = { ["è"] = "f_lab_bench" },
        item_placements = {
            { id = "grenade_inferno", x = 7, y = 3, chance = 30, repetitions = { 1, 2 } },
            { id = "grenade_inferno", x = 7, y = 4, chance = 60, repetitions = { 1, 3 } },
            { id = "schematics_grenade_inferno", x = 7, y = 7, chance = 60 },
        },
        item_groups = {
            ["è"] = {
                { group = "psi_lab", chance = 20, repetitions = { 1, 3 } },
                { group = "dist_pulse_rifles_heavy_prototype", chance = 40 },
            },
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            U = { { group = "psi_lab", chance = 50, repetitions = { 1, 3 } } },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                id = "mon_zombie_technician",
                x = { 0, 7 },
                y = { 0, 7 },
                repetitions = { 2, 4 },
                chance = 60,
            },
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 1, 6 },
                y = { 1, 6 },
                repetitions = { 1, 2 },
                chance = 50,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab room north of the hall, door in the lower right.  This is a weapons lab
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DS8x8",
    weight = 450,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "UU.....C",
            "ɱc....AC",
            "M......C",
            "è..ɱA..C",
            "ç..ⱮⱮ...",
            "...çç...",
            "........",
            "....l&..",
        },
        furniture = { ["è"] = "f_lab_bench" },
        palettes = { "office_phavian_palette" },
        item_placements = {
            { id = "grenade_inferno", x = 0, y = 4, chance = 30, repetitions = { 1, 2 } },
            { id = "grenade_inferno", x = 0, y = 3, chance = 60, repetitions = { 1, 3 } },
            { id = "schematics_grenade_inferno", x = 0, y = 0, chance = 60 },
        },
        item_groups = {
            ["è"] = {
                { group = "psi_lab", chance = 20, repetitions = { 1, 3 } },
                { group = "dist_pulse_rifles_heavy_prototype", chance = 40 },
            },
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            U = { { group = "psi_lab", chance = 50, repetitions = { 1, 3 } } },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                id = "mon_zombie_technician",
                x = { 0, 7 },
                y = { 0, 7 },
                repetitions = { 2, 4 },
                chance = 60,
            },
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 1, 6 },
                y = { 1, 6 },
                repetitions = { 1, 2 },
                chance = 50,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab room south of the hall, door in the upper left.  This is an anomalous materials lab
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DN8x8",
    weight = 500,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "..&llSCC",
            "........",
            ":::==:::",
            "c......U",
            "E..çç..U",
            "ç.Sɱɱ..ç",
            "U.....Sç",
            "UU.cɱçɱç",
        },
        palettes = { "office_phavian_palette" },
        item_placements = {
            { id = "escape_stone", x = 3, y = 4, chance = 30 },
            { id = "vortex_stone", x = 4, y = 4, chance = 30 },
            { id = "calming_stone", x = 0, y = 4, chance = 30 },
            { id = "chaos_stone", x = 7, y = 6, chance = 30 },
        },
        item_groups = {
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
                { group = "decontamination_room", chance = 40, repetitions = { 1, 3 } },
            },
            U = { { group = "psi_lab", chance = 50, repetitions = { 1, 3 } } },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_NETHER",
                x = { 0, 7 },
                y = { 3, 7 },
                repetitions = { 0, 4 },
                chance = 70,
            },
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 1, 6 },
                y = { 1, 6 },
                repetitions = { 2, 4 },
                chance = 50,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab room north of the hall, door in the lower right.  This is an anomalous materials lab
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_lab_DS8x8",
    weight = 500,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "çɱçɱc.UU",
            "çS.....U",
            "ç..ɱɱS.ç",
            "U..çç..E",
            "U......c",
            ":::==:::",
            "........",
            "CCSll&..",
        },
        palettes = { "office_phavian_palette" },
        item_placements = {
            { id = "escape_stone", x = 4, y = 3, chance = 30 },
            { id = "vortex_stone", x = 3, y = 3, chance = 30 },
            { id = "calming_stone", x = 7, y = 3, chance = 30 },
            { id = "chaos_stone", x = 0, y = 1, chance = 30 },
        },
        item_groups = {
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
                { group = "decontamination_room", chance = 40, repetitions = { 1, 3 } },
            },
            U = { { group = "psi_lab", chance = 50, repetitions = { 1, 3 } } },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_NETHER",
                x = { 0, 7 },
                y = { 0, 4 },
                repetitions = { 0, 4 },
                chance = 70,
            },
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 1, 6 },
                y = { 1, 6 },
                repetitions = { 2, 4 },
                chance = 50,
            },
        },
    },
}

-- A nested map for the Phavian secret office lab security room, near the keylocked entrance, door to the south.
ccb.content.define_mapgen {
    kind = "nested",
    id = "office_phavian_security_DS8x8",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "ddɱdd&.l",
            "dc..c..l",
            "ɱc.....l",
            "d......l",
            "&.......",
            "..ɱc....",
            "..dddd..",
            "y......y",
        },
        palettes = { "office_phavian_palette" },
        item_groups = {
            d = { { group = "SUS_office_desk", chance = 50, repetitions = { 1, 2 } } },
            l = {
                { group = "cop_armory", chance = 40, repetitions = { 2, 3 } },
                { group = "security_torso", chance = 20, repetitions = { 1, 2 } },
                { group = "security_pants", chance = 20, repetitions = { 1, 2 } },
                { group = "security_shoes", chance = 20, repetitions = { 1, 2 } },
            },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_LAB_BASIC_SECURITY",
                x = { 0, 7 },
                y = { 0, 7 },
                repetitions = { 3, 6 },
                chance = 65,
            },
            {
                group = "GROUP_PHAVIAN_OFFICE",
                x = { 1, 6 },
                y = { 1, 6 },
                repetitions = { 2, 4 },
                chance = 40,
            },
        },
    },
}
