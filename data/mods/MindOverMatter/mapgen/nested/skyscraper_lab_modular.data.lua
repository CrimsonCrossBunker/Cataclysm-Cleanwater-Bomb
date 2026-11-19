local ccb = require("ccb")

-- generic office room, door in the upper left
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_south_uldoor",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "&......FF",
            "-..-|-..-",
            "dx.d|dx.d",
            "dc.d|d.cx",
            "d.cd|dc.d",
            "d.xd|d.xd",
            "-..-|-..-",
            ".ccd|.ccd",
            "dxxd|xdxd",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 70 },
                { group = "lab_files_psi", chance = 5 },
                { group = "dist_lab_file_phavian_internal", chance = 2 },
            },
            F = { group = "SUS_office_filing_cabinet", chance = 80 },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            ["."] = { group = "SUS_office_mess", chance = 1 },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 1, 6 },
                y = { 1, 6 },
                chance = 70,
                repetitions = { 3, 7 },
            },
        },
    },
}

-- generic office room, door in the upper right
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_south_urdoor",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "FF......&",
            "-..-|-..-",
            "d.xd|d.xd",
            "xc.d|d.cd",
            "d.cd|dc.d",
            "dx.d|dx.d",
            "-..-|-..-",
            "dcc.|dcc.",
            "dxdx|dxxd",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 70 },
                { group = "lab_files_psi", chance = 5 },
                { group = "dist_lab_file_phavian_internal", chance = 2 },
            },
            F = { group = "SUS_office_filing_cabinet", chance = 80 },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            ["."] = { group = "SUS_office_mess", chance = 1 },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 1, 6 },
                y = { 1, 6 },
                chance = 70,
                repetitions = { 3, 7 },
            },
        },
    },
}

-- A nested map for the Phavian secret skyscraper lab room on the south side, door in the upper right.  This room is for clairsentient/telepathic blind testing.
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_south_urdoor",
    weight = 850,
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "CCCSll..&",
            ".........",
            ".........",
            "xc...P...",
            "đ....P...",
            "U..ĐcPcd.",
            "đ....P...",
            "xc...P...",
            "đđĐ..P.đđ",
        },
        furniture = { P = "f_curtain", ["đ"] = "f_desk", ["Đ"] = "f_desk" },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_placements = {
            { id = "pen", x = 7, y = 5, chance = 100 },
            { id = "paper", x = 7, y = 5, repetitions = { 2, 10 }, chance = 90 },
            { id = "lab_file_telepathy_item", x = 0, y = 1, chance = 40 },
            { id = "lab_file_clairsentience_item", x = 0, y = 1, chance = 40 },
        },
        item_groups = {
            d = {
                { group = "clairsentient_matrix_crystals_group", chance = 5 },
                { group = "telepathic_matrix_crystals_group", chance = 5 },
            },
            U = {
                { group = "cleaning", chance = 70, repetitions = { 1, 3 } },
                { group = "novels", chance = 100, repetitions = { 1, 3 } },
            },
            ["đ"] = { group = "SUS_office_desk", chance = 50 },
            ["Đ"] = { group = "psi_testing_materials", chance = 100, repetitions = { 2, 4 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 1, 8 },
                y = { 1, 7 },
                chance = 60,
                repetitions = { 2, 6 },
            },
            {
                group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH",
                x = 6,
                y = { 4, 8 },
                chance = 80,
                repetitions = { 1, 2 },
            },
        },
    },
}

-- A nested map for the Phavian secret skyscraper lab room on the south side, door in the upper left.  This room is for clairsentient/telepathic blind testing.
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_south_uldoor",
    weight = 850,
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "&..llSCCC",
            ".........",
            ".........",
            "...P...cx",
            "...P....đ",
            ".dcPcĐ..U",
            "...P....đ",
            "...P...cx",
            "đđ.P..Đđđ",
        },
        furniture = { P = "f_curtain", ["đ"] = "f_desk", ["Đ"] = "f_desk" },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_placements = {
            { id = "pen", x = 1, y = 5, chance = 100 },
            { id = "paper", x = 1, y = 5, repetitions = { 2, 10 }, chance = 90 },
            { id = "lab_file_telepathy_item", x = 8, y = 4, chance = 40 },
            { id = "lab_file_clairsentience_item", x = 8, y = 4, chance = 40 },
        },
        item_groups = {
            d = {
                { group = "clairsentient_matrix_crystals_group", chance = 5 },
                { group = "telepathic_matrix_crystals_group", chance = 5 },
            },
            U = {
                { group = "cleaning", chance = 70, repetitions = { 1, 3 } },
                { group = "novels", chance = 100, repetitions = { 1, 3 } },
            },
            ["đ"] = { group = "SUS_office_desk", chance = 30, repetitions = { 1, 3 } },
            ["Đ"] = { group = "psi_testing_materials", chance = 100, repetitions = { 2, 4 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 1, 6 },
                y = { 1, 6 },
                chance = 60,
                repetitions = { 2, 6 },
            },
            {
                group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH",
                x = 1,
                y = { 4, 8 },
                chance = 80,
                repetitions = { 1, 2 },
            },
        },
    },
}

