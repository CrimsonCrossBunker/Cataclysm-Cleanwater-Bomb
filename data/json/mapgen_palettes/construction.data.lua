local ccb = require("ccb")

-- phase 1: 6-8 weeks, phase 2: 6-10 weeks, phase 3: 14-20 weeks, phase 0 usually takes ~4-8 weeks depending on weather. This is based on what I could find on multiple construction company websites, feel free to change if you find a better source for these
-- Construction projects last ~12 months in the northeast according to https://eyeonhousing.org/2023/06/home-building-takes-longer-in-2022/
ccb.content.define_mapgen_palette {
    id = "construction_general_palette",
    layout = {
        parameters = {
            variant_construction_palette = {
                value_type = "palette",
                default = {
                    weighted = {
                        { id = "construction_phase_0_palette", weight = 225 },
                        { id = "construction_phase_1_palette", weight = 194 },
                        { id = "construction_phase_2_palette", weight = 275 },
                        { id = "construction_phase_3_palette", weight = 306 },
                    },
                },
                scope = "overmap_special",
            },
        },
        palettes = { { parameter = "variant_construction_palette" }, "construction_all_variants" },
    },
}

-- Palette shared by all in-construction houses
ccb.content.define_mapgen_palette {
    id = "construction_all_variants",
    layout = {
        nested_glyphs = {
            ["#"] = {
                choices = {
                    { id = "shelter_graffiti", weight = 1 },
                    { id = "general_graffiti", weight = 1 },
                    { id = "null", weight = 298 },
                },
            },
            [","] = {
                choices = {
                    { id = "corpse_blood_1x1", weight = 1 },
                    { id = "blood_field", weight = 2 },
                    { id = "bile_field", weight = 1 },
                    { id = "construction_supplies", weight = 8 },
                    { id = "construction_paint", weight = 4 },
                    { id = "null", weight = 188 },
                },
            },
            ["`"] = {
                choices = {
                    { id = "corpse_blood_1x1", weight = 1 },
                    { id = "blood_field", weight = 2 },
                    { id = "bile_field", weight = 1 },
                    { id = "construction_supplies", weight = 8 },
                    { id = "construction_paint", weight = 4 },
                    { id = "null", weight = 188 },
                },
            },
        },
        terrain = {
            [","] = "t_floor",
            a = "t_thconc_floor",
            ["'"] = "t_concrete",
            ["`"] = "t_thconc_floor",
            X = "t_floor",
            x = "t_thconc_floor",
        },
    },
}

-- intended for in-construction homes that just had interior walls framed
ccb.content.define_mapgen_palette {
    id = "construction_phase_0_palette",
    layout = {
        nested_glyphs = {
            X = {
                choices = {
                    { id = "null", weight = 5 },
                    { id = "construction_crate_open", weight = 5 },
                    { id = "construction_crate_closed", weight = 1 },
                },
            },
            x = {
                choices = {
                    { id = "null", weight = 5 },
                    { id = "construction_crate_open", weight = 5 },
                    { id = "construction_crate_closed", weight = 1 },
                },
            },
        },
        parameters = {
            construction0_exterior_wall_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_brick_wall", weight = 6 },
                        { id = "t_rock_wall", weight = 3 },
                        { id = "t_wall_wood", weight = 3 },
                        { id = "t_concrete_wall", weight = 4 },
                        { id = "t_adobe_brick_wall", weight = 1 },
                    },
                },
            },
            construction0_interior_wall_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_wall_half", weight = 6 },
                        { id = "t_brick_wall_halfway", weight = 2 },
                    },
                },
            },
            construction0_house_concrete_outside_type = {
                value_type = "terrain",
                default = {
                    weighted = { { id = "t_pit_shallow", weight = 2 }, { id = "t_region_soil", weight = 3 } },
                },
            },
        },
        terrain = {
            b = "t_floor",
            c = { parameter = "construction0_house_concrete_outside_type", fallback = "t_region_soil" },
            f = "t_region_soil",
            g = "t_region_soil",
            o = "t_floor",
            p = {
                select = {
                    parameter = "construction0_house_concrete_outside_type",
                    fallback = "t_region_soil",
                },
                cases = { t_pit_shallow = "t_pit_shallow", t_region_soil = "t_region_soil" },
            },
            s = "t_floor",
            t = "t_floor",
            M = "t_floor",
            F = "t_floor",
            O = "t_floor",
            S = "t_floor",
            ["5"] = "t_floor",
            ["6"] = "t_floor",
            ["7"] = "t_floor",
            ["8"] = "t_floor",
            ["9"] = "t_floor",
            ["."] = {
                { id = "t_region_groundcover_urban", copies = 1 },
                { id = "t_region_soil", copies = 10 },
            },
            ["+"] = "t_floor",
            ["*"] = "t_floor",
            ["="] = "t_floor",
            ["&"] = "t_floor",
            ["^"] = "t_region_soil",
            ["#"] = { parameter = "construction0_exterior_wall_type", fallback = "t_brick_wall" },
            ["|"] = { parameter = "construction0_interior_wall_type", fallback = "t_wall_half" },
            [":"] = "t_floor",
            ["-"] = {
                select = {
                    parameter = "construction0_house_concrete_outside_type",
                    fallback = "t_region_soil",
                },
                cases = { t_pit_shallow = "t_pit_shallow", t_region_soil = "t_region_soil" },
            },
            ["~"] = "t_floor",
            ["<"] = "t_stairs_up",
            [">"] = "t_stairs_down",
        },
        furniture = {
            C = {
                { id = "f_null", copies = 10 },
                { id = "f_pallet_brick", copies = 2 },
                { id = "f_pallet_brick_adobe", copies = 2 },
                { id = "f_pallet_cement", copies = 2 },
                { id = "f_stack_plank", copies = 6 },
            },
            ["{"] = "f_null",
        },
    },
}

