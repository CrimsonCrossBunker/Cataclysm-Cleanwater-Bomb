local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "convention_palette",
    layout = {
        toilets = { "t" },
        nested_glyphs = {
            ["("] = {
                choices = {
                    { id = "null", weight = 2 },
                    { id = "conference_small_vacant", weight = 6 },
                    { id = "conference_small_lecture", weight = 3 },
                    { id = "conference_small_meeting", weight = 3 },
                },
            },
            [")"] = {
                choices = {
                    { id = "null", weight = 2 },
                    { id = "conference_big_vacant", weight = 6 },
                    { id = "conference_big_lecture", weight = 3 },
                    { id = "conference_big_meeting", weight = 3 },
                },
            },
        },
        item_groups = {
            A = { group = "SUS_trash_dumpster", chance = 75 },
            O = { group = "SUS_oven", chance = 80 },
            P = { group = "SUS_office_filing_cabinet", chance = 33 },
            a = { group = "SUS_trash_trashcan_public", chance = 33 },
            d = { group = "SUS_office_desk", chance = 33 },
            e = { group = "SUS_fridge_breakroom", chance = 80 },
            l = { group = "SUS_janitors_closet", chance = 100 },
            m = { group = "groce_softdrink", chance = 80, repetitions = { 4, 10 } },
            r = { group = "fast_kitchen", chance = 80, repetitions = { 2, 5 } },
            t = { group = "SUS_toilet", chance = 50 },
            ["é"] = { group = "fast_fridge", chance = 80, repetitions = { 4, 10 } },
        },
        liquid_glyphs = { g = { id = "water_clean", amount = { 0, 100 } } },
        vending_glyphs = {
            D = { group = "vending_drink", lootable = true },
            F = { group = "vending_food", lootable = true },
        },
        palettes = {
            {
                weighted = {
                    { id = "convention_nested_vacant", weight = 2 },
                    { id = "convention_nested_fandom", weight = 5 },
                    { id = "convention_nested_lecture_small", weight = 2 },
                    { id = "convention_nested_lecture_big", weight = 3 },
                },
            },
        },
        terrain = {
            ["│"] = "t_open_air",
            _ = "t_concrete",
            A = "t_concrete",
            f = "t_chainfence",
            G = "t_chaingate_l",
            ["-"] = "t_wall_glass",
            ["="] = "t_door_glass_c",
            ["+"] = "t_door_metal_c",
            ["|"] = "t_concrete_wall",
            ["."] = "t_linoleum_white",
            [":"] = "t_linoleum_gray",
            [" "] = "t_thconc_floor",
            H = "t_thconc_floor",
            N = "t_thconc_floor",
            ["["] = "t_thconc_floor",
            l = "t_thconc_floor",
            g = "t_thconc_floor",
            ["1"] = "t_thconc_floor",
            ["2"] = "t_thconc_floor",
            ["4"] = "t_thconc_floor",
            ["5"] = "t_thconc_floor",
            ["6"] = "t_thconc_floor",
            ["7"] = "t_thconc_floor",
            ["8"] = "t_thconc_floor",
            ["9"] = "t_thconc_floor",
            ["0"] = "t_thconc_floor",
            [","] = "t_floor",
            ["("] = "t_floor",
            [")"] = "t_floor",
            ["!"] = "t_grate",
            ["'"] = "t_metal_railing",
            ["/"] = "t_glass_railing",
            E = "t_elevator",
            ["<"] = "t_stairs_up",
            [">"] = "t_stairs_down",
            ["^"] = "t_ladder_up",
            I = "t_gutter_downspout",
            o = "t_glass_roof",
            ["*"] = "t_open_air_rooved",
        },
        furniture = {
            e = "f_fridge",
            ["é"] = "f_heavy_duty_fridge",
            m = "f_glass_fridge",
            r = "f_utility_shelf",
            O = "f_oven",
            c = "f_counter",
            d = "f_desk",
            P = "f_filing_cabinet",
            h = "f_chair",
            b = "f_metal_bench",
            y = { { id = "f_indoor_plant" }, { id = "f_indoor_plant_y" } },
            H = "f_chair_folding",
            N = "f_tourist_table",
            n = "f_table",
            ["["] = "f_room_divider",
            S = "f_sink",
            l = "f_locker",
            g = "f_water_heater",
            A = "f_dumpster",
            a = "f_trashcan",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "convention_nested_vacant",
    layout = {
        nested_glyphs = {
            ["1"] = {
                choices = { { id = "null", weight = 1 }, { id = "convention_up_left_vacant", weight = 1 } },
            },
            ["2"] = {
                choices = { { id = "null", weight = 1 }, { id = "convention_up_right_vacant", weight = 1 } },
            },
            ["3"] = {
                choices = { { id = "null", weight = 1 }, { id = "convention_mid_left_vacant", weight = 1 } },
            },
            ["4"] = {
                choices = { { id = "null", weight = 1 }, { id = "convention_mid_right_vacant", weight = 1 } },
            },
            ["5"] = {
                choices = { { id = "null", weight = 1 }, { id = "convention_down_left_vacant", weight = 1 } },
            },
            ["6"] = {
                choices = { { id = "null", weight = 1 }, { id = "convention_down_right_vacant", weight = 1 } },
            },
            ["7"] = {
                choices = { { id = "null", weight = 1 }, { id = "convention_up_left_vacant", weight = 1 } },
            },
            ["8"] = {
                choices = { { id = "null", weight = 1 }, { id = "convention_up_right_vacant", weight = 1 } },
            },
            ["9"] = {
                choices = { { id = "null", weight = 1 }, { id = "convention_down_left_vacant", weight = 1 } },
            },
            ["0"] = {
                choices = { { id = "null", weight = 1 }, { id = "convention_down_right_vacant", weight = 1 } },
            },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "convention_nested_fandom",
    layout = {
        nested_glyphs = {
            ["1"] = { id = "convention_up_left_fandom" },
            ["2"] = { id = "convention_up_right_fandom" },
            ["3"] = { id = "convention_mid_left_fandom" },
            ["4"] = { id = "convention_mid_right_fandom" },
            ["5"] = { id = "convention_down_left_fandom" },
            ["6"] = { id = "convention_down_right_fandom" },
            ["7"] = { id = "convention_up_left_lecture" },
            ["8"] = { id = "convention_up_right_lecture" },
            ["9"] = { id = "convention_down_left_lecture" },
            ["0"] = { id = "convention_down_right_lecture" },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "convention_nested_lecture_small",
    layout = {
        nested_glyphs = {
            ["1"] = { id = "convention_up_left_vacant" },
            ["2"] = { id = "convention_up_right_vacant" },
            ["3"] = { id = "convention_mid_left_vacant" },
            ["4"] = { id = "convention_mid_right_vacant" },
            ["5"] = { id = "convention_down_left_vacant" },
            ["6"] = { id = "convention_down_right_vacant" },
            ["7"] = { id = "convention_up_left_lecture" },
            ["8"] = { id = "convention_up_right_lecture" },
            ["9"] = { id = "convention_down_left_lecture" },
            ["0"] = { id = "convention_down_right_lecture" },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "convention_nested_lecture_big",
    layout = {
        nested_glyphs = {
            ["1"] = { id = "convention_up_left_lecture" },
            ["2"] = { id = "convention_up_right_lecture" },
            ["3"] = { id = "convention_mid_left_lecture" },
            ["4"] = { id = "convention_mid_right_lecture" },
            ["5"] = { id = "convention_down_left_lecture" },
            ["6"] = { id = "convention_down_right_lecture" },
            ["7"] = { id = "convention_up_left_vacant" },
            ["8"] = { id = "convention_up_right_vacant" },
            ["9"] = { id = "convention_down_left_vacant" },
            ["0"] = { id = "convention_down_right_vacant" },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "convention_nested_palette",
    layout = {
        item_groups = { a = { group = "SUS_trash_trashcan_public", chance = 33 } },
        terrain = { ["│"] = "t_null" },
        furniture = {
            ["*"] = "f_room_divider",
            n = "f_tourist_table",
            h = "f_chair_folding",
            y = { { id = "f_indoor_plant" }, { id = "f_indoor_plant_y" } },
            a = "f_trashcan",
            X = "f_cardboard_box",
        },
    },
}
