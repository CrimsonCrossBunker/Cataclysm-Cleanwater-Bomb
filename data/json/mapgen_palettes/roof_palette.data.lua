local ccb = require("ccb")

-- 12.5% chance of solar, assuming 50% of solar is 7kW, 25% is 6kW and 8kW.
ccb.content.define_mapgen_palette {
    id = "roof_palette",
    layout = {
        toilets = { "T" },
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "residential_6kW_solar", weight = 31 },
                    { id = "residential_7kW_solar", weight = 63 },
                    { id = "residential_8kW_solar", weight = 31 },
                    { id = "null", weight = 873 },
                },
            },
            ["2"] = {
                choices = {
                    { id = "industrial_1x1_solar", weight = 4 },
                    { id = "industrial_1x1_solar_v2", weight = 1 },
                },
            },
            ["3"] = {
                choices = {
                    { id = "null", weight = 15 },
                    { id = "roof_2x2_utilities", weight = 50 },
                    { id = "roof_2x2_utilities_b", weight = 15 },
                    { id = "roof_2x2_utilities_c", weight = 15 },
                    { id = "roof_2x2_utilities_d", weight = 15 },
                },
            },
            ["5"] = {
                choices = { { id = "null", weight = 90 }, { id = "roof_1x1_birdnest", weight = 10 } },
            },
            ["6"] = {
                choices = {
                    { id = "null", weight = 20 },
                    { id = "roof_4x4_utility", weight = 5 },
                    { id = "roof_4x4_utility_1", weight = 5 },
                },
            },
            ["7"] = {
                choices = {
                    { id = "null", weight = 20 },
                    { id = "roof_2x2_infrastructure", weight = 15 },
                    { id = "roof_2x2_infrastructure_1", weight = 5 },
                    { id = "roof_2x2_infrastructure_2", weight = 40 },
                },
            },
            ["8"] = {
                choices = {
                    { id = "null", weight = 50 },
                    { id = "roof_4x4_survivor", weight = 20 },
                    { id = "roof_4x4_party", weight = 10 },
                    { id = "roof_2x2_golf", weight = 7 },
                    { id = "roof_4x4_holdout", weight = 3 },
                    { id = "roof_3x3_wine", weight = 10 },
                },
            },
            ["9"] = {
                choices = {
                    { id = "null", weight = 120 },
                    { id = "roof_6x6_greenhouse_1", weight = 25 },
                    { id = "roof_6x6_greenhouse_2", weight = 25 },
                    { id = "roof_6x6_garden_1", weight = 25 },
                    { id = "roof_6x6_garden_2", weight = 25 },
                    { id = "roof_6x6_survivor", weight = 20 },
                },
            },
            ["-"] = {
                choices = { { id = "null", weight = 1000 }, { id = "roof_1x1_birdnest", weight = 5 } },
            },
        },
        liquid_glyphs = {
            ["Я"] = { id = "water_clean", amount = { 0, 300 } },
            w = { id = "water_clean", amount = { 0, 1000 } },
            W = { id = "water_clean", amount = { 0, 100 } },
        },
        item_groups = { T = { group = "SUS_toilet", chance = 50 } },
        terrain = {
            [">"] = "t_stairs_down",
            v = "t_ladder_down",
            ["."] = "t_flat_roof",
            [" "] = "t_open_air",
            o = "t_glass_roof",
            _ = "t_floor",
            ["-"] = "t_gutter",
            ["4"] = "t_gutter_downspout",
            ["5"] = "t_gutter_drop",
            ["#"] = "t_grate",
            ["&"] = "t_null",
            [":"] = "t_null",
            X = "t_null",
            ["="] = "t_null",
            A = "t_null",
            b = "t_null",
            c = "t_null",
            t = "t_null",
            r = "t_null",
            L = "t_null",
            C = "t_null",
            Y = "t_null",
            y = "t_null",
            f = "t_chainfence",
            g = "t_chaingate_c",
            ["+"] = "t_door_metal_c",
        },
        furniture = {
            ["&"] = "f_roof_turbine_vent",
            N = "f_TV_antenna",
            [":"] = "f_cellphone_booster",
            X = "f_small_satellite_dish",
            ["~"] = "f_chimney",
            ["="] = "f_vent_pipe",
            A = "f_air_conditioner",
            M = "f_solar_unit",
            b = "f_bench",
            c = "f_counter",
            t = "f_table",
            r = "f_rack",
            L = "f_locker",
            C = { { id = "f_crate_c" }, { id = "f_cardboard_box" } },
            Y = "f_stool",
            s = "f_sofa",
            S = "f_sink",
            e = "f_oven",
            F = "f_fridge",
            ["Я"] = "f_standing_tank",
            w = "f_water_heater",
            W = "f_water_heater_family",
            y = { { id = "f_indoor_plant_y" }, { id = "f_indoor_plant" } },
        },
    },
}
