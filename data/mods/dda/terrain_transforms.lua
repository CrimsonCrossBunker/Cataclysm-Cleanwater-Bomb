local ccb = require("ccb")
local content = ccb.content

content.add(content.TerrainTransform { id = "spider_clear_webs" }
    :field {
        inputs = { "fd_web" },
        results = { "fd_null" },
    })

content.add(content.TerrainTransform { id = "deactivate_imperial_road_gate" }
    :terrain {
        inputs = { "t_highland_bronze_floor" },
        results = { "t_highland_bronze_floor_inactive" },
    })

content.add(content.TerrainTransform { id = "transform_LS_teleport_default_dimension_spire_to_safehouse" }
    :terrain {
        inputs = { "t_nl_obelisk_earth" },
        results = { "t_nl_obelisk_earth_broken" },
        message = ccb.content.text("You hear a resounding CRACK!"),
        message_good = false,
    })

content.add(content.TerrainTransform { id = "exodii_foam" }
    :terrain {
        flags = { "FLAT" },
        results = { "t_foam_wall" },
    })

content.add(content.TerrainTransform { id = "LIXA_power_out" }
    :terrain {
        inputs = { "t_carpet_concrete_green_olight" },
        results = { "t_carpet_concrete_green" },
    }
    :terrain {
        inputs = { "t_thconc_floor_olight" },
        results = { "t_thconc_floor" },
    }
    :furniture {
        inputs = { "f_console" },
        results = { "f_console_broken" },
    }
    :furniture {
        inputs = { "f_LIXA_unfold_barrier" },
        results = { "f_null" },
    })

content.add(content.TerrainTransform { id = "merc_spike_transform" }
    :furniture {
        inputs = { "f_impaled_officer" },
        results = { "f_empty_spike" },
    })

content.add(content.TerrainTransform { id = "merc_darkness_transform" }
    :terrain {
        inputs = { "t_strconc_floor" },
        results = { "t_nether_glass_floor", { "t_strconc_floor", 3 } },
    })

content.add(content.TerrainTransform { id = "merc_darkness_transform_walls" }
    :terrain {
        inputs = { "t_wall_glass", "t_concrete_wall" },
        results = { "t_nether_glass_floor", { "t_nether_glass_wall", 2 } },
    })

content.add(content.TerrainTransform { id = "clearcut" }
    :terrain {
        flags = { "TREE", "YOUNG" },
        results = { "t_stump" },
    })

-- Ideally place withered plant item somehow
content.add(content.TerrainTransform { id = "dead_vegetation" }
    :terrain {
        inputs = {
            "t_grass", "t_grass_long", "t_grass_tall", "t_grass_golf", "t_grass_white", "t_moss",
            "t_forestfloor",
        },
        results = { "t_grass_dead" },
    }
    :terrain {
        inputs = { "t_tree_pine" },
        results = { "t_tree_deadpine" },
    }
    :terrain {
        inputs = { "t_tree_birch" },
        results = { "t_tree_birch_harvested" },
    }
    :terrain {
        inputs = { "t_tree_willow" },
        results = { "t_tree_dead" },
    }
    :terrain {
        inputs = { "t_tree_hickory", "t_tree_hickory_harvested" },
        results = { "t_tree_hickory_dead" },
    }
    -- Ideally place sticks half the time, for now we just place items randomly
    :terrain {
        flags = { "SHRUB" },
        results = { "t_dirt" },
    }
    -- Ideally place a long stick half the time, for now we just place items randomly
    :terrain {
        flags = { "YOUNG" },
        results = { "t_dirt" },
    }
    :terrain {
        flags = { "TREE" },
        results = { { "t_tree_dead", 9 }, { "t_trunk", 4 }, { "t_stump", 3 } },
    }
    -- Ideally place a withered plant, for now we just place items randomly
    :furniture {
        flags = { "PLANT", "FLOWER", "ORGANIC" },
        results = { "f_null" },
    })

content.add(content.TerrainTransform { id = "remove_door" }
    :terrain {
        flags = { "DOOR", "BARRICADABLE_DOOR_DAMAGED", "BARRICADABLE_DOOR" },
        results = { "t_door_frame" },
    })

content.add(content.TerrainTransform { id = "remove_window" }
    :terrain {
        flags = { "WINDOW" },
        results = { "t_window_frame" },
    })

