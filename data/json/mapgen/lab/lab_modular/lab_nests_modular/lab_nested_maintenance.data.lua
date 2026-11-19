local ccb = require("ccb")

-- A nested map for maintenance areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_6x6_open",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "vv   g",
            "   5 g",
            " A₸5  ",
            "  Z5  ",
            "   5 g",
            "uu   g",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
    },
}

-- A nested map for maintenance areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_6x6_open",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            " XXXX ",
            " - ØX ",
            " XØØX ",
            " XXXX ",
            "      ",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- A nested map for generic content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " h   ",
            "NN  Q",
            "    q",
            "  NN ",
            "   h ",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- A nested map for generic content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "L   L",
            "L j y",
            "  j  ",
            "Y j L",
            "L   L",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- A nested map for generic content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "^^^^^",
            "^ƨƨƨ^",
            "^ƨƨƨ^",
            "^ƨƨƨ^",
            "^^^^^",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- A nested map for generic content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "00   ",
            " 0ƨƨ ",
            " 07Z ",
            " 0ƨƨ ",
            "00   ",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- A nested map for generic content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "₸   ⁵",
            "    ⁵",
            " ɱJJ ",
            "  A  ",
            "⁵⁵   ",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- A nested map for generic content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            ";ƧƧƧ;",
            ";~~~;",
            ";~~~;",
            ";~~~;",
            ";ƧƧƧ;",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        terrain = { ["~"] = "t_sewage", ["Ƨ"] = "t_thconc_floor" },
        furniture = { ["Ƨ"] = "f_barricade_road" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- A nested map for generic content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            " WWW ",
            " WWW ",
            " WWW ",
            "     ",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- A nested map for maintenance areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_6x6_open",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "II    ",
            "h  Ø  ",
            "   Ø  ",
            "   Ø  ",
            "⁵  Ø ⁵",
            "⁵⁵  ⁵⁵",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- A nested map for maintenance areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_3x3_NS_open",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "  Y",
            " AN",
            "Q N",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        item_groups = {
            N = { { group = "tools_common", chance = 20 } },
            Q = { { group = "tools_electronics", chance = 20 } },
        },
    },
}

-- A nested map for maintenance areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_3x3_NS_open",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "₸  ",
            "₸ Z",
            "6 Ö",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
    },
}

-- A nested map for maintenance areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_3x3_NS_open",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "ɜ ɜ",
            "5 5",
            "ɜ ɜ",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
    },
}

-- A nested map for maintenance areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_3x3_NS_open",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "v Y",
            "u u",
            "6 v",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
    },
}

-- A nested map for maintenance areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_3x3_NS_open",
    layout = {
        size = { width = 3, height = 3 },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        nested = {
            {
                choices = { { id = "sub_fd_shock_vent", weight = 30 }, { id = "null", weight = 70 } },
                x = 1,
                y = 1,
            },
        },
        loot_placements = { { group = "SUS_trash_floor", x = { 1, 3 }, y = { 1, 3 }, repetitions = 3, chance = 100 } },
    },
}

-- A nested map for maintenance areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_3x3_NS_open",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "Q q",
            "Q q",
            "Q q",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        item_groups = {
            q = { { group = "tools_common", chance = 70, repetitions = { 1, 3 } } },
            Q = { { group = "tools_electronics", chance = 70, repetitions = { 1, 3 } } },
        },
    },
}

-- A nested map for maintenance areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_3x3_NS_open",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "I w",
            "IAw",
            "Y w",
        },
        palettes = { "lab_common_palette" },
        item_groups = {
            I = {
                { group = "SUS_tailoring_tool_drawer", chance = 60, repetitions = { 0, 1 } },
                { group = "tailorbooks", chance = 60, repetitions = { 0, 1 } },
                { group = "SUS_tailoring_fasteners", chance = 30, repetitions = { 2, 6 } },
            },
            w = { { group = "SUS_tailoring_materials", chance = 70, repetitions = { 1, 3 } } },
        },
    },
}

-- A nested map for maintenance areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_3x3_EW_open",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "qqq",
            "   ",
            "QQQ",
        },
        palettes = { "lab_common_palette" },
        item_groups = {
            q = { { group = "tools_common", chance = 70, repetitions = { 1, 3 } } },
            Q = { { group = "tools_electronics", chance = 70, repetitions = { 1, 3 } } },
        },
    },
}

-- A nested map for maintenance areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_3x3_EW_open",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "IIY",
            " A ",
            "www",
        },
        palettes = { "lab_common_palette" },
        item_groups = {
            I = {
                { group = "SUS_tailoring_tool_drawer", chance = 60, repetitions = { 0, 1 } },
                { group = "tailorbooks", chance = 60, repetitions = { 0, 1 } },
                { group = "SUS_tailoring_fasteners", chance = 30, repetitions = { 2, 6 } },
            },
            w = { { group = "SUS_tailoring_materials", chance = 70, repetitions = { 1, 3 } } },
        },
    },
}

-- A nested map for maintenance tunnel content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_room_NE",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "||;||",
            "|;;;|",
            "|;^;;",
            "|;;;|",
            "|||||",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "cheese_hard", x = 2, y = { 1, 3 }, chance = 100 },
            { id = "blanket", x = 1, y = 3, chance = 100 },
            { id = "flask_glass", x = 1, y = 3, chance = 100 },
            { id = "iv_mutagen_rat", x = { 1, 3 }, y = { 1, 3 }, chance = 100 },
        },
    },
}

