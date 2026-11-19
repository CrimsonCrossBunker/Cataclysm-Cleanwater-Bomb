local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "recycling_plant",
    layout = {
        toilets = { "5" },
        nested_glyphs = {
            ["Ò"] = {
                choices = { { id = "8x8_machine1", weight = 1 }, { id = "8x8_machine2", weight = 1 } },
            },
            ["Ó"] = {
                choices = { { id = "shipping_container_north", weight = 80 }, { id = "null", weight = 20 } },
            },
        },
        vehicle_glyphs = {
            ["Ú"] = { chance = 80, id = "forklift_diesel", rotation = 90 },
            ["Ù"] = { chance = 80, id = "forklift", rotation = 270 },
        },
        item_groups = {
            ["9"] = { group = "SUS_junk_drawer_messy" },
            H = { group = "SUS_junk_drawer_messy", chance = 80 },
        },
        sign_glyphs = {
            ["ó"] = { text = ccb.content.text("Repolymerization.") },
            ["ò"] = { text = ccb.content.text("Refuse.") },
            ["ö"] = { text = ccb.content.text("Ready for processing.") },
        },
        glyph_mappings = {
            _ = { terrain = "t_sidewalk" },
            ["-"] = { terrain = "t_thconc_y" },
            [";"] = { terrain = { parameter = "carpet_color_type", fallback = "t_carpet_red" } },
            [":"] = { terrain = "t_grate" },
            ["."] = { terrain = "t_railroad_rubble" },
            ["'"] = { terrain = "t_concrete" },
            ["["] = { terrain = "t_wall_glass" },
            ["*"] = { terrain = "t_railroad_track" },
            ["/"] = { terrain = "t_door_metal_locked" },
            ["#"] = { terrain = "t_concrete_wall" },
            ["+"] = { terrain = "t_door_c" },
            ["<"] = { terrain = "t_stairs_up" },
            ["="] = { terrain = "t_door_metal_locked" },
            [">"] = { terrain = "t_stairs_down" },
            ["0"] = { terrain = "t_open_air" },
            ["1"] = { terrain = "t_concrete_ramp_down_high" },
            ["2"] = { terrain = "t_concrete_ramp_down_low" },
            ["3"] = { terrain = "t_concrete_ramp_up_high" },
            ["4"] = { terrain = "t_concrete_ramp_up_low" },
            ["5"] = { item_groups = { { group = "SUS_toilet", chance = 50 } }, terrain = "t_concrete" },
            ["6"] = {
                furniture = {
                    { id = "f_degraded_nurdle_pile_tall" },
                    { id = "f_degraded_nurdle_pile" },
                    { id = "f_degraded_nurdle_pile_short" },
                },
            },
            ["7"] = {
                furniture = {
                    { id = "f_contaminated_dirt_pile_tall" },
                    { id = "f_contaminated_dirt_pile" },
                    { id = "f_contaminated_dirt_pile_short" },
                },
            },
            ["8"] = {
                furniture = {
                    { id = "f_nurdle_pile_tall" },
                    { id = "f_nurdle_pile" },
                    { id = "f_nurdle_pile_short" },
                },
            },
            A = { terrain = "t_wall_metal_shipping_container" },
            B = { terrain = "t_metal_floor" },
            C = { terrain = "t_elevator_control_no_roof" },
            c = {
                terrain = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
                furniture = { { id = "f_bench" } },
            },
            D = { terrain = "t_support_l" },
            d = {
                item_groups = { { group = "locker_gym", chance = 50, repetitions = 3 } },
                terrain = { { id = "t_concrete" } },
                furniture = { { id = "f_locker" } },
            },
            e = { terrain = { { id = "t_concrete" } }, furniture = { { id = "f_sink" } } },
            F = { terrain = "t_gate_metal_o" },
            f = {
                item_groups = { { group = "SUS_office_desk", chance = 40 } },
                terrain = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
                furniture = { { id = "f_counter" } },
            },
            G = { terrain = "t_elevator_no_roof" },
            g = {
                terrain = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
                furniture = { { id = "f_counter_gate_c" } },
            },
            H = { terrain = "t_water_pool_shallow" },
            h = {
                terrain = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
                furniture = { { id = "f_armchair" } },
            },
            i = { terrain = { { id = "t_metal_railing" } } },
            j = { terrain = { { id = "t_concrete" } }, furniture = { { id = "f_oven" } } },
            k = {
                terrain = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
                furniture = { { id = "f_coffee_table" } },
            },
            l = { terrain = { { id = "t_concrete" } }, furniture = { { id = "f_table" } } },
            m = {
                item_groups = { { group = "dining", chance = 40, repetitions = { 1, 2 } } },
                terrain = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
                furniture = { { id = "f_table" } },
            },
            n = {
                item_groups = { { group = "SUS_office_filing_cabinet", chance = 90 } },
                terrain = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
                furniture = { { id = "f_filing_cabinet" } },
            },
            o = {
                terrain = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
                furniture = { { id = "f_sofa" } },
            },
            q = { terrain = { { id = "t_concrete" } }, furniture = { { id = "f_bench" } } },
            r = {
                item_groups = { { group = "dining", chance = 40, repetitions = { 1, 2 } } },
                terrain = { { id = "t_concrete" } },
                furniture = { { id = "f_table" } },
            },
            s = { terrain = { { id = "t_concrete" } }, furniture = { { id = "f_counter" } } },
            T = { terrain = "t_chainfence" },
            t = {
                item_groups = { { group = "SUS_office_desk", chance = 40 } },
                terrain = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
                furniture = { { id = "f_desk" } },
            },
            u = {
                item_groups = { { group = "locker_gym", chance = 50, repetitions = 3 } },
                terrain = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
                furniture = { { id = "f_locker" } },
            },
            v = {
                item_groups = { { group = "SUS_fridge_breakroom", chance = 70 } },
                terrain = { { id = "t_concrete" } },
                furniture = { { id = "f_fridge" } },
            },
            w = {
                item_groups = { { group = "SUS_fridge_breakroom", chance = 70 } },
                terrain = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
                furniture = { { id = "f_fridge" } },
            },
            x = {
                item_groups = { { group = "SUS_oven", chance = 90 } },
                terrain = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
                furniture = { { id = "f_oven" } },
            },
            y = {
                terrain = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
                furniture = { { id = "f_sink" } },
            },
        },
        parameters = {
            carpet_color_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_carpet_red", weight = 1 },
                        { id = "t_carpet_green", weight = 1 },
                        { id = "t_carpet_purple", weight = 1 },
                        { id = "t_carpet_yellow", weight = 1 },
                    },
                },
            },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "machines",
    layout = {
        terrain = { ["3"] = "t_thconc_y" },
        furniture = { ["0"] = "f_barstool", ["1"] = "f_machinery_heavy", ["2"] = "f_machinery_heavy" },
    },
}