content.add(content.TerrainTransform { id = "wall_to_paper" }
    :terrain {
        flags = { "WALL" },
        results = { "t_paper" },
    })

content.add(content.TerrainTransform { id = "upturn_earth" }
    :terrain {
        flags = { "DIGGABLE" },
        results = { "t_dirtmound" },
    })

content.add(content.TerrainTransform { id = "microlab_triffidize" }
    :terrain {
        inputs = { "t_strconc_floor" },
        results = { "t_strconc_floor", { "t_region_groundcover_forest", 3 } },
    })

-- Should include the bash result for every standard_domestic_palette window
content.add(content.TerrainTransform { id = "damaged_window" }
    :terrain {
        inputs = {
            "t_window_domestic", "t_window_no_curtains", "t_window_open", "t_window_no_curtains_open",
            "t_curtains",
        },
        results = { "t_window_frame" },
    })

content.add(content.TerrainTransform { id = "glass_door_wall_2_floor" }
    :terrain {
        inputs = { "t_wall_glass", "t_door_glass_c" },
        results = { "t_floor" },
    })

-- Should include the bash result for every standard_domestic_palette window
content.add(content.TerrainTransform { id = "destroyed_window" }
    :terrain {
        inputs = {
            "t_window_domestic", "t_window_no_curtains", "t_window_open", "t_window_no_curtains_open",
            "t_curtains", "t_window_frame",
        },
        results = { "t_window_empty" },
    })

-- Should include the bash result for every wooden door
content.add(content.TerrainTransform { id = "damaged_door" }
    :terrain {
        inputs = {
            "t_door_c", "t_door_o", "t_door_locked_interior", "t_rdoor_b", "t_door_locked", "t_door_elocked",
            "t_door_locked_alarm", "t_door_elocked_alarm", "t_door_boarded_damaged",
        },
        results = { "t_door_b" },
    }
    :terrain {
        inputs = { "t_rdoor_c", "t_rdoor_o", "t_rdoor_boarded_damaged" },
        results = { "t_rdoor_b" },
    }
    :terrain {
        inputs = { "t_door_boarded" },
        results = { "t_door_boarded_damaged" },
    }
    :terrain {
        inputs = { "t_rdoor_boarded" },
        results = { "t_rdoor_boarded_damaged" },
    }
    :terrain {
        inputs = { "t_door_boarded_peep" },
        results = { "t_door_boarded_damaged_peep" },
    }
    :terrain {
        inputs = { "t_door_elocked_peep" },
        results = { "t_door_o_peep" },
    }
    :terrain {
        inputs = { "t_door_makeshift_c", "t_door_makeshift_o" },
        results = { "t_door_frame" },
    }
    :terrain {
        inputs = { "t_door_c_peep", "t_door_o_peep", "t_door_locked_peep", "t_door_boarded_damaged_peep" },
        results = { "t_door_b_peep" },
    }
    :terrain {
        inputs = { "t_door_white_c", "t_door_white_o" },
        results = { "t_door_white_b" },
    }
    :terrain {
        inputs = { "t_door_gray_c", "t_door_gray_o" },
        results = { "t_door_gray_b" },
    }
    :terrain {
        inputs = { "t_door_red_c", "t_door_red_o" },
        results = { "t_door_red_b" },
    }
    :terrain {
        inputs = { "t_door_green_c", "t_door_green_o" },
        results = { "t_door_green_b" },
    })

content.add(content.TerrainTransform { id = "destroyed_door" }
    :terrain {
        inputs = {
            "t_door_c", "t_door_o", "t_door_locked_interior", "t_rdoor_b", "t_door_locked", "t_door_elocked",
            "t_door_locked_alarm", "t_door_elocked_alarm", "t_door_boarded_damaged", "t_door_b", "t_rdoor_c",
            "t_rdoor_o", "t_rdoor_boarded_damaged", "t_door_boarded", "t_rdoor_boarded",
            "t_door_boarded_peep", "t_door_boarded_damaged_peep", "t_door_makeshift_c", "t_door_makeshift_o",
            "t_door_c_peep", "t_door_o_peep", "t_door_locked_peep", "t_door_b_peep",
        },
        results = { "t_door_frame" },
    }
    :terrain {
        inputs = { "t_door_white_c", "t_door_white_o", "t_door_white_b" },
        results = { "t_door_white_frame" },
    }
    :terrain {
        inputs = { "t_door_gray_c", "t_door_gray_o", "t_door_gray_b" },
        results = { "t_door_gray_frame" },
    }
    :terrain {
        inputs = { "t_door_red_c", "t_door_red_o", "t_door_red_b" },
        results = { "t_door_red_frame" },
    }
    :terrain {
        inputs = { "t_door_green_c", "t_door_green_o", "t_door_green_b" },
        results = { "t_door_green_frame" },
    })

