local ccb = require("ccb")

-- 10x10 side room with south center door.  This is an office space
-- Available area is 10x9, hence the empty row
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_south_door_10x10_room",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "          ",
            "dxdd|ddxxd",
            "dcc.|dc.cc",
            "-..-|--.--",
            "dx.d|dx..d",
            "d.cd|dc.cd",
            "xc.d|d..cd",
            "d.xd|dc.xd",
            "-..-|--.--",
            "FFy......&",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        terrain = { ["|"] = "t_wall_w" },
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
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 6 },
                y = { 1, 6 },
                chance = 60,
                repetitions = { 3, 6 },
            },
        },
    },
}

-- 10x10 side room with south center door.  This is an office space
-- Available area is 10x9, hence the empty row
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_south_door_10x10_room",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "          ",
            "dxddddxdxd",
            "dcc.cdc.cd",
            "dd......xd",
            "dx.cdd..cd",
            "dd. ddc..d",
            "xc.cdd..cd",
            "dc...c..xd",
            "dd......dd",
            "FFy......&",
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
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 6 },
                y = { 1, 6 },
                chance = 60,
                repetitions = { 3, 6 },
            },
        },
    },
}

-- 10x10 side room with south center door.  This is a meeting room.
-- Available area is 10x9, hence the empty rows
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_south_door_10x10_room",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "          ",
            "dddddddddd",
            "d........d",
            "d...cc...d",
            "...cttc..d",
            "ð..cttc..&",
            "ð..cttc...",
            "...cttc...",
            "....cc....",
            "y........y",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        furniture = { ["ð"] = "f_desk" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            t = {
                { group = "SUS_office_desk", chance = 70 },
                { group = "lab_files_psi", chance = 5 },
                { group = "dist_lab_file_phavian_internal", chance = 2 },
            },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            ["."] = { group = "SUS_office_mess", chance = 1 },
        },
        item_placements = { { id = "television", x = 0, y = 5 }, { id = "television", x = 0, y = 6 } },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 9 },
                y = { 2, 9 },
                repetitions = { 1, 3 },
                chance = 70,
            },
        },
    },
}

-- 10x10 side room with south center door.  This is a server room.
-- Available area is 10x9, hence the empty rows
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_south_door_10x10_room",
    weight = 500,
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "          ",
            "5.5.55.5.5",
            "5.5.55.5.5",
            "5.5.55.5.5",
            "5.5.55.5.5",
            "5.5.55.5.5",
            "5.5....5.5",
            "5.5....5.5",
            ":f:fDDf:f:",
            "..........",
        },
        palettes = { "phavian_hospital_lab" },
        terrain = { ["."] = "t_linoleum_white" },
        furniture = { ["5"] = "f_server", f = "f_air_filter" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- 10x10 side room with north center door.  This is an office space
-- Available area is 10x9, hence the empty row
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_north_door_10x10_room",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "&......yFF",
            "-..-|-...-",
            "dx.d|dx..d",
            "dc.d|d..cx",
            "d.cd|dc..d",
            "d.xd|d..xd",
            "-..-|-...-",
            ".ccd|..ccd",
            "dxxd|xddxd",
            "          ",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        terrain = { ["|"] = "t_wall_w", ["-"] = "t_wall_w" },
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
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 6 },
                y = { 1, 6 },
                chance = 60,
                repetitions = { 3, 6 },
            },
        },
    },
}

-- 10x10 side room with north center door.  This is an office space
-- Available area is 10x9, hence the empty row
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_north_door_10x10_room",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "&......yFF",
            "dd......dd",
            "dx..c...cd",
            "dc..ddc.cx",
            "d..cdd .dd",
            "dc..ddc.xd",
            "dx......dd",
            "dc.cdc.ccd",
            "dxdxddddxd",
            "          ",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "lab_files_psi", chance = 5 },
                { group = "dist_lab_file_phavian_internal", chance = 2 },
            },
            F = { group = "SUS_office_filing_cabinet", chance = 80 },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            ["."] = { group = "SUS_office_mess", chance = 1 },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 6 },
                y = { 1, 6 },
                chance = 60,
                repetitions = { 3, 6 },
            },
        },
    },
}