-- A nested map for maintenance tunnel content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_room_NE",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "||;||",
            "|;;;|",
            "|;^;;",
            "|;;;|",
            "|||||",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "recipe_elfa", x = 2, y = { 1, 3 }, chance = 100 },
            { id = "blanket", x = 1, y = 3, chance = 100 },
            { id = "syringe", x = 1, y = 3, chance = 100 },
            { id = "test_tube", x = { 1, 3 }, y = { 1, 3 }, chance = 100 },
        },
    },
}

-- A nested map for maintenance tunnel content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_room_NE",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "||;||",
            "|;;;|",
            "|;^;;",
            "|;;;|",
            "|||||",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "record_patient", x = 2, y = { 1, 3 }, chance = 100 },
            { id = "decoy_elfa", x = 1, y = 3, chance = 100 },
            { id = "wrench", x = 1, y = 3, chance = 100 },
            { id = "canister_goo", x = { 1, 3 }, y = { 1, 3 }, chance = 100 },
        },
    },
}

-- A nested map for maintenance tunnel content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_room_NE",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "||;||",
            "|;;;|",
            "|;^;;",
            "|;;;|",
            "|||||",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { group = "toxic_waste", x = { 1, 3 }, y = { 1, 3 }, repetitions = 3, chance = 100 },
            { id = "geiger_off", x = 1, y = 3, chance = 100 },
        },
    },
}

-- A nested map for maintenance tunnel content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_room_NE",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "||;||",
            "|;;;|",
            "|;^;;",
            "|;;;|",
            "|||||",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_placements = {
            {
                id = "mon_sewer_rat",
                x = { 1, 3 },
                y = { 1, 3 },
                repetitions = { 2, 4 },
                chance = 100,
            },
        },
    },
}

-- A nested map for maintenance tunnel content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_room_S",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "|||||",
            "|;;;|",
            "|;^;|",
            "|;;;|",
            "||;||",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_placements = {
            {
                id = "mon_black_rat",
                x = { 1, 3 },
                y = { 1, 3 },
                repetitions = { 2, 4 },
                chance = 100,
            },
        },
    },
}

-- A nested map for maintenance tunnel content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_room_S",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "|||||",
            "|;;;|",
            "|;^;|",
            "|;;;|",
            "||;||",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_placements = {
            {
                id = "mon_sewer_snake",
                x = { 1, 3 },
                y = { 1, 3 },
                repetitions = { 2, 4 },
                chance = 100,
            },
        },
    },
}

-- A nested map for maintenance tunnel content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_room_S",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "|||||",
            "|;;;|",
            "|;Æ;|",
            "|;;;|",
            "||;||",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        terrain = { ["Æ"] = "t_thconc_floor" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "file", x = { 1, 3 }, y = { 1, 3 }, repetitions = 5, chance = 50 },
            { id = "paper", x = { 1, 3 }, y = { 1, 3 }, repetitions = 6, chance = 50 },
            { id = "money_strap_twenty", x = { 1, 3 }, y = { 1, 3 }, repetitions = 2, chance = 60 },
            { id = "molotov", x = { 1, 3 }, y = { 1, 3 }, repetitions = 2, chance = 3 },
            { id = "matches", x = { 1, 3 }, y = { 1, 3 }, repetitions = 2, chance = 100 },
        },
    },
}

-- A nested map for a 5x9 room, includes door on east wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_9x9_E",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "A   Q|   ",
            "NN  Q|   ",
            "     |   ",
            "J    #   ",
            "J A  #   ",
            "J    |   ",
            "    Y|   ",
            "N A Q|   ",
            "NN  Q|   ",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        loot_placements = { { id = "broken_secubot", x = 0, y = 6, chance = 100 } },
    },
}

-- A nested map for a 5x9 room, includes door on west wall, possible door on south wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_9x9_W",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "   |Q  NN",
            "   |Q  A ",
            "   |     ",
            "   #    J",
            "   #    J",
            "   |    J",
            "   |Y    ",
            "   |Q  NN",
            "   |Q   A",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        loot_placements = {
            { id = "broken_skitterbot", x = 8, y = 2, chance = 100 },
            { id = "broken_nursebot_defective", x = 8, y = 6, chance = 100 },
        },
    },
}

-- A nested map for a 5x9 room, includes door on east wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_9x9_E",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "`WWW`|   ",
            "     |   ",
            "  s  |   ",
            "₸ s  #   ",
            "Z sA #   ",
            "₸ s  |   ",
            " As  |   ",
            "     |   ",
            "QQ QQ|   ",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        loot_placements = {
            { id = "broken_gasbomb_hack", x = 0, y = 0, chance = 100 },
            { id = "broken_EMP_hack", x = 4, y = 0, chance = 100 },
        },
    },
}

-- A nested map for a 5x9 room, includes door on west wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_9x9_W",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "   |`WWW`",
            "   |     ",
            "   |  s  ",
            "   #  sA₸",
            "   #  s Z",
            "   | As ₸",
            "   |  s  ",
            "   |     ",
            "   |QQ QQ",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        loot_placements = {
            { id = "broken_science_bot", x = 4, y = 0, chance = 100 },
            { id = "broken_grenade_hack", x = 8, y = 0, chance = 100 },
        },
    },
}
