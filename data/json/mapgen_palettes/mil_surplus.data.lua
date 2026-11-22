local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "indoor_tent_3x3_N",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "#+#",
            "#x#",
            "###",
        },
        furniture = { ["#"] = "f_canvas_wall", x = "f_groundsheet", ["+"] = "f_canvas_door" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen_palette {
    id = "mil_surplus",
    layout = {
        parameters = {
            window_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_window", weight = 1 },
                        { id = "t_window_alarm", weight = 1 },
                    },
                },
            },
        },
        terrain = {
            ["."] = "t_region_groundcover_urban",
            ["["] = "t_region_groundcover_urban",
            ["~"] = "t_sidewalk",
            ["="] = "t_sidewalk",
            ["-"] = "t_railing",
            _ = "t_linoleum_white",
            ["&"] = "t_linoleum_white",
            ["%"] = "t_linoleum_white",
            ["'"] = { parameter = "window_type", fallback = "t_window" },
            ["+"] = "t_door_c",
            ["!"] = "t_door_locked",
            ["/"] = "t_door_curtain_c",
            Y = "t_concrete",
            U = "t_concrete",
            ["4"] = "t_gutter_downspout",
            ["<"] = "t_ladder_up",
        },
        furniture = {
            G = "f_counter",
            U = {
                { id = "f_dumpster" },
                { id = "f_recycle_bin" },
            },
            h = "f_chair",
            ["%"] = "f_sink",
            ["@"] = "f_mannequin",
            L = "f_locker",
            l = "f_locker",
            ["^"] = {
                { id = "f_bigmirror", copies = 3 },
                { id = "f_bigmirror_b" },
            },
            S = "f_stool",
            A = "f_rack",
            B = "f_rack",
            C = "f_rack",
            D = "f_rack",
            E = "f_rack",
            F = "f_rack",
            ["А"] = "f_rack",
            ["Б"] = "f_rack",
            ["В"] = "f_rack",
            ["Г"] = "f_rack",
            ["Д"] = "f_rack",
            ["Е"] = "f_rack",
            ["*"] = "f_canvas_wall",
            ["8"] = "f_groundsheet",
            ["]"] = "f_canvas_door",
            Q = "f_camp_chair",
            b = "f_brazier",
            r = "f_tourist_table",
            t = "f_table",
            y = {
                { id = "f_indoor_plant_y" },
                { id = "f_indoor_plant" },
            },
            ["="] = "f_sandbag_half",
            ["["] = "f_flagpole",
        },
        item_spawns = {
            ["["] = { id = "american_flag" },
        },
        item_groups = {
            ["&"] = { group = "SUS_toilet", chance = 50 },
        },
        toilets = { "&" },
    },
}

