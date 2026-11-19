local ccb = require("ccb")

-- null represents an empty shipping container.  Odds: 20 common bulk items, 10 common diverse items (eg for common shops), 5 uncommon (eg art, antiques), 1 very rare/illegal
ccb.content.define_mapgen_palette {
    id = "shipping_container_nest_palette",
    layout = {
        nested_glyphs = {
            ["."] = { id = { parameter = "contents_nest", fallback = "null" } },
            ["#"] = {
                choices = {
                    { id = "shelter_graffiti", weight = 1 },
                    { id = "general_graffiti", weight = 1 },
                    { id = "null", weight = 98 },
                },
            },
        },
        parameters = {
            contents_nest = {
                value_type = "nested_mapgen",
                default = {
                    weighted = {
                        { id = "null", weight = 20 },
                        { id = "shipping_container_appliances_1x1", weight = 20 },
                        { id = "shipping_container_fridge_1x1", weight = 20 },
                        { id = "shipping_container_freezer_1x1", weight = 20 },
                        { id = "shipping_container_washerdryer_1x1", weight = 20 },
                        { id = "shipping_container_exam_chair_1x1", weight = 20 },
                        { id = "shipping_container_toilet_1x1", weight = 20 },
                        { id = "shipping_container_armchair_1x1", weight = 20 },
                        { id = "shipping_container_bookcase_1x1", weight = 20 },
                        { id = "shipping_container_coffin_1x1", weight = 20 },
                        { id = "shipping_container_stack_wooden_planks_1x1", weight = 20 },
                        { id = "shipping_container_pallet_adobe_bricks_1x1", weight = 20 },
                        { id = "shipping_container_stack_pipes_1x1", weight = 20 },
                        { id = "shipping_container_mattress_1x1", weight = 20 },
                        { id = "shipping_container_mannequin_1x1", weight = 20 },
                        { id = "shipping_container_paint_1x1", weight = 20 },
                        { id = "shipping_container_nails_1x1", weight = 20 },
                        { id = "shipping_container_gravelbag_1x1", weight = 20 },
                        { id = "shipping_container_sandbag_1x1", weight = 20 },
                        { id = "shipping_container_rebar_1x1", weight = 20 },
                        { id = "shipping_container_tampon_1x1", weight = 20 },
                        { id = "shipping_container_men_pads_1x1", weight = 20 },
                        { id = "shipping_container_v6_comb_1x1", weight = 20 },
                        { id = "shipping_container_v6_diesel_1x1", weight = 20 },
                        { id = "shipping_container_v8_comb_1x1", weight = 20 },
                        { id = "shipping_container_v8_diesel_1x1", weight = 20 },
                        { id = "shipping_container_v12_comb_1x1", weight = 20 },
                        { id = "shipping_container_v12_diesel_1x1", weight = 20 },
                        { id = "shipping_container_glue_strong_1x1", weight = 20 },
                        { id = "shipping_container_protein_bars_1x1", weight = 20 },
                        { id = "shipping_container_water_1x1", weight = 20 },
                        { id = "shipping_container_toilet_paper_1x1", weight = 20 },
                        { id = "shipping_container_soap_1x1", weight = 20 },
                        { id = "shipping_container_duct_tape_1x1", weight = 20 },
                        { id = "shipping_container_large_cardboard_box_1x1", weight = 20 },
                        { id = "shipping_container_mp3_1x1", weight = 20 },
                        { id = "shipping_container_new_phones_1x1", weight = 20 },
                        { id = "shipping_container_circsaw_blade_1x1", weight = 20 },
                        { id = "shipping_container_stereos_1x1", weight = 20 },
                        { id = "shipping_container_barrels_1x1", weight = 20 },
                        { id = "shipping_container_barstools_1x1", weight = 20 },
                        { id = "shipping_container_wardrobe_1x1", weight = 20 },
                        { id = "shipping_container_television_1x1", weight = 20 },
                        { id = "shipping_container_vending_1x1", weight = 20 },
                        { id = "shipping_container_flashlight_1x1", weight = 20 },
                        { id = "shipping_container_fertilizer_1x1", weight = 20 },
                        { id = "shipping_container_sunglasses_1x1", weight = 20 },
                        { id = "shipping_container_open_gunsafe_1x1", weight = 20 },
                        { id = "shipping_container_filing_cabinet_1x1", weight = 20 },
                        { id = "shipping_container_emer_blanket_1x1", weight = 20 },
                        { id = "shipping_container_diesel_generator_1x1", weight = 20 },
                        { id = "shipping_container_portable_generator_1x1", weight = 20 },
                        { id = "shipping_container_12000_gasoline_generator_1x1", weight = 20 },
                        { id = "shipping_container_extinguisher_1x1", weight = 20 },
                        { id = "shipping_container_sm_extinguisher_1x1", weight = 20 },
                        { id = "shipping_container_light_bulb_1x1", weight = 20 },
                        { id = "shipping_container_long_extension_cable_1x1", weight = 20 },
                        { id = "shipping_container_extension_cable_1x1", weight = 20 },
                        { id = "shipping_container_clothes_hanger_1x1", weight = 20 },
                        { id = "shipping_container_bike_rack_1x1", weight = 20 },
                        { id = "shipping_container_food_1x1", weight = 10 },
                        { id = "shipping_container_books_1x1", weight = 10 },
                        { id = "shipping_container_gift_shop_1x1", weight = 10 },
                        { id = "shipping_container_otc_pharmacy_1x1", weight = 10 },
                        { id = "shipping_container_electronics_1x1", weight = 10 },
                        { id = "shipping_container_sunscreen_1x1", weight = 10 },
                        { id = "shipping_container_cigs_1x1", weight = 10 },
                        { id = "shipping_container_concrete_1x1", weight = 10 },
                        { id = "shipping_container_brick_1x1", weight = 10 },
                        { id = "shipping_container_wheel_1x1", weight = 10 },
                        { id = "shipping_container_spare_parts_1x1", weight = 10 },
                        { id = "shipping_container_glass_1x1", weight = 10 },
                        { id = "shipping_container_wind_instrument_1x1", weight = 10 },
                        { id = "shipping_container_string_instrument_1x1", weight = 10 },
                        { id = "shipping_container_personal_devices_1x1", weight = 10 },
                        { id = "shipping_container_elec_appliances_1x1", weight = 10 },
                        { id = "shipping_container_newstorage_1x1", weight = 10 },
                        { id = "shipping_container_batteries_1x1", weight = 10 },
                        { id = "shipping_container_heavy_batteries_1x1", weight = 10 },
                        { id = "shipping_container_petstore_1x1", weight = 10 },
                        { id = "shipping_container_bedding_1x1", weight = 10 },
                        { id = "shipping_container_fishing_rods_comm_1x1", weight = 10 },
                        { id = "shipping_container_fishing_rods_port_1x1", weight = 10 },
                        { id = "shipping_container_golf_ball_1x1", weight = 10 },
                        { id = "shipping_container_camping_1x1", weight = 10 },
                        { id = "shipping_container_spirits_1x1", weight = 10 },
                        { id = "shipping_container_alternator_motorbike_1x1", weight = 10 },
                        { id = "shipping_container_alternator_car_1x1", weight = 10 },
                        { id = "shipping_container_alternator_truck_1x1", weight = 10 },
                        { id = "shipping_container_decorative_tree_1x1", weight = 10 },
                        { id = "shipping_container_foodplace_1x1", weight = 5 },
                        { id = "shipping_container_antiques_1x1", weight = 5 },
                        { id = "shipping_container_art_all_1x1", weight = 5 },
                        { id = "shipping_container_radio_1x1", weight = 5 },
                        { id = "shipping_container_dildo_1x1", weight = 5 },
                        { id = "shipping_container_ar_basic_1x1", weight = 5 },
                        { id = "shipping_container_microcentrifuge_1x1", weight = 5 },
                        { id = "shipping_container_centrifuge_1x1", weight = 5 },
                        { id = "shipping_container_shaker_1x1", weight = 5 },
                        { id = "shipping_container_wine_keg_1x1", weight = 5 },
                        { id = "shipping_container_inflatable_boat_1x1", weight = 5 },
                        { id = "shipping_container_science_1x1", weight = 1 },
                        { id = "shipping_container_chem_lab_1x1", weight = 1 },
                        { id = "shipping_container_surgery_1x1", weight = 1 },
                        { id = "shipping_container_pharmacy_1x1", weight = 1 },
                        { id = "shipping_container_weed_1x1", weight = 1 },
                        { id = "shipping_container_meth_1x1", weight = 1 },
                        { id = "shipping_container_cigar_1x1", weight = 1 },
                        { id = "shipping_container_antique_rare_1x1", weight = 1 },
                        { id = "shipping_container_banknotes_1x1", weight = 1 },
                        { id = "shipping_container_illegal_AK_1x1", weight = 1 },
                        { id = "shipping_container_cockroach_1x1", weight = 1 },
                        { id = "shipping_container_slime_1x1", weight = 1 },
                        { id = "shipping_container_ar_advanced_1x1", weight = 1 },
                        { id = "shipping_container_cocaine_1x1", weight = 1 },
                        { id = "shipping_container_gunmod_common_1x1", weight = 1 },
                        { id = "shipping_container_gunmod_rare_1x1", weight = 1 },
                        { id = "shipping_container_illegal_AK_rounds_1x1", weight = 1 },
                        { id = "shipping_container_dentist_1x1", weight = 1 },
                    },
                },
                scope = "nested",
            },
            exterior_wall_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_wall_metal_shipping_container_black", weight = 1 },
                        { id = "t_wall_metal_shipping_container_white", weight = 1 },
                        { id = "t_wall_metal_shipping_container_red", weight = 4 },
                        { id = "t_wall_metal_shipping_container_light_red", weight = 4 },
                        { id = "t_wall_metal_shipping_container_green", weight = 4 },
                        { id = "t_wall_metal_shipping_container_light_green", weight = 4 },
                        { id = "t_wall_metal_shipping_container_blue", weight = 4 },
                        { id = "t_wall_metal_shipping_container_light_blue", weight = 4 },
                        { id = "t_wall_metal_shipping_container_cyan", weight = 2 },
                        { id = "t_wall_metal_shipping_container_light_cyan", weight = 2 },
                        { id = "t_wall_metal_shipping_container_magenta", weight = 2 },
                        { id = "t_wall_metal_shipping_container_brown", weight = 4 },
                        { id = "t_wall_metal_shipping_container_pink", weight = 1 },
                        { id = "t_wall_metal_shipping_container_yellow", weight = 4 },
                    },
                },
                scope = "nested",
            },
            exterior_door_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_door_metal_c", weight = 4 },
                        { id = "t_door_metal_locked", weight = 1 },
                    },
                },
                scope = "nested",
            },
        },
        terrain = {
            ["."] = "t_metal_floor",
            _ = "t_metal_floor",
            ["#"] = { parameter = "exterior_wall_type", fallback = "t_wall_metal_shipping_container" },
            ["+"] = { parameter = "exterior_door_type", fallback = "t_door_metal_c" },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_appliances_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = {
            [" "] = {
                { id = "f_null", copies = 5 },
                { id = "f_dishwasher", copies = 5 },
                { id = "f_home_furnace", copies = 5 },
                { id = "f_washer", copies = 5 },
                { id = "f_oven", copies = 5 },
                { id = "f_dryer", copies = 5 },
                { id = "f_diesel_generator", copies = 5 },
                { id = "f_fridge", copies = 1 },
                { id = "f_glass_fridge", copies = 1 },
                { id = "f_glass_fridge_double", copies = 1 },
                { id = "f_heavy_duty_fridge", copies = 1 },
                { id = "f_display_fridge", copies = 1 },
                { id = "f_minifreezer", copies = 1 },
                { id = "f_freezer", copies = 1 },
                { id = "f_heavy_duty_freezer", copies = 1 },
                { id = "f_glass_freezer", copies = 1 },
                { id = "f_display_freezer", copies = 1 },
                { id = "f_exercise", copies = 1 },
                { id = "f_ball_mach", copies = 5 },
                { id = "f_arcade_machine", copies = 5 },
                { id = "f_pinball_machine", copies = 5 },
                { id = "f_ergometer", copies = 1 },
                { id = "f_ergometer_mechanical", copies = 1 },
                { id = "f_treadmill", copies = 1 },
                { id = "f_treadmill_mechanical", copies = 1 },
                { id = "f_piano", copies = 5 },
                { id = "f_speaker_cabinet", copies = 5 },
                { id = "f_training_dummy_light", copies = 1 },
                { id = "f_training_dummy_heavy", copies = 1 },
                { id = "f_archery_target_box", copies = 1 },
                { id = "f_archery_target_bale", copies = 1 },
                { id = "f_toilet", copies = 5 },
                { id = "f_water_heater", copies = 1 },
                { id = "f_water_heater_family", copies = 1 },
                { id = "f_water_purifier", copies = 1 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_fridge_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = {
            [" "] = {
                { id = "f_fridge", copies = 1 },
                { id = "f_glass_fridge", copies = 1 },
                { id = "f_glass_fridge_double", copies = 1 },
                { id = "f_heavy_duty_fridge", copies = 1 },
                { id = "f_display_fridge", copies = 1 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_freezer_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = {
            [" "] = {
                { id = "f_minifreezer", copies = 1 },
                { id = "f_freezer", copies = 1 },
                { id = "f_heavy_duty_freezer", copies = 1 },
                { id = "f_glass_freezer", copies = 1 },
                { id = "f_display_freezer", copies = 1 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_washerdryer_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_washer", copies = 5 }, { id = "f_dryer", copies = 5 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_centrifuge_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_pallet_belted" },
        item_spawns = { [" "] = { id = "centrifuge", chance = 95 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_shaker_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_shaker" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_exam_chair_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_exam_chair" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_toilet_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_toilet" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_bookcase_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_bookcase" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_coffin_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_coffin_c" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_stack_wooden_planks_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_plank_stack_mid" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_pallet_adobe_bricks_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_pallet_brick_adobe" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_stack_pipes_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_pipe_stack_mid" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_mannequin_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_mannequin" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_fertilizer_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "fertilizer_commercial_bag_canvas_60", chance = 95 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_wine_keg_1x1",
    layout = {
        size = { width = 1, height = 1 },
        item_groups = { [" "] = { group = "keg_wine_intact", chance = 95 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_bedding_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "bed", chance = 95 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_barrels_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "barrels", chance = 95 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_wardrobe_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_wardrobe" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_utility_shelf_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_utility_shelf" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_vending_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_vending_c_off" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_decorative_tree_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_decorative_tree", copies = 90 }, { id = "f_null", copies = 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_open_gunsafe_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_gunsafe_o", copies = 90 }, { id = "f_null", copies = 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_filing_cabinet_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_filing_cabinet", copies = 90 }, { id = "f_null", copies = 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_diesel_generator_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_diesel_generator", copies = 90 }, { id = "f_null", copies = 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_portable_generator_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_pallet_belted" },
        item_spawns = { [" "] = { id = "portable_generator", chance = 95 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_12000_gasoline_generator_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_pallet_belted" },
        item_spawns = { [" "] = { id = "12000_gasoline_generator", chance = 95 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_food_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "cannedfood", chance = 95, repetitions = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_foodplace_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_spawns = { [" "] = { id = "foodplace_food", chance = 95, amount = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_electronics_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "consumer_electronics", chance = 95, repetitions = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_antiques_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "antique", chance = 95, repetitions = { 1, 5 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_books_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "homebooks", chance = 95, repetitions = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_science_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "mundane_science", chance = 95, repetitions = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_chem_lab_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "chem_lab", chance = 95, repetitions = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_surgery_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "surgery", chance = 95, repetitions = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_gift_shop_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "gift_shop", chance = 95, repetitions = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_art_all_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "art_all", chance = 95, repetitions = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_antique_rare_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "antique_rare", chance = 95, repetitions = { 1, 2 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_otc_pharmacy_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "drugs_heal_simple", chance = 95, repetitions = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_pharmacy_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "drugs_pharmacy", chance = 95, repetitions = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_weed_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "jar_weed", chance = 95, repetitions = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_meth_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "meth_bag_zipper_6", chance = 95, repetitions = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_sunscreen_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "sunscreen_bottle", chance = 95, repetitions = { 30, 60 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_cigar_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "cigar_box_unopened", chance = 95, repetitions = { 30, 50 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_cigs_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "cig_box_cigarette_20", chance = 95, repetitions = { 100, 200 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_banknotes_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "banknotes", chance = 95, repetitions = { 200, 1000 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_illegal_AK_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 95 }, { id = "f_cardboard_box", copies = 5 } } },
        item_spawns = { [" "] = { id = "ak47", chance = 70, amount = { 1, 2 } } },
        item_groups = { [" "] = { group = "magazines_akm", chance = 95, repetitions = { 5, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_cockroach_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_cardboard_box" },
        item_spawns = { [" "] = { id = "feces_roach", chance = 20, amount = { 1, 2 } } },
        monster_group_glyphs = { [" "] = { group = "GROUP_ROACH", chance = 6, density = 0.0001 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_slime_1x1",
    layout = {
        size = { width = 1, height = 1 },
        monster_group_glyphs = { [" "] = { group = "GROUP_SLIME", chance = 4, density = 0.0001 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_concrete_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_pallet_belted" },
        item_groups = { [" "] = { group = "concrete_bag", chance = 95, repetitions = { 5, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_wheel_1x1",
    layout = {
        size = { width = 1, height = 1 },
        item_groups = { [" "] = { group = "wheels_no_wood", chance = 95, repetitions = { 1, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_spare_parts_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "supplies_spares_vehicle", chance = 95, repetitions = { 1, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_nails_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 90 }, { id = "f_cardboard_box", copies = 10 } } },
        item_groups = { [" "] = { group = "nail_box_10lb_full", chance = 95, repetitions = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_paint_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 90 }, { id = "f_cardboard_box", copies = 10 } } },
        item_groups = { [" "] = { group = "paint", chance = 95, repetitions = { 10, 15 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_gravelbag_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_pallet_belted" },
        item_groups = { [" "] = { group = "gravelbag", chance = 95, repetitions = { 10, 15 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_sandbag_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_pallet_belted" },
        item_groups = { [" "] = { group = "sandbag", chance = 95, repetitions = { 10, 15 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_rebar_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_spawns = { [" "] = { id = "rebar", chance = 95, amount = { 30, 50 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_glue_strong_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_pallet_belted" },
        item_groups = {
            [" "] = { group = "glue_strong_professional_full", chance = 95, repetitions = { 1, 10 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_radio_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_spawns = { [" "] = { id = "radio", chance = 95, amount = { 5, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_dildo_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_spawns = { [" "] = { id = "sextoy", chance = 95, amount = { 5, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_ar_basic_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_spawns = { [" "] = { id = "ar_glasses_basic", chance = 95, amount = { 5, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_ar_advanced_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_spawns = { [" "] = { id = "ar_glasses_advanced", chance = 95, amount = { 5, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_mp3_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_spawns = { [" "] = { id = "mp3", chance = 95, amount = { 5, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_new_phones_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "new_phones", chance = 95, repetitions = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_personal_devices_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "elecsto_persele", chance = 95, repetitions = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_elec_appliances_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "elecsto_homapl", chance = 95, repetitions = { 1, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_newstorage_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "elecsto_stor", chance = 95, repetitions = { 20, 50 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_batteries_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "box_of_batteries_unopened", chance = 95, repetitions = { 10, 30 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_heavy_batteries_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "ammo_heavy_batteries_full", chance = 95, repetitions = { 10, 30 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_petstore_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "petstore_misc", chance = 95, repetitions = { 5, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_protein_bars_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_pallet_belted" },
        item_groups = { [" "] = { group = "protein_bar_wrapped_box", chance = 95, repetitions = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_water_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_pallet_belted" },
        item_groups = { [" "] = { group = "twoliter_water_batch", chance = 95, repetitions = { 10, 30 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_toilet_paper_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_pallet_belted" },
        item_groups = { [" "] = { group = "toilet_paper_packed", chance = 95, repetitions = { 10, 30 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_soap_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "soap_packed", chance = 95, repetitions = { 10, 30 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_duct_tape_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 90 }, { id = "f_cardboard_box", copies = 10 } } },
        item_groups = { [" "] = { group = "duct_tape_roll", chance = 95, repetitions = { 10, 30 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_large_cardboard_box_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_spawns = { [" "] = { id = "box_large_folded", chance = 95, amount = { 5, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_circsaw_blade_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_spawns = { [" "] = { id = "circsaw_blade", chance = 95, amount = { 5, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_microcentrifuge_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_pallet_belted" },
        item_spawns = { [" "] = { id = "microcentrifuge", chance = 95, amount = 5 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_armchair_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_pallet_belted" },
        item_spawns = { [" "] = { id = "armchair", chance = 95, amount = 5 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_mattress_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_pallet_belted" },
        item_spawns = { [" "] = { id = "mattress", chance = 95, amount = 2 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_cocaine_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "coke_bag_zipper_1_8", chance = 95, repetitions = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_flashlight_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_spawns = { [" "] = { id = "flashlight", chance = 95, amount = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_glass_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "glass_shop", chance = 95, repetitions = { 1, 5 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_wind_instrument_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "mussto_windinst", chance = 95, repetitions = { 1, 5 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_string_instrument_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "mussto_stringinst", chance = 95, repetitions = { 1, 5 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_stereos_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_spawns = { [" "] = { id = "stereo", chance = 85, amount = { 1, 2 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_barstools_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_spawns = { [" "] = { id = "barstool", chance = 85, amount = { 1, 5 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_television_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_pallet_belted" },
        item_spawns = { [" "] = { id = "television", chance = 95, amount = 2 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_dentist_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "dentist_supplies", chance = 95, repetitions = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_gunmod_common_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "gunmod_common", chance = 95, repetitions = { 5, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_gunmod_rare_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "gunmod_rare", chance = 95, repetitions = { 5, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_tampon_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "tampon_box_full", chance = 95, repetitions = { 5, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_men_pads_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "menstrual_pad_box_full", chance = 95, repetitions = { 5, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_v6_comb_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 95 }, { id = "f_cardboard_box", copies = 5 } } },
        item_spawns = { [" "] = { id = "v6_combustion", chance = 90, amount = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_v6_diesel_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 95 }, { id = "f_cardboard_box", copies = 5 } } },
        item_spawns = { [" "] = { id = "v6_diesel", chance = 90, amount = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_v8_comb_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 95 }, { id = "f_cardboard_box", copies = 5 } } },
        item_spawns = { [" "] = { id = "v8_combustion", chance = 90, amount = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_v8_diesel_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 95 }, { id = "f_cardboard_box", copies = 5 } } },
        item_spawns = { [" "] = { id = "v8_diesel", chance = 90, amount = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_v12_comb_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 95 }, { id = "f_cardboard_box", copies = 5 } } },
        item_spawns = { [" "] = { id = "v12_combustion", chance = 90, amount = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_v12_diesel_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 95 }, { id = "f_cardboard_box", copies = 5 } } },
        item_spawns = { [" "] = { id = "v12_diesel", chance = 90, amount = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_illegal_AK_rounds_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "boxed_762", chance = 95, repetitions = { 5, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_fishing_rods_comm_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "tools_fishingrods_commercial", chance = 95, repetitions = { 5, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_fishing_rods_port_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "tools_fishingrods_portable", chance = 95, repetitions = { 5, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_golf_ball_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 10 }, { id = "f_cardboard_box", copies = 90 } } },
        item_spawns = { [" "] = { id = "golf_ball", chance = 95, amount = 50 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_emer_blanket_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 10 }, { id = "f_cardboard_box", copies = 90 } } },
        item_spawns = { [" "] = { id = "emer_blanket", chance = 95, amount = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_camping_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 70 }, { id = "f_cardboard_box", copies = 30 } } },
        item_groups = { [" "] = { group = "camping", chance = 95, repetitions = { 5, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_inflatable_boat_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 95 }, { id = "f_cardboard_box", copies = 5 } } },
        item_spawns = { [" "] = { id = "folded_inflatable_boat", chance = 95, amount = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_sunglasses_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 10 }, { id = "f_cardboard_box", copies = 90 } } },
        item_spawns = { [" "] = { id = "sunglasses", chance = 95, amount = 20 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_spirits_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 10 }, { id = "f_cardboard_box", copies = 90 } } },
        item_groups = { [" "] = { group = "liquor_and_spirits", chance = 95, repetitions = { 5, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_alternator_motorbike_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 10 }, { id = "f_cardboard_box", copies = 90 } } },
        item_spawns = { [" "] = { id = "alternator_motorbike", chance = 95, amount = { 1, 5 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_alternator_car_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 10 }, { id = "f_cardboard_box", copies = 90 } } },
        item_spawns = { [" "] = { id = "alternator_car", chance = 95, amount = { 1, 5 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_alternator_truck_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 10 }, { id = "f_cardboard_box", copies = 90 } } },
        item_spawns = { [" "] = { id = "alternator_truck", chance = 95, amount = { 1, 5 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_extinguisher_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_pallet_belted" },
        item_spawns = { [" "] = { id = "extinguisher", chance = 95, repetitions = { 8, 12 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_sm_extinguisher_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_pallet_belted" },
        item_spawns = { [" "] = { id = "sm_extinguisher", chance = 95, repetitions = { 16, 24 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_light_bulb_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 90 }, { id = "f_cardboard_box", copies = 10 } } },
        item_spawns = { [" "] = { id = "light_bulb", chance = 95, repetitions = { 45, 55 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_long_extension_cable_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 90 }, { id = "f_cardboard_box", copies = 10 } } },
        item_spawns = { [" "] = { id = "long_extension_cable", chance = 95, repetitions = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_extension_cable_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 90 }, { id = "f_cardboard_box", copies = 10 } } },
        item_spawns = { [" "] = { id = "extension_cable", chance = 95, repetitions = { 10, 20 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_clothes_hanger_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = { { id = "f_crate_c", copies = 90 }, { id = "f_cardboard_box", copies = 10 } } },
        item_spawns = { [" "] = { id = "clothes_hanger", chance = 95, repetitions = { 40, 50 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "shipping_container_bike_rack_1x1",
    layout = {
        size = { width = 1, height = 1 },
        furniture = { [" "] = "f_pallet_belted" },
        item_spawns = { [" "] = { id = "bike_rack", chance = 95, repetitions = { 2, 4 } } },
    },
}