-- 10x10 side room with north center door.  This is a meeting room.
-- Available area is 10x9, hence the empty rows
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_north_door_10x10_room",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "y........y",
            "....cc....",
            "...cttc...",
            "...cttc..ð",
            "&..cttc..ð",
            "d..cttc...",
            "d...cc...d",
            "d........d",
            "dddddddddd",
            "          ",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        furniture = { ["ð"] = "f_desk" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            t = {
                { group = "lab_files_psi", chance = 5 },
                { group = "dist_lab_file_phavian_internal", chance = 2 },
            },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            ["."] = { group = "SUS_office_mess", chance = 1 },
        },
        item_placements = { { id = "television", x = 0, y = 5 }, { id = "television", x = 0, y = 6 } },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 9 },
                y = { 2, 9 },
                repetitions = { 1, 3 },
                chance = 70,
            },
        },
    },
}

-- 10x10 side room with north center door.  This is a server room.
-- Available area is 10x9, hence the empty rows
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_north_door_10x10_room",
    weight = 500,
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "..........",
            ":f:fDDf:f:",
            "5.5....5.5",
            "5.5....5.5",
            "5.5.55.5.5",
            "5.5.55.5.5",
            "5.5.55.5.5",
            "5.5.55.5.5",
            "5.5.55.5.5",
            "          ",
        },
        palettes = { "phavian_hospital_lab" },
        terrain = { ["."] = "t_linoleum_white" },
        furniture = { ["5"] = "f_server", f = "f_air_filter" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- 11x11 side room with south center door.  This is an office space.
-- Available area is 11x9, hence the empty rows
-- south center door rooms begin here
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_south_door_11x11_room",
    weight = 750,
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "dxddx|dxdxd",
            "dcc..|dc.c.",
            "--.--|--.--",
            "dx..d|dx.cd",
            "d..cd|dc..d",
            "xc..d|d..cd",
            "d..xd|dc.xd",
            "--..-|--.--",
            "FFy.......&",
            "           ",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        terrain = { ["|"] = "t_wall_w" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 40 },
                { group = "lab_files_psi", chance = 5 },
                { group = "dist_lab_file_phavian_internal", chance = 2 },
            },
            F = { group = "SUS_office_filing_cabinet", chance = 80 },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            ["."] = { group = "SUS_office_mess", chance = 1 },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 6 },
                y = { 1, 6 },
                chance = 60,
                repetitions = { 3, 6 },
            },
        },
    },
}

-- 11x11 side room with south center door.  This is an office space.
-- Available area is 11x9, hence the empty rows
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_south_door_11x11_room",
    weight = 750,
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "dxddxddxdxd",
            "dcc..cdc.cd",
            "dd.......xd",
            "dx..cdc..cd",
            "dd..ddxc..d",
            "xc..cdc..cd",
            "dc.......xd",
            "dd.......dd",
            "FFy.......&",
            "           ",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        terrain = { ["|"] = "t_wall_w" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 40 },
                { group = "lab_files_psi", chance = 5 },
                { group = "dist_lab_file_phavian_internal", chance = 2 },
            },
            F = { group = "SUS_office_filing_cabinet", chance = 80 },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            ["."] = { group = "SUS_office_mess", chance = 1 },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 6 },
                y = { 1, 6 },
                chance = 60,
                repetitions = { 3, 6 },
            },
        },
    },
}

-- 11x11 side room with south center door.  This is a meeting room.
-- Available area is 11x9, hence the empty rows
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_south_door_11x11_room",
    weight = 800,
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "ddddddddddd",
            "d.........d",
            "d...ccc...d",
            "...ctttc..d",
            "ð..ctttc..&",
            "ð..ctttc...",
            "...ctttc...",
            "....ccc....",
            "y.........y",
            "           ",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        furniture = { ["ð"] = "f_desk" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            t = {
                { group = "SUS_office_desk", chance = 40 },
                { group = "lab_files_psi", chance = 5 },
                { group = "dist_lab_file_phavian_internal", chance = 2 },
            },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            ["."] = { group = "SUS_office_mess", chance = 1 },
        },
        item_placements = { { id = "television", x = 0, y = 5 }, { id = "television", x = 0, y = 6 } },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 9 },
                y = { 2, 9 },
                repetitions = { 2, 5 },
                chance = 70,
            },
        },
    },
}

