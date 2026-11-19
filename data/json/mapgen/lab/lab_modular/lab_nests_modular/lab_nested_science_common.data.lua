local ccb = require("ccb")

-- A nested map for walls variety.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_wall_chain_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "XX-XX",
            "     ",
            "     ",
            "     ",
            "     ",
        },
        terrain = { ["-"] = "t_chaingate_c", X = "t_chainfence" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- A nested map for lab common research areas.  Rats in cages.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_black_rats_1x1_caged",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        monster_placements = { { id = "mon_black_rat", x = 0, y = 0, chance = 100 } },
        loot_placements = { { id = "pet_carrier", x = 0, y = 0, chance = 100 } },
    },
}

-- A nested map for lab common research areas. Lab rats in cages.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_rats_1x1_caged",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        monster_placements = { { id = "mon_lab_rat", x = 0, y = 0, chance = 100 } },
        loot_placements = { { id = "pet_carrier", x = 0, y = 0, chance = 100 } },
    },
}

-- A nested map for general science areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_3x3_EW_open",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "LLL",
            "   ",
            "jjj",
        },
        palettes = { "lab_common_palette" },
        item_groups = {
            L = {
                { group = "lab_shoes", chance = 70, repetitions = 2 },
                { group = "lab_pants", chance = 70, repetitions = 2 },
                { group = "lab_torso", chance = 70, repetitions = 2 },
            },
        },
    },
}

-- A nested map for general science areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_3x3_EW_open",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "VVV",
            "   ",
            "VVV",
        },
        palettes = { "lab_common_palette" },
        item_groups = { V = { { group = "hospital_medical_items", chance = 70, repetitions = { 1, 3 } } } },
    },
}

-- A nested map for general science areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_3x3_EW_open",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "LLL",
            "   ",
            "jjj",
        },
        palettes = { "lab_common_palette" },
        item_groups = { L = { { group = "hazmat_masks", chance = 70 }, { group = "hazmat_suits", chance = 70 } } },
    },
}

-- A nested map for general science areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_3x3_EW_open",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "UUU",
            "   ",
            "UUU",
        },
        palettes = { "lab_common_palette" },
        item_groups = { U = { { group = "supplies_reagents_lab", chance = 70, repetitions = { 1, 3 } } } },
    },
}

-- A nested map for general science areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_3x3_EW_open",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "qqq",
            "   ",
            "QQQ",
        },
        palettes = { "lab_common_palette" },
        item_groups = {
            q = { { group = "tools_science", chance = 30, repetitions = { 1, 3 } } },
            Q = { { group = "tools_electronics", chance = 30, repetitions = { 1, 3 } } },
        },
    },
}

-- A nested map for lab common research areas.  Includes cold fields.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "mm.mm",
            "f...f",
            "..^..",
            "f...f",
            "aa.aa",
        },
        palettes = { "lab_common_palette" },
        terrain = {},
        furniture = {
            ["^"] = {
                { id = "f_vent_cold_air2_stream", copies = 10 },
                { id = "f_vent_cold_air2_blast", copies = 10 },
            },
        },
        rotation = { 0, 3 },
        item_groups = {
            f = { group = "science", chance = 30, repetitions = { 1, 10 } },
            a = { group = "snacks", chance = 20 },
            m = { { group = "chem_lab", chance = 25 }, { group = "cloning_vat", chance = 25 } },
        },
    },
}

-- A nested map for lab common research areas.  Includes hot fields.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "mm.mm",
            "f...f",
            "..^..",
            "f...f",
            "aa.aa",
        },
        palettes = { "lab_common_palette" },
        terrain = {},
        furniture = {
            ["^"] = {
                { id = "f_vent_hot_air2_blast", copies = 10 },
                { id = "f_vent_hot_air2_stream", copies = 10 },
            },
        },
        rotation = { 0, 3 },
        item_groups = {
            f = { group = "science", chance = 20, repetitions = { 1, 10 } },
            a = { group = "science", chance = 5 },
            m = { { group = "chem_lab", chance = 25 }, { group = "cloning_vat", chance = 25 } },
        },
    },
}

-- A nested map for general science areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_3x3_EW_open",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "VVV",
            "   ",
            "VVV",
        },
        palettes = { "lab_common_palette" },
        item_groups = { V = { { group = "hospital_medical_items", chance = 70, repetitions = { 1, 3 } } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_safety_graffiti",
    layout = {
        size = { width = 1, height = 1 },
        graffiti_placements = { { snippet = "lab_safety_snippet", x = 0, y = 0 } },
    },
}

-- A nested map for walls variety.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_wall_glass_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "XX-XX",
            "     ",
            "     ",
            "     ",
            "     ",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        sign_placements = {
            { snippet = "lab_safety_snippet", x = { 0, 1 }, y = 0 },
            { snippet = "lab_safety_snippet", x = { 3, 4 }, y = 0 },
        },
    },
}