-- A nested map for the Phavian secret skyscraper lab room on the south side, door in the upper right.  This is a telepathic amplifier.
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_south_urdoor",
    weight = 750,
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "CCSll&...",
            ".........",
            "::::=::::",
            "xA.....Fx",
            "ç.......A",
            "ç..Ŧx....",
            "S..xA...U",
            "dc....c.U",
            "dx....xUU",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = { group = "SUS_office_desk", chance = 30 },
            F = { group = "SUS_office_desk", chance = 95 },
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            U = {
                { group = "psi_lab", chance = 50, repetitions = { 1, 3 } },
                { group = "SUS_bathroom_medicine", chance = 20 },
                {
                    group = "matrix_crystal_telepath_dust_group",
                    chance = 50,
                    repetitions = { 2, 4 },
                },
            },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 2, 6 },
                y = { 2, 6 },
                chance = 60,
                repetitions = { 2, 5 },
            },
            { group = "GROUP_FERAL_TELEPATH", x = 5, y = 5, chance = 80 },
        },
    },
}

-- A nested map for the Phavian secret skyscraper lab room on the south side, door in the upper left.  This is a telepathic amplifier.
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_south_uldoor",
    weight = 750,
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "...&llSCC",
            ".........",
            "::::=::::",
            "xF.....Ax",
            "A.......ç",
            "....xŦ..ç",
            "U...Ax..S",
            "U.c....cd",
            "UUx....xd",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
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
            d = { group = "SUS_office_desk", chance = 30 },
            F = { group = "SUS_office_desk", chance = 95 },
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            U = {
                { group = "psi_lab", chance = 50, repetitions = { 1, 3 } },
                { group = "SUS_bathroom_medicine", chance = 20 },
                {
                    group = "matrix_crystal_telepath_dust_group",
                    chance = 50,
                    repetitions = { 2, 4 },
                },
            },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 2, 6 },
                y = { 2, 6 },
                chance = 60,
                repetitions = { 2, 5 },
            },
            { group = "GROUP_FERAL_TELEPATH", x = 5, y = 5, chance = 80 },
        },
    },
}

-- room for researching the PATIENT MOSAIC personality-editing process, doors in the upper left
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_south_uldoor",
    weight = 400,
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "...&lSȻCC",
            "........C",
            ":f::=::f:",
            "......---",
            "C.....jcd",
            "xc.Ş..---",
            "C..X....C",
            "Cc......ç",
            "CxC.MMM.C",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        furniture = {
            f = "f_air_filter",
            X = "f_MRI",
            ["Ş"] = "f_scan_bed",
            ["Ȼ"] = "f_counter",
            ["ç"] = "f_counter",
            j = "f_curtain",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_placements = {
            { id = "lab_file_IG882_P_item", x = 8, y = 4, chance = 50 },
            { id = "phavian_psionic_telepathic_mental_engineering_book", x = 8, y = 7, chance = 85 },
            { id = "telepathic_focusing_tool", x = 8, y = 7, chance = 50 },
        },
        item_groups = {
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            C = { group = "psi_lab_no_recipes", chance = 30, repetitions = { 1, 3 } },
            ["ç"] = { group = "psi_lab_no_recipes", chance = 30, repetitions = { 1, 3 } },
            ["Ȼ"] = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 2, 6 },
                y = { 2, 6 },
                chance = 60,
                repetitions = { 1, 4 },
            },
        },
    },
}

-- room for researching the PATIENT MOSAIC personality-editing process, doors in the upper right
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_south_urdoor",
    weight = 400,
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "CCȻSl&...",
            "C........",
            ":f::=::f:",
            "---......",
            "dcj.....C",
            "---..Ş.cx",
            "C....X..C",
            "ç......cC",
            "C.MMM.CxC",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        furniture = {
            f = "f_air_filter",
            X = "f_MRI",
            ["Ş"] = "f_scan_bed",
            ["Ȼ"] = "f_counter",
            ["ç"] = "f_counter",
            j = "f_curtain",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_placements = {
            { id = "lab_file_IG882_P_item", x = 0, y = 4, chance = 50 },
            { id = "phavian_psionic_telepathic_mental_engineering_book", x = 0, y = 7, chance = 85 },
            { id = "telepathic_focusing_tool", x = 0, y = 7, chance = 50 },
        },
        item_groups = {
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            C = { group = "psi_lab_no_recipes", chance = 30, repetitions = { 1, 3 } },
            ["Ȼ"] = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 2, 6 },
                y = { 2, 6 },
                chance = 60,
                repetitions = { 1, 4 },
            },
        },
    },
}