-- 11x11 side room with south center door.  This is a patient care room.
-- Available area is 11x9, hence the empty rows
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_south_door_11x11_room",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "Г..Ṛ...Ṛ.Г.",
            "v.hṚ...Ṛh.v",
            "Uh.Ṛ...Ṛ.hU",
            "||||..ւ||||",
            "Г..Ṛ...Ṛ.Г.",
            "v.hṚ...Ṛh.v",
            "||||ւ..||||",
            "Г..Ṛ...Ṛ.Г.",
            "v.hṚ...Ṛh.v",
            "           ",
        },
        palettes = { "phavian_hospital_lab" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = { ["ւ"] = { group = "full_1st_aid", chance = 65, repetitions = { 1, 3 } } },
        vehicle_glyphs = {
            ["Г"] = { id = "hospital_bed", rotation = 180 },
            ["ւ"] = { id = "medical_cart", rotation = 180 },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 9 },
                y = { 2, 9 },
                repetitions = { 4, 8 },
                chance = 70,
            },
            {
                group = "GROUP_FERAL_BIOKINETIC_VITAKINETIC",
                x = { 1, 9 },
                y = { 1, 9 },
                chance = 30,
                repetitions = { 1, 3 },
            },
        },
    },
}

-- 11x11 side room with south center door.  This is a biokinetic testing space.
-- Available area is 11x9, hence the empty rows
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_south_door_11x11_room",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "NNNNNNNNNNN",
            ".E.E...E.E.",
            "...........",
            ".P.P...P.P.",
            "...........",
            ".T.X...X.T.",
            "...........",
            "Uh.......hU",
            "y.........z",
            "           ",
        },
        palettes = { "phavian_hospital_lab" },
        terrain = { ["|"] = "t_wall_w" },
        furniture = { E = "f_ergometer", P = "f_punching_bag", T = "f_treadmill", X = "f_exercise" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            N = { { group = "psi_lab_no_recipes", chance = 40, repetitions = { 1, 3 } } },
            z = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 10 },
                y = { 2, 9 },
                chance = 60,
                repetitions = { 1, 3 },
            },
            {
                group = "GROUP_FERAL_BIOKINETIC",
                x = { 1, 10 },
                y = { 2, 9 },
                chance = 60,
                repetitions = { 0, 3 },
            },
        },
    },
}

-- 11x11 side room with south center door.  This is an MRI room.
-- Available area is 11x9, hence the empty rows
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_south_door_11x11_room",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "......|...U",
            "..cd..|...h",
            "t.....D....",
            "t.....|.Г..",
            "|ooDoo|....",
            "Uh..hU|ւ...",
            "Uh..hU|...u",
            "|||D|||...u",
            "Ł.........u",
            "           ",
        },
        palettes = { "phavian_hospital_lab" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            ["Ł"] = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            ["ւ"] = { group = "full_1st_aid", chance = 65, repetitions = { 1, 3 } },
            u = { group = "used_1st_aid", chance = 30, repetitions = { 1, 2 } },
        },
        vehicle_glyphs = {
            ["Г"] = { id = "hospital_bed", rotation = 90 },
            ["ւ"] = { id = "medical_cart", rotation = 180 },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 9 },
                y = { 2, 9 },
                repetitions = { 2, 4 },
                chance = 70,
            },
        },
    },
}

-- 11x11 side room with south center door.  This is a matrix crystal research lab
-- Available area is 11x9, hence the empty rows
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_south_door_11x11_room",
    weight = 750,
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "NNNNNNN5555",
            ".....A....0",
            "....UaU...U",
            "Uh........h",
            ":Å:Å:D:Å:Å:",
            "Nh....3...C",
            "NU...Nh..hN",
            ".........AN",
            "ztLt...zNNN",
            "           ",
        },
        palettes = { "phavian_hospital_lab" },
        furniture = { ["5"] = "f_server" },
        item_groups = {
            N = {
                { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
                { group = "electronics", chance = 30, repetitions = { 1, 2 } },
            },
            t = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            a = { { group = "dist_matrix_crystal_hospital_lab_group", chance = 85 } },
            z = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 9 },
                y = { 2, 9 },
                repetitions = { 3, 5 },
                chance = 70,
            },
        },
    },
}