ccb.content.define_mapgen_palette {
    id = "mil_surplus_intact",
    layout = {
        palettes = { "mil_surplus" },
        item_groups = {
            ["@"] = {
                group = {
                    kind = "distribution",
                    entries = {
                        { group = "clothing_military" },
                        { group = "clothing_military_winter" },
                    },
                },
                chance = 70,
            },
            A = {
                repetitions = { 1, 3 },
                group = {
                    kind = "distribution",
                    entries = {
                        { item = "canteen", probability = 3 },
                        { item = "e_tool", probability = 3 },
                        { item = "two_way_radio", probability = 1 },
                        { item = "mess_kit", probability = 3 },
                        { item = "camelbak", probability = 2 },
                        {
                            collection = {
                                { item = "esbit_stove" },
                                {
                                    item = "chem_hexamine",
                                    count = { 1, 3 },
                                },
                            },
                            probability = 2,
                        },
                    },
                },
                chance = 70,
            },
            B = {
                repetitions = { 1, 3 },
                group = {
                    kind = "distribution",
                    entries = {
                        { item = "ballistic_vest_esapi", probability = 15 },
                        { group = "contractor_ballistic_vest_light", probability = 15 },
                        {
                            group = "armor_plates",
                            probability = 70,
                            count = { 2, 6 },
                        },
                    },
                },
                chance = 70,
            },
            C = {
                repetitions = { 1, 3 },
                group = "MRE",
                chance = 90,
            },
            D = {
                repetitions = { 1, 3 },
                group = {
                    kind = "distribution",
                    entries = {
                        { item = "helmet_army", probability = 60 },
                        { item = "tac_helmet", probability = 10 },
                        { item = "helmet_liner", probability = 10 },
                        { item = "glasses_bal", probability = 10 },
                        { item = "mask_gas", probability = 10 },
                    },
                },
                chance = 70,
            },
            E = { group = "SUS_field_manual_bookcase", chance = 60 },
            F = {
                repetitions = { 1, 3 },
                group = {
                    kind = "distribution",
                    entries = {
                        { item = "hat_boonie", probability = 1 },
                        { item = "webbing_belt", probability = 1 },
                        { item = "pants_army", probability = 1 },
                        { item = "jacket_army", probability = 1 },
                        { item = "winter_pants_army", probability = 1 },
                        { item = "winter_jacket_army", probability = 1 },
                        { item = "knee_pads", probability = 1 },
                        { item = "elbow_pads", probability = 1 },
                        { item = "legpouch_large", probability = 1 },
                        { item = "gloves_tactical", probability = 1 },
                        { item = "molle_pack", probability = 1 },
                        { item = "military_poncho", probability = 1 },
                        { item = "military_poncho_heavy", probability = 1 },
                        { item = "military_poncho_liner", probability = 1 },
                    },
                },
                chance = 60,
            },
            L = { group = "SUS_janitors_closet", chance = 60 },
            t = {
                { group = "antique_guns", chance = 10 },
                { group = "knife_shop", chance = 20 },
            },
            l = {
                { group = "jackets", chance = 30 },
                { group = "softdrugs", chance = 30 },
                { group = "bags", chance = 30 },
                { group = "winter", chance = 30 },
            },
            U = { group = "SUS_trash_dumpster" },
        },
        nested_glyphs = {
            T = { id = "indoor_tent_3x3_N" },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "mil_surplus_looted",
    layout = {
        palettes = { "mil_surplus" },
        terrain = {
            ["'"] = {
                { id = "t_window_frame", copies = 70 },
                { id = "t_window_empty", copies = 20 },
                { id = "t_window", copies = 5 },
            },
            ["+"] = {
                { id = "t_door_b", copies = 20 },
                { id = "t_door_frame", copies = 10 },
                { id = "t_door_o", copies = 70 },
                { id = "t_door_c", copies = 5 },
            },
            ["!"] = {
                { id = "t_door_b", copies = 20 },
                { id = "t_door_frame", copies = 10 },
                { id = "t_door_o", copies = 70 },
                { id = "t_door_c", copies = 5 },
                { id = "t_door_locked_interior", copies = 3 },
            },
        },
        furniture = {
            Q = {
                { id = "f_camp_chair", copies = 5 },
                { id = "f_null", copies = 95 },
            },
            r = {
                { id = "f_tourist_table", copies = 5 },
                { id = "f_null", copies = 95 },
            },
            b = {
                { id = "f_brazier", copies = 5 },
                { id = "f_null", copies = 95 },
            },
        },
        item_groups = {
            ["@"] = {
                group = {
                    kind = "distribution",
                    entries = {
                        { group = "clothing_military" },
                        { group = "clothing_military_winter" },
                    },
                },
                chance = 2,
            },
            ["А"] = {
                repetitions = { 1, 3 },
                group = {
                    kind = "distribution",
                    entries = {
                        { item = "canteen", probability = 3 },
                        { item = "e_tool", probability = 3 },
                        { item = "two_way_radio", probability = 1 },
                        { item = "mess_kit", probability = 3 },
                        { item = "camelbak", probability = 2 },
                        {
                            collection = {
                                { item = "esbit_stove" },
                                {
                                    item = "chem_hexamine",
                                    count = { 1, 3 },
                                },
                            },
                            probability = 2,
                        },
                    },
                },
                chance = 2,
            },
            ["Б"] = {
                repetitions = { 1, 3 },
                group = {
                    kind = "distribution",
                    entries = {
                        { item = "ballistic_vest_esapi", probability = 15 },
                        { item = "ballistic_vest_light", probability = 15 },
                        { item = "soft_3a_vest", variant = "security_armor_vest", probability = 10 },
                        {
                            group = "armor_plates",
                            probability = 70,
                            count = { 2, 6 },
                        },
                    },
                },
                chance = 2,
            },
            ["В"] = {
                repetitions = { 1, 3 },
                group = "MRE",
                chance = 2,
            },
            ["Г"] = {
                repetitions = { 1, 3 },
                group = {
                    kind = "distribution",
                    entries = {
                        { item = "helmet_army", probability = 60 },
                        { item = "tac_helmet", probability = 10 },
                        { item = "helmet_liner", probability = 10 },
                        { item = "glasses_bal", probability = 10 },
                        { item = "mask_gas", probability = 10 },
                    },
                },
                chance = 2,
            },
            ["Д"] = { group = "SUS_field_manual_bookcase", chance = 2 },
            F = {
                repetitions = { 1, 3 },
                group = {
                    kind = "distribution",
                    entries = {
                        { item = "hat_boonie", probability = 1 },
                        { group = "loaded_webbing_belt", probability = 1 },
                        { item = "pants_army", probability = 1 },
                        { item = "jacket_army", probability = 1 },
                        { item = "winter_pants_army", probability = 1 },
                        { item = "winter_jacket_army", probability = 1 },
                        { item = "knee_pads", probability = 1 },
                        { item = "elbow_pads", probability = 1 },
                        { item = "legpouch_large", probability = 1 },
                        { item = "gloves_tactical", probability = 1 },
                        { group = "molle_backpacks_and_accessories", probability = 1 },
                        { group = "loaded_lbv", probability = 1 },
                        { item = "military_poncho", probability = 1 },
                        { item = "military_poncho_heavy", probability = 1 },
                        { item = "military_poncho_liner", probability = 1 },
                    },
                },
                chance = 2,
            },
            L = { group = "SUS_janitors_closet", chance = 50 },
            [" "] = { group = "SUS_trash_floor_light", chance = 5 },
        },
        nested_glyphs = {
            ["|"] = {
                choices = {
                    { id = "bile_field", weight = 10 },
                    { id = "shelter_graffiti", weight = 5 },
                    { id = "general_graffiti", weight = 20 },
                    { id = "null", weight = 75 },
                },
            },
            ["А"] = {
                choices = {
                    { id = "destroyed_furniture", weight = 20 },
                    { id = "null", weight = 80 },
                },
            },
            ["Б"] = {
                choices = {
                    { id = "destroyed_furniture", weight = 20 },
                    { id = "null", weight = 80 },
                },
            },
            ["В"] = {
                choices = {
                    { id = "destroyed_furniture", weight = 20 },
                    { id = "null", weight = 80 },
                },
            },
            ["Г"] = {
                choices = {
                    { id = "destroyed_furniture", weight = 20 },
                    { id = "null", weight = 80 },
                },
            },
            ["Д"] = {
                choices = {
                    { id = "destroyed_furniture", weight = 20 },
                    { id = "null", weight = 80 },
                },
            },
            ["Е"] = {
                choices = {
                    { id = "destroyed_furniture", weight = 20 },
                    { id = "null", weight = 80 },
                },
            },
            ["@"] = {
                choices = {
                    { id = "destroyed_furniture", weight = 80 },
                    { id = "null", weight = 20 },
                },
            },
            T = {
                choices = {
                    { id = "deployed_small_tent", weight = 20 },
                    { id = "destroyed_small_tent", weight = 20 },
                    { id = "null", weight = 60 },
                },
            },
            S = {
                choices = {
                    { id = "destroyed_furniture", weight = 80 },
                    { id = "null", weight = 20 },
                },
            },
            t = {
                choices = {
                    { id = "destroyed_furniture", weight = 80 },
                    { id = "null", weight = 20 },
                },
            },
            ["1"] = {
                choices = {
                    { id = "corpse_blood_casings_3x3", weight = 50 },
                    { id = "null", weight = 50 },
                },
            },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "mil_surplus_boarded",
    layout = {
        palettes = { "mil_surplus" },
        terrain = { ["'"] = "t_window_boarded", ["!"] = "t_door_boarded" },
        furniture = {
            Q = {
                { id = "f_camp_chair", copies = 5 },
                { id = "f_null", copies = 95 },
            },
            r = {
                { id = "f_tourist_table", copies = 5 },
                { id = "f_null", copies = 95 },
            },
            b = {
                { id = "f_brazier", copies = 5 },
                { id = "f_null", copies = 95 },
            },
        },
        item_groups = {
            ["@"] = {
                group = {
                    kind = "distribution",
                    entries = {
                        { group = "clothing_military" },
                        { group = "clothing_military_winter" },
                    },
                },
                chance = 2,
            },
            ["А"] = {
                repetitions = { 1, 3 },
                group = {
                    kind = "distribution",
                    entries = {
                        { item = "canteen", probability = 3 },
                        { item = "e_tool", probability = 3 },
                        { item = "two_way_radio", probability = 1 },
                        { item = "mess_kit", probability = 3 },
                        { item = "camelbak", probability = 2 },
                        {
                            collection = {
                                { item = "esbit_stove" },
                                {
                                    item = "chem_hexamine",
                                    count = { 1, 3 },
                                },
                            },
                            probability = 2,
                        },
                    },
                },
                chance = 2,
            },
            ["Б"] = {
                repetitions = { 1, 3 },
                group = {
                    kind = "distribution",
                    entries = {
                        { item = "ballistic_vest_esapi", probability = 15 },
                        { item = "ballistic_vest_light", probability = 15 },
                        { item = "soft_3a_vest", variant = "security_armor_vest", probability = 10 },
                        {
                            group = "armor_plates",
                            probability = 70,
                            count = { 2, 6 },
                        },
                    },
                },
                chance = 2,
            },
            ["В"] = {
                repetitions = { 1, 3 },
                group = "MRE",
                chance = 2,
            },
            ["Г"] = {
                repetitions = { 1, 3 },
                group = {
                    kind = "distribution",
                    entries = {
                        { item = "helmet_army", probability = 60 },
                        { item = "tac_helmet", probability = 10 },
                        { item = "helmet_liner", probability = 10 },
                        { item = "glasses_bal", probability = 10 },
                        { item = "mask_gas", probability = 10 },
                    },
                },
                chance = 2,
            },
            ["Д"] = { group = "SUS_field_manual_bookcase", chance = 2 },
            F = {
                repetitions = { 1, 3 },
                group = {
                    kind = "distribution",
                    entries = {
                        { item = "hat_boonie", probability = 1 },
                        { item = "webbing_belt", probability = 1 },
                        { item = "pants_army", probability = 1 },
                        { item = "jacket_army", probability = 1 },
                        { item = "winter_pants_army", probability = 1 },
                        { item = "winter_jacket_army", probability = 1 },
                        { item = "knee_pads", probability = 1 },
                        { item = "elbow_pads", probability = 1 },
                        { item = "legpouch_large", probability = 1 },
                        { item = "gloves_tactical", probability = 1 },
                        { item = "molle_pack", probability = 1 },
                        { item = "military_poncho", probability = 1 },
                        { item = "military_poncho_heavy", probability = 1 },
                        { item = "military_poncho_liner", probability = 1 },
                    },
                },
                chance = 2,
            },
            L = { group = "SUS_janitors_closet", chance = 50 },
        },
        nested_glyphs = {
            T = {
                choices = {
                    { id = "indoor_tent_3x3_N", weight = 25 },
                    { id = "deployed_small_tent", weight = 25 },
                    { id = "null", weight = 50 },
                },
            },
        },
    },
}
