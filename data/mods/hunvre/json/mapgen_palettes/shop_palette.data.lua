local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "restaurant_palette_hunvre",
    layout = {
        item_groups = {
            ["="] = { { group = "crepe_ingredients" }, { group = "crepe_filling_ingredients" } },
            C = { { group = "any_crepe", chance = 50 }, { group = "kitchen_nonfood" } },
            E = { { group = "crepe_ingredients" }, { group = "crepe_filling_ingredients" } },
            F = { { group = "crepe_ingredients" }, { group = "crepe_filling_ingredients" } },
            H = { { group = "crepe_ingredients" }, { group = "crepe_filling_ingredients" } },
            d = { group = "kitchen_nonfood" },
            f = { { group = "crepe_ingredients" }, { group = "crepe_filling_ingredients" } },
            j = { group = "SUS_kitchen_sink" },
        },
        palettes = { "base" },
        parameters = {
            carpet_color_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_carpet_green", weight = 1 },
                        { id = "t_carpet_red", weight = 1 },
                        { id = "t_carpet_yellow", weight = 1 },
                    },
                },
            },
        },
        terrain = {
            _ = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            T = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            h = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            e = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            g = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            b = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
        },
        furniture = {
            j = "f_sink",
            D = "f_dishwasher",
            E = "f_fridge",
            F = "f_heavy_duty_fridge",
            f = "f_freezer",
            O = "f_oven",
            o = "f_deep_fryer",
            A = "f_dumpster",
            a = "f_trashcan",
            C = "f_counter",
            c = "f_counter_gate_c",
            d = "f_cupboard",
            T = "f_table",
            h = "f_chair",
            e = "f_barstool",
            g = "f_stool",
            b = "f_bench",
            ["="] = "f_rack",
            H = "f_warehouse_shelf",
        },
    },
}