content.add(content.TerrainTransform { id = "boarded_up" }
    :terrain {
        flags = { "DOOR" },
        results = { "t_door_boarded" },
    }
    :terrain {
        flags = { "WINDOW" },
        results = { "t_window_boarded" },
    }
    :terrain {
        inputs = { "t_wall_glass" },
        results = { "t_scrap_wall" },
    })

content.add(content.TerrainTransform { id = "boarded_up_rushed" }
    :terrain {
        flags = { "DOOR" },
        results = { "t_door_locked" },
    }
    :terrain {
        flags = { "WINDOW" },
        results = { "t_window_taped" },
    })

content.add(content.TerrainTransform { id = "cut_foliage" }
    :terrain {
        inputs = { "t_grass", "t_grass_dead" },
        flags = { "SHRUB" },
        results = { "t_dirt" },
    }
    :furniture {
        flags = { "FLOWER" },
        results = { "f_null" },
    })

content.add(content.TerrainTransform { id = "destroyed_metal_door" }
    :terrain {
        inputs = { "t_door_metal_pickable", "t_door_metal_o", "t_door_metal_c" },
        results = { "t_mdoor_frame" },
    })

content.add(content.TerrainTransform { id = "damaged_window_bars" }
    :terrain {
        inputs = { "t_window_bars_alarm" },
        results = { "t_window_bars" },
    })

content.add(content.TerrainTransform { id = "destroyed_window_bars" }
    :terrain {
        inputs = { "t_window_bars", "t_window_bars_alarm" },
        results = { "t_window_empty" },
    })

content.add(content.TerrainTransform { id = "fit_door" }
    :terrain {
        inputs = { "t_door_frame" },
        results = { "t_door_c" },
    })

content.add(content.TerrainTransform { id = "looted_gunsafe" }
    :furniture {
        inputs = { "f_gunsafe_ml", "f_gunsafe_o" },
        results = { "f_gunsafe_o" },
    })

content.add(content.TerrainTransform { id = "jammed_gunsafe" }
    :furniture {
        inputs = { "f_gunsafe_ml", "f_gunsafe_o" },
        results = { "f_gunsafe_mj" },
    })

content.add(content.TerrainTransform { id = "open_gunsafe" }
    :furniture {
        inputs = { "f_gunsafe_ml" },
        results = { "f_gunsafe_o" },
    })

content.add(content.TerrainTransform { id = "unlock_door" }
    :terrain {
        inputs = {
            "t_door_locked_interior", "t_door_locked", "t_door_elocked", "t_door_locked_alarm",
            "t_door_elocked_alarm",
        },
        results = { "t_door_c" },
    }
    :terrain {
        inputs = { "t_door_locked_peep" },
        results = { "t_door_c_peep" },
    }
    :terrain {
        inputs = { "t_door_metal_locked", "t_door_metal_interior_locked" },
        results = { "t_door_metal_c" },
    }
    :terrain {
        inputs = { "t_door_bar_locked" },
        results = { "t_door_bar_o" },
    })

content.add(content.TerrainTransform { id = "ranch_wall_upgrade1" }
    :terrain {
        inputs = { "t_wall_half" },
        results = { "t_wall_wood" },
    })

content.add(content.TerrainTransform { id = "ranch_wall_upgrade2" }
    :terrain {
        inputs = { "t_wall_wood" },
        results = { "t_wall" },
    })

content.add(content.TerrainTransform { id = "ranch_window_upgrade1" }
    :terrain {
        inputs = { "t_window_empty" },
        results = { "t_window_boarded_noglass" },
    })

content.add(content.TerrainTransform { id = "fungalize" }
    :terrain {
        flags = { "FLAT" },
        results = { { "t_fungus", 2 }, "t_fungus_floor_sup" },
    }
    :furniture {
        flags = { "ORGANIC" },
        results = { "f_fungal_mass", "f_fungal_tangle", "f_fungal_clump" },
    })

