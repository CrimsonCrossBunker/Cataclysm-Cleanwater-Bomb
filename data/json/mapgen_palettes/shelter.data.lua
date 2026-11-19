local ccb = require("ccb")

-- shelter_infested_scenario wants to be 0 but then it gets skipped when the weighted_list is populated and so isn't recognised as valid when used as a starting parameter
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
                        { id = "shelter_basic", weight = 200 },
                        { id = "shelter_survivor", weight = 100 },
                        { id = "shelter_infested", weight = 100 },
                        { id = "shelter_infested_scenario", weight = 1 },
                        { id = "shelter_vandal", weight = 100 },
                        { id = "shelter_used", weight = 100 },
                    },
                },
            },
        },
        palettes = { { parameter = "shelter_palette", fallback = "shelter_basic" } },
    },
}

ccb.content.define_mapgen_palette {
    id = "shelter_under",
    layout = {
        terrain = {
            ["-"] = "t_soil",
            [";"] = "t_concrete_wall",
            ["."] = "t_linoleum_white",
            ["6"] = "t_linoleum_white",
            b = "t_linoleum_white",
            c = "t_linoleum_white",
            S = "t_linoleum_white",
            ["%"] = "t_linoleum_white",
            t = "t_linoleum_white",
            C = "t_linoleum_white",
            l = "t_linoleum_white",
            U = "t_linoleum_white",
            B = "t_linoleum_white",
            T = "t_linoleum_white",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "shelter_shared",
    layout = {
        toilets = { "T" },
        nested_glyphs = { ["§"] = { id = "fire_extinguisher" } },
        palettes = { "parametrized_walls_palette" },
        terrain = {
            ["."] = "t_floor",
            ["6"] = "t_floor",
            ["§"] = "t_floor",
            b = "t_floor",
            c = "t_floor",
            S = "t_floor",
            ["%"] = "t_floor",
            t = "t_floor",
            C = "t_floor",
            l = "t_floor",
            U = "t_floor",
            B = "t_floor",
            T = "t_floor",
            ["!"] = "t_pavement",
            ["`"] = "t_pavement_y",
            ["&"] = "t_sidewalk",
            _ = "t_linoleum_white",
            [">"] = "t_stairs_down",
            ["<"] = "t_stairs_up",
            ["*"] = "t_ladder_up",
            ["4"] = "t_gutter_downspout",
        },
        furniture = {
            ["6"] = "f_bulletin_evac",
            b = "f_bench",
            c = "f_cupboard",
            S = "f_sink",
            ["%"] = "f_trashcan",
            t = "f_table",
            C = "f_counter",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "shelter_basic",
    layout = {
        toilets = { "T" },
        item_groups = {
            ["%"] = {
                { group = "shelter_supplies", chance = 15, repetitions = { 1, 2 } },
                { group = "SUS_trash_trashcan_empty", chance = 25 },
            },
            B = { group = "SUS_evac_shelter_bathroom_supplies", chance = 70 },
            C = { group = "SUS_evac_shelter_bathroom_counter", chance = 40 },
            S = { group = "SUS_evac_shelter_sink", chance = 70 },
            T = { group = "SUS_toilet", chance = 50 },
            U = { group = "SUS_evac_shelter_supply_closet", chance = 70 },
            _ = { group = "shelter_supplies", chance = 1 },
            c = { group = "SUS_evac_shelter_cabinet", chance = 60 },
            l = { group = "SUS_evac_shelter_locker", chance = 80 },
            t = { group = "SUS_evac_shelter_table", chance = 70 },
        },
        palettes = { "shelter_shared" },
        terrain = { ["+"] = "t_door_c", [":"] = "t_window_domestic", ["="] = "t_door_locked_interior" },
        furniture = { l = "f_locker", U = "f_utility_shelf", B = "f_utility_shelf" },
    },
}

ccb.content.define_mapgen_palette {
    id = "shelter_used",
    layout = {
        toilets = { "T" },
        nested_glyphs = {
            ["|"] = { choices = { { id = "shelter_graffiti", weight = 10 }, { id = "null", weight = 90 } } },
            ["#"] = { choices = { { id = "shelter_graffiti", weight = 10 }, { id = "null", weight = 90 } } },
            [";"] = { choices = { { id = "shelter_graffiti", weight = 10 }, { id = "null", weight = 90 } } },
            ["."] = { choices = { { id = "1x1_group_zombie", weight = 1 }, { id = "null", weight = 25 } } },
            _ = { choices = { { id = "1x1_group_zombie", weight = 1 }, { id = "null", weight = 25 } } },
            b = { choices = { { id = "1x1_group_zombie", weight = 1 }, { id = "null", weight = 25 } } },
        },
        item_groups = {
            ["%"] = {
                { group = "shelter_supplies", chance = 30, repetitions = { 1, 2 } },
                { group = "SUS_trash_trashcan", chance = 50 },
            },
            ["."] = {
                { group = "shelter_supplies", chance = 2 },
                { group = "SUS_trash_floor", chance = 2 },
                { group = "SUS_trash_forest_manmade", chance = 1 },
            },
            B = { group = "SUS_evac_shelter_bathroom_supplies_used", chance = 70 },
            C = { group = "SUS_evac_shelter_bathroom_counter_used", chance = 40 },
            S = { group = "SUS_evac_shelter_sink_used", chance = 70 },
            T = { group = "SUS_toilet", chance = 25 },
            U = { group = "SUS_evac_shelter_supply_closet_used", chance = 70 },
            _ = {
                { group = "shelter_supplies", chance = 2 },
                { group = "SUS_trash_floor", chance = 2 },
            },
            b = {
                { group = "shelter_supplies", chance = 2 },
                { group = "SUS_trash_floor", chance = 2 },
            },
            c = { group = "SUS_evac_shelter_cabinet_used", chance = 50 },
            l = { group = "SUS_evac_shelter_locker_used", chance = 70 },
            t = { group = "SUS_evac_shelter_table_used", chance = 70 },
        },
        palettes = { "shelter_shared" },
        terrain = {
            ["+"] = { { id = "t_door_c" }, { id = "t_door_b" } },
            [":"] = { { id = "t_window_frame" }, { id = "t_window_no_curtains" }, { id = "t_window" } },
            ["="] = {
                { id = "t_door_b" },
                { id = "t_door_locked_interior" },
                { id = "t_door_c" },
                { id = "t_door_o" },
            },
        },
        furniture = { l = "f_locker", U = "f_utility_shelf", B = "f_utility_shelf" },
    },
}

ccb.content.define_mapgen_palette {
    id = "shelter_vandal",
    layout = {
        toilets = { "T" },
        nested_glyphs = {
            ["|"] = {
                choices = {
                    { id = "shelter_graffiti", weight = 5 },
                    { id = "general_graffiti", weight = 20 },
                    { id = "null", weight = 75 },
                },
            },
            ["#"] = {
                choices = {
                    { id = "shelter_graffiti", weight = 5 },
                    { id = "general_graffiti", weight = 20 },
                    { id = "null", weight = 75 },
                },
            },
            [";"] = {
                choices = {
                    { id = "shelter_graffiti", weight = 5 },
                    { id = "general_graffiti", weight = 20 },
                    { id = "null", weight = 75 },
                },
            },
        },
        item_groups = {
            ["%"] = { { group = "SUS_trash_trashcan", chance = 20 } },
            ["."] = {
                { group = "SUS_trash_floor", chance = 1 },
                { group = "SUS_trash_forest_manmade", chance = 1 },
            },
            B = {
                { group = "softdrugs", chance = 2 },
                { group = "shelter_supplies", chance = 10 },
                { group = "SUS_trash_floor", chance = 1 },
            },
            C = {
                { group = "softdrugs", chance = 2 },
                { group = "shelter_supplies", chance = 10 },
                { group = "SUS_trash_floor", chance = 1 },
            },
            S = {
                { group = "softdrugs", chance = 2 },
                { group = "shelter_supplies", chance = 10 },
                { group = "SUS_trash_floor", chance = 1 },
            },
            T = { group = "SUS_toilet", chance = 5 },
            U = {
                { group = "softdrugs", chance = 2 },
                { group = "shelter_supplies", chance = 10 },
                { group = "SUS_trash_floor", chance = 1 },
            },
            _ = { { group = "SUS_trash_floor", chance = 1 } },
            b = {
                { group = "softdrugs", chance = 2 },
                { group = "shelter_supplies", chance = 1 },
                { group = "SUS_trash_floor", chance = 1 },
            },
            c = {
                { group = "SUS_trash_floor", chance = 1 },
                { group = "softdrugs", chance = 2 },
                { group = "shelter_supplies", chance = 10 },
            },
            l = { group = "shelter_supplies", chance = 40 },
            t = {
                { group = "softdrugs", chance = 2 },
                { group = "shelter_supplies", chance = 10 },
                { group = "SUS_trash_floor", chance = 1 },
            },
        },
        palettes = { "shelter_shared" },
        terrain = {
            ["+"] = { { id = "t_door_c" }, { id = "t_door_b" } },
            [":"] = { { id = "t_window_frame" }, { id = "t_window_no_curtains" }, { id = "t_window" } },
            ["="] = {
                { id = "t_door_b" },
                { id = "t_door_locked_interior" },
                { id = "t_door_c" },
                { id = "t_door_o" },
            },
        },
        furniture = {
            l = { { id = "f_locker" }, { id = "f_wreckage" } },
            U = { { id = "f_utility_shelf" }, { id = "f_wreckage" } },
            B = { { id = "f_utility_shelf" }, { id = "f_wreckage" } },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "shelter_survivor",
    layout = {
        toilets = { "T" },
        item_groups = {
            ["%"] = {
                { group = "shelter_supplies", chance = 30, repetitions = { 1, 2 } },
                { group = "SUS_trash_trashcan", chance = 50 },
            },
            ["."] = {
                { group = "shelter_supplies", chance = 2 },
                { group = "SUS_trash_floor", chance = 2 },
                { group = "SUS_trash_forest_manmade", chance = 1 },
            },
            B = { group = "SUS_evac_shelter_bathroom_supplies_used", chance = 50 },
            C = { group = "SUS_evac_shelter_bathroom_counter_used", chance = 20 },
            S = { group = "SUS_evac_shelter_sink_used", chance = 50 },
            T = { group = "SUS_toilet", chance = 50 },
            U = { group = "SUS_evac_shelter_supply_closet_used", chance = 50 },
            _ = {
                { group = "shelter_supplies", chance = 2 },
                { group = "SUS_trash_floor", chance = 2 },
            },
            b = {
                { group = "shelter_supplies", chance = 2 },
                { group = "SUS_trash_floor", chance = 2 },
            },
            c = { group = "SUS_evac_shelter_cabinet_used", chance = 30 },
            l = { group = "SUS_evac_shelter_locker_used", chance = 50 },
            t = { group = "SUS_evac_shelter_table_used", chance = 50 },
        },
        npc_glyphs = { ["@"] = { id = "NPC_evac_shelter_survivor" } },
        palettes = { "shelter_shared" },
        terrain = { ["+"] = "t_door_c", [":"] = "t_window_boarded", ["="] = "t_door_locked_interior" },
        furniture = { l = "f_locker", U = "f_utility_shelf", B = "f_utility_shelf" },
    },
}

-- Adds back basement zeds
ccb.content.define_mapgen_palette {
    id = "shelter_infested",
    layout = {
        nested_glyphs = {
            ["."] = {
                levels = { -1 },
                choices = { { id = "1x1_group_infested", weight = 1 }, { id = "null", weight = 12 } },
            },
            _ = {
                levels = { -1 },
                choices = { { id = "1x1_group_infested", weight = 1 }, { id = "null", weight = 12 } },
            },
            b = {
                levels = { -1 },
                choices = { { id = "1x1_group_infested", weight = 1 }, { id = "null", weight = 12 } },
            },
        },
        palettes = { "shelter_infested_scenario" },
    },
}

-- Don't spawn zeds in the basement for the challenge scenario where you start in the basement
ccb.content.define_mapgen_palette {
    id = "shelter_infested_scenario",
    layout = {
        toilets = { "T" },
        nested_glyphs = {
            ["."] = {
                levels = { -1 },
                otherwise = { { id = "1x1_group_infested", weight = 1 }, { id = "null", weight = 8 } },
            },
            _ = {
                levels = { -1 },
                otherwise = { { id = "1x1_group_infested", weight = 1 }, { id = "null", weight = 8 } },
            },
            b = {
                levels = { -1 },
                otherwise = { { id = "1x1_group_infested", weight = 1 }, { id = "null", weight = 8 } },
            },
        },
        item_groups = {
            ["%"] = {
                { group = "shelter_supplies", chance = 30, repetitions = { 1, 2 } },
                { group = "SUS_trash_trashcan" },
            },
            B = { group = "SUS_evac_shelter_bathroom_supplies", chance = 70 },
            C = { group = "SUS_evac_shelter_bathroom_counter", chance = 40 },
            S = { group = "SUS_evac_shelter_sink", chance = 70 },
            U = { group = "SUS_evac_shelter_supply_closet", chance = 70 },
            _ = { group = "shelter_supplies", chance = 1 },
            c = { group = "SUS_evac_shelter_cabinet", chance = 60 },
            l = { group = "SUS_evac_shelter_locker", chance = 80 },
            t = { group = "SUS_evac_shelter_table", chance = 70 },
        },
        palettes = { "shelter_shared" },
        terrain = {
            ["+"] = "t_door_c",
            [":"] = { { id = "t_window_domestic" }, { id = "t_window_boarded" } },
            ["="] = "t_door_locked_interior",
        },
        furniture = { l = "f_locker", U = "f_utility_shelf", B = "f_utility_shelf" },
    },
}

ccb.content.define_mapgen_palette {
    id = "shelter_unfinished",
    layout = {
        item_groups = {
            X = {
                { group = "hardware_bulk", chance = 40, repetitions = { 1, 3 } },
                { group = "plumbing_bulk", chance = 30, repetitions = { 1, 2 } },
            },
            c = {
                { group = "clothing_work_hat", chance = 15 },
                { group = "clothing_work_gloves", chance = 12 },
                { group = "magazines", chance = 2 },
                { group = "misc_smoking", chance = 5 },
            },
            t = {
                { group = "power_tools", chance = 5 },
                { group = "tools_construction", chance = 12 },
                { group = "tools_carpentry", chance = 5 },
                { group = "tools_earthworking", chance = 2 },
                { group = "hardware_plumbing", chance = 2 },
            },
        },
        parameters = {
            shelter_unfinished_layout = {
                value_type = "nested_mapgen",
                default = {
                    weighted = {
                        "24x24_shelter_unfinished",
                        "24x24_shelter_unfinished_1",
                        "24x24_shelter_unfinished_2",
                    },
                },
            },
        },
        terrain = {
            ["."] = "t_concrete",
            S = "t_concrete",
            C = "t_concrete",
            T = "t_concrete",
            ["+"] = "t_door_frame",
            ["|"] = "t_wall_half",
            _ = "t_linoleum_white",
            [":"] = "t_window_empty_no_roof",
            [">"] = "t_stairs_down_no_roof",
            ["<"] = "t_stairs_up",
            ["*"] = "t_ladder_up",
            ["4"] = "t_gutter_downspout",
            [","] = "t_region_soil",
        },
        furniture = {
            X = { { id = "f_crate_c", copies = 2 }, { id = "f_crate_o" }, { id = "f_cardboard_box" } },
            ["~"] = "f_stack_plank",
            t = "f_tourist_table",
            c = "f_camp_chair",
            S = "f_sink",
            C = "f_counter",
            T = "f_toilet",
        },
    },
}