-- 11x11 side room with south center door.  This is a project SHADOW URGE lab
-- Available area is 11x9, hence the empty rows
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_south_door_11x11_room",
    weight = 500,
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "NNNNNNN5555",
            "N.........0",
            "N....4...hU",
            "Uh..UXU...U",
            "..........h",
            ":Å:Å:D:Å:Å:",
            "Uh.......hU",
            "Uh.......hU",
            "ŁŁL....zNNN",
            "           ",
        },
        palettes = { "phavian_hospital_lab" },
        furniture = { ["Ṅ"] = "f_lab_bench", X = "f_biokinetic_physiology_improver", ["5"] = "f_server" },
        item_placements = {
            { id = "lab_file_shadow_urge_item", x = 10, y = 9, chance = 30 },
            { id = "lab_file_shadow_urge_password", x = 9, y = 9, chance = 15 },
        },
        item_groups = {
            ["Ł"] = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            N = {
                { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
                { group = "psi_lab_no_recipes", chance = 30, repetitions = { 1, 2 } },
                { group = "electronics", chance = 30, repetitions = { 1, 2 } },
            },
            ["Ṅ"] = { group = "drugs_emergency", chance = 30, repetitions = { 1, 2 } },
            z = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 9 },
                y = { 2, 9 },
                repetitions = { 3, 5 },
                chance = 70,
            },
        },
    },
}

-- 11x11 side room with north center door.  This is an office space
-- Available area is 11x9, hence the empty rows
-- north center door rooms begin here
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_north_door_11x11_room",
    weight = 750,
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "&.......yFF",
            "--.--|-..--",
            "dx.cd|dx..d",
            "dc..d|d..cx",
            "d..cd|dc..d",
            "dc.xd|d..xd",
            "--.--|--.--",
            ".c.cd|..ccd",
            "dxdxd|xddxd",
            "           ",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        terrain = { ["|"] = "t_wall_w" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 40 },
                { group = "lab_files_psi", chance = 5 },
                { group = "dist_lab_file_phavian_internal", chance = 2 },
            },
            F = { group = "SUS_office_filing_cabinet", chance = 80 },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            ["."] = { group = "SUS_office_mess", chance = 1 },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 6 },
                y = { 1, 6 },
                chance = 60,
                repetitions = { 3, 6 },
            },
        },
    },
}

-- 11x11 side room with north center door.  This is office space
-- Available area is 11x9, hence the empty rows
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_north_door_11x11_room",
    weight = 750,
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "&.......yFF",
            "dd.......dd",
            "dx.......cd",
            "dc..cdc..cx",
            "d..cxdd..dd",
            "dc..cdc..xd",
            "dx.......dd",
            "dc.cdc..ccd",
            "dxdxddxddxd",
            "           ",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        terrain = { ["|"] = "t_wall_w" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 40 },
                { group = "lab_files_psi", chance = 5 },
                { group = "dist_lab_file_phavian_internal", chance = 2 },
            },
            F = { group = "SUS_office_filing_cabinet", chance = 80 },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            ["."] = { group = "SUS_office_mess", chance = 1 },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 6 },
                y = { 1, 6 },
                chance = 60,
                repetitions = { 3, 6 },
            },
        },
    },
}

-- 11x11 side room with north center door.  This is a meeting room.
-- Available area is 11x9, hence the empty rows
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_north_door_11x11_room",
    weight = 800,
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "y.........y",
            "....ccc....",
            "...ctttc...",
            "...ctttc..ð",
            "&..ctttc..ð",
            "d..ctttc...",
            "d...ccc...d",
            "d.........d",
            "ddddddddddd",
            "           ",
        },
        palettes = { "phavian_skyscraper_office_room_palette" },
        furniture = { ["ð"] = "f_desk" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            t = {
                { group = "lab_files_psi", chance = 5 },
                { group = "dist_lab_file_phavian_internal", chance = 2 },
            },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
            ["."] = { group = "SUS_office_mess", chance = 1 },
        },
        item_placements = { { id = "television", x = 10, y = 4 }, { id = "television", x = 10, y = 5 } },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 9 },
                y = { 2, 9 },
                repetitions = { 2, 5 },
                chance = 70,
            },
        },
    },
}

