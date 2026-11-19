local ccb = require("ccb")

-- Alchemical basement
ccb.content.define_mapgen {
    kind = "nested",
    id = "6x6_sewing_open",
    weight = 250,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "bb..CC",
            "b.....",
            "..ff..",
            ".hffT.",
            "...a..",
            "......",
        },
        terrain = {
            ["."] = "t_thconc_floor",
            B = "t_thconc_floor",
            f = "t_thconc_floor",
            h = "t_thconc_floor",
            C = "t_thconc_floor",
            a = "t_thconc_floor",
            T = "t_thconc_floor",
            b = "t_thconc_floor",
        },
        furniture = {
            a = "f_alembic",
            h = "f_stool",
            b = "f_bookcase",
            B = "f_workbench",
            E = "f_armchair",
            C = "f_rack_wood",
            T = "f_floor_lamp",
            f = "f_table",
            y = { { id = "f_indoor_plant_y" }, { id = "f_indoor_plant" } },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_placements = { { id = "chemistry_set", x = 2, y = 2, chance = 50 } },
        item_groups = {
            f = { { group = "alchemical_materials", chance = 50, repetitions = { 1, 2 } } },
            C = { { group = "alchemical_materials", chance = 60, repetitions = { 3, 6 } } },
            b = {
                { group = "alchemical_recipes", chance = 75 },
                { group = "hedge_magic_books", chance = 2 },
            },
        },
    },
}

-- Alchemical basement
ccb.content.define_mapgen {
    kind = "nested",
    id = "6x6_electronics_open",
    weight = 250,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "bb..CC",
            "b.....",
            "..ff..",
            ".hffT.",
            "...a..",
            "......",
        },
        terrain = {
            ["."] = "t_thconc_floor",
            B = "t_thconc_floor",
            f = "t_thconc_floor",
            h = "t_thconc_floor",
            C = "t_thconc_floor",
            a = "t_thconc_floor",
            T = "t_thconc_floor",
            b = "t_thconc_floor",
        },
        furniture = {
            a = "f_alembic",
            h = "f_stool",
            b = "f_bookcase",
            B = "f_workbench",
            E = "f_armchair",
            C = "f_rack_wood",
            T = "f_floor_lamp",
            f = "f_table",
            y = { { id = "f_indoor_plant_y" }, { id = "f_indoor_plant" } },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_placements = { { id = "chemistry_set", x = 2, y = 2, chance = 50 } },
        item_groups = {
            f = { { group = "alchemical_materials", chance = 50, repetitions = { 1, 2 } } },
            C = { { group = "alchemical_materials", chance = 60, repetitions = { 3, 6 } } },
            b = {
                { group = "alchemical_recipes", chance = 75 },
                { group = "hedge_magic_books", chance = 2 },
            },
        },
    },
}