-- intended for in-construction homes that were done framing windows, doors and finishing the exteriors
ccb.content.define_mapgen_palette {
    id = "construction_phase_1_palette",
    layout = {
        nested_glyphs = {
            X = {
                choices = {
                    { id = "null", weight = 4 },
                    { id = "construction_crate_open", weight = 4 },
                    { id = "construction_crate_closed", weight = 1 },
                },
            },
            x = {
                choices = {
                    { id = "null", weight = 4 },
                    { id = "construction_crate_open", weight = 4 },
                    { id = "construction_crate_closed", weight = 1 },
                },
            },
        },
        parameters = {
            construction1_exterior_wall_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_brick_wall", weight = 6 },
                        { id = "t_rock_wall", weight = 3 },
                        { id = "t_wall_wood", weight = 3 },
                        { id = "t_concrete_wall", weight = 4 },
                        { id = "t_adobe_brick_wall", weight = 1 },
                    },
                },
            },
            construction1_interior_wall_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_wall_half", weight = 6 },
                        { id = "t_brick_wall_halfway", weight = 2 },
                    },
                },
            },
            construction1_house_concrete_outside_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_thconc_floor_no_roof", weight = 3 },
                        { id = "t_pit_shallow", weight = 2 },
                    },
                },
            },
        },
        terrain = {
            b = "t_floor",
            c = { parameter = "construction1_house_concrete_outside_type", fallback = "t_pit_shallow" },
            f = "t_region_soil",
            g = "t_region_soil",
            o = "t_window_empty",
            p = {
                select = {
                    parameter = "construction1_house_concrete_outside_type",
                    fallback = "t_pit_shallow",
                },
                cases = { t_thconc_floor_no_roof = "t_pavement", t_pit_shallow = "t_pit_shallow" },
            },
            s = "t_floor",
            t = "t_floor",
            F = "t_floor",
            O = "t_floor",
            S = "t_floor",
            ["5"] = "t_floor",
            ["6"] = "t_floor",
            ["7"] = "t_floor",
            ["8"] = "t_floor",
            ["9"] = "t_floor",
            ["."] = {
                { id = "t_region_groundcover_urban", copies = 1 },
                { id = "t_region_soil", copies = 10 },
            },
            ["+"] = "t_door_frame",
            ["*"] = "t_door_frame",
            ["="] = "t_floor",
            ["&"] = "t_floor",
            ["^"] = "t_gutter_downspout",
            ["#"] = { parameter = "construction1_exterior_wall_type", fallback = "t_brick_wall" },
            ["|"] = { parameter = "construction1_interior_wall_type", fallback = "t_wall_half" },
            [":"] = "t_window_empty",
            ["~"] = "t_floor",
            ["<"] = "t_stairs_up",
            [">"] = "t_stairs_down",
            ["-"] = {
                select = {
                    parameter = "construction1_house_concrete_outside_type",
                    fallback = "t_pit_shallow",
                },
                cases = { t_thconc_floor_no_roof = "t_sidewalk", t_pit_shallow = "t_pit_shallow" },
            },
        },
        furniture = {
            C = {
                { id = "f_null", copies = 8 },
                { id = "f_pallet_brick", copies = 2 },
                { id = "f_pallet_brick_adobe", copies = 2 },
                { id = "f_pallet_cement", copies = 4 },
                { id = "f_stack_plank", copies = 6 },
            },
            M = "f_null",
            ["{"] = "f_null",
        },
    },
}