-- 11x11 side room with north center door.  This is a patient care room.
-- Available area is 11x9, hence the empty rows
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_north_door_11x11_room",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "v.hṚ...Ṛh.v",
            "Г..Ṛ...Ṛ.Г.",
            "||||..ւ||||",
            "v.hṚ...Ṛh.v",
            "Г..Ṛ...Ṛ.Г.",
            "||||ւ..||||",
            "Uh.Ṛ...Ṛ.hU",
            "v.hṚ...Ṛh.v",
            "Г..Ṛ...Ṛ.Г.",
            "           ",
        },
        palettes = { "phavian_hospital_lab" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = { ["ւ"] = { group = "full_1st_aid", chance = 65, repetitions = { 1, 3 } } },
        vehicle_glyphs = {
            ["Г"] = { id = "hospital_bed", rotation = 180 },
            ["ւ"] = { id = "medical_cart", rotation = 180 },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 9 },
                y = { 2, 9 },
                repetitions = { 4, 8 },
                chance = 70,
            },
            {
                group = "GROUP_FERAL_BIOKINETIC_VITAKINETIC",
                x = { 1, 9 },
                y = { 1, 9 },
                chance = 30,
                repetitions = { 1, 3 },
            },
        },
    },
}

-- 11x11 side room with north center door.  This is a biokinetic testing space.
-- Available area is 11x9, hence the empty rows
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_north_door_11x11_room",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "z.........y",
            "Uh.......hU",
            "...........",
            ".T.X...X.T.",
            "...........",
            ".P.P...P.P.",
            "...........",
            ".E.E...E.E.",
            "NNNNNNNNNNN",
            "           ",
        },
        palettes = { "phavian_hospital_lab" },
        terrain = { ["|"] = "t_wall_w" },
        furniture = { E = "f_ergometer", P = "f_punching_bag", T = "f_treadmill", X = "f_exercise" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            N = { { group = "psi_lab_no_recipes", chance = 40, repetitions = { 1, 3 } } },
            z = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 10 },
                y = { 1, 8 },
                chance = 60,
                repetitions = { 1, 3 },
            },
            {
                group = "GROUP_FERAL_BIOKINETIC",
                x = { 1, 10 },
                y = { 1, 8 },
                chance = 60,
                repetitions = { 0, 3 },
            },
        },
    },
}

-- 11x11 side room with north center door.  This is an MRI room.
-- Available area is 11x9, hence the empty rows
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_north_door_11x11_room",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "u.........Ł",
            "u...|||D|||",
            "u...|Uh..hU",
            "...ւ|Uh..hU",
            "....|ooDoo|",
            "....|.....t",
            "..Г.D.....t",
            "h...|..dc..",
            "U...|......",
            "           ",
        },
        palettes = { "phavian_hospital_lab" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            ["Ł"] = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            ["ւ"] = { group = "full_1st_aid", chance = 65, repetitions = { 1, 3 } },
            u = { group = "used_1st_aid", chance = 30, repetitions = { 1, 2 } },
        },
        vehicle_glyphs = {
            ["Г"] = { id = "hospital_bed", rotation = 90 },
            ["ւ"] = { id = "medical_cart", rotation = 180 },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 9 },
                y = { 2, 9 },
                repetitions = { 2, 4 },
                chance = 70,
            },
        },
    },
}

-- 11x11 side room with north center door.  This is a matrix crystal research lab
-- Available area is 11x9, hence the empty rows
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_north_door_11x11_room",
    weight = 750,
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "NNNz...tLtz",
            "NA.........",
            "Nh..hN...UN",
            "C...3....hN",
            ":Å:Å:D:Å:Å:",
            "h........hU",
            "U...UaU....",
            "0....A.....",
            "5555NNNNNNN",
            "           ",
        },
        palettes = { "phavian_hospital_lab" },
        furniture = { ["5"] = "f_server" },
        item_groups = {
            N = {
                { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
                { group = "electronics", chance = 30, repetitions = { 1, 2 } },
            },
            t = { group = "cleaning", chance = 30, repetitions = { 1, 2 } },
            a = { { group = "dist_matrix_crystal_hospital_lab_group", chance = 85 } },
            z = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 9 },
                y = { 2, 9 },
                repetitions = { 3, 5 },
                chance = 70,
            },
        },
    },
}