-- A nested map for door variety.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_wall_door_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "null", weight = 50 }, { id = "lab_safety_graffiti", weight = 50 } },
                x = { 0, 1 },
                y = 0,
            },
            {
                choices = { { id = "null", weight = 50 }, { id = "lab_safety_graffiti", weight = 50 } },
                x = { 3, 4 },
                y = 0,
            },
        },
        terrain_placements = { { id = "t_door_lab_c", x = 2, y = 0 } },
    },
}

-- A nested map for door variety.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_wall_glassdoor_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "null", weight = 50 }, { id = "lab_safety_graffiti", weight = 50 } },
                x = { 0, 1 },
                y = 0,
            },
            {
                choices = { { id = "null", weight = 50 }, { id = "lab_safety_graffiti", weight = 50 } },
                x = { 3, 4 },
                y = 0,
            },
        },
        terrain_placements = { { id = "t_door_glass_lab_c", x = 2, y = 0 } },
    },
}

-- A nested map for door variety, includes slime spawns for rooms that use this wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_wall_glassdoor_5x5",
    weight = 10,
    layout = {
        size = { width = 5, height = 5 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "null", weight = 50 }, { id = "lab_safety_graffiti", weight = 50 } },
                x = { 0, 1 },
                y = 0,
            },
            {
                choices = { { id = "null", weight = 50 }, { id = "lab_safety_graffiti", weight = 50 } },
                x = { 3, 4 },
                y = 0,
            },
        },
        terrain_placements = { { id = "t_door_glass_lab_c", x = 2, y = 0 } },
        monster_group_placements = { { group = "GROUP_SLIME", x = { 0, 4 }, y = { 1, 4 }, density = 0.1 } },
        loot_placements = { { id = "canister_empty", x = 3, y = 2, chance = 100 } },
    },
}

-- A nested map for lab common research areas.  Includes cold fields.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_6x6",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "qq..qq",
            "......",
            ".qqqq.",
            ".qqqq.",
            "..^...",
            "qq..qq",
        },
        palettes = { "lab_common_palette" },
        furniture = {
            ["^"] = { { id = "f_vent_cold_air2_stream", copies = 70 }, { id = "f_null", copies = 30 } },
        },
        rotation = { 0, 3 },
        item_groups = { q = { { group = "supplies_reagents_lab", chance = 50 } } },
    },
}

-- A nested map for lab common research areas.  Includes hot fields.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_6x6",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "qq..qq",
            "......",
            ".Af...",
            "..f.A.",
            "..^...",
            "qq..qq",
        },
        palettes = { "lab_mutagen_palette" },
        furniture = {
            ["^"] = {
                { id = "f_vent_hot_air2_blast", copies = 30 },
                { id = "f_vent_hot_air2_stream", copies = 30 },
            },
        },
        rotation = { 0, 3 },
        item_groups = { q = { { group = "supplies_reagents_lab", chance = 50 } } },
    },
}

-- A nested map for lab common research areas.  Includes toxic fields.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_6x6",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "qn...k",
            "w.Ac.l",
            "...c..",
            "..^d..",
            ".o....",
            "ef..fe",
        },
        palettes = { "lab_common_palette" },
        furniture = { ["^"] = "f_vent_toxic_leak" },
        rotation = { 0, 3 },
        item_groups = { F = { { group = "goo", chance = 50 } } },
    },
}

-- A nested map for lab common research areas. Classic goo trap room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_6x6",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            ".....F",
            "......",
            "......",
            "..^...",
            "......",
            "......",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        trap_placements = { { id = "tr_goo", x = { 0, 5 }, y = { 0, 5 }, repetitions = { 1, 10 } } },
        item_groups = { F = { { group = "goo", chance = 50 } } },
    },
}

-- A nested map for lab common research areas. Radiation room.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_6x6",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "......",
            ".    .",
            ". ^^ .",
            ". ^^ .",
            ".   ɱ.",
            "......",
        },
        palettes = { "lab_common_palette" },
        terrain = { [" "] = "t_floor_green" },
        furniture = { ["^"] = "f_vent_rad_leak" },
        rotation = { 0, 3 },
        monster_placements = { { id = "mon_hazmatbot", x = 3, y = 3, chance = 100 } },
        liquid_placements = { { id = "plut_slurry", x = { 1, 4 }, y = { 1, 3 }, amount = { 1, 2 } } },
    },
}

