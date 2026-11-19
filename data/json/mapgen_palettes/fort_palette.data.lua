local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "fort_parameter_palette",
    layout = {
        parameters = {
            variant = {
                value_type = "string",
                default = { weighted = { "tourist", "reenactors", "closed" } },
            },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "fort_palette",
    layout = {
        glyph_mappings = {
            R = {
                item_groups = { group = "fort_giftshop_rack", chance = 50, repetitions = { 1, 3 } },
                furniture = "f_rack_wood",
                terrain = "t_floor",
            },
            ["π"] = {
                item_groups = { group = "fort_giftshop_case", chance = 70 },
                furniture = "f_displaycase",
                terrain = "t_floor",
            },
            L = {
                item_groups = { group = "fort_breakroom_lockers", chance = 70, repetitions = { 1, 3 } },
                furniture = "f_locker",
                terrain = "t_floor",
            },
            F = {
                item_groups = { group = "SUS_fridge_partial_empty", chance = 70 },
                furniture = "f_fridge",
                terrain = "t_floor",
            },
            w = {
                item_groups = { group = "fort_historic_wardrobe", chance = 70 },
                furniture = "f_wardrobe",
                terrain = "t_floor",
            },
            C = {
                item_groups = { group = "fort_crate", chance = 70, repetitions = { 1, 10 } },
                furniture = { { id = "f_crate_c", copies = 3 }, { id = "f_crate_o", copies = 1 } },
                terrain = "t_floor",
            },
            O = { item_groups = { group = "fort_powderbarrel", chance = 100 }, terrain = "t_floor" },
            ["&"] = {
                item_spawns = { id = "liquid_soap", chance = 100 },
                furniture = "f_sink",
                terrain = "t_thconc_floor",
            },
            T = {
                item_spawns = { id = "toilet_paper", chance = 100, repetitions = { 1, 2 } },
                furniture = "f_toilet",
                terrain = "t_thconc_floor",
                toilets = {},
            },
            b = {
                item_groups = { group = "bed", chance = 60 },
                furniture = "f_bunkbed",
                terrain = "t_floor",
            },
            r = { furniture = "f_chair", terrain = "t_floor" },
            ["-"] = {
                item_groups = { group = "cash_register_random", chance = 100 },
                furniture = "f_counter",
                terrain = "t_floor",
            },
            ["/"] = { furniture = "f_counter_gate_o", terrain = "t_floor" },
            s = {
                item_groups = { group = "SUS_trash_trashcan", chance = 15 },
                furniture = "f_trashcan",
                terrain = "t_thconc_floor",
            },
            S = {
                item_groups = { group = "SUS_trash_trashcan", chance = 15 },
                furniture = "f_trashcan",
                terrain = "t_floor",
            },
            p = {
                item_groups = { group = "plastic_dishes", chance = 30, repetitions = { 4, 6 } },
                furniture = "f_cupboard",
                terrain = "t_floor",
            },
            ["="] = {
                item_groups = { group = "ammo_cannon", chance = 100 },
                furniture = "f_table",
                terrain = "t_floor",
            },
            t = { furniture = "f_table", terrain = "t_floor" },
            e = { furniture = "f_bench", terrain = "t_sidewalk" },
        },
        terrain = {
            ["*"] = "t_region_groundcover_urban",
            ["?"] = {
                { id = "t_null" },
                { id = "t_region_groundcover_urban" },
                { id = "t_dirt" },
                { id = "t_sidewalk" },
            },
            ["~"] = { { id = "t_dirt", copies = 2 }, { id = "t_region_groundcover_urban", copies = 1 } },
            _ = "t_sidewalk",
            ["."] = "t_floor",
            [","] = "t_thconc_floor",
            ["#"] = "t_rock_smooth",
            ["<"] = "t_slope_up",
            ["7"] = "t_region_tree",
        },
    },
}
