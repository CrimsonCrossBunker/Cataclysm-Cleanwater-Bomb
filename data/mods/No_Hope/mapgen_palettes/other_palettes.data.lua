local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "bike_shop",
    layout = {
        toilets = { "T" },
        vending_glyphs = {
            D = { group = "vending_drink", lootable = true },
            F = { group = "vending_food", lootable = true },
        },
        palettes = { "parametrized_walls_palette" },
        terrain = {
            [" "] = "t_region_groundcover_urban",
            ["*"] = "t_region_tree_shade",
            _ = "t_concrete",
            ["@"] = "t_concrete",
            ["."] = "t_thconc_floor",
            [":"] = "t_door_glass_c",
            ["+"] = "t_door_c",
            [";"] = "t_door_locked",
            ["-"] = "t_wall_glass",
            ["<"] = "t_ladder_up",
            ["4"] = "t_gutter_downspout",
        },
        furniture = {
            c = "f_counter",
            S = "f_sink",
            h = "f_chair",
            d = "f_desk",
            f = "f_fridge",
            l = "f_locker",
            r = "f_rack",
            t = "f_table",
            q = "f_stool",
            B = "f_bench",
            ["%"] = "f_counter",
            ["&"] = "f_trashcan",
            ["@"] = "f_dumpster",
            ["^"] = "f_indoor_plant",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "office_doctor",
    layout = {
        terrain = {
            ["+"] = {
                { id = "t_door_b", copies = 20 },
                { id = "t_door_frame", copies = 10 },
                { id = "t_door_o", copies = 70 },
                { id = "t_door_c", copies = 5 },
                { id = "t_door_locked_interior", copies = 3 },
            },
            ["9"] = {
                { id = "t_window_frame", copies = 70 },
                { id = "t_window_empty", copies = 20 },
                { id = "t_window_domestic", copies = 5 },
                { id = "t_window_no_curtains" },
                { id = "t_window_open" },
                { id = "t_window_no_curtains_open" },
                { id = "t_curtains", copies = 5 },
            },
            w = {
                { id = "t_window_frame", copies = 70 },
                { id = "t_window_empty", copies = 20 },
                { id = "t_window", copies = 5 },
            },
        },
    },
    extend = true,
}

-- shelter_basic and shelter_infested_scenario want to be 0 weight but then they gets skipped when the weighted_list is populated and so isn't recognised as valid when used as a starting parameter
ccb.content.define_mapgen_palette {
    id = "shelter",
    layout = {
        parameters = {
            shelter_layout = {
                value_type = "nested_mapgen",
                default = { weighted = { "24x24_shelter", "24x24_shelter_1", "24x24_shelter_2" } },
            },
            shelter_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        { id = "shelter_basic", weight = 1 },
                        { id = "shelter_survivor", weight = 100 },
                        { id = "shelter_infested", weight = 300 },
                        { id = "shelter_infested_scenario", weight = 1 },
                        { id = "shelter_vandal", weight = 300 },
                        { id = "shelter_used", weight = 100 },
                    },
                },
            },
        },
        palettes = { { parameter = "shelter_palette", fallback = "shelter_used" } },
    },
}