-- 11x11 side room with north center door.  This is a project SHADOW URGE lab
-- Available area is 11x9, hence the empty rows
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_north_door_11x11_room",
    weight = 500,
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "NNNz....LŁŁ",
            "Uh.......hU",
            "Uh.......hU",
            ":Å:Å:D:Å:Å:",
            "h..........",
            "U...UXU..hU",
            "Uh...4....N",
            "0.........N",
            "5555NNNNNNN",
            "           ",
        },
        palettes = { "phavian_hospital_lab" },
        furniture = { ["Ṅ"] = "f_lab_bench", X = "f_biokinetic_physiology_improver", ["5"] = "f_server" },
        item_placements = {
            { id = "lab_file_shadow_urge_item", x = 0, y = 0, chance = 30 },
            { id = "lab_file_shadow_urge_password", x = 1, y = 0, chance = 15 },
        },
        item_groups = {
            ["Ł"] = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
            },
            N = {
                { group = "tools_science", chance = 30, repetitions = { 1, 2 } },
                { group = "psi_lab_no_recipes", chance = 30, repetitions = { 1, 2 } },
                { group = "electronics", chance = 30, repetitions = { 1, 2 } },
            },
            ["Ṅ"] = { group = "drugs_emergency", chance = 30, repetitions = { 1, 2 } },
            z = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 1, 9 },
                y = { 1, 8 },
                repetitions = { 3, 5 },
                chance = 70,
            },
        },
    },
}

-- 4x4 office with SE wall door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_office_east_door4x4",
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
            { group = "GROUP_FERAL_BIOKINETIC_VITAKINETIC", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 office with SE wall door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_office_east_door4x4",
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
            { group = "GROUP_FERAL_BIOKINETIC_VITAKINETIC", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 office with SE wall door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_office_east_door4x4",
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
            { group = "GROUP_FERAL_BIOKINETIC_VITAKINETIC", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 upstairs office with SE wall door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_office_east_door4x4",
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
            { group = "GROUP_FERAL_BIOKINETIC_VITAKINETIC", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 office with SE door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_office_east_door4x4",
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
        item_placements = { { id = "lab_file_shadow_urge_password", x = 2, y = 1, chance = 15 } },
        monster_placements = {
            {
                id = "mon_zombie_scientist_phavian",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 35,
                repetitions = { 0, 3 },
            },
            { group = "GROUP_FERAL_BIOKINETIC_VITAKINETIC", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 office with SE door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_office_east_door4x4",
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
            { group = "GROUP_FERAL_BIOKINETIC_VITAKINETIC", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 office with SE door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_office_east_door4x4",
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
            { group = "GROUP_FERAL_BIOKINETIC_VITAKINETIC", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 office with SE door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_office_east_door4x4",
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
            { group = "GROUP_FERAL_BIOKINETIC_VITAKINETIC", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 office with SW wall door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_office_west_door4x4",
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
            F = { group = "SUS_office_desk", chance = 95 },
            B = {
                { group = "magazines", chance = 75, repetitions = { 1, 5 } },
                { group = "lab_bookshelves", chance = 55, repetitions = { 1, 3 } },
            },
        },
        item_placements = { { id = "lab_file_shadow_urge_password", x = 0, y = 0, chance = 15 } },
        monster_placements = {
            {
                id = "mon_zombie_scientist_phavian",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 35,
                repetitions = { 0, 3 },
            },
            { group = "GROUP_FERAL_BIOKINETIC_VITAKINETIC", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 office with SW wall door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_office_west_door4x4",
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
            { group = "GROUP_FERAL_BIOKINETIC_VITAKINETIC", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 office with SW door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_office_west_door4x4",
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
            { group = "GROUP_FERAL_BIOKINETIC_VITAKINETIC", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 office with SW wall door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_office_west_door4x4",
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
            { group = "GROUP_FERAL_BIOKINETIC_VITAKINETIC", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 office with SW door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_office_west_door4x4",
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
            { group = "GROUP_FERAL_BIOKINETIC_VITAKINETIC", x = { 1, 2 }, y = { 1, 2 }, chance = 2 },
        },
    },
}

-- 4x4 office with SW door
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_storage_room_west_door4x4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "CCCC",
            "   z",
            "   z",
            "L  <",
        },
        palettes = { "phavian_hospital_lab" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            C = { group = "SUS_janitors_closet", chance = 90 },
            ["&"] = { group = "SUS_trash_trashcan", chance = 75, repetitions = { 1, 2 } },
        },
        item_placements = { { id = "broom", x = 0, y = 1, chance = 100 }, { id = "mop", x = 0, y = 2, chance = 100 } },
        monster_placements = {
            {
                id = "mon_zombie_technician",
                x = { 1, 2 },
                y = { 1, 2 },
                chance = 35,
                repetitions = { 0, 2 },
            },
        },
    },
}

-- 11x11 side room with south center door.  This is an Osiris chamber room for Ascension-level biokinetic awakenings.
-- Available area is 11x9, hence the empty rows
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_osiris_chamber_biokinesis_11x11",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "x̄..:x̄..:x̄..",
            "...:...:...",
            "...:...:...",
            ":D:::D:::D:",
            "...........",
            "UU...U...UU",
            "hh...h...hh",
            "...........",
            "NLNN.....ŁŁ",
            "           ",
            "           ",
        },
        palettes = { "phavian_hospital_lab" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested_glyphs = {
            ["x̄"] = { choices = { { id = "phavian_hospital_lab_osiris_chamber_biokinesis", weight = 1 } } },
        },
        item_placements = { { id = "lab_file_obsidian_ring_item", x = 3, y = 10, chance = 45 } },
        item_groups = {
            ["Ł"] = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
                { group = "decontamination_room", chance = 10, repetitions = { 1, 3 } },
            },
            N = {
                { group = "psi_lab_no_recipes", chance = 60, repetitions = { 1, 3 } },
                { group = "matrix_crystal_biokin_dust_group", chance = 50, repetitions = { 1, 2 } },
                { group = "biokinetic_matrix_crystals_group", chance = 15 },
            },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 0, 10 },
                y = { 6, 10 },
                repetitions = { 2, 4 },
                chance = 70,
            },
        },
    },
}

-- 11x11 side room with south center door.  This is an Osiris chamber room for Ascension-level vitakinetic awakenings.
-- Available area is 11x9, hence the empty rows
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_osiris_chamber_vitakinesis_11x11",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "x̄..:x̄..:x̄..",
            "...:...:...",
            "...:...:...",
            ":D:::D:::D:",
            "...........",
            "UU...U...UU",
            "hh...h...hh",
            "...........",
            "NLNN.....ŁŁ",
            "           ",
            "           ",
        },
        palettes = { "phavian_hospital_lab" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested_glyphs = {
            ["x̄"] = { choices = { { id = "phavian_hospital_lab_osiris_chamber_vitakinesis", weight = 1 } } },
        },
        item_placements = { { id = "lab_file_obsidian_ring_item", x = 3, y = 10, chance = 45 } },
        item_groups = {
            ["Ł"] = {
                { group = "lab_torso", chance = 40, repetitions = { 1, 8 } },
                { group = "lab_shoes", chance = 40, repetitions = { 1, 8 } },
                { group = "decontamination_room", chance = 10, repetitions = { 1, 3 } },
            },
            N = {
                { group = "psi_lab_no_recipes", chance = 60, repetitions = { 1, 3 } },
                { group = "matrix_crystal_vitakin_dust_group", chance = 50, repetitions = { 1, 2 } },
                { group = "vitakinetic_matrix_crystals_group", chance = 15 },
            },
        },
        monster_placements = {
            {
                group = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
                x = { 0, 10 },
                y = { 6, 10 },
                repetitions = { 2, 4 },
                chance = 70,
            },
        },
    },
}

