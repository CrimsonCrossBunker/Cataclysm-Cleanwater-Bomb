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
