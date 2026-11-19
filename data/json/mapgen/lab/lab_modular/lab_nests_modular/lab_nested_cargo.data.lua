local ccb = require("ccb")

-- A nested map for lab cargo areas.  Includes cold fields.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_cargo_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            "     ",
            "  ^  ",
            "     ",
            "     ",
        },
        palettes = { "lab_common_palette" },
        furniture = {
            ["^"] = {
                { id = "f_vent_cold_air2_stream", copies = 30 },
                { id = "f_vent_cold_air2_stream", copies = 30 },
            },
        },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "null", weight = 50 }, { id = "surface_sub_f_crate", weight = 50 } },
                x = { 0, 4 },
                y = { 0, 4 },
                repetitions = { 2, 10 },
            },
        },
    },
}

-- A nested map for lab cargo research areas.  Includes hot fields.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_cargo_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            "     ",
            "  ^  ",
            "     ",
            "     ",
        },
        palettes = { "lab_common_palette" },
        furniture = {
            ["^"] = {
                { id = "f_vent_hot_air2_blast", copies = 30 },
                { id = "f_vent_hot_air2_stream", copies = 30 },
            },
        },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "null", weight = 50 }, { id = "surface_sub_f_crate", weight = 50 } },
                x = { 0, 4 },
                y = { 0, 4 },
                repetitions = { 2, 10 },
            },
        },
    },
}

-- A nested map for lab cargo research areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_cargo_5x5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            "     ",
            "  ^  ",
            "     ",
            "     ",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "null", weight = 50 }, { id = "surface_sub_f_crate", weight = 50 } },
                x = { 0, 4 },
                y = { 0, 4 },
                repetitions = { 2, 10 },
            },
        },
    },
}

-- A nested map for lab cargo research areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_cargo_5x5",
    weight = 10,
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "   z ",
            "     ",
            "  ^  ",
            " z   ",
            "     ",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "null", weight = 50 }, { id = "surface_sub_f_crate", weight = 50 } },
                x = { 0, 4 },
                y = { 0, 4 },
                repetitions = { 1, 3 },
            },
        },
        monster_placements = { { id = "mon_zombie_static", x = 2, y = 2 } },
        item_groups = { z = { group = "batteries", chance = 100 } },
    },
}
