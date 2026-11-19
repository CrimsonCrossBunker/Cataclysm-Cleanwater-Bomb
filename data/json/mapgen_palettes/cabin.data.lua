local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "cabin_palette_common",
    layout = {
        terrain = {
            ["#"] = "t_wall_log",
            G = "t_fencegate_c",
            o = "t_column",
            P = "t_water_pump",
            R = "t_floor",
            r = "t_floor",
            S = "t_floor",
            ["%"] = "t_gutter_downspout",
            q = "t_water_sh",
            Q = "t_water_dp",
            H = "t_chickenwire_gate_c",
            I = "t_chickenwire_fence",
        },
        furniture = {
            a = "f_armchair",
            A = "f_bookcase",
            C = "f_counter",
            F = "f_fridge",
            h = "f_bathtub",
            L = "f_locker",
            R = { { id = "f_rack" }, { id = "f_utility_shelf" } },
            S = "f_woodstove",
            s = "f_sink",
            T = "f_toilet",
            U = "f_utility_shelf",
            V = { { id = "f_oven" }, { id = "f_gas_oven_microwave_combo" } },
            u = "f_cupboard",
            z = "f_brazier",
            Z = "f_fireplace",
            ["1"] = "f_cupboard",
            ["2"] = "f_cupboard",
            ["3"] = "f_cupboard",
            ["4"] = "f_cupboard",
            ["5"] = "f_sink",
            ["0"] = "f_standing_tank",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "cabin_palette_abandoned",
    layout = {
        item_groups = {
            [" "] = { group = "SUS_trash_floor", chance = 2 },
            ["."] = { group = "SUS_trash_forest_no_manmade", chance = 1 },
            ["1"] = { group = "SUS_junk_drawer_messy", chance = 20 },
            ["2"] = { group = "SUS_junk_drawer_messy", chance = 20 },
            ["3"] = { group = "SUS_junk_drawer_messy", chance = 20 },
            ["4"] = { group = "SUS_junk_drawer_messy", chance = 20 },
            ["5"] = { group = "SUS_kitchen_sink", chance = 10 },
            C = { group = "SUS_trash_floor", chance = 20 },
        },
        palettes = { "cabin_palette_common" },
        parameters = {
            cabin_window_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_window_boarded", weight = 3 },
                        { id = "t_window_domestic", weight = 1 },
                        { id = "t_window_no_curtains", weight = 2 },
                    },
                },
            },
            table_or_not = {
                value_type = "furniture",
                default = { weighted = { { id = "f_table", weight = 1 }, { id = "f_null", weight = 2 } } },
            },
            sofa_or_not = {
                value_type = "furniture",
                default = { weighted = { { id = "f_sofa", weight = 1 }, { id = "f_null", weight = 4 } } },
            },
            bed_or_not = {
                value_type = "furniture",
                default = { weighted = { { id = "f_bed", weight = 1 }, { id = "f_null", weight = 2 } } },
            },
        },
        terrain = {
            ["."] = {
                { id = "t_region_groundcover", copies = 4 },
                { id = "t_region_groundcover_forest", copies = 3 },
                { id = "t_region_shrub" },
            },
            ["~"] = {
                { id = "t_region_groundcover_barren", copies = 3 },
                { id = "t_region_groundcover", copies = 3 },
                { id = "t_region_shrub" },
            },
            ["*"] = {
                { id = "t_region_shrub" },
                { id = "t_region_groundcover_forest", copies = 2 },
                { id = "t_region_groundcover", copies = 5 },
            },
            ["-"] = { { id = "t_fence", copies = 15 }, { id = "t_region_groundcover" } },
            w = {
                {
                    id = { parameter = "cabin_window_type", fallback = "t_window_boarded" },
                    copies = 6,
                },
                { id = "t_window_frame" },
            },
            W = {
                { id = "t_window_boarded", copies = 3 },
                { id = "t_window" },
                { id = "t_window_frame" },
            },
            ["+"] = {
                { id = "t_door_c", copies = 1 },
                { id = "t_door_locked", copies = 4 },
                { id = "t_door_b", copies = 2 },
                { id = "t_door_elocked", copies = 2 },
            },
            ["="] = {
                { id = "t_door_c", copies = 1 },
                { id = "t_door_o", copies = 1 },
                { id = "t_door_b", copies = 2 },
            },
        },
        furniture = {
            B = { parameter = "bed_or_not", fallback = "f_null" },
            b = { { id = "f_bench", copies = 1 }, { id = "f_null", copies = 5 } },
            c = { { id = "f_chair", copies = 1 }, { id = "f_null", copies = 5 } },
            D = { { id = "f_dresser", copies = 1 }, { id = "f_null", copies = 3 } },
            d = { { id = "f_desk", copies = 1 }, { id = "f_null", copies = 3 } },
            l = { { id = "f_stool", copies = 1 }, { id = "f_null", copies = 5 } },
            t = { parameter = "table_or_not", fallback = "f_null" },
            O = { parameter = "sofa_or_not", fallback = "f_null" },
            y = { { id = "f_indoor_plant_y" }, { id = "f_indoor_plant" } },
            ["&"] = "f_trashcan",
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
            ["1"] = { { group = "SUS_dishes", chance = 50 }, { group = "SUS_silverware", chance = 50 } },
            ["2"] = { group = "SUS_cookware", chance = 100 },
            ["3"] = { { group = "SUS_utensils", chance = 50 }, { group = "SUS_knife_drawer", chance = 50 } },
            ["4"] = {
                { group = "SUS_junk_drawer", chance = 50 },
                { group = "SUS_spice_collection", chance = 50 },
            },
            ["5"] = { group = "SUS_kitchen_sink", chance = 100 },
            A = {
                { group = "homebooks", chance = 60, repetitions = { 1, 3 } },
                { group = "magazines", chance = 60, repetitions = { 1, 8 } },
                { group = "manuals", chance = 30 },
            },
            B = { group = "bed", chance = 60, repetitions = { 1, 3 } },
            D = {
                { group = "SUS_dresser_mens", chance = 50, repetitions = { 1, 4 } },
                { group = "SUS_dresser_womens", chance = 50, repetitions = { 1, 4 } },
            },
            F = { group = "SUS_fridge", chance = 35 },
            L = {
                { group = "tools_earthworking", chance = 30, repetitions = { 1, 4 } },
                { group = "tools_home", chance = 30, repetitions = { 1, 4 } },
            },
            O = { group = "livingroom", chance = 20 },
            R = {
                { group = "camping", chance = 50 },
                { group = "gear_survival", chance = 30 },
                { group = "stash_food", chance = 50 },
            },
            S = { group = "stash_wood", chance = 60, repetitions = { 2, 4 } },
            T = { group = "SUS_toilet", chance = 50 },
            U = { group = "camping", chance = 30, repetitions = { 1, 4 } },
            V = { group = "SUS_oven", chance = 70 },
            Y = { group = "coat_rack", chance = 35, repetitions = { 1, 4 } },
            a = { group = "livingroom", chance = 20 },
            d = { { group = "livingroom", chance = 40 }, { group = "SUS_office_desk", chance = 40 } },
            h = { group = "shower", chance = 20 },
            s = {
                { group = "SUS_bathroom_sink", chance = 60 },
                { group = "SUS_hair_drawer", chance = 30 },
                { group = "SUS_bathroom_cabinet", chance = 60, repetitions = { 1, 4 } },
                { group = "SUS_bathroom_medicine", chance = 20 },
                { group = "harddrugs_residential", chance = 2 },
            },
            t = { group = "dining", chance = 30, repetitions = { 1, 2 } },
            u = {
                { group = "SUS_pantry", chance = 25 },
                { group = "cannedfood", chance = 20, repetitions = { 1, 2 } },
            },
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

ccb.content.define_mapgen_palette {
    id = "cabin_cellar",
    layout = {
        parameters = {
            floor_types = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_dirtfloor", weight = 500 },
                        { id = "t_floor", weight = 100 },
                        { id = "t_concrete", weight = 100 },
                        { id = "t_water_sh_underground", weight = 1 },
                    },
                },
            },
            wall_types = {
                value_type = "terrain",
                default = {
                    weighted = { { id = "t_wall_wood", weight = 10 }, { id = "t_sconc_wall", weight = 1 } },
                },
            },
        },
        terrain = {
            [">"] = "t_wood_stairs_down",
            ["<"] = "t_wood_stairs_up",
            ["#"] = "t_soil",
            ["-"] = { parameter = "wall_types", fallback = "t_wall_wood" },
            ["."] = { parameter = "floor_types", fallback = "t_dirtfloor" },
            N = { parameter = "floor_types", fallback = "t_dirtfloor" },
            R = { parameter = "floor_types", fallback = "t_dirtfloor" },
            c = { parameter = "floor_types", fallback = "t_dirtfloor" },
            t = { parameter = "floor_types", fallback = "t_dirtfloor" },
        },
        furniture = { R = "f_rack_wood", t = "f_table", c = "f_chair" },
    },
}