-- psionic research lab, with possible matrix crystal, doors in the upper right
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_south_urdoor",
    weight = 650,
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "...&lSȻCC",
            ".......AC",
            "Cx..çA.cx",
            "CA.Aç...F",
            "C.......F",
            ":f::=::f:",
            "xc......c",
            "...xEx..x",
            "ççççç5555",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        furniture = { f = "f_air_filter", ["5"] = "f_server", ["Ȼ"] = "f_counter" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_group_placements = { { group = "clairsentient_matrix_crystals_group", x = 4, y = 7, chance = 30 } },
        item_groups = {
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            d = { group = "dist_lab_file_phavian_skyscraper_lab", chance = 5 },
            C = { group = "psi_lab_no_recipes", chance = 30, repetitions = { 1, 3 } },
            F = { group = "electronics", chance = 70, repetitions = { 2, 5 } },
            ["Ȼ"] = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            E = {
                { group = "matrix_crystal_drained_group", chance = 85 },
                { group = "telepathic_matrix_crystals_group", chance = 30 },
            },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 1, 7 },
                y = { 1, 7 },
                chance = 60,
                repetitions = { 2, 5 },
            },
        },
    },
}

-- psionic research lab, with possible matrix crystal, doors in the upper right
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_south_urdoor",
    weight = 650,
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "CCȻSl&...",
            "CA.......",
            "xc.Aç..xC",
            "F...çA.AC",
            "F.......C",
            ":f::=::f:",
            "c......cx",
            "x..xEx...",
            "5555ççççç",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        furniture = { f = "f_air_filter", ["5"] = "f_server", ["Ȼ"] = "f_counter" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_group_placements = { { group = "clairsentient_matrix_crystals_group", x = 4, y = 7, chance = 30 } },
        item_groups = {
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            d = { group = "dist_lab_file_phavian_skyscraper_lab", chance = 5 },
            C = { group = "psi_lab_no_recipes", chance = 30, repetitions = { 1, 3 } },
            F = { group = "electronics", chance = 70, repetitions = { 2, 5 } },
            ["Ȼ"] = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            E = {
                { group = "matrix_crystal_drained_group", chance = 85 },
                { group = "telepathic_matrix_crystals_group", chance = 30 },
            },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 1, 7 },
                y = { 1, 7 },
                chance = 60,
                repetitions = { 2, 5 },
            },
        },
    },
}

