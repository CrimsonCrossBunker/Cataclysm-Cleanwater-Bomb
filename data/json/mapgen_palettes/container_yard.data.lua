local ccb = require("ccb")

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