ccb.content.define_mapgen_palette {
    id = "cabin_palette_reverberation",
    layout = {
        toilets = { "T" },
        item_groups = {
            ["1"] = { { group = "SUS_dishes", chance = 50 }, { group = "SUS_silverware", chance = 50 } },
            ["2"] = { group = "SUS_cookware", chance = 100 },
            ["3"] = { { group = "SUS_utensils", chance = 50 }, { group = "SUS_knife_drawer", chance = 50 } },
            ["4"] = { { group = "SUS_junk_drawer", chance = 50 } },
            ["5"] = { group = "SUS_kitchen_sink", chance = 100 },
            B = { group = "bed", chance = 60 },
            D = {
                { group = "SUS_dresser_mens", chance = 50 },
                { group = "SUS_dresser_womens", chance = 50 },
            },
            L = { { group = "tools_earthworking", chance = 30 }, { group = "tools_home", chance = 30 } },
            S = { group = "stash_wood", chance = 60 },
            T = { group = "SUS_toilet", chance = 50 },
            V = { group = "SUS_oven", chance = 70 },
            Y = { group = "coat_rack", chance = 35, repetitions = { 1, 4 } },
            d = { { group = "SUS_office_desk", chance = 40 } },
            h = { group = "shower", chance = 20 },
            s = {
                { group = "SUS_bathroom_sink", chance = 60 },
                { group = "SUS_hair_drawer", chance = 30 },
                { group = "SUS_bathroom_cabinet", chance = 60, repetitions = { 1, 4 } },
            },
            t = { group = "dining", chance = 30, repetitions = { 1, 2 } },
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