-- A nested map for the Phavian secret skyscraper lab room north on the north side, door in the upper right. This is a server room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_south_urdoor",
    weight = 500,
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            ".........",
            ":f:f=f:f:",
            "5.5...5.5",
            "5.5...5.5",
            "5.5.5.5.5",
            "5.5.5.5.5",
            "5.5.5.5.5",
            "5.5.5.5.5",
            "5.5.5.5.5",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        furniture = { ["5"] = "f_server", f = "f_air_filter" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- A nested map for the Phavian secret skyscraper lab room north on the north side, door in the upper left. This is a server room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_south_uldoor",
    weight = 500,
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            ".........",
            ":f:f=f:f:",
            "5.5...5.5",
            "5.5...5.5",
            "5.5.5.5.5",
            "5.5.5.5.5",
            "5.5.5.5.5",
            "5.5.5.5.5",
            "5.5.5.5.5",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        furniture = { ["5"] = "f_server", f = "f_air_filter" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- 4x4 upstairs office with SW wall door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_office_Wdoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "dddd",
            "F c ",
            "    ",
            " HHH",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 25 },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            F = { group = "SUS_office_desk", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
        monster_placements = {
            {
                id = "mon_zombie_scientist_phavian",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 35,
                repetitions = { 0, 2 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 upstairs office with SW wall door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_office_Wdoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "B cd",
            "B  d",
            "F  d",
            "  cd",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 25 },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            F = { group = "SUS_office_desk", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
        monster_placements = {
            {
                id = "mon_zombie_scientist_phavian",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 35,
                repetitions = { 0, 3 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 upstairs office with SW wall door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_office_Wdoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "ddFB",
            "dc F",
            "  cd",
            "  dd",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 25 },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            F = { group = "SUS_office_desk", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
        monster_placements = {
            {
                id = "mon_zombie_scientist_phavian",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 35,
                repetitions = { 0, 3 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 upstairs office with south wall door on west side
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_office_Wdoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "BBHH",
            "F   ",
            "  cd",
            " xdd",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 25 },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            F = { group = "SUS_office_desk", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
        monster_placements = {
            {
                id = "mon_zombie_scientist_phavian",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 35,
                repetitions = { 0, 2 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 upstairs office with SW door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_office_Wdoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "dddd",
            "cddc",
            "    ",
            " FBB",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 25 },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            F = { group = "SUS_office_desk", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
        monster_placements = {
            {
                id = "mon_zombie_scientist_phavian",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 35,
                repetitions = { 0, 3 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 upstairs office with SW door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_office_Wdoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "ddFB",
            "dc F",
            "  cd",
            "  dd",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 25 },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            F = { group = "SUS_office_desk", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
        monster_placements = {
            {
                id = "mon_zombie_scientist_phavian",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 35,
                repetitions = { 0, 3 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 upstairs office with SW door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_office_Wdoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "HH F",
            "H  d",
            "  cd",
            "  dd",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 25 },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            F = { group = "SUS_office_desk", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
        monster_placements = {
            {
                id = "mon_zombie_scientist_phavian",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 35,
                repetitions = { 0, 2 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 upstairs office with SW door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_office_Wdoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "H dd",
            "H cd",
            "   d",
            " BBB",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 25 },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
        monster_placements = {
            {
                id = "mon_zombie_scientist_phavian",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 35,
                repetitions = { 0, 2 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 upstairs office with SE wall door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_office_Edoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "dddd",
            " c F",
            "    ",
            "HHH ",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 25 },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            F = { group = "SUS_office_desk", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
        monster_placements = {
            {
                id = "mon_zombie_scientist_phavian",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 35,
                repetitions = { 0, 2 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 upstairs office with SE wall door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_office_Edoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "dc B",
            "d  B",
            "d  F",
            "dc  ",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 25 },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            F = { group = "SUS_office_desk", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
        monster_placements = {
            {
                id = "mon_zombie_scientist_phavian",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 35,
                repetitions = { 0, 3 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 upstairs office with SE wall door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_office_Edoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "BFdd",
            "F cd",
            "dc  ",
            "dd  ",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 25 },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            F = { group = "SUS_office_desk", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
        monster_placements = {
            {
                id = "mon_zombie_scientist_phavian",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 35,
                repetitions = { 0, 3 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 upstairs office with SE wall door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_office_Edoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "HHBB",
            "   F",
            "dc  ",
            "ddx ",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 25 },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            F = { group = "SUS_office_desk", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
        monster_placements = {
            {
                id = "mon_zombie_scientist_phavian",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 35,
                repetitions = { 0, 2 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 upstairs office with SE door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_office_Edoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "dddd",
            "cddc",
            "    ",
            "BBF ",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 25 },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            F = { group = "SUS_office_desk", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
        monster_placements = {
            {
                id = "mon_zombie_scientist_phavian",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 35,
                repetitions = { 0, 3 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 upstairs office with SE door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_office_Edoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "BFdd",
            "F cd",
            "dc  ",
            "dd  ",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 25 },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            F = { group = "SUS_office_desk", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
        monster_placements = {
            {
                id = "mon_zombie_scientist_phavian",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 35,
                repetitions = { 0, 3 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 upstairs office with SE door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_office_Edoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "F HH",
            "d  H",
            "dc  ",
            "dd  ",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 25 },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            F = { group = "SUS_office_desk", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
        monster_placements = {
            {
                id = "mon_zombie_scientist_phavian",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 35,
                repetitions = { 0, 2 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 upstairs office with SE door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_office_Edoor4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "dd H",
            "dc H",
            "d   ",
            "BBB ",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 25 },
                { group = "electronics", chance = 15 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            H = { group = "bed", chance = 15 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
        monster_placements = {
            {
                id = "mon_zombie_scientist_phavian",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 35,
                repetitions = { 0, 2 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_store_room_3x3",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "HHH",
            "AAc",
            "..c",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        terrain = { ["."] = "t_linoleum_white" },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_store_room_3x3",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "ttc",
            "ttc",
            "...",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        terrain = { ["."] = "t_linoleum_white" },
        furniture = { M = "f_armchair" },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_store_room_3x3",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "xMx",
            "Mxx",
            "c..",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        terrain = { ["."] = "t_linoleum_white" },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_store_room_3x3",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "lll",
            "S..",
            "..&",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        terrain = { ["."] = "t_linoleum_white" },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        item_groups = {
            l = { group = "SUS_janitors_closet", chance = 90 },
            ["."] = { group = "SUS_office_mess", chance = 1 },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_store_room_3x3",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "lCC",
            "...",
            "..&",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        terrain = { ["."] = "t_linoleum_white" },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        item_groups = {
            l = { group = "SUS_janitors_closet", chance = 90 },
            ["."] = { group = "SUS_office_mess", chance = 1 },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
    },
}

-- A nested map for the Phavian secret skyscraper lab room north on the north side, door in the lower right. This is a meeting room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_north_lrdoor",
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
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_placements = {
            { id = "water_clean", x = 4, y = 0, chance = 30, repetitions = { 1, 2 } },
            { id = "water_clean", x = 5, y = 0, chance = 30, repetitions = { 1, 2 } },
            { id = "water_clean", x = 6, y = 0, chance = 30, repetitions = { 1, 2 } },
            { id = "water_clean", x = 7, y = 0, chance = 30, repetitions = { 1, 2 } },
            { id = "water_clean", x = 7, y = 1, chance = 30, repetitions = { 1, 2 } },
        },
        item_groups = {
            d = { group = "SUS_office_desk", chance = 50, repetitions = { 1, 2 } },
            t = { group = "SUS_office_desk", chance = 20 },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            ["."] = { group = "SUS_office_mess", chance = 1 },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 0, 7 },
                y = { 0, 7 },
                chance = 50,
                repetitions = { 2, 5 },
            },
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        terrain = { t = "t_carpet_linoleum_gray_green", c = "t_carpet_linoleum_gray_green" },
    },
}

-- A nested map for the Phavian secret skyscraper lab room north on the north side, door in the lower left. This is a meeting room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_north_lldoor",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "y......y",
            "..ꞝccꞝ..",
            "..cttc..",
            "..cttc..",
            "..cttc..",
            "..cttc.&",
            "..ꞝccꞝ.d",
            "....dddd",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_placements = {
            { id = "water_clean", x = 4, y = 0, chance = 30, repetitions = { 1, 2 } },
            { id = "water_clean", x = 5, y = 0, chance = 30, repetitions = { 1, 2 } },
            { id = "water_clean", x = 6, y = 0, chance = 30, repetitions = { 1, 2 } },
            { id = "water_clean", x = 7, y = 0, chance = 30, repetitions = { 1, 2 } },
            { id = "water_clean", x = 7, y = 1, chance = 30, repetitions = { 1, 2 } },
        },
        item_groups = {
            d = { group = "SUS_office_desk", chance = 50, repetitions = { 1, 2 } },
            t = { group = "SUS_office_desk", chance = 20 },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            ["."] = { group = "SUS_office_mess", chance = 1 },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 0, 7 },
                y = { 0, 7 },
                chance = 50,
                repetitions = { 2, 5 },
            },
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        terrain = { t = "t_carpet_linoleum_gray_green", c = "t_carpet_linoleum_gray_green" },
    },
}

-- A nested map for the Phavian secret skyscraper lab room north on the north side, door in the lower right. This is a general office room for writing reports
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_north_lrdoor",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "dd&xFxdd",
            "xc.c..c&",
            "--....--",
            "xc.....F",
            "d.....cx",
            "F..-...d",
            "&c.-....",
            "dxd-l..&",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 30 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
            },
            F = { group = "SUS_office_filing_cabinet", chance = 80 },
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            ["."] = { group = "SUS_office_mess", chance = 1 },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 1, 6 },
                y = { 1, 6 },
                chance = 60,
                repetitions = { 2, 5 },
            },
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        terrain = {
            ["."] = "t_carpet_linoleum_white_purple",
            c = "t_carpet_linoleum_white_purple",
            ["&"] = "t_carpet_linoleum_white_purple",
            ["-"] = "t_carpet_linoleum_white_purple",
        },
    },
}

-- A nested map for the Phavian secret office lab room on the north side, door in the lower left.  This is a general office room for writing reports
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_north_lldoor",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "ddxFx&dd",
            "&c..c.cx",
            "--....--",
            "F.....cx",
            "xc.....d",
            "d...-..F",
            "....-.c&",
            "&..l-dxd",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 30 },
                { group = "dist_lab_file_phavian_internal", chance = 3 },
                { group = "dist_lab_file_phavian_skyscraper_lab", chance = 3 },
            },
            F = { group = "SUS_office_filing_cabinet", chance = 80 },
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            ["."] = { group = "SUS_office_mess", chance = 1 },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 1, 6 },
                y = { 1, 6 },
                chance = 60,
                repetitions = { 2, 5 },
            },
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        terrain = {
            ["."] = "t_carpet_linoleum_white_purple",
            c = "t_carpet_linoleum_white_purple",
            ["&"] = "t_carpet_linoleum_white_purple",
            ["-"] = "t_carpet_linoleum_white_purple",
        },
    },
}

-- A nested map for the Phavian secret skyscraper lab room north on the north side, door in the lower right. This is clairsentient location scout testing.
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_north_lrdoor",
    weight = 850,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "........",
            "..ꞝccꞝ..",
            "..cttc..",
            "..cttc..",
            "..ꞝccꞝ..",
            "........",
            "dȼ.ȼ....",
            "dxdx&..y",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 80, repetitions = { 1, 2 } },
                { group = "psi_testing_materials", chance = 50, repetitions = { 1, 2 } },
            },
            t = { group = "dist_maps", chance = 50, repetitions = { 1, 3 } },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            ["."] = { group = "SUS_office_mess", chance = 1 },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 0, 7 },
                y = { 0, 7 },
                chance = 50,
                repetitions = { 2, 6 },
            },
        },
        palettes = { "phavian_skyscraper_office_room_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            t = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            c = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            ["ꞝ"] = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
        },
        furniture = { ["ȼ"] = "f_chair" },
    },
}

-- A nested map for the Phavian secret skyscraper lab room north on the north side, door in the lower left. This is clairsentient location scout testing.
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_north_lldoor",
    weight = 850,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "........",
            "..ꞝccꞝ..",
            "..cttc..",
            "..cttc..",
            "..ꞝccꞝ..",
            "........",
            "....ȼ.ȼd",
            "y..&xdxd",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 80, repetitions = { 1, 2 } },
                { group = "psi_testing_materials", chance = 50, repetitions = { 1, 2 } },
            },
            t = { group = "dist_maps", chance = 50, repetitions = { 1, 3 } },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            ["."] = { group = "SUS_office_mess", chance = 1 },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 0, 7 },
                y = { 0, 7 },
                chance = 50,
                repetitions = { 2, 6 },
            },
        },
        palettes = { "phavian_skyscraper_office_room_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            t = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            c = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            ["ꞝ"] = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
        },
        furniture = { ["ȼ"] = "f_chair" },
    },
}

-- room for controlled awakening, doors in the lower right
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_north_lrdoor",
    weight = 750,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "........",
            "...ct...",
            "........",
            ":f:==:f:",
            "xc....cx",
            "xc....cx",
            "C.......",
            "CCȻSl..&",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            C = {
                { group = "psi_lab", chance = 60, repetitions = { 1, 3 } },
                { group = "dist_lab_file_phavian_skyscraper_lab", chance = 5 },
            },
            ["Ȼ"] = { group = "cleaning", chance = 40, repetitions = { 1, 2 } },
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            t = { { group = "dist_matrix_crystal_skyscraper_lab_group", chance = 85 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 1, 7 },
                y = { 1, 7 },
                chance = 60,
                repetitions = { 2, 6 },
            },
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        furniture = { f = "f_air_filter", ["Ȼ"] = "f_counter" },
    },
}

-- room for controlled awakening, doors in the lower left
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_north_lldoor",
    weight = 750,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "........",
            "...tc...",
            "........",
            ":f:==:f:",
            "xc....cx",
            "xc....cx",
            "........",
            "&..lSȻCC",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            C = {
                { group = "psi_lab", chance = 60, repetitions = { 1, 3 } },
                { group = "dist_lab_file_phavian_skyscraper_lab", chance = 5 },
            },
            ["Ȼ"] = { group = "cleaning", chance = 40, repetitions = { 1, 2 } },
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            t = { { group = "dist_matrix_crystal_skyscraper_lab_group", chance = 85 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 1, 7 },
                y = { 1, 7 },
                chance = 60,
                repetitions = { 2, 6 },
            },
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        furniture = { f = "f_air_filter", ["Ȼ"] = "f_counter" },
    },
}

-- room for testing blocking telepathy or clairsentience, doors in the lower left
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_north_lldoor",
    weight = 450,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "..P....C",
            "cdP...cx",
            "WWW....C",
            "W.1...cȼ",
            "WWW...cx",
            "x......C",
            "c.....cx",
            "&..lSȻCC",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_spawns = {
            ["ȼ"] = {
                { id = "psionic_telepathic_dampener", chance = 70 },
                { id = "schematics_telepathic_dampener", chance = 25 },
            },
            C = {
                { id = "1l_lead", chance = 20 },
                { id = "5l_steel", chance = 25 },
                { id = "1l_gold", chance = 5 },
                { id = "1l_tin", chance = 25 },
                { id = "5l_copper", chance = 25 },
                { id = "1l_silver", chance = 15 },
                { id = "5l_iron", chance = 25 },
                { id = "5l_brass", chance = 25 },
                { id = "5l_aluminum", chance = 25 },
                { id = "1l_platinum", chance = 5 },
            },
        },
        item_groups = {
            d = {
                { group = "clairsentient_matrix_crystals_group", chance = 5 },
                { group = "telepathic_matrix_crystals_group", chance = 5 },
                { group = "psi_testing_materials", chance = 80, repetitions = { 2, 4 } },
            },
            C = {
                { group = "psi_lab", chance = 20, repetitions = { 1, 3 } },
                { group = "dist_lab_file_phavian_skyscraper_lab", chance = 5 },
            },
            ["Ȼ"] = { group = "cleaning", chance = 40, repetitions = { 1, 2 } },
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            t = { { group = "dist_matrix_crystal_skyscraper_lab_group", chance = 85 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 1, 7 },
                y = { 1, 7 },
                chance = 60,
                repetitions = { 2, 6 },
            },
            {
                group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH",
                x = { 2, 6 },
                y = { 2, 6 },
                chance = 10,
                repetitions = { 1, 2 },
            },
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        terrain = { W = "t_wall_metal" },
        furniture = { ["ȼ"] = "f_counter", P = "f_curtain" },
    },
}

-- room for testing blocking telepathy or clairsentience, doors in the lower right
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_north_lrdoor",
    weight = 450,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "C....P..",
            "xc...Pdc",
            "C....WWW",
            "ȼc...1.W",
            "xc...WWW",
            "C......x",
            "cx.....c",
            "CCȻSl..&",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_spawns = {
            ["ȼ"] = {
                { id = "psionic_telepathic_dampener", chance = 70 },
                { id = "schematics_telepathic_dampener", chance = 25 },
            },
            C = {
                { id = "1l_lead", chance = 20 },
                { id = "5l_steel", chance = 25 },
                { id = "1l_gold", chance = 5 },
                { id = "1l_tin", chance = 25 },
                { id = "5l_copper", chance = 25 },
                { id = "1l_silver", chance = 15 },
                { id = "5l_iron", chance = 25 },
                { id = "5l_brass", chance = 25 },
                { id = "5l_aluminum", chance = 25 },
                { id = "1l_platinum", chance = 5 },
            },
        },
        item_groups = {
            d = {
                { group = "psi_testing_materials", chance = 80, repetitions = { 2, 4 } },
                { group = "telepathic_matrix_crystals_group", chance = 5 },
                { group = "clairsentient_matrix_crystals_group", chance = 5 },
            },
            C = {
                { group = "psi_lab", chance = 20, repetitions = { 1, 3 } },
                { group = "dist_lab_file_phavian_skyscraper_lab", chance = 5 },
            },
            ["Ȼ"] = { group = "cleaning", chance = 40, repetitions = { 1, 2 } },
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            t = { { group = "dist_matrix_crystal_skyscraper_lab_group", chance = 85 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 1, 7 },
                y = { 1, 7 },
                chance = 60,
                repetitions = { 2, 6 },
            },
            {
                group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH",
                x = { 2, 6 },
                y = { 2, 6 },
                chance = 10,
                repetitions = { 1, 2 },
            },
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        terrain = { W = "t_wall_metal" },
        furniture = { ["ȼ"] = "f_counter", P = "f_curtain" },
    },
}

-- room for creating matrix technology prototypes, doors in the lower left
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_north_lldoor",
    weight = 600,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "U......C",
            "U..MM..M",
            "U..CC..M",
            "U..¢¢..C",
            "&......C",
            ":::==:::",
            "........",
            "&..llSĆĆ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_placements = { { id = "schematics_matrix_crystal_ground", x = 0, y = 0, chance = 75 } },
        item_groups = {
            ["¢"] = {
                { group = "supplies_electronics", chance = 40, repetitions = { 1, 4 } },
                { group = "hardware", chance = 20, repetitions = { 1, 3 } },
                { group = "clairsentience_telepathy_matrix_technology", chance = 40 },
            },
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
                { group = "hardware_clothing", chance = 60, repetitions = { 1, 5 } },
                { group = "decontamination_room", chance = 10, repetitions = { 1, 3 } },
            },
            C = {
                { group = "psi_lab_no_recipes", chance = 10, repetitions = { 1, 3 } },
                { group = "supplies_electronics", chance = 40, repetitions = { 1, 4 } },
                { group = "hardware", chance = 20, repetitions = { 1, 3 } },
            },
            U = {
                { group = "psi_lab_no_recipes", chance = 40, repetitions = { 1, 3 } },
                { group = "supplies_electronics", chance = 60, repetitions = { 1, 4 } },
                { group = "hardware", chance = 40, repetitions = { 1, 5 } },
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
        palettes = { "phavian_skyscraper_office_room_palette" },
        furniture = { ["¢"] = "f_counter", M = "f_machinery_electronic", ["Ć"] = "f_counter" },
    },
}

-- room for creating matrix technology prototypes, doors in the lower right
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_north_lrdoor",
    weight = 600,
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "C......U",
            "M..MM..U",
            "M..CC..U",
            "C..¢¢..U",
            "C......&",
            ":::==:::",
            "........",
            "ĆĆSll..&",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_placements = { { id = "schematics_matrix_crystal_ground", x = 7, y = 0, chance = 75 } },
        item_groups = {
            ["¢"] = {
                { group = "supplies_electronics", chance = 40, repetitions = { 1, 4 } },
                { group = "hardware", chance = 20, repetitions = { 1, 3 } },
                { group = "clairsentience_telepathy_matrix_technology", chance = 40 },
            },
            l = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
                { group = "hardware_clothing", chance = 60, repetitions = { 1, 5 } },
                { group = "decontamination_room", chance = 10, repetitions = { 1, 3 } },
            },
            C = {
                { group = "psi_lab_no_recipes", chance = 10, repetitions = { 1, 3 } },
                { group = "supplies_electronics", chance = 40, repetitions = { 1, 4 } },
                { group = "hardware", chance = 20, repetitions = { 1, 3 } },
            },
            U = {
                { group = "psi_lab_no_recipes", chance = 40, repetitions = { 1, 3 } },
                { group = "supplies_electronics", chance = 60, repetitions = { 1, 4 } },
                { group = "hardware", chance = 40, repetitions = { 1, 5 } },
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
        palettes = { "phavian_skyscraper_office_room_palette" },
        furniture = { ["¢"] = "f_counter", M = "f_machinery_electronic", ["Ć"] = "f_counter" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_break_area_4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            ".???",
            "...?",
            ".t.?",
            "y..?",
        },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        item_groups = {
            t = {
                { group = "newspaper_recent", chance = 30, repetitions = { 1, 2 } },
                { group = "book_mag_gen", chance = 50, repetitions = { 1, 2 } },
            },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 33,
                repetitions = { 1, 3 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 5 },
        },
        palettes = { "phavian_skyscraper_office_room_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            y = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            m = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["."] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            t = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_break_area_4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "y???",
            "....",
            ".mtm",
            "....",
        },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        item_groups = {
            t = {
                { group = "newspaper_recent", chance = 30, repetitions = { 1, 2 } },
                { group = "book_mag_gen", chance = 50, repetitions = { 1, 2 } },
            },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 33,
                repetitions = { 1, 3 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 5 },
        },
        palettes = { "phavian_skyscraper_office_room_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            m = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            t = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["."] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_break_area_4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "ttt?",
            "...?",
            "...?",
            ".???",
        },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        item_groups = {
            t = {
                { group = "newspaper_recent", chance = 30, repetitions = { 1, 2 } },
                { group = "book_mag_gen", chance = 50, repetitions = { 1, 2 } },
            },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 33,
                repetitions = { 1, 3 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 5 },
        },
        palettes = { "phavian_skyscraper_office_room_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            ["."] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            t = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_break_area_4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "mttm",
            "....",
            ".mm.",
            "....",
        },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        item_groups = {
            t = {
                { group = "newspaper_recent", chance = 30, repetitions = { 1, 2 } },
                { group = "book_mag_gen", chance = 50, repetitions = { 1, 2 } },
            },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 33,
                repetitions = { 1, 3 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 5 },
        },
        palettes = { "phavian_skyscraper_office_room_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            t = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            m = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            ["."] = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_break_area_4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            ".ctc",
            ".ctc",
            ".ctc",
            "y.c.",
        },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        item_groups = {
            t = {
                { group = "vending_food", chance = 20, repetitions = { 1, 2 } },
                { group = "vending_drink", chance = 20, repetitions = { 1, 2 } },
            },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 33,
                repetitions = { 1, 3 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 5 },
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_skyscraper_lab_break_area_4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            ".ctc",
            "....",
            ".ctc",
            "....",
        },
        rotation = { 0, 0 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        item_groups = {
            t = {
                { group = "vending_food", chance = 20, repetitions = { 1, 2 } },
                { group = "vending_drink", chance = 20, repetitions = { 1, 2 } },
            },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 33,
                repetitions = { 1, 3 },
            },
            { group = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", x = { 1, 2 }, y = { 1, 2 }, chance = 5 },
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
    },
}