-- intended for in-construction homes that were done with most plumbing and cabling (appliances, inner walls unpainted) and installed fence posts
ccb.content.define_mapgen_palette {
    id = "construction_phase_2_palette",
    layout = {
        toilets = { "t" },
        nested_glyphs = {
            X = {
                choices = {
                    { id = "null", weight = 6 },
                    { id = "construction_crate_open", weight = 5 },
                    { id = "construction_crate_closed", weight = 1 },
                },
            },
            x = {
                choices = {
                    { id = "null", weight = 6 },
                    { id = "construction_crate_open", weight = 5 },
                    { id = "construction_crate_closed", weight = 1 },
                },
            },
            ["~"] = {
                choices = {
                    { id = "null", weight = 9 },
                    { id = "construction_bathroom_plumbing", weight = 3 },
                    { id = "construction_bathroom_tools", weight = 1 },
                },
            },
        },
        item_groups = { t = { group = "SUS_toilet", chance = 50 } },
        parameters = {
            construction2_exterior_wall_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_brick_wall", weight = 6 },
                        { id = "t_rock_wall", weight = 3 },
                        { id = "t_wall_wood", weight = 3 },
                        { id = "t_concrete_wall", weight = 4 },
                        { id = "t_adobe_brick_wall", weight = 1 },
                    },
                },
            },
            construction2_interior_wall_type = {
                value_type = "terrain",
                default = {
                    weighted = { { id = "t_brick_wall", weight = 1 }, { id = "t_wall_wood", weight = 6 } },
                },
            },
            construction2_house_fence_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_fence_post", weight = 8 },
                        { id = "t_chainfence_posts", weight = 4 },
                    },
                },
            },
        },
        terrain = {
            b = "t_floor",
            c = "t_thconc_floor_no_roof",
            f = { parameter = "construction2_house_fence_type", fallback = "t_region_soil" },
            g = "t_region_soil",
            h = "t_pit_shallow",
            o = "t_window_empty",
            p = "t_pavement",
            s = "t_floor",
            t = "t_floor",
            F = "t_floor",
            O = "t_floor",
            S = "t_floor",
            ["5"] = "t_floor",
            ["6"] = "t_floor",
            ["7"] = "t_floor",
            ["8"] = "t_floor",
            ["9"] = "t_floor",
            ["."] = {
                { id = "t_region_groundcover_urban", copies = 3 },
                { id = "t_region_soil", copies = 10 },
            },
            ["+"] = "t_door_frame",
            ["*"] = "t_door_frame",
            ["="] = "t_floor",
            ["&"] = "t_floor",
            ["^"] = "t_gutter_downspout",
            ["#"] = { parameter = "construction2_exterior_wall_type", fallback = "t_brick_wall" },
            ["|"] = { parameter = "construction2_interior_wall_type", fallback = "t_wall_half" },
            [":"] = "t_window_empty",
            ["-"] = "t_sidewalk",
            ["~"] = "t_floor",
            ["<"] = "t_stairs_up",
            [">"] = "t_stairs_down",
        },
        furniture = {
            b = "f_bathtub",
            s = "f_sink",
            C = {
                { id = "f_null", copies = 20 },
                { id = "f_pallet_brick", copies = 2 },
                { id = "f_pallet_brick_adobe", copies = 2 },
                { id = "f_pallet_cement", copies = 2 },
                { id = "f_stack_plank", copies = 3 },
            },
            M = "f_mailbox",
            F = "f_fridge",
            O = { { id = "f_oven" }, { id = "f_gas_oven_microwave_combo" } },
            S = "f_sink",
            ["9"] = "f_shower",
            ["{"] = "f_dumpster",
        },
    },
}