-- transform won't accept null in a switch statement, so for now this is the solution. Does nothing.
content.add(content.TerrainTransform { id = "tft_null" }
    :terrain {
        inputs = { "t_null" },
        results = { "t_null" },
    })

content.add(content.TerrainTransform { id = "struc_carcrash_rubble" }
    :terrain {
        inputs = {
            "t_door_white_frame", "t_door_frame", "t_door_lab_frame", "t_door_red_frame",
            "t_door_green_frame", "t_door_gray_frame", "t_mdoor_lab_frame", "t_mdoor_frame",
        },
        flags = { "DOOR", "WALL", "WINDOW", "BARRICADABLE_DOOR", "BARRICADABLE_DOOR_DAMAGED" },
        results = { "t_floor" },
    }
    :terrain {
        inputs = { "t_gutter_downspout" },
        flags = { "DIGGABLE", "TREE", "SHRUB", "FLOWER" },
        results = { "t_dirtmoundfloor" },
    }
    :furniture {
        inputs = { "f_null" },
        flags = { "BLOCKSDOOR", "TRANSPARENT" },
        results = { "f_rubble" },
    })

content.add(content.TerrainTransform { id = "struc_carcrash_dirt" }
    :terrain {
        flags = { "DIGGABLE", "TREE", "SHRUB", "FLOWER" },
        results = { "t_dirtmoundfloor" },
    }
    :furniture {
        flags = { "BLOCKSDOOR", "TRANSPARENT" },
        results = { "f_null" },
    })

content.add(content.TerrainTransform { id = "struc_carcrash_clear" }
    :terrain {
        inputs = {
            "t_door_white_frame", "t_door_frame", "t_door_lab_frame", "t_door_red_frame",
            "t_door_green_frame", "t_door_gray_frame", "t_mdoor_lab_frame", "t_mdoor_frame",
        },
        flags = { "DOOR", "WINDOW", "WALL", "BARRICADABLE_DOOR", "BARRICADABLE_DOOR_DAMAGED" },
        results = { "t_floor" },
    }
    :furniture {
        flags = { "BLOCKSDOOR", "TRANSPARENT" },
        results = { "f_null" },
    })

-- Should be merged with the one in aux_nested when moved to vanilla
content.add(content.TerrainTransform { id = "nl_unlock_door" }
    :terrain {
        inputs = { "t_nl_door_l" },
        results = { "t_nl_door_c" },
    })

-- Should be merged with the one in aux_nested when moved to vanilla
content.add(content.TerrainTransform { id = "nl_lock_door" }
    :terrain {
        inputs = { "t_nl_door_c", "t_nl_door_o" },
        results = { "t_nl_door_l" },
    })

content.add(content.TerrainTransform { id = "nl_door_to_floor" }
    :terrain {
        inputs = { "t_nl_door_l", "t_nl_door_c", "t_nl_door_o" },
        results = { "t_nl_metal_floor" },
    })

content.add(content.TerrainTransform { id = "nl_obelisk_0_to_1" }
    :terrain {
        inputs = { "t_nl_obelisk_0" },
        results = { "t_nl_obelisk_1" },
    })

content.add(content.TerrainTransform { id = "nl_obelisk_0_to_2" }
    :terrain {
        inputs = { "t_nl_obelisk_0" },
        results = { "t_nl_obelisk_2" },
    })

content.add(content.TerrainTransform { id = "nl_obelisk_0_to_3" }
    :terrain {
        inputs = { "t_nl_obelisk_0" },
        results = { "t_nl_obelisk_3" },
    })

content.add(content.TerrainTransform { id = "megafernification" }
    :terrain {
        flags = { "TREE", "SHRUB", "YOUNG" },
        results = { "t_mega_fern" },
    })

content.add(content.TerrainTransform { id = "remove_forest_terrain_plants" }
    :terrain {
        flags = { "TREE", "SHRUB", "YOUNG" },
        results = { "t_region_groundcover_forest" },
    })

content.add(content.TerrainTransform { id = "unlock_elock_xedra3" }
    :terrain {
        inputs = { "t_door_metal_elocked_xedra3" },
        results = { "t_door_metal_c" },
        message = ccb.content.text("You enter the code and door mechanism clicks as it unlocks."),
    })

content.add(content.TerrainTransform { id = "portal_cage_transform" }
    :furniture {
        inputs = { "f_null" },
        results = { "f_absence" },
    })

content.add(content.TerrainTransform { id = "portal_cage_revert_transform" }
    :furniture {
        inputs = { "f_absence" },
        results = { "f_null" },
    })