-- This is a security area near the elevator. Available area is part of 12x6, but L-shaped
ccb.content.define_mapgen {
    kind = "nested",
    id = "phavian_hospital_lab_security_area_12x12",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "v...UvvvUv.C",
            "vh..h.h.h..C",
            "vh.........C",
            "v.....hv    ",
            "Ł...h.hv    ",
            "Ł...vvvU    ",
            "            ",
            "            ",
            "            ",
            "            ",
            "            ",
            "            ",
        },
        palettes = { "phavian_hospital_lab" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            d = {
                { group = "SUS_office_desk", chance = 70 },
                { group = "dist_lab_file_phavian_internal", chance = 2 },
            },
            ["Ł"] = {
                { group = "prison_weapons", chance = 30 },
                { group = "prison_armor", chance = 30 },
                { group = "security_torso", chance = 20 },
                { group = "security_pants", chance = 20 },
                { group = "security_shoes", chance = 20 },
                { group = "phavian_lab_security", chance = 20 },
            },
        },
        monster_placements = {
            {
                group = "GROUP_LAB_SECURITY_PHAVIAN",
                x = { 0, 11 },
                y = { 1, 2 },
                chance = 100,
                repetitions = { 1, 3 },
            },
            {
                group = "GROUP_LAB_SECURITY_PHAVIAN",
                x = { 0, 8 },
                y = { 0, 5 },
                chance = 60,
                repetitions = { 1, 3 },
            },
        },
    },
}