-- intended for in-construction homes that were practically ready to move in to
ccb.content.define_mapgen_palette {
    id = "construction_phase_3_palette",
    layout = {
        toilets = { "t" },
        nested_glyphs = {
            X = {
                choices = { { id = "null", weight = 6 }, { id = "construction_crate_open", weight = 2 } },
            },
            x = {
                choices = { { id = "null", weight = 6 }, { id = "construction_crate_open", weight = 2 } },
            },
            ["~"] = {
                choices = {
                    { id = "null", weight = 10 },
                    { id = "construction_bathroom_plumbing", weight = 3 },
                    { id = "construction_bathroom_tools", weight = 1 },
                },
            },
        },
        item_groups = { t = { group = "SUS_toilet", chance = 50 } },
        parameters = {
            construction3_exterior_wall_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_brick_wall", weight = 6 },
                        { id = "t_rock_wall", weight = 3 },
                        { id = "t_wall_wood", weight = 3 },
                        { id = "t_concrete_wall", weight = 4 },
                        { id = "t_adobe_brick_wall", weight = 1 },
                    },
                },
            },
            construction3_interior_wall_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_brick_wall", weight = 1 },
                        { id = "t_wall_b", weight = 1 },
                        { id = "t_wall_g", weight = 1 },
                        { id = "t_wall_p", weight = 1 },
                        { id = "t_wall_P", weight = 1 },
                        { id = "t_wall_r", weight = 1 },
                        { id = "t_wall_w", weight = 6 },
                        { id = "t_wall_y", weight = 1 },
                        { id = "t_wall_gray", weight = 1 },
                        { id = "t_wall_brown", weight = 1 },
                        { id = "t_wall_cyan", weight = 1 },
                        { id = "t_wall_black", weight = 1 },
                        { id = "t_wall_orange", weight = 1 },
                    },
                },
            },
            construction3_house_linoleum_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_linoleum_white", weight = 1 },
                        { id = "t_linoleum_gray", weight = 1 },
                    },
                },
            },
            construction3_house_fence_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_splitrail_fence", weight = 3 },
                        { id = "t_chainfence", weight = 2 },
                        { id = "t_fence", weight = 2 },
                        { id = "t_privacy_fence", weight = 1 },
                        { id = "t_drystone_wall_half", weight = 1 },
                    },
                },
            },
        },
        terrain = {
            c = "t_thconc_floor_no_roof",
            f = { parameter = "construction3_house_fence_type", fallback = "t_region_soil" },
            g = {
                select = { parameter = "construction3_house_fence_type", fallback = "t_region_soil" },
                cases = {
                    t_splitrail_fence = "t_splitrail_fencegate_c",
                    t_chainfence = "t_chaingate_c",
                    t_fence = "t_fencegate_c",
                    t_privacy_fence = "t_privacy_fencegate_c",
                    t_drystone_wall_half = "t_chaingate_l",
                },
            },
            o = {
                { id = "t_window" },
                { id = "t_window_no_curtains" },
                { id = "t_window_open" },
                { id = "t_window_no_curtains_open" },
            },
            p = "t_pavement",
            b = { parameter = "construction3_house_linoleum_type", fallback = "t_linoleum_white" },
            t = { parameter = "construction3_house_linoleum_type", fallback = "t_linoleum_white" },
            s = { parameter = "construction3_house_linoleum_type", fallback = "t_linoleum_white" },
            ["5"] = { parameter = "construction3_house_linoleum_type", fallback = "t_linoleum_white" },
            ["6"] = { parameter = "construction3_house_linoleum_type", fallback = "t_linoleum_white" },
            ["9"] = { parameter = "construction3_house_linoleum_type", fallback = "t_linoleum_white" },
            ["."] = {
                { id = "t_region_groundcover_urban", copies = 6 },
                { id = "t_region_soil", copies = 10 },
            },
            ["+"] = "t_door_o",
            ["*"] = {
                { id = "t_door_locked_peep", copies = 2 },
                { id = "t_door_locked_alarm" },
                { id = "t_door_locked", copies = 10 },
                { id = "t_door_elocked_peep", copies = 4 },
                { id = "t_door_elocked_alarm" },
                { id = "t_door_elocked", copies = 15 },
                { id = "t_door_c" },
                { id = "t_door_o", copies = 2 },
            },
            ["="] = "t_door_metal_locked",
            ["&"] = "t_gates_control_brick",
            ["^"] = "t_gutter_downspout",
            ["#"] = { parameter = "construction3_exterior_wall_type", fallback = "t_brick_wall" },
            ["|"] = { parameter = "construction3_interior_wall_type", fallback = "t_wall_w" },
            [":"] = "t_wall_glass",
            ["-"] = "t_sidewalk",
            ["~"] = { parameter = "construction3_house_linoleum_type", fallback = "t_linoleum_white" },
            ["<"] = "t_stairs_up",
            [">"] = "t_stairs_down",
        },
        furniture = {
            a = "f_fireplace",
            b = "f_bathtub",
            k = "f_woodstove",
            s = "f_sink",
            C = "f_null",
            M = "f_mailbox",
            F = "f_fridge",
            O = { { id = "f_oven" }, { id = "f_gas_oven_microwave_combo" } },
            S = "f_sink",
            ["5"] = "f_cupboard",
            ["6"] = "f_counter",
            ["7"] = "f_counter",
            ["8"] = "f_cupboard",
            ["9"] = "f_shower",
            ["{"] = "f_dumpster",
        },
    },
}