content.add(content.TerrainTransform { id = "clear_portal_walls" }
    :terrain {
        inputs = { "t_wall_warped" },
        results = { "t_floor_warped" },
    })

-- Yes this is a giant list of terrain.
content.add(content.TerrainTransform { id = "ltnt_grass_drain" }
    :terrain {
        inputs = {
            "t_grass", "t_grass_alien", "t_grass_dead", "t_bamboo_long", "t_grass_long", "t_bamboo_tall",
            "t_grass_tall", "t_bamboo", "t_bamboo_harvested", "t_shrub", "t_shrub_rose", "t_shrub_lilac",
            "t_shrub_grape", "t_shrub_peanut", "t_shrub_blueberry", "t_shrub_hydrangea", "t_shrub_raspberry",
            "t_shrub_strawberry", "t_shrub_blackberry", "t_shrub_huckleberry", "t_shrub_rose_harvested",
            "t_shrub_grape_harvested", "t_shrub_lilac_harvested", "t_shrub_peanut_harvested",
            "t_shrub_raspberry_harvested", "t_shrub_blueberry_harvested", "t_shrub_hydrangea_harvested",
            "t_shrub_blackberry_harvested", "t_shrub_strawberry_harvested", "t_shrub_huckleberry_harvested",
            "t_forestfloor", "t_moss", "t_underbrush", "t_underbrush_harvested", "t_fern", "t_fern_harvested",
            "t_tree_young",
        },
        results = { "t_dirt" },
    })

content.add(content.TerrainTransform { id = "ltnt_tree_drain" }
    :terrain {
        inputs = {
            "t_tree", "t_tree_elm", "t_tree_harvested", "t_tree_plum_harvested", "t_tree_pine_harvested",
            "t_tree_dead", "t_tree_pear", "t_tree_plum", "t_tree_pear_harvested", "t_tree_pine",
            "t_tree_maple", "t_tree_apple", "t_tree_beech", "t_tree_alder_harvested",
            "t_tree_peach_harvested", "t_tree_peach", "t_tree_birch", "t_tree_birch_harvested",
            "t_tree_maple_tapped", "t_tree_pecan_harvested", "t_tree_beech_harvested",
            "t_tree_apple_harvested", "t_tree_pecan", "t_tree_alder", "t_tree_walnut",
            "t_tree_almond_harvested", "t_tree_willow_harvested", "t_tree_willow", "t_tree_walnut_harvested",
            "t_tree_fungal", "t_tree_cherry_harvested", "t_tree_cherry", "t_tree_coffee_harvested",
            "t_tree_coffee", "t_tree_almond", "t_tree_hickory_harvested", "t_tree_hickory",
            "t_tree_apricot_harvested", "t_tree_apricot", "t_tree_juniper_harvested", "t_tree_juniper",
            "t_marloss_tree", "t_tree_chestnut_harvested", "t_tree_chestnut", "t_tree_mulberry_harvested",
            "t_tree_mulberry", "t_tree_basswood", "t_tree_hazelnut_harvested", "t_tree_hazelnut",
            "t_tree_basswood_harvested", "t_tree_pistachio_harvested", "t_tree_pistachio", "t_tree_deadpine",
            "t_tree_butternut", "t_tree_butternut_harvested", "t_tree_sassafras_harvested",
            "t_tree_sassafras", "t_tree_cottonwood_harvested", "t_tree_elderberry",
            "t_tree_elderberry_harvested", "t_tree_cottonwood", "t_tree_blackjack", "t_tree_dead_warped",
            "t_tree_hickory_dead", "t_tree_deadpine_warped", "t_tree_blackjack_harvested",
        },
        results = { "t_tree_very_dead" },
    })

content.add(content.TerrainTransform { id = "ter_local_sd_distress_beacon_1" }
    :furniture {
        inputs = { "f_console" },
        results = { "f_string_dimension_distress_beacon_1" },
    })

content.add(content.TerrainTransform { id = "ter_local_sd_distress_beacon_2" }
    :furniture {
        inputs = { "f_console" },
        results = { "f_string_dimension_distress_beacon_2" },
    })

content.add(content.TerrainTransform { id = "ter_local_sd_distress_beacon_3" }
    :furniture {
        inputs = { "f_console" },
        results = { "f_string_dimension_distress_beacon_3" },
    })