-- A nested map for lab common research areas.  Includes freezing fields.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_6x6",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "......",
            ".****.",
            ".*^.*.",
            "...^*.",
            ".****.",
            "......",
        },
        palettes = { "lab_common_palette" },
        furniture = { ["^"] = "f_vent_cold_air2_blast" },
        rotation = { 0, 3 },
        item_groups = { ["*"] = { { group = "cloning_vat", chance = 50 } } },
    },
}

-- A nested map for lab common research areas.  Includes freezing fields.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_6x6",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "**..**",
            "......",
            ".AJb..",
            "..ab..",
            "^...A.",
            "**..**",
        },
        palettes = { "lab_common_palette" },
        furniture = { ["^"] = "f_vent_cold_air2_blast" },
        rotation = { 0, 3 },
        item_groups = {
            ["*"] = { group = "cloning_vat", chance = 50 },
            J = { group = "dissection", chance = 50 },
        },
    },
}

-- A nested map for a 5x9 room, includes door on east wall.  This is a small library.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_9x9_E",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "RR RR|   ",
            "R    X   ",
            "REI  X   ",
            "R IE |   ",
            "R    -   ",
            "REI  |   ",
            "R IE X   ",
            "R    X   ",
            "RR RR|   ",
        },
        palettes = { "lab_common_palette" },
        item_groups = { R = { { group = "lab_bookshelves", chance = 70, repetitions = { 1, 3 } } } },
    },
}

-- A nested map for a 5x9 room, includes door on west wall.  This is a small library.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_9x9_W",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "   |RR RR",
            "   X    R",
            "   X IE R",
            "   |EI  R",
            "   -    R",
            "   |EI  R",
            "   X IE R",
            "   X    R",
            "   |RR RR",
        },
        palettes = { "lab_common_palette" },
        item_groups = { R = { { group = "lab_bookshelves", chance = 70, repetitions = { 1, 3 } } } },
    },
}

-- A nested map for a 5x9 room, includes door on west wall.  This is a small armory for emergent situations.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_9x9_W",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "   |∞∞∞∞∞",
            "   |Q    ",
            "   |Q j L",
            "  6|  j L",
            "   =    L",
            "   ||Y  L",
            "   ||||||",
            "   |UUUUU",
            "   +    U",
        },
        palettes = { "lab_common_palette" },
        item_groups = {
            L = {
                { group = "clothing_soldier_set_pristine", chance = 30 },
                { group = "book_military", chance = 33 },
                { group = "snacks", chance = 10 },
            },
            ["∞"] = {
                { group = "ammo_milspec", chance = 30 },
                { group = "mags_milspec", chance = 30 },
                { group = "mags_flamethrower_xedra", chance = 15 },
            },
            j = { { group = "gear_soldier_sidearm", chance = 33 } },
            U = { { group = "cleaning", chance = 33 } },
            Q = {
                { group = "guns_milspec", chance = 66, repetitions = { 1, 3 } },
                { group = "guns_launcher_flame_xedra", chance = 50, repetitions = { 0, 1 } },
            },
        },
        computer_glyphs = {
            ["6"] = {
                name = ccb.content.text("Magazine Entrance"),
                security = 6,
                menu = {
                    {
                        label = ccb.content.text("UNLOCK ENTRANCE"),
                        action = "unlock_disarm",
                        security = 7,
                    },
                },
                failures = { "damage", "shutdown" },
            },
        },
    },
}

-- A nested map for a 5x9 room, includes door on east wall. This is a small armory for emergent situations.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_9x9_E",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "∞∞∞∞∞|   ",
            "    Q|   ",
            "L   Q|   ",
            "L j  |6  ",
            "L j  =   ",
            "L   Y|   ",
            "||||||   ",
            "UUUUU|   ",
            "U    +   ",
        },
        palettes = { "lab_common_palette" },
        item_groups = {
            L = {
                { group = "clothing_soldier_set_pristine", chance = 30 },
                { group = "book_military", chance = 33 },
                { group = "snacks", chance = 10 },
            },
            ["∞"] = {
                { group = "ammo_milspec", chance = 30 },
                { group = "mags_milspec", chance = 30 },
                { group = "mags_flamethrower_xedra", chance = 15 },
            },
            j = { { group = "gear_soldier_sidearm", chance = 33 } },
            U = { { group = "cleaning", chance = 33 } },
            Q = {
                { group = "guns_milspec", chance = 66, repetitions = { 1, 3 } },
                { group = "guns_launcher_flame_xedra", chance = 50, repetitions = { 0, 1 } },
            },
        },
        computer_glyphs = {
            ["6"] = {
                name = ccb.content.text("Magazine Entrance"),
                security = 6,
                menu = {
                    {
                        label = ccb.content.text("UNLOCK ENTRANCE"),
                        action = "unlock_disarm",
                        security = 7,
                    },
                },
                failures = { "damage", "shutdown" },
            },
        },
    },
}