ccb.content.define_mapgen_palette {
    id = "empty_bunker_items",
    layout = {
        item_groups = {
            B = { group = "bed", chance = 70, repetitions = { 1, 2 } },
            C = {
                { group = "dining", chance = 30, repetitions = { 1, 3 } },
                { group = "SUS_oven", chance = 20 },
            },
            D = { group = "SUS_office_desk", chance = 70 },
            L = { group = "dining", chance = 30 },
            R = { group = "hardware", chance = 10 },
            S = { group = "SUS_oven", chance = 80 },
            T = { group = "tools_common", chance = 10, repetitions = { 1, 2 } },
            U = { group = "gear_survival", chance = 10, repetitions = { 3, 5 } },
            V = { group = "bags", chance = 10 },
            Y = {
                { group = "jackets", chance = 15 },
                { group = "hatstore_hats", chance = 15 },
                { group = "winter", chance = 10 },
            },
            ["^"] = { group = "shelter", chance = 10 },
            b = { { group = "manuals", chance = 10 }, { group = "textbooks", chance = 10 } },
            c = { group = "hardware", chance = 10 },
            d = { group = "allclothes", chance = 20, repetitions = { 2, 4 } },
            l = { group = "hardware", chance = 10, repetitions = { 1, 2 } },
            r = { group = "stash_wood", chance = 85 },
            u = {
                { group = "cannedfood", chance = 10, repetitions = { 1, 5 } },
                { group = "pasta_ingredients", chance = 10, repetitions = { 1, 3 } },
            },
            v = { group = "softdrugs", chance = 10 },
            w = { group = "allclothes", chance = 20, repetitions = { 2, 4 } },
            ["{"] = {
                { group = "lmoe_guns", chance = 5 },
                { group = "ammo_common_boxed", chance = 5, repetitions = { 3, 7 } },
            },
            ["}"] = { group = "novels", chance = 90, repetitions = { 3, 8 } },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "full_bunker_items",
    layout = {
        item_groups = {
            B = { group = "bed", chance = 70, repetitions = { 1, 2 } },
            C = {
                { group = "dining", chance = 30, repetitions = { 1, 3 } },
                { group = "SUS_oven", chance = 20 },
            },
            D = { group = "SUS_office_desk", chance = 70 },
            L = { group = "dining", chance = 30 },
            R = { group = "hardware", chance = 80 },
            S = { group = "SUS_oven", chance = 80 },
            T = { group = "tools_common", chance = 60, repetitions = { 1, 2 } },
            U = { group = "gear_survival", chance = 20, repetitions = { 3, 5 } },
            V = { group = "bags", chance = 30 },
            Y = {
                { group = "jackets", chance = 15 },
                { group = "hatstore_hats", chance = 15 },
                { group = "winter", chance = 10 },
            },
            ["^"] = { group = "shelter", chance = 30 },
            b = { { group = "manuals", chance = 60 }, { group = "textbooks", chance = 40 } },
            c = { group = "hardware", chance = 50 },
            d = { group = "allclothes", chance = 80, repetitions = { 2, 4 } },
            l = { group = "hardware", chance = 50, repetitions = { 1, 2 } },
            r = { group = "stash_wood", chance = 85 },
            u = {
                { group = "cannedfood", chance = 20, repetitions = { 1, 5 } },
                { group = "pasta_ingredients", chance = 10, repetitions = { 1, 3 } },
            },
            v = { group = "softdrugs", chance = 50 },
            w = { group = "allclothes", chance = 80, repetitions = { 2, 4 } },
            ["{"] = {
                { group = "lmoe_guns", chance = 80 },
                { group = "ammo_common_boxed", chance = 5, repetitions = { 3, 7 } },
            },
            ["}"] = { group = "novels", chance = 90, repetitions = { 3, 8 } },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "clothes_store_palette",
    layout = {
        item_groups = {
            ["$"] = { group = "SUS_office_filing_cabinet", chance = 20 },
            ["&"] = { group = "SUS_mannequin_general", chance = 20 },
            ["("] = { group = "SUS_mannequin_outdoor", chance = 30 },
            B = { group = "bags", chance = 20 },
            D = { group = "SUS_trash_trashcan", chance = 30, repetitions = { 1, 2 } },
            I = { group = "underwear_womens", chance = 20 },
            J = { { group = "shoes_unisex", chance = 20 }, { group = "shoes_womens", chance = 20 } },
            K = { group = "coats_unisex", chance = 30 },
            L = { group = "SUS_janitors_closet", chance = 20 },
            M = {
                { group = "pants_unisex", chance = 20 },
                { group = "pants_womens", chance = 20 },
                { group = "pants_mens", chance = 20 },
            },
            O = {
                { group = "clothing_outdoor_torso", chance = 20 },
                { group = "clothing_outdoor_pants", chance = 20 },
            },
            T = { { group = "gloves_unisex", chance = 25 }, { group = "scarfs_unisex", chance = 30 } },
            U = { group = "underwear_mens", chance = 20 },
            W = { { group = "shirts_unisex", chance = 20 }, { group = "shirts_womens", chance = 10 } },
            d = { group = "SUS_office_desk", chance = 20 },
        },
        terrain = { p = "t_region_groundcover_urban" },
        furniture = {
            ["%"] = "f_console_broken",
            c = "f_counter",
            C = "f_armchair",
            s = "f_stool",
            M = "f_clothing_rail",
            K = "f_clothing_rail",
            J = "f_clothing_rail",
            W = "f_clothing_rail",
            U = "f_clothing_rail",
            T = "f_clothing_rail",
            O = "f_clothing_rail",
            B = "f_clothing_rail",
            I = "f_clothing_rail",
            d = "f_desk",
            ["["] = "f_table",
            h = "f_chair",
            ["$"] = "f_filing_cabinet",
            L = "f_locker",
            l = "f_locker",
            b = "f_bigmirror",
            y = { { id = "f_indoor_plant" }, { id = "f_indoor_plant_y" } },
            p = "f_region_flower",
            D = "f_trashcan",
            ["&"] = "f_mannequin",
            ["("] = "f_mannequin",
            n = "f_bulletin",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "tailor_palette",
    layout = {
        item_groups = {
            ["&"] = { group = "SUS_mannequin_formal_mens", chance = 20 },
            ["@"] = { group = "SUS_mannequin_dresses", chance = 20 },
            L = { group = "SUS_janitors_closet", chance = 25 },
            R = {
                { group = "dresses_womens", chance = 20 },
                { group = "shirts_summer_womens", chance = 20 },
                { group = "pants_summer_womens", chance = 20 },
            },
            ["]"] = { group = "SUS_tailoring_bookcase", chance = 20 },
            d = { group = "SUS_tailoring_tool_drawer", chance = 20 },
            f = {
                { group = "SUS_tailoring_materials", chance = 25 },
                { group = "SUS_tailoring_fasteners", chance = 25 },
            },
        },
        terrain = {
            [";"] = "t_door_locked",
            ["0"] = "t_window_alarm",
            z = "t_region_shrub_decorative",
            p = "t_region_groundcover_urban",
        },
        furniture = {
            ["%"] = "f_console_broken",
            c = "f_counter",
            R = "f_clothing_rail",
            s = "f_stool",
            d = "f_desk",
            ["["] = "f_table",
            b = "f_bigmirror",
            y = { { id = "f_indoor_plant" }, { id = "f_indoor_plant_y" } },
            ["&"] = "f_mannequin",
            ["@"] = "f_mannequin",
            h = "f_chair",
            p = "f_region_flower",
            ["]"] = "f_bookcase",
            f = "f_cupboard",
            L = "f_locker",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "furs_palette",
    layout = {
        item_groups = {
            ["&"] = { group = "SUS_mannequin_fur", chance = 20 },
            J = { group = "SUS_janitors_closet", chance = 20 },
            L = {
                { group = "SUS_fur_tailoring_materials", chance = 20 },
                { group = "SUS_tailoring_fasteners", chance = 20 },
            },
            ["["] = { group = "SUS_tailoring_tool_drawer", chance = 30 },
            c = {
                { group = "fur_hats_unisex", chance = 20 },
                { group = "fur_gloves_unisex", chance = 20 },
                { group = "fur_shoes_unisex", chance = 20 },
            },
            d = { group = "SUS_office_desk", chance = 20 },
        },
        terrain = {
            [";"] = { { id = "t_door_locked" }, { id = "t_door_elocked_alarm" } },
            i = "t_door_locked_interior",
            ["0"] = "t_window_alarm",
            z = "t_region_shrub_decorative",
            p = "t_region_groundcover_urban",
        },
        furniture = {
            ["%"] = "f_console_broken",
            c = "f_displaycase",
            s = "f_stool",
            d = "f_desk",
            ["["] = "f_table",
            b = "f_bigmirror",
            y = { { id = "f_indoor_plant" }, { id = "f_indoor_plant_y" } },
            ["&"] = "f_mannequin",
            h = "f_chair",
            p = "f_region_flower",
            A = "f_statue",
            L = "f_locker",
            J = "f_locker",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "cabin_palette",
    layout = {
        toilets = { "T" },
        liquid_glyphs = { ["0"] = { id = "water_clean", amount = { 10, 900 } } },
        item_groups = {
            ["&"] = { group = "SUS_trash_trashcan", chance = 20 },
            ["1"] = { { group = "SUS_dishes", chance = 20 }, { group = "SUS_silverware", chance = 20 } },
            ["2"] = { group = "SUS_cookware", chance = 20 },
            ["3"] = { { group = "SUS_utensils", chance = 20 }, { group = "SUS_knife_drawer", chance = 20 } },
            ["4"] = {
                { group = "SUS_junk_drawer", chance = 20 },
                { group = "SUS_spice_collection", chance = 20 },
            },
            ["5"] = { group = "SUS_kitchen_sink", chance = 20 },
            A = {
                { group = "homebooks", chance = 20 },
                { group = "magazines", chance = 20 },
                { group = "manuals", chance = 20 },
            },
            B = { group = "bed", chance = 60 },
            D = {
                { group = "SUS_dresser_mens", chance = 20 },
                { group = "SUS_dresser_womens", chance = 20 },
            },
            F = { group = "SUS_fridge_healthy_vegan", chance = 20 },
            L = { { group = "tools_earthworking", chance = 30 }, { group = "tools_home", chance = 30 } },
            O = { group = "livingroom", chance = 20 },
            R = {
                { group = "camping", chance = 20 },
                { group = "gear_survival", chance = 20 },
                { group = "cannedfood", chance = 20 },
            },
            S = { group = "stash_wood", chance = 60, repetitions = { 2, 4 } },
            T = { group = "SUS_toilet", chance = 5 },
            U = { group = "camping", chance = 20 },
            V = { group = "SUS_oven", chance = 20 },
            Y = { group = "coat_rack", chance = 25 },
            a = { group = "livingroom", chance = 20 },
            d = { { group = "livingroom", chance = 40 }, { group = "SUS_office_desk", chance = 40 } },
            h = { group = "shower", chance = 20 },
            s = {
                { group = "SUS_bathroom_sink", chance = 20 },
                { group = "SUS_hair_drawer", chance = 30 },
                { group = "SUS_bathroom_cabinet", chance = 30 },
                { group = "SUS_bathroom_medicine", chance = 20 },
                { group = "harddrugs", chance = 2 },
            },
            t = { group = "dining", chance = 20 },
            u = { { group = "SUS_pantry", chance = 20 }, { group = "cannedfood", chance = 20 } },
        },
        palettes = { "cabin_palette_common" },
        terrain = {
            ["."] = { { id = "t_region_groundcover", copies = 4 }, { id = "t_region_groundcover_forest" } },
            ["~"] = { { id = "t_region_groundcover_barren", copies = 3 }, { id = "t_region_groundcover" } },
            ["*"] = { { id = "t_region_groundcover", copies = 15 }, { id = "t_region_shrub" } },
            ["-"] = "t_fence",
            w = "t_window_domestic",
            W = { { id = "t_window_boarded", copies = 2 }, { id = "t_window" } },
            ["+"] = { { id = "t_door_c", copies = 3 }, { id = "t_door_locked" } },
            ["="] = "t_door_c",
        },
        furniture = {
            B = "f_bed",
            b = "f_bench",
            c = "f_chair",
            D = "f_dresser",
            d = "f_desk",
            l = "f_stool",
            t = "f_table",
            O = "f_sofa",
            Y = "f_rack_coat",
            y = { { id = "f_indoor_plant_y" }, { id = "f_indoor_plant" } },
            ["&"] = "f_trashcan",
        },
    },
}
